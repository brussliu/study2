-- 函数2：主函数，判断是否可以申请游戏时间
CREATE OR REPLACE FUNCTION check_game_time_availability(
    classification TEXT,
    div TEXT,
    block_time_range TEXT, -- 封锁时间段，格式：'23:00-07:00'
    -- 学习要求参数（8个）
    study_mon INTEGER, study_tue INTEGER, study_wed INTEGER, study_thu INTEGER,
    study_fri INTEGER, study_sat INTEGER, study_sun INTEGER, study_holiday INTEGER,
    -- 游戏额度参数（8个）
    game_mon INTEGER, game_tue INTEGER, game_wed INTEGER, game_thu INTEGER,
    game_fri INTEGER, game_sat INTEGER, game_sun INTEGER, game_holiday INTEGER
)
RETURNS TEXT AS $$
DECLARE
    current_time TIME := CURRENT_TIME;
    current_date DATE := CURRENT_DATE;
    block_start_time TIME;
    block_end_time TIME;
    current_dow INTEGER; -- 当前星期几 (0=周日, 1=周一, ..., 6=周六)
    is_holiday BOOLEAN := FALSE;
    study_requirement INTEGER;
    game_allowance INTEGER;
    total_study_time INTEGER;
    used_game_time INTEGER;
    remaining_game_time INTEGER;
    time_parts TEXT[];
BEGIN
    IF div = 'S0' or div = 'S3' THEN
        RETURN NULL;
    END IF;
    
    -- 解析封锁时间段
    time_parts := string_to_array(block_time_range, '-');
    
    IF array_length(time_parts, 1) != 2 THEN
        RAISE EXCEPTION '无效的时间段格式: %，正确格式如：23:00-07:00', block_time_range;
    END IF;
    
    BEGIN
        block_start_time := time_parts[1]::TIME;
        block_end_time := time_parts[2]::TIME;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION '无效的时间格式: %', block_time_range;
    END;
    
    -- 检查当前时间是否在封锁时间段内
    IF block_start_time < block_end_time THEN
        -- 正常时间段，如 20:00-22:00
        IF current_time >= block_start_time AND current_time < block_end_time THEN
            RETURN NULL;
        END IF;
    ELSE
        -- 跨越午夜的时间段，如 23:00-07:00
        IF current_time >= block_start_time OR current_time < block_end_time THEN
            RETURN NULL;
        END IF;
    END IF;
    
    -- 判断是否为节假日（假设有holiday表，包含holiday_date字段）
    SELECT COUNT(*) > 0 INTO is_holiday 
    FROM "STY_休日情報" 
    WHERE "日付" = to_char(current_date, 'YYYYMMDD');
    
    -- 获取当前星期几 (0=周日, 1=周一, ..., 6=周六)
    current_dow := EXTRACT(DOW FROM current_date);
    
    -- 根据是否为节假日选择对应的要求
    IF is_holiday THEN
        study_requirement := study_holiday;
        game_allowance := game_holiday;
    ELSE
        -- 根据星期几选择对应的要求
        CASE current_dow
            WHEN 1 THEN -- 周一
                study_requirement := study_mon;
                game_allowance := game_mon;
            WHEN 2 THEN -- 周二
                study_requirement := study_tue;
                game_allowance := game_tue;
            WHEN 3 THEN -- 周三
                study_requirement := study_wed;
                game_allowance := game_wed;
            WHEN 4 THEN -- 周四
                study_requirement := study_thu;
                game_allowance := game_thu;
            WHEN 5 THEN -- 周五
                study_requirement := study_fri;
                game_allowance := game_fri;
            WHEN 6 THEN -- 周六
                study_requirement := study_sat;
                game_allowance := game_sat;
            WHEN 0 THEN -- 周日
                study_requirement := study_sun;
                game_allowance := game_sun;
            ELSE
                study_requirement := study_mon; -- 默认值
                game_allowance := game_mon;
        END CASE;
    END IF;
    
    -- 检索A表获取当天的学习时间（假设A表有study_date和study_minutes字段）
    --SELECT COALESCE(SUM(study_minutes), 0) INTO total_study_time
    --FROM A
    --WHERE study_date = current_date;
    IF div = 'S1' THEN

        SELECT sum(B."時間") into total_study_time
        FROM "STY_単語テスト詳細情報" B
        WHERE to_char(B."更新日時", 'YYYYMMDD') = to_char(current_date, 'YYYYMMDD')
            AND B."時間" <= 30;
        
        -- 检查是否满足学习要求
        IF total_study_time is null or total_study_time < study_requirement * 60 THEN
            RETURN NULL;
        END IF;

        
    END IF;

    -- 检索B表获取当天已使用的游戏时间（假设B表有game_date和game_minutes字段）
    SELECT CAST("値" AS INTEGER) INTO used_game_time
    FROM "COM_システム情報"
    WHERE "キー" = 'accessTime';

    -- アクセス時間が無限
    if game_allowance is NULL THEN

        RETURN format_remaining_time(30);

    ELSE

        -- 计算剩余游戏时间
        remaining_game_time := game_allowance - used_game_time;
        
        -- 如果没有剩余时间，返回NULL
        IF remaining_game_time <= 0 THEN
            RETURN NULL;
        END IF;
        
        -- 调用辅助函数格式化剩余时间
        RETURN format_remaining_time(remaining_game_time);

    END IF;
END;
$$ LANGUAGE plpgsql;
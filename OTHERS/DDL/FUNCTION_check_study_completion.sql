-- 函数：判断是否已完成当天学习要求
CREATE OR REPLACE FUNCTION check_study_completion(
    -- 学习要求参数（8个）
    study_mon INTEGER, study_tue INTEGER, study_wed INTEGER, study_thu INTEGER,
    study_fri INTEGER, study_sat INTEGER, study_sun INTEGER, study_holiday INTEGER
)
RETURNS TEXT AS $$
DECLARE
    current_date DATE := CURRENT_DATE;
    current_dow INTEGER; -- 当前星期几 (0=周日, 1=周一, ..., 6=周六)
    is_holiday BOOLEAN := FALSE;
    study_requirement INTEGER;
    total_study_time INTEGER;
BEGIN
    -- 判断是否为节假日（假设有holiday表，包含holiday_date字段）
    SELECT COUNT(*) > 0 INTO is_holiday 
    FROM "STY_休日情報" 
    WHERE "日付" = to_char(current_date, 'YYYYMMDD');
    
    -- 获取当前星期几 (0=周日, 1=周一, ..., 6=周六)
    current_dow := EXTRACT(DOW FROM current_date);
    
    -- 根据是否为节假日选择对应的学习要求
    IF is_holiday THEN
        study_requirement := study_holiday;
    ELSE
        -- 根据星期几选择对应的学习要求
        CASE current_dow
            WHEN 1 THEN -- 周一
                study_requirement := study_mon;
            WHEN 2 THEN -- 周二
                study_requirement := study_tue;
            WHEN 3 THEN -- 周三
                study_requirement := study_wed;
            WHEN 4 THEN -- 周四
                study_requirement := study_thu;
            WHEN 5 THEN -- 周五
                study_requirement := study_fri;
            WHEN 6 THEN -- 周六
                study_requirement := study_sat;
            WHEN 0 THEN -- 周日
                study_requirement := study_sun;
            ELSE
                study_requirement := study_mon; -- 默认值
        END CASE;
    END IF;
    
    SELECT sum(B."時間") into total_study_time
    FROM "STY_単語テスト詳細情報" B
    WHERE to_char(B."更新日時", 'YYYYMMDD') = to_char(current_date, 'YYYYMMDD')
    AND B."時間" <= 30;
        
    -- 检查是否满足学习要求
    IF total_study_time is null or total_study_time < study_requirement * 60 THEN
        RETURN'×'; -- 不满足要求
    ELSE
        RETURN '○'; -- 满足要求
    END IF;
    
END;
$$ LANGUAGE plpgsql;
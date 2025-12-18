CREATE OR REPLACE FUNCTION get_daily_game_quota(
    -- 游戏额度参数（8个）
    game_mon INTEGER, game_tue INTEGER, game_wed INTEGER, game_thu INTEGER,
    game_fri INTEGER, game_sat INTEGER, game_sun INTEGER, game_holiday INTEGER
) 
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
    is_holiday boolean;
    current_date DATE := CURRENT_DATE;
    day_of_week integer;
    result_quota integer;
BEGIN
    -- 检查是否为节假日
    SELECT COUNT(*) > 0 INTO is_holiday 
    FROM "STY_休日情報" 
    WHERE "日付" = to_char(current_date, 'YYYYMMDD');
    
    -- 如果是节假日，返回节假日额度
    IF is_holiday THEN
        RETURN game_holiday;
    END IF;
    
    -- 如果不是节假日，根据星期几返回对应的额度
    -- extract(dow from date): 0=周日, 1=周一, 2=周二, ..., 6=周六
    day_of_week := EXTRACT(DOW FROM current_date);
    
    CASE day_of_week
        WHEN 1 THEN result_quota := game_mon;      -- 周一
        WHEN 2 THEN result_quota := game_tue;      -- 周二
        WHEN 3 THEN result_quota := game_wed;    -- 周三
        WHEN 4 THEN result_quota := game_thu;     -- 周四
        WHEN 5 THEN result_quota := game_fri;       -- 周五
        WHEN 6 THEN result_quota := game_sat;     -- 周六
        WHEN 0 THEN result_quota := game_sun;       -- 周日
        ELSE result_quota := game_mon;             -- 默认值
    END CASE;
    
    RETURN result_quota;
END;
$$;
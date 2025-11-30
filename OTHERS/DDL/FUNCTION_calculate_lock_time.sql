CREATE OR REPLACE FUNCTION calculate_lock_time(
    scheduled_time TEXT,
    add_minutes INTEGER
) 
RETURNS TEXT AS $$
DECLARE
    base_time TIME;
    result_time TIME;
BEGIN
    -- 如果当前预定时间为空，使用系统当前时间
    IF scheduled_time IS NULL OR scheduled_time = '' THEN
        base_time := CURRENT_TIME::TIME;
    ELSE
        -- 将文本时间转换为TIME类型
        base_time := scheduled_time::TIME;
    END IF;
    
    -- 加上指定的分钟数
    result_time := base_time + (add_minutes || ' minutes')::INTERVAL;
    
    -- 返回格式化的时间字符串 (HH24:MI 格式)
    RETURN TO_CHAR(result_time, 'HH24:MI');
    
EXCEPTION
    WHEN invalid_datetime_format THEN
        RAISE EXCEPTION '无效的时间格式: %。请使用 HH24:MI 格式 (例如: 23:00)', current_lock_time;
    WHEN others THEN
        RAISE EXCEPTION '计算锁定时间时发生错误';
END;
$$ LANGUAGE plpgsql;
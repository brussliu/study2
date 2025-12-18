-- 函数1：将剩余时间转换为逗号分隔的字符串
CREATE OR REPLACE FUNCTION format_remaining_time(remaining_minutes INTEGER)
RETURNS TEXT AS $$
DECLARE
    result_text TEXT := '';
    i INTEGER;
    current_value INTEGER;
BEGIN
    -- 如果剩余时间小于等于0，返回空字符串
    IF remaining_minutes <= 0 THEN
        RETURN NULL;
    END IF;
    
    -- 生成10分钟为单位的选项，直到超过剩余时间
    i := 10;
    WHILE i <= remaining_minutes LOOP
        IF result_text != '' THEN
            result_text := result_text || ',';
        END IF;
        result_text := result_text || i::TEXT;
        i := i + 10;
    END LOOP;
    
    -- 如果最后一个10分钟单位小于剩余时间，添加实际剩余时间
    IF (i - 10) < remaining_minutes THEN
        IF result_text != '' THEN
            result_text := result_text || ',';
        END IF;
        result_text := result_text || remaining_minutes::TEXT;
    END IF;
    
    -- 如果剩余时间小于10分钟，直接返回剩余时间
    IF remaining_minutes < 10 THEN
        result_text := remaining_minutes::TEXT;
    END IF;
    
    RETURN result_text;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION public.generate_time_ranges(p_day text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    datetime_rec RECORD;
    prev_datetime TIMESTAMP;
    range_start TIMESTAMP;
    result_string TEXT := '';
    first_range BOOLEAN := TRUE;
    datetime_cursor REFCURSOR;
    time_diff INTERVAL;
    current_gap INTERVAL;
BEGIN
    -- 打开游标查询数据（请替换实际表名和列名）
    OPEN datetime_cursor FOR 
        SELECT "更新日時"::TIMESTAMP AS datetime_value 
        FROM "STY_単語テスト詳細情報" 
        WHERE TO_CHAR("更新日時",'YYYYMMDD') = p_day
        AND "時間" IS NOT NULL
        ORDER BY "更新日時";
    
    -- 获取第一条记录
    FETCH datetime_cursor INTO datetime_rec;
    IF NOT FOUND THEN
        CLOSE datetime_cursor;
        RETURN ''; -- 无数据时返回空字符串
    END IF;
    
    -- 初始化第一个时间范围
    range_start := datetime_rec.datetime_value;
    prev_datetime := datetime_rec.datetime_value;
    
    -- 处理每条记录
    LOOP
        FETCH datetime_cursor INTO datetime_rec;
        IF NOT FOUND THEN
            -- 添加最后一个时间范围
            IF NOT first_range THEN
                result_string := result_string || ',';
            END IF;
            result_string := result_string || 
                           to_char(range_start, 'HH24:MI:SS') || '～' || 
                           to_char(prev_datetime, 'HH24:MI:SS');
            EXIT;
        END IF;
        
        -- 计算当前时间差
        current_gap := datetime_rec.datetime_value - prev_datetime;
        
        -- 判断是否应该合并到当前范围
        IF EXTRACT(EPOCH FROM current_gap) <= 300 THEN
            prev_datetime := datetime_rec.datetime_value;
        ELSE
            -- 结束当前范围并开始新范围
            IF NOT first_range THEN
                result_string := result_string || ',';
            END IF;
            result_string := result_string || 
                           to_char(range_start, 'HH24:MI:SS') || '～' || 
                           to_char(prev_datetime, 'HH24:MI:SS');
            
            range_start := datetime_rec.datetime_value;
            prev_datetime := datetime_rec.datetime_value;
            first_range := FALSE;
        END IF;
    END LOOP;
    
    CLOSE datetime_cursor;
    RETURN result_string;
END;
$function$
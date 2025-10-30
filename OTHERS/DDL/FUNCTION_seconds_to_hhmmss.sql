CREATE OR REPLACE FUNCTION seconds_to_hhmmss(total_seconds bigint)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    hours INTEGER;
    minutes INTEGER;
    seconds INTEGER;
BEGIN
    IF total_seconds IS NULL THEN
        RETURN '00:00:00';
    END IF;

    hours := total_seconds / 3600;
    minutes := (total_seconds % 3600) / 60;
    seconds := total_seconds % 60;

    RETURN LPAD(hours::TEXT, 2, '0') || ':' ||
           LPAD(minutes::TEXT, 2, '0') || ':' ||
           LPAD(seconds::TEXT, 2, '0');
END;
$$;

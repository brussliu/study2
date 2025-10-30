CREATE OR REPLACE FUNCTION calc_accuracy(total_tests bigint, correct_answers bigint)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    accuracy NUMERIC;
BEGIN
    IF total_tests IS NULL OR total_tests = 0 THEN
        RETURN NULL;
    END IF;

    IF correct_answers IS NULL THEN
        correct_answers := 0;
    END IF;

    accuracy := ROUND((correct_answers::NUMERIC / total_tests) * 100, 2);
    RETURN accuracy;
END;
$$;

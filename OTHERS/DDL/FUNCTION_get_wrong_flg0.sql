CREATE OR REPLACE FUNCTION get_wrong_flg0(
    per NUMERIC,
    all_right bigint,
    recentrighttimes bigint,
    kind text
)
RETURNS TEXT AS $$
BEGIN

    IF kind = 'A.勉強' then

         RETURN '';

    ELSIF kind = 'D.英訳中' THEN

         RETURN '';

    ELSIF kind = 'C.音訳英' THEN

         RETURN '';

    ELSE

        -- 未勉強
        IF per IS NULL THEN
            RETURN '-';
        
        -- 勉強済
        ELSIF per = 100 AND all_right >= 5 THEN
            RETURN '○';
        ELSIF per >= 90 AND per < 100 AND all_right >= 6 AND recentrighttimes >= 3 THEN
            RETURN '○';
        ELSIF per >= 80 AND per < 90 AND all_right >= 7 AND recentrighttimes >= 3 THEN
            RETURN '○';
        ELSIF per >= 70 AND per < 80 AND all_right >= 8 AND recentrighttimes >= 3 THEN
            RETURN '○';
        ELSIF per >= 60 AND per < 70 AND all_right >= 9 AND recentrighttimes >= 3 THEN
            RETURN '○';
        ELSIF per < 60 AND all_right >= 10 AND recentrighttimes >= 3 THEN
            RETURN '○';

        -- 勉強中（間もなく済み）
        ELSIF per = 100 AND all_right >= 3 THEN
            RETURN '▲';
        ELSIF per >= 88 AND per < 100 AND all_right >= 4 AND recentrighttimes >= 1 THEN
            RETURN '▲';
        ELSIF per >= 78 AND per < 90 AND all_right >= 5 AND recentrighttimes >= 1 THEN
            RETURN '▲';
        ELSIF per >= 68 AND per < 80 AND all_right >= 6 AND recentrighttimes >= 1 THEN
            RETURN '▲';
        ELSIF per >= 58 AND per < 70 AND all_right >= 7 AND recentrighttimes >= 1 THEN
            RETURN '▲';
        ELSIF per < 60 AND all_right >= 8 AND recentrighttimes >= 1 THEN
            RETURN '▲';

        -- 勉強中（まだ時間かかる）
        ELSE
            RETURN '△';
        END IF;

    END IF;

END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION get_wrong_flg(
    per NUMERIC,
    all_right bigint,
    recentrighttimes bigint,
    kind text,
    wrong_flg0 text
)
RETURNS TEXT AS $$
BEGIN

    IF kind = 'A.勉強' then

        IF per IS NULL THEN
            RETURN '-';
        -- 勉強済
        ELSE 
            RETURN '○';
        END IF;

    ELSIF kind = 'D.英訳中' THEN

        IF per IS NULL THEN
            RETURN '-';
        -- 勉強済
        ELSE 

            IF recentrighttimes >= 2 THEN
                RETURN '○';
            ELSIF recentrighttimes = 1 THEN
                RETURN '▲';
            ELSE
                RETURN '△';
            END IF;
        END IF;

    ELSIF kind = 'C.音訳英' THEN

        IF wrong_flg0 = '○' THEN

            IF recentrighttimes >= 1 THEN
                RETURN '○';
            ELSE
                RETURN '-';
            END IF;

        ELSE 

            RETURN '-';

        END IF;

    ELSE

        RETURN wrong_flg0;

    END IF;

END;
$$ LANGUAGE plpgsql;
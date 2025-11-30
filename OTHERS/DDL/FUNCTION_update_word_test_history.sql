CREATE OR REPLACE PROCEDURE update_word_test_history(p_test_number character varying)
AS $$
DECLARE
    v_test_type character varying(50);
    v_difficulty character varying(50);
    v_book character varying(50);
    v_category character varying(200);
    rec_record RECORD;
    v_all_correct boolean;
    v_recent_correct_count integer;
BEGIN
    -- 从A表获取测试种别和难易度
    SELECT "テスト種別", "難易度", "書籍", "分類" 
    INTO v_test_type, v_difficulty, v_book, v_category
    FROM public."STY_単語テスト情報"
    WHERE "テスト番号" = p_test_number;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION '测试番号 % 不存在于A表中', p_test_number;
    END IF;
    
    -- 遍历B表的所有相关记录
    FOR rec_record IN 
        SELECT 
            b."書籍",
            b."分類",
            b."単語SEQ",
            b."判定結果_単語",
            b."判定結果_例句1", 
            b."判定結果_例句2",
            b."時間"
        FROM public."STY_単語テスト詳細情報" b
        WHERE b."テスト番号" = p_test_number
        order by b."更新日時"
    LOOP
        -- 判断三个项目是否都不为×
        v_all_correct := (rec_record."判定結果_単語" <> '×' AND 
                         rec_record."判定結果_例句1" <> '×' AND 
                         rec_record."判定結果_例句2" <> '×');
        
        -- 检查C表中是否存在对应记录
        IF EXISTS (
            SELECT 1 
            FROM public."STY_単語テスト履歴情報" c
            WHERE c.book = rec_record."書籍"
            AND c.classification = rec_record."分類"
            AND c.wordseq = rec_record."単語SEQ"
            AND c.kind = v_test_type
            AND c.level = v_difficulty
        ) THEN
            -- 更新现有记录
            UPDATE public."STY_単語テスト履歴情報"
            SET 
                testtimes = testtimes + 1,
                word_right = word_right + 
                    CASE WHEN rec_record."判定結果_単語" = '○' THEN 1 ELSE 0 END,
                word_wrong = word_wrong + 
                    CASE WHEN rec_record."判定結果_単語" = '×' THEN 1 ELSE 0 END,
                sen1_right = sen1_right + 
                    CASE WHEN rec_record."判定結果_例句1" = '○' THEN 1 ELSE 0 END,
                sen1_wrong = sen1_wrong + 
                    CASE WHEN rec_record."判定結果_例句1" = '×' THEN 1 ELSE 0 END,
                sen2_right = sen2_right + 
                    CASE WHEN rec_record."判定結果_例句2" = '○' THEN 1 ELSE 0 END,
                sen2_wrong = sen2_wrong + 
                    CASE WHEN rec_record."判定結果_例句2" = '×' THEN 1 ELSE 0 END,
                all_right = all_right + 
                    CASE WHEN v_all_correct THEN 1 ELSE 0 END,
                time = time + rec_record."時間",
                recentrighttimes = CASE 
                    WHEN v_all_correct THEN recentrighttimes + 1 
                    ELSE 0 
                END,
                "更新ID" = current_user,
                "更新日時" = CURRENT_TIMESTAMP
            WHERE 
                book = rec_record."書籍"
                AND classification = rec_record."分類"
                AND wordseq = rec_record."単語SEQ"
                AND kind = v_test_type
                AND level = v_difficulty;
        ELSE
            -- 插入新记录
            INSERT INTO public."STY_単語テスト履歴情報" (
                book, classification, wordseq, kind, level,
                testtimes, 
                word_right, word_wrong, 
                sen1_right, sen1_wrong, 
                sen2_right, sen2_wrong, 
                all_right, time, recentrighttimes,
                "登録ID", "更新ID", "登録日時", "更新日時"
            ) VALUES (
                rec_record."書籍", 
                rec_record."分類", 
                rec_record."単語SEQ", 
                v_test_type, 
                v_difficulty,
                1, -- テスト回数
                CASE WHEN rec_record."判定結果_単語" = '○' THEN 1 ELSE 0 END, -- 単語_正確回数
                CASE WHEN rec_record."判定結果_単語" = '×' THEN 1 ELSE 0 END, -- 単語_誤り回数
                CASE WHEN rec_record."判定結果_例句1" = '○' THEN 1 ELSE 0 END, -- 例句1_正確回数
                CASE WHEN rec_record."判定結果_例句1" = '×' THEN 1 ELSE 0 END, -- 例句1_誤り回数
                CASE WHEN rec_record."判定結果_例句2" = '○' THEN 1 ELSE 0 END, -- 例句2_正確回数
                CASE WHEN rec_record."判定結果_例句2" = '×' THEN 1 ELSE 0 END, -- 例句2_誤り回数
                CASE WHEN v_all_correct THEN 1 ELSE 0 END, -- 全部_正確回数
                rec_record."時間", -- 時間
                CASE WHEN v_all_correct THEN 1 ELSE 0 END, -- 直近正確回数
                current_user, -- 登録ID
                current_user, -- 更新ID
                CURRENT_TIMESTAMP, -- 登録日時
                CURRENT_TIMESTAMP -- 更新日時
            );
        END IF;
    END LOOP;
    

    DELETE FROM public."STY_単語テスト情報"
    WHERE "テスト番号" = p_test_number;

    DELETE FROM public."STY_単語テスト詳細情報"
    WHERE "テスト番号" = p_test_number;

END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE VIEW public."V_単語情報リスト0" AS 

SELECT 
  data.book,
  data.kind,
  data.level,
  data."分類" AS classification,
  data."単語SEQ" AS wordseq,
  data.costtime,
  data.testtimes,
  data.all_right,
  data.per,
  data."単語_英語" AS word_e,
  data."単語_日本語" AS word_j,
  data."単語_中国語" AS word_c,
  data.word_right,
  data.word_wrong,
  data."例句1_英語" AS sen1_e,
  data."例句1_日本語" AS sen1_j,
  data."例句1_中国語" AS sen1_c,
  data.sen1_right,
  data.sen1_wrong,
  data."例句2_英語" AS sen2_e,
  data."例句2_日本語" AS sen2_j,
  data."例句2_中国語" AS sen2_c,
  data.sen2_right,
  data.sen2_wrong,
  data.recentrighttimes,
  get_wrong_flg(data.per, data.all_right, data.recentrighttimes, data.kind) AS wrong_flg0
FROM (
    SELECT 
        t.book,
        t.kind,
        t.level,
        d0."分類",
        d0."単語SEQ",
        d0."単語_英語",
        d0."単語_日本語",
        d0."単語_中国語",
        d0."例句1_英語",
        d0."例句1_日本語",
        d0."例句1_中国語",
        d0."例句2_英語",
        d0."例句2_日本語",
        d0."例句2_中国語",
        COALESCE(d1.testtimes, 0) + COALESCE(d2.testtimes, 0) as testtimes,
        COALESCE(d1.word_right, 0) + COALESCE(d2.word_right, 0) as word_right,
        COALESCE(d1.word_wrong, 0) + COALESCE(d2.word_wrong, 0) as word_wrong,
        COALESCE(d1.sen1_right, 0) + COALESCE(d2.sen1_right, 0) as sen1_right,
        COALESCE(d1.sen1_wrong, 0) + COALESCE(d2.sen1_wrong, 0) as sen1_wrong,
        COALESCE(d1.sen2_right, 0) + COALESCE(d2.sen2_right, 0) as sen2_right,
        COALESCE(d1.sen2_wrong, 0) + COALESCE(d2.sen2_wrong, 0) as sen2_wrong,
        COALESCE(d1.all_right, 0) + COALESCE(d2.all_right, 0) as all_right,
        seconds_to_hhmmss(d1.time) as costtime,
        calc_accuracy(
            COALESCE(d1.testtimes, 0) + COALESCE(d2.testtimes, 0),
            COALESCE(d1.all_right, 0) + COALESCE(d2.all_right, 0)
        ) as per,
        case when d1.wrongflg = '1' then COALESCE(d1.recentrighttimes,0)
             else COALESCE(d1.recentrighttimes,0) + COALESCE(d2.recentrighttimes,0) end as recentrighttimes
    FROM 
        "V_単語テスト状況タイトル情報" t
    LEFT JOIN "STY_単語情報" d0
    ON t.book = d0.書籍
    LEFT JOIN "V_単語テスト結果情報" d1 
    ON d0."書籍" = d1.book AND d0.分類 = d1.classification AND d0."単語SEQ" = d1.wordseq AND t.kind = d1.kind AND t.level = d1.level
    LEFT JOIN "STY_単語テスト履歴情報" d2
    ON d0."書籍" = d2.book AND d0.分類 = d2.classification AND d0."単語SEQ" = d2.wordseq AND t.kind = d2.kind AND t.level = d2.level
) data;

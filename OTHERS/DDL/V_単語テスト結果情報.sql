CREATE OR REPLACE VIEW public."V_単語テスト結果情報" AS 
SELECT 
    DATA.*,
    c.recentrighttimes,
    c.wrongflg
FROM
(
SELECT 
  a."書籍" AS book,
  a."分類" AS classification,
  a."単語SEQ" AS wordseq,
  b."テスト種別" AS kind, 
  b."難易度" AS level,
  count(a."テスト番号") AS testtimes,
  sum(CASE WHEN a."判定結果_単語" = '○' THEN 1 ELSE 0 END) AS word_right,
  sum(CASE WHEN a."判定結果_単語" = '×' THEN 1 ELSE 0 END) AS word_wrong,
  sum(CASE WHEN a."判定結果_例句1" = '○' THEN 1 ELSE 0 END) AS sen1_right,
  sum(CASE WHEN a."判定結果_例句1" = '×' THEN 1 ELSE 0 END) AS sen1_wrong,
  sum(CASE WHEN a."判定結果_例句2" = '○' THEN 1 ELSE 0 END) AS sen2_right,
  sum(CASE WHEN a."判定結果_例句2" = '×' THEN 1 ELSE 0 END) AS sen2_wrong,
  sum(
      CASE WHEN 
        a."判定結果_単語" in ('○','-') AND a."判定結果_例句1" in ('○','-') AND a."判定結果_例句2" in ('○','-') THEN 1
          ELSE 0
      END) AS all_right,
  sum(a."時間") AS time
FROM 
  "STY_単語テスト詳細情報" a
  LEFT JOIN "STY_単語テスト情報" b 
    ON a."テスト番号" = b."テスト番号"

WHERE 
  a."ステータス" in ('9') AND
(
  NOT EXISTS (
      SELECT 1
      FROM "COM_指定日付"
  )
  OR to_char(a."更新日時",'YYYYMMDD') <= (
      SELECT "指定日付"
      FROM "COM_指定日付"
      LIMIT 1
  )
)


GROUP BY 
  a."書籍", a."分類", a."単語SEQ", b."テスト種別", b."難易度"
) DATA
LEFT JOIN "V_直近正確回数情報" c 
ON  DATA.book = c.book AND 
    DATA.classification = c.classification AND 
    DATA.wordseq = c.wordseq AND 
    DATA.kind = c.kind AND 
    DATA.level = c.level
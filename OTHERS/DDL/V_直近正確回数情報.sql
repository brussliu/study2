CREATE OR REPLACE VIEW public."V_直近正確回数情報" AS 
SELECT
    book, 
    classification, 
    wordseq,
    kind, 
    level,
    recentrighttimes,
    case when times > recentrighttimes then '1' else '' end as wrongflg
FROM
(
SELECT
    S."書籍" AS book, 
    S."分類" AS classification, 
    S."単語SEQ" AS wordseq,
    Z."テスト種別" AS kind, 
    Z."難易度" AS level, 
    count(case when S."更新日時" > TEMP.updatetime then 1 else 0 end) AS recentrighttimes, 
    count(S.*)  AS times
FROM
    "STY_単語テスト詳細情報" S
LEFT JOIN
(
    SELECT 
        a."書籍",
        a."分類",
        a."単語SEQ",
        c."テスト種別",
        c."難易度",
        MAX(a."更新日時") as updatetime
    FROM 
        "STY_単語テスト詳細情報" a
        LEFT JOIN "STY_単語テスト情報" c ON a."テスト番号" = c."テスト番号"
    WHERE 
        a."ステータス" in ('9')
        AND
        (
            a."判定結果_単語" = '×' OR 
            a."判定結果_例句1" = '×' OR 
            a."判定結果_例句2" = '×'
        )
    GROUP BY 
        a."書籍", a."分類", a."単語SEQ", c."テスト種別", c."難易度"
) TEMP
ON S."書籍" = TEMP."書籍"  AND  S."分類" = TEMP."分類"  AND  S."単語SEQ" = TEMP."単語SEQ"
LEFT JOIN "STY_単語テスト情報" Z ON S."テスト番号" = Z."テスト番号"
WHERE

    S."ステータス" in ('9')
GROUP BY 
    S."書籍", S."分類", S."単語SEQ", Z."テスト種別", Z."難易度"
)
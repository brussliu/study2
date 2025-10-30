CREATE OR REPLACE FUNCTION analyze_update_interrupts_simple(analysis_date DATE)
RETURNS INTEGER
LANGUAGE sql
AS $$
    SELECT COUNT(*)::INTEGER
    FROM (
        SELECT 
            "更新日時" as update_time,
            LAG("更新日時") OVER (ORDER BY "更新日時") as prev_update_time
        FROM "STY_単語テスト詳細情報"   -- 请替换为你的实际表名
        WHERE DATE("更新日時") = analysis_date
        AND "時間" IS NOT NULL
    ) AS time_diffs
    WHERE prev_update_time IS NOT NULL 
      AND (update_time - prev_update_time) > INTERVAL '3 minutes';
$$;
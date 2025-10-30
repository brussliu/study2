drop table public."STY_単語英訳漢情報";

create table public."STY_単語英訳漢情報" (
    "書籍" character varying(50) not null
  , "分類" character varying(20) not null
  , "単語SEQ" integer not null

  , "中国語_正解" character varying(500)
  , "中国語_誤解1" character varying(500)
  , "中国語_誤解2" character varying(500)
  , "中国語_誤解3" character varying(500)
  , "中国語_誤解4" character varying(500)
  , "中国語_誤解5" character varying(500)

  , "日本語_正解" character varying(500)
  , "日本語_誤解1" character varying(500)
  , "日本語_誤解2" character varying(500)
  , "日本語_誤解3" character varying(500)
  , "日本語_誤解4" character varying(500)
  , "日本語_誤解5" character varying(500)

  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) without time zone
  , "更新日時" timestamp(6) without time zone
  , primary key ("書籍", "分類", "単語SEQ")
);
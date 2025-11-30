drop table public."STY_単語質問情報";

create table public."STY_単語質問情報" (
  "書籍" character varying(50) not null
  , "分類" character varying(20) not null
  , "単語SEQ" integer not null
  , "連番" integer not null
  , "区分1" character varying(50)
  , "区分2" character varying(50)
  , "質問" text
  , "正解" text
  , "誤解1" text
  , "誤解2" text
  , "誤解3" text
  , "誤解4" text
  , "誤解5" text
  , "説明" text
  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) with time zone
  , "更新日時" timestamp(6) with time zone
  , primary key ("書籍", "分類", "単語SEQ", "連番")
);

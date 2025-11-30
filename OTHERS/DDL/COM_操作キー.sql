drop table public."COM_JAVA操作情報";

create table public."COM_JAVA操作情報" (
  "キー" character varying(50) not null
  , "ステータス" character varying(50)
  , "値1" text
  , "値2" text
  , "値3" text
  , "値4" text
  , "値5" text
  , "登録日時" timestamp(6) with time zone
  , "更新日時" timestamp(6) with time zone
  , primary key ("キー")
);

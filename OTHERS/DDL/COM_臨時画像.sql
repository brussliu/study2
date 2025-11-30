drop table public."COM_臨時画像";

create table public."COM_臨時画像" (
  "連番" serial not null
  , "区分" character varying(1)
  , "拡張子" character varying(10)
  , "元ファイル" text
  , "縮略ファイル500" text
  , "縮略ファイル200" text
  , "縮略ファイル50" text
  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) without time zone
  , "更新日時" timestamp(6) without time zone
  , primary key ("連番")
);

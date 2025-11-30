drop table public."DOC_資料詳細情報";

create table public."DOC_資料詳細情報" (
  "資料番号" character varying(20) not null
  , "枝番号" integer not null
  , "拡張子" character varying(10)
  , "元ファイル" text
  , "縮略ファイル500" text
  , "縮略ファイル200" text
  , "縮略ファイル50" text
  , "コメント" character varying(200)
  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) without time zone
  , "更新日時" timestamp(6) without time zone
  , primary key ("資料番号", "枝番号")
);

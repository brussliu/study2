drop table public."DOC_資料情報";

create table public."DOC_資料情報" (
  "資料番号" character varying(20) not null
  , "ステータス" character varying(20)
  , "有効期限" character varying(10)
  , "大分類" character varying(50)
  , "中分類" character varying(50)
  , "小分類" character varying(50)
  , "細分類" character varying(50)
  , "コメント" character varying(100)
  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) without time zone
  , "更新日時" timestamp(6) without time zone
  , primary key ("資料番号")
);

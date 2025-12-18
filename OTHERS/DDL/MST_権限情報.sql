drop table public."MST_権限情報";

create table public."MST_権限情報" (
  "店舗ID" character varying(20)
  , "ロール" character varying(20)
  , "権限ID" character varying(20)
  , "権限種別" character varying(20)
  , "権限区分" character varying(20)
  , "備考" character varying(500)
  , "登録日時" timestamp(6) without time zone
  , "更新日時" timestamp(6) without time zone
);

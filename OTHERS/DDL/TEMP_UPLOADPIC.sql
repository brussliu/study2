drop table public."TEMP_UPLOADPIC";

create table public."TEMP_UPLOADPIC" (
  "PICNO" serial not null
  , "PIC" character varying(99999)
  , "店舗ID" character varying(20)
  , "登録日時" timestamp(6) with time zone
  , "更新日時" timestamp(6) with time zone
  , primary key (PICNO)
);

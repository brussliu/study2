drop table public."STY_日次情報";

create table public."STY_日次情報" (
  "日付" character varying(8) not null
  , "単語総数" integer
  , "未勉強個数" integer
  , "勉強中個数" integer
  , "勉強済個数" integer
  , "A_勉強_未勉強_個数" integer
  , "B_中日訳英_未勉強_個数" integer
  , "C_音訳英_未勉強_個数" integer
  , "D_英訳中_未勉強_個数" integer
  , "A_勉強_勉強中_個数" integer
  , "B_中日訳英_勉強中_個数" integer
  , "C_音訳英_勉強中_個数" integer
  , "D_英訳中_勉強中_個数" integer
  , "A_勉強_勉強済_個数" integer
  , "B_中日訳英_勉強済_個数" integer
  , "C_音訳英_勉強済_個数" integer
  , "D_英訳中_勉強済_個数" integer
  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) with time zone
  , "更新日時" timestamp(6) with time zone
  , primary key ("日付")
);

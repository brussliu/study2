drop table public."STY_サイト制限情報";

create table public."STY_サイト制限情報" (
    "サイト" character varying(100)
  , "ステータス" character varying(50)
  , "分類" character varying(50)
  , "区分" character varying(50)
  , "条件-月" int
  , "条件-火" int
  , "条件-水" int
  , "条件-木" int
  , "条件-金" int
  , "条件-土" int
  , "条件-日" int
  , "条件-休日" int  
  , "額度-月" int
  , "額度-火" int
  , "額度-水" int
  , "額度-木" int
  , "額度-金" int
  , "額度-土" int
  , "額度-日" int
  , "額度-休日" int  
  , "毎日ロック時間" character varying(50)
  , "次のロック時間" character varying(50)

);
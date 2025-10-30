drop table public."STY_単語テスト履歴情報";

create table public."STY_単語テスト履歴情報" (

    book character varying(50) not null
  , classification character varying(20) not null
  , wordseq integer not null
  , kind character varying(50) not null
  , level character varying(50) not null
  , testtimes integer
  , word_right integer
  , word_wrong integer
  , sen1_right integer
  , sen1_wrong integer
  , sen2_right integer
  , sen2_wrong integer
  , all_right integer
  , time integer
  , recentrighttimes integer

  , "登録ID" character varying(20)
  , "更新ID" character varying(20)
  , "登録日時" timestamp(6) without time zone
  , "更新日時" timestamp(6) without time zone
  , primary key (book, classification, wordseq)
);

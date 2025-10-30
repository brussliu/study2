drop table public."STY_�P��e�X�g�������";

create table public."STY_�P��e�X�g�������" (

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

  , "�o�^ID" character varying(20)
  , "�X�VID" character varying(20)
  , "�o�^����" timestamp(6) without time zone
  , "�X�V����" timestamp(6) without time zone
  , primary key (book, classification, wordseq)
);

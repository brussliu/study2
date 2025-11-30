drop table public."STY_�摜���";

create table public."STY_�摜���" (

    "SEQ" character varying(20) primary key
  , "����" character varying(1)
  , "SUB-SEQ" integer

  , "���t�@�C��" text
  , "�k���t�@�C��" text

  , "�o�^ID" character varying(20)
  , "�X�VID" character varying(20)
  , "�o�^����" timestamp(6) with time zone
  , "�X�V����" timestamp(6) with time zone
);

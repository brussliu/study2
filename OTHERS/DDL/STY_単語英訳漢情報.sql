drop table public."STY_�P��p�󊿏��";

create table public."STY_�P��p�󊿏��" (
    "����" character varying(50) not null
  , "����" character varying(20) not null
  , "�P��SEQ" integer not null

  , "������_����" character varying(500)
  , "������_���1" character varying(500)
  , "������_���2" character varying(500)
  , "������_���3" character varying(500)
  , "������_���4" character varying(500)
  , "������_���5" character varying(500)

  , "���{��_����" character varying(500)
  , "���{��_���1" character varying(500)
  , "���{��_���2" character varying(500)
  , "���{��_���3" character varying(500)
  , "���{��_���4" character varying(500)
  , "���{��_���5" character varying(500)

  , "�o�^ID" character varying(20)
  , "�X�VID" character varying(20)
  , "�o�^����" timestamp(6) without time zone
  , "�X�V����" timestamp(6) without time zone
  , primary key ("����", "����", "�P��SEQ")
);
CREATE OR REPLACE VIEW public."V_単語テスト状況タイトル情報" AS 
select 
    distinct A."書籍" as book, B.kind, B.level 
from "STY_単語情報" A
,(
select 'A.勉強' as kind, '1.簡単' as level
union all
select 'B.中日訳英' as kind, '1.簡単' as level
union all
select 'C.音訳英' as kind, '1.簡単' as level
union all
select 'D.英訳中' as kind, '1.簡単' as level
) B
order by A."書籍",B.kind,B.level
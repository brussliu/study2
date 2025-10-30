CREATE OR REPLACE VIEW public."V_単語情報リスト" AS 

SELECT 
  T1.*,
  get_wrong_flg(T1.per, T1.all_right, T1.recentrighttimes, T1.kind, T2.wrong_flg0) AS wrong_flg
FROM 
"V_単語情報リスト0" T1 
left join "V_単語情報リスト0" T2 on
T1.book = T2.book AND 
T1.classification = T2.classification AND 
T1.wordseq = T2.wordseq AND 
T1.level = T2.level AND 
T2.kind = 'B.中日訳英';
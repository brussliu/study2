CREATE OR REPLACE FUNCTION public.update_max_value()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- 如果a3为空或者为0，则自动设置为相同a1,a2下的最大值+1
    IF NEW."連番" IS NULL OR NEW."連番" = 0 THEN
        SELECT COALESCE(MAX("連番"), 0) + 1 
        INTO NEW."連番"
        FROM "STY_単語質問情報"
        WHERE "書籍" = NEW."書籍" AND "分類" = NEW."分類" AND "単語SEQ" = NEW."単語SEQ";
    END IF;
    
    RETURN NEW;
END;
$function$

CREATE TRIGGER trigger_auto_update
    BEFORE INSERT ON "STY_単語質問情報"
    FOR EACH ROW
    EXECUTE FUNCTION update_max_value();
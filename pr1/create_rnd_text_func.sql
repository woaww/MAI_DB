CREATE OR REPLACE FUNCTION rnd_text(
    len int,
    list_of_chars text DEFAULT
    'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюяABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789'
)
RETURNS text AS $$
DECLARE
    result text := '';
    i int;
BEGIN
    FOR i IN 1..len LOOP
        result := result || substr(
            list_of_chars,
            rnd_integer(1, length(list_of_chars)),
            1
        );
    END LOOP;

    RETURN result;
END;
$$ LANGUAGE plpgsql;
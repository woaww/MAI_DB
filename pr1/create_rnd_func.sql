CREATE OR REPLACE FUNCTION rnd_integer(a int, b int)
RETURNS int AS $$
BEGIN
    RETURN floor(random() * (b - a + 1) + a)::int;
END;
$$ LANGUAGE plpgsql;
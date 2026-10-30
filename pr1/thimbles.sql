DO $$
DECLARE
    prize int;
    choice int;
    win_first int := 0;
    win_change int := 0;
    i int;
BEGIN
    FOR i IN 1..1000 LOOP
        prize := rnd_integer(1, 3);
        choice := rnd_integer(1, 3);

        IF prize = choice THEN
            win_first := win_first + 1;
        ELSE
            win_change := win_change + 1;
        END IF;
    END LOOP;

    RAISE NOTICE 'Побед без смены: %', win_first;
    RAISE NOTICE 'Побед со сменой: %', win_change;

    RAISE NOTICE 'Вероятность без смены: %%%',
        round(win_first / 1000.0 * 100, 2);

    RAISE NOTICE 'Вероятность со сменой: %%%',
        round(win_change / 1000.0 * 100, 2);
END;
$$ LANGUAGE plpgsql;
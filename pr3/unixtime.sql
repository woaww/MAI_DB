DO $$
DECLARE
    v_m_name VARCHAR(20) := 'Ivan Petrov';
    v_m_date_of_birth DATE := '1990-09-01';

    v_date TEXT;
    v_day TEXT;
    v_time TEXT;

    v_unix_now BIGINT;
    v_unix_birth BIGINT;
    v_diff BIGINT;

    v_age INTEGER;
    v_days BIGINT;
    v_hours BIGINT;
    v_minutes BIGINT;

BEGIN
    RAISE NOTICE 'Результат:';
    RAISE NOTICE 'Меня зовут: %', v_m_name;
    RAISE NOTICE 'Я родился: %', v_m_date_of_birth;

    v_date := TO_CHAR(CURRENT_DATE, 'DD-MM-YYYY');
    v_day := TO_CHAR(CURRENT_DATE, 'DAY');
    v_time := TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS');

    RAISE NOTICE 'Сегодня: %', v_date;
    RAISE NOTICE 'День недели: %', v_day;
    RAISE NOTICE 'Время: %', v_time;

    -- Перевод дат в Unix Time
    v_unix_now := EXTRACT(EPOCH FROM CURRENT_TIMESTAMP);
    v_unix_birth := EXTRACT(EPOCH FROM
        (v_m_date_of_birth::TIMESTAMP AT TIME ZONE 'UTC'));

    RAISE NOTICE 'Текущее Unix Time: %', v_unix_now;
    RAISE NOTICE 'Unix Time рождения: %', v_unix_birth;

    -- Обратное преобразование Unix Time
    RAISE NOTICE 'Текущая дата из Unix: %',
        TO_TIMESTAMP(v_unix_now);
    RAISE NOTICE 'Дата рождения из Unix: %',
        TO_TIMESTAMP(v_unix_birth) AT TIME ZONE 'UTC';

    -- Разница между датами в секундах
    v_diff := v_unix_now - v_unix_birth;

    v_days := v_diff / 86400;
    v_hours := v_diff / 3600;
    v_minutes := v_diff / 60;

    RAISE NOTICE 'Прожито секунд: %', v_diff;
    RAISE NOTICE 'Прожито минут: %', v_minutes;
    RAISE NOTICE 'Прожито часов: %', v_hours;
    RAISE NOTICE 'Прожито дней: %', v_days;

    -- Вычисление возраста
    v_age := EXTRACT(YEAR FROM AGE(v_m_date_of_birth));

    RAISE NOTICE 'Возраст через AGE: %', v_age;

    -- Возраст через Unix Time
    RAISE NOTICE 'Возраст через Unix Time: %',
        EXTRACT(YEAR FROM AGE(
            TO_TIMESTAMP(v_unix_now),
            TO_TIMESTAMP(v_unix_birth)
        ));

    -- Извлечение компонентов даты из Unix Time
    RAISE NOTICE 'Год: %',
        EXTRACT(YEAR FROM TO_TIMESTAMP(v_unix_now));

    RAISE NOTICE 'Месяц: %',
        EXTRACT(MONTH FROM TO_TIMESTAMP(v_unix_now));

    RAISE NOTICE 'День: %',
        EXTRACT(DAY FROM TO_TIMESTAMP(v_unix_now));

    RAISE NOTICE 'Час: %',
        EXTRACT(HOUR FROM TO_TIMESTAMP(v_unix_now));

    RAISE NOTICE 'Минута: %',
        EXTRACT(MINUTE FROM TO_TIMESTAMP(v_unix_now));

    RAISE NOTICE 'День недели: %',
        EXTRACT(DOW FROM TO_TIMESTAMP(v_unix_now));

END $$;
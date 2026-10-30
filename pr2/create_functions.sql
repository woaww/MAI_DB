CREATE OR REPLACE FUNCTION calculate_discriminant(
    p_a NUMERIC,
    p_b NUMERIC,
    p_c NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
IMMUTABLE
AS $$
    SELECT p_b * p_b - 4 * p_a * p_c;
$$;


CREATE OR REPLACE PROCEDURE solve_quadratic(
    p_equation_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_a NUMERIC;
    v_b NUMERIC;
    v_c NUMERIC;

    v_d NUMERIC;
    v_x1 NUMERIC;
    v_x2 NUMERIC;
    v_root_count INTEGER;
BEGIN
    SELECT a, b, c
    INTO v_a, v_b, v_c
    FROM quadratic_equations
    WHERE id = p_equation_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Уравнение с id = % не найдено',
            p_equation_id;
    END IF;
	
    v_d := calculate_discriminant(v_a, v_b, v_c);
    IF v_d > 0 THEN
        v_root_count := 2;

        v_x1 := (-v_b + sqrt(v_d)) / (2 * v_a);
        v_x2 := (-v_b - sqrt(v_d)) / (2 * v_a);

    ELSIF v_d = 0 THEN
        v_root_count := 1;

        v_x1 := -v_b / (2 * v_a);
        v_x2 := NULL;

    ELSE
        v_root_count := 0;

        v_x1 := NULL;
        v_x2 := NULL;

    END IF;
	
    INSERT INTO quadratic_solutions (
        equation_id,
        discriminant,
        root_count,
        x1,
        x2
    )
    VALUES (
        p_equation_id,
        v_d,
        v_root_count,
        v_x1,
        v_x2
    )

    ON CONFLICT (equation_id)
    DO UPDATE SET
        discriminant = EXCLUDED.discriminant,
        root_count = EXCLUDED.root_count,
        x1 = EXCLUDED.x1,
        x2 = EXCLUDED.x2;
END;
$$;


CREATE OR REPLACE PROCEDURE solve_all_quadratics()
LANGUAGE plpgsql
AS $$
DECLARE
    v_equation RECORD;
BEGIN

    FOR v_equation IN
        SELECT id
        FROM quadratic_equations
        ORDER BY id
    LOOP

        CALL solve_quadratic(v_equation.id);

    END LOOP;

END;
$$;

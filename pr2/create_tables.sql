CREATE TABLE quadratic_equations (
    id SERIAL PRIMARY KEY,
    a NUMERIC NOT NULL,
    b NUMERIC NOT NULL,
    c NUMERIC NOT NULL,

    CONSTRAINT check_a_not_zero CHECK (a <> 0)
);


CREATE TABLE quadratic_solutions (
    id SERIAL PRIMARY KEY,

    equation_id INTEGER NOT NULL UNIQUE,
    discriminant NUMERIC NOT NULL,
    root_count INTEGER NOT NULL,
    x1 NUMERIC,
    x2 NUMERIC,

    CONSTRAINT fk_equation
        FOREIGN KEY (equation_id)
        REFERENCES quadratic_equations(id)
        ON DELETE CASCADE,

    CONSTRAINT check_root_count
        CHECK (root_count IN (0, 1, 2))
);

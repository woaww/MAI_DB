CALL solve_all_quadratics();


SELECT
    q.id,
    q.a,
    q.b,
    q.c,
    s.discriminant,
    s.root_count,
    s.x1,
    s.x2
FROM quadratic_equations q
JOIN quadratic_solutions s
    ON q.id = s.equation_id
ORDER BY q.id;
SELECT 
    r.date,
    s.first_name,
    s.last_name,
    s.hourly_rate,
    sh.start_time,
    sh.end_time,
    EXTRACT(EPOCH FROM (sh.end_time - sh.start_time)) / 3600 AS hours_in_shift,
    (EXTRACT(EPOCH FROM (sh.end_time - sh.start_time)) / 3600) * s.hourly_rate AS staff_cost
FROM
    rotations r
LEFT JOIN
    staff s ON r.staff_id = s.staff_id
LEFT JOIN
    shifts sh ON r.shift_id = sh.shift_id
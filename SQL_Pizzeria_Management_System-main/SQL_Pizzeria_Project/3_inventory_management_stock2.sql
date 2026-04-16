SELECT 
    s2.ing_name,
    s2.ordered_weight,
    (ing.ing_weight * inv.quantity) as total_inv_weight,
    (ing.ing_weight * inv.quantity) - s2.ordered_weight as remaining_weight
FROM (SELECT  
    ing_id,
    ing_name,
    sum(ordered_weight) as ordered_weight
FROM
    stock1
GROUP BY
    ing_id, ing_name) as s2
LEFT JOIN
    inventory inv ON s2.ing_name = inv.ing_name
LEFT JOIN
    ingredients ing ON s2.ing_id = ing.ing_id
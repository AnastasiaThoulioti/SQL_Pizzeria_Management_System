CREATE OR REPLACE VIEW stock1 AS
SELECT 
    s1.ing_id,
    s1.ing_name,    
    s1.recipe_quantity,
    s1.order_quantity,
    (s1.order_quantity * s1.recipe_quantity) as ordered_weight,
    (s1.ing_price/s1.ing_weight) as unit_cost,
    (s1.order_quantity * s1.recipe_quantity) * (s1.ing_price/s1.ing_weight) as ingredient_cost
FROM
    (SELECT  
    o.item_id,
    i.item_sku,
    i.item_name,
    r.ing_id,
    ing.ing_name,
    ing.ing_weight,
    ing.ing_price,
    r.quantity as recipe_quantity,
    sum(o.quantity) as order_quantity
    FROM
    orders o   
    LEFT JOIN
    items i ON o.item_id = i.item_id
    LEFT JOIN
        recipe r ON i.item_sku = r.recipe_id
    LEFT JOIN  
        ingredients ing on r.ing_id = ing.ing_id
    GROUP BY
    o.item_id, i.item_sku, i.item_name,recipe_quantity, r.ing_id, ing.ing_name, ing.ing_weight,
    ing.ing_price) as s1
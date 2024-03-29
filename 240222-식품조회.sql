-- 원트만에 성공했다...
-- 대신 중요한건 오타 안내는거, 헷갈리지말기, 조건 빼먹지 말기..실전에선 확인불가능하니까 조심하기!!

SELECT P.PRODUCT_ID, P.PRODUCT_NAME, (P.PRICE * O.AMOUNT) AS TOTAL_SALES
FROM FOOD_PRODUCT P
JOIN (SELECT PRODUCT_ID, SUM(AMOUNT) AS AMOUNT
     FROM FOOD_ORDER
     WHERE PRODUCE_DATE LIKE '%2022-05%'
     GROUP BY PRODUCT_ID) O 
     ON P.PRODUCT_ID = O.PRODUCT_ID
ORDER BY TOTAL_SALES DESC, P.PRODUCT_ID ASC

SELECT PRODUCT_CODE, SUM(SALES_AMOUNT*PRICE) AS SALES
FROM PRODUCT JOIN OFFLINE_SALE USING(PRODUCT_ID)
GROUP BY PRODUCT_CODE
ORDER BY SALES DESC, PRODUCT_CODE

SELECT p.PRODUCT_CODE , sum(p.PRICE * o.SALES_AMOUNT) as SALES
from PRODUCT as p join OFFLINE_SALE as o
on p.PRODUCT_ID = o.PRODUCT_ID
group by p.PRODUCT_ID
order by 2 desc ,1

SELECT P.PRODUCT_CODE, SUM(P.PRICE*O.SALES_AMOUNT) AS SALES
FROM PRODUCT P
JOIN OFFLINE_SALE O ON P.PRODUCT_ID = O.PRODUCT_ID
GROUP BY P.PRODUCT_ID -- PRODUCT_ID 로 묶어버리면 됨, 계산은 SUM()으로 해주고!
ORDER BY SALES DESC, PRODUCT_CODE ASC

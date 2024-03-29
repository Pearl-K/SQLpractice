-- 정답풀이
SELECT CP.CAR_ID, CP.CAR_TYPE, CP.FEE 
FROM (SELECT CAR_ID, FIRST_VALUE(CAR_ID) OVER (PARTITION BY CAR_ID ORDER BY END_DATE) FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAST(CAST(END_DATE AS DATE) AS SIGNED)>=20221101
GROUP BY CAR_ID) H

RIGHT OUTER JOIN (SELECT C.CAR_ID, C.CAR_TYPE, CAST(C.DAILY_FEE*30*(100-P.DISCOUNT_RATE)/100 AS SIGNED) FEE, P.DISCOUNT_RATE
FROM CAR_RENTAL_COMPANY_CAR C, CAR_RENTAL_COMPANY_DISCOUNT_PLAN P
WHERE C.CAR_TYPE = P.CAR_TYPE

AND (C.CAR_TYPE = '세단' OR C.CAR_TYPE = 'SUV')
AND ((C.DAILY_FEE*30*(100-P.DISCOUNT_RATE)/100) >= 500000 AND (C.DAILY_FEE*30*(100-P.DISCOUNT_RATE)/100)<2000000)
AND P.DURATION_TYPE = '30일 이상') CP 
ON H.CAR_ID = CP.CAR_ID

WHERE H.CAR_ID IS NULL
ORDER BY CP.FEE DESC, CP.CAR_TYPE, CP.CAR_ID DESC


-- 내가 하다가 막힌 풀이

SELECT R.CAR_ID, R.CAR_TYPE, ROUND(R.DAILY_FEE*30 - (R.DAILY_FEE*30*DIS.DISCOUNT_RATE)) AS FEE
FROM CAR_RENTAL_COMPANY_CAR R
LEFT JOIN (SELECT *
          FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
          WHERE END_DATE < '2022-11-01') AS H ON R.CAR_ID = H.CAR_ID
RIGHT OUTER JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS DIS ON R.CAR_TYPE = DIS.CAR_TYPE
WHERE R.CAR_TYPE LIKE '%SUV%' or R.CAR_TYPE LIKE '%세단%'
GROUP BY R.CAR_ID
ORDER BY FEE DESC, R.CAR_TYPE ASC, R.CAR_ID DESC

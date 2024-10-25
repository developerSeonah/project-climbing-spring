CREATE TABLE BATTLE_RECORD(
	BATTLE_RECORD_NUM INT PRIMARY KEY,					--크루전 참여기록 PK
	BATTLE_RECORD_BATTLE_NUM INT,						--크루전 FK
	BATTLE_RECORD_CREW_NUM INT,							--크루전 참여한 크루 FK
	BATTLE_RECORD_IS_WINNER CHAR(1) DEFAULT 'F' CHECK(BATTLE_RECORD_IS_WINNER IN ('T', 'F')),		--해당 크루 승리 여부
	BATTLE_RECORD_MVP_ID VARCHAR(100) DEFAULT NULL,		--해당 크루전 MVP사용자의 PK
	
	-- 외래키 제약조건 설정
	--크루전 FK, 크루전 PK가 삭제될시 NULL로 설정
    CONSTRAINT FK_BATTLE_RECORD_BATTLE_NUM 
    FOREIGN KEY (BATTLE_RECORD_BATTLE_NUM)
    REFERENCES BATTLE(BATTLE_NUM)
    ON DELETE SET NULL,
    
    --크루 FK, 크루가 삭제되어도 변경하지 않음
    CONSTRAINT FK_BATTLE_RECORD_CREW_NUM
    FOREIGN KEY (BATTLE_RECORD_CREW_NUM)
    REFERENCES CREW(CREW_NUM)
);

SELECT
		BR.BATTLE_RECORD_BATTLE_NUM,
		BR.BATTLE_RECORD_IS_WINNER,
		BR.BATTLE_RECORD_MVP_ID,
		BR.BATTLE_RECORD_CREW_NUM,
		C.CREW_NAME,
		C.CREW_LEADER,
		C.CREW_PROFILE
			FROM
			BATTLE_RECORD BR
			JOIN
			CREW C
			ON
			BR.BATTLE_RECORD_CREW_NUM = C.CREW_NUM
			WHERE
			BR.BATTLE_RECORD_BATTLE_NUM = 4;
			
--크루전 등록 BATTLE_RECORD_BATTLE_NUM, BATTLE_RECORD_CREW_NUM
INSERT INTO BATTLE_RECORD(BATTLE_RECORD_NUM,BATTLE_RECORD_BATTLE_NUM,BATTLE_RECORD_CREW_NUM)
VALUES ((SELECT NVL(MAX(BATTLE_RECORD_NUM),0)+1 FROM BATTLE_RECORD),?,?)

--크루전 승리크루 업데이트 BATTLE_RECORD_IS_WINNER, BATTLE_RECORD_MVP_ID, BATTLE_RECORD_BATTLE_NUM, BATTLE_RECORD_CREW_NUM
UPDATE 
	BATTLE_RECORD 
SET 
	BATTLE_RECORD_IS_WINNER = ?,
	BATTLE_RECORD_MVP_ID = ?
WHERE 
	BATTLE_RECORD_BATTLE_NUM = ? 
	AND BATTLE_RECORD_CREW_NUM = ?

--내 크루 승리목록 BATTLE_RECORD_CREW_NUM
SELECT
	BR.BATTLE_RECORD_NUM,
	BR.BATTLE_RECORD_BATTLE_NUM,
	BR.BATTLE_RECORD_CREW_NUM,
	BR.BATTLE_RECORD_IS_WINNER,
	BR.BATTLE_RECORD_MVP_ID
FROM
	BATTLE_RECORD BR
JOIN
	CREW C
ON
	BR.BATTLE_RECORD_CREW_NUM = C.CREW_NUM
JOIN
	BATTLE B
ON
	BR.BATTLE_RECORD_BATTLE_NUM = B.BATTLE_NUM
WHERE
	BR.BATTLE_RECORD_IS_WINNER = 'T' 
	AND BR.BATTLE_RECORD_CREW_NUM = ?;
	
--해당 크루전 내용 BATTLE_RECORD_BATTLE_NUM
SELECT
	BR.BATTLE_RECORD_NUM,
	G.GYM_NAME,
	G.GYM_LOCATION,
	B.BATTLE_GAME_DATE
FROM
	BATTLE_RECORD BR
JOIN
	BATTLE B
ON
	B.BATTLE_NUM = BR.BATTLE_RECORD_BATTLE_NUM
JOIN
	CREW C
ON
	BR.BATTLE_RECORD_CREW_NUM = C.CREW_NUM
JOIN
	GYM G
ON
	B.BATTLE_GYM_NUM = G.GYM_NUM
WHERE
	B.BATTLE_NUM = ?

--해당 크루전 참가한 크루 개수 BATTLE_RECORD_BATTLE_NUM
SELECT
    BR.BATTLE_RECORD_BATTLE_NUM,
    COUNT(DISTINCT BR.BATTLE_RECORD_CREW_NUM) OVER (PARTITION BY B.BATTLE_NUM) AS BATTLE_RECORD_CREW_TOTAL
FROM
    BATTLE_RECORD BR
JOIN
    BATTLE B 
ON 
    B.BATTLE_NUM = BR.BATTLE_RECORD_BATTLE_NUM
WHERE
    BR.BATTLE_RECORD_BATTLE_NUM = ?

--크루전 참가크루 전부 조회
SELECT
	BR.BATTLE_RECORD_BATTLE_NUM,
	BR.BATTLE_RECORD_IS_WINNER,
	BR.BATTLE_RECORD_MVP_ID,
	BR.BATTLE_RECORD_CREW_NUM,
	C.CREW_NAME,
	C.CREW_LEADER,
	C.CREW_PROFILE
FROM
	BATTLE_RECORD BR
JOIN
	CREW C
ON
	BR.BATTLE_RECORD_CREW_NUM = C.CREW_NUM
WHERE
	BR.BATTLE_RECORD_BATTLE_NUM = ?
	
--해당 암벽장에서 실행된 크루전 전부 출력 BATTLE_GYM_NUM
SELECT
	BATTLE_RECORD_NUM,
	BATTLE_RECORD_BATTLE_NUM,
	BATTLE_RECORD_CREW_NUM,
	BATTLE_GAME_DATE,
	BATTLE_RECORD_MVP_ID
FROM
	BATTLE_RECORD BR
JOIN
	GYM G
ON
	B.BATTLE_GYM_NUM = G.GYM_NUM
WHERE
	B.BATTLE_GYM_NUM = 4

SELECT
	B.BATTLE_GYM_NUM,
	BR.BATTLE_RECORD_BATTLE_NUM,
	BR.BATTLE_RECORD_IS_WINNER,
	BR.BATTLE_RECORD_MVP_ID,
	BR.BATTLE_RECORD_CREW_NUM,
	C.CREW_NAME,
	C.CREW_LEADER,
	C.CREW_PROFILE
			FROM
			BATTLE_RECORD BR
			JOIN CREW C ON BR.BATTLE_RECORD_CREW_NUM = C.CREW_NUM
			JOIN BATTLE B ON BR.BATTLE_RECORD_BATTLE_NUM = B.BATTLE_NUM	
			JOIN GYM G ON B.BATTLE_GYM_NUM = G.GYM_NUM
			WHERE
			B.BATTLE_GYM_NUM = ? AND BATTLE_RECORD_IS_WINNER = 'T'
			
	SELECT 
				    B.BATTLE_GAME_DATE, 
				    C.CREW_NAME, 
				    C.CREW_PROFILE, 
				    BR.BATTLE_RECORD_MVP_ID
				FROM 
				    BATTLE_RECORD BR
				JOIN 
				    BATTLE B ON BR.BATTLE_RECORD_BATTLE_NUM = B.BATTLE_NUM
				JOIN 
				    CREW C ON BR.BATTLE_RECORD_CREW_NUM = C.CREW_NUM
				WHERE 
				    B.BATTLE_GYM_NUM = 4 AND BR.BATTLE_RECORD_IS_WINNER = 'Y'
-- DML : DATA MANIPULATION LANGUAGE ( 데이터 조작어 )
-- INSERT / UPDATE / DELETE

-- 현재 유저에 속한 테이블 목록 보기
SELECT * FROM USER_TABLES;
-- 필요없는 테이블은 삭제하기 (기존 연습문제로 만든 것들)
DROP TABLE DEPT;
DROP TABLE EMP;

-- 테스트용 테이블 및 데이터 만들기
CREATE TABLE DEPT_COPY
AS
SELECT *
FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;

-- 데이터 삭제 ( TRUNCATE TABLE )
TRUNCATE TABLE DEPT_COPY;

-- 데이터 추가 ( INSERT )
INSERT INTO DEPT_COPY
VALUES (50, 'ACCOUNTING', 'NEW YORK'); -- DNO, DNAME, LOC / 1행 추가

COMMIT; -- COMMIT을 완료해야 데이터에 영구 반영됨

-- 기존 DNO, DNAME, LOC 순서대로 했지만 VALUE값 섞여서 넣더라도
-- 컬럼명 뒤에 (DNO, LOC, DNAME) 으로 순서에 맞게 처리가 가능하지만 좋은 방법 아님
INSERT INTO DEPT_COPY(DNO, LOC, DNAME)
VALUES (20, 'DALLAS', 'RESEARCH'); 

INSERT INTO DEPT_COPY
VALUES (30, 'SALES', 'CHICAGO');

INSERT INTO DEPT_COPY
VALUES (40, 'OPERATION', 'BOSTON');

-- 데이터 추가
-- 1) NULL인 값은 생략하고 추가하는 방법
INSERT INTO DEPT_COPY(DNO, DNAME)
VALUES(50, 'SALES');

-- 2) 명시적으로 NULL 추가하는 방법 (추천)
INSERT INTO DEPT_COPY
VALUES(60, 'OPERATIONS', NULL);

-- 테스트 데이터 및 ENP_COPY 테이블 만들기
CREATE TABLE EMP_COPY
AS
SELECT *
FROM EMPLOYEE
WHERE 1=2; -- 구조만 복사

-- EMP_COPY 테이블에 데이터 넣기
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7000, 'CANDY', 'MANAGER', SYSDATE, 10); -- 날짜형을 자동으로 TO_DATE 형태로 바꿔주지만 넣어주는게 좋음

SELECT * FROM EMP_COPY; -- 확인용

-- 롤백 : 자료를 잘못 넣어 되돌려야 할 경우 사용, 커밋 전 상태로 돌아감 (작업 취소) <-> COMMIT
ROLLBACK;

-- 다른 테이블의 데이터를 복사해서 INSERT 하기
SELECT * FROM DEPT_COPY;
-- 데이터 / 공간 비우기 (삭제)
TRUNCATE TABLE DEPT_COPY;
-- 다른 테이블의 데이터를 복사해서 INSERT 하기
INSERT INTO DEPT_COPY
SELECT * FROM DEPARTMENT;

-- 데이터 수정하기 ( UPDATE )
SELECT * FROM DEPT_COPY;

-- 일반적인 사용 : UPDATE + WHERE 조건절
-- 문법 )
-- UPDATE 테이블명 SET 컬럼명(수정할값) WHERE 조건
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING'
WHERE DNO = 20;

-- 실행 취소
ROLLBACK;

-- DB 영구 반영
COMMIT;

-- 문제 1) DEPT_COPY 테이블에 LOC 컬럼을 'PUSAN'으로 수정하는데, 부서명이 'SALES'만 수정 되도록 처리하기
UPDATE DEPT_COPY
SET LOC = 'PUSAN'
WHERE DNAME = 'SALES';

-- 응용문제 2) DEPT_COPY 테이블에서 부서번호가 20인 부서만 부서이름을 'JAVA'로 수정하고, LOC 컬럼을 'SEOUL'로 수정하기
UPDATE DEPT_COPY
SET DNAME = 'JAVA',
      LOC = 'SEOUL'
WHERE DNO = 20;

-- 특이한 예) DEPT_COPY 테이블에서 부서 번호가 10인 데이터를 가져와서 
--                부서번호가 20인 LOC 데이터로 수정하기
UPDATE DEPT_COPY
SET LOC = (SELECT LOC FROM DEPT_COPY WHERE DNO = 20)
WHERE DNO = 10;

-- DELETE : 테이블의 내용을 삭제하는 DML 명령어
-- COMMIT 해야 영구적으로 처리
-- 문법)
-- DELETE [FROM] 테이블명 WHERE 조건
DELETE FROM DEPT_COPY -- FROM 생략 가능
WHERE DNO = 10;

-- 문제 2) DEPT_COPY 테이블에서 부서번호(DNO)가 20 30인 데이터를 삭제하시오
DELETE FROM DEPT_COPY
WHERE DNO IN (20, 30);

-- 참고 : DELETE ~ 서브쿼리 사용 가능
DELETE FROM DEPT_COPY
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME = 'SALES');
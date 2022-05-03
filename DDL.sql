-- DDL : 데이터 정의어
-- 테이블 만들기, 테이블 수정하기, 컬럼 수정하기, 컬럼 추가하기

-- 테이블 만들기
-- 예) 부서 정보를 저장하기 위한 테이블 생성하기
-- 테이블명: TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT(
        DNO NUMBER(2),
        DNAME VARCHAR2(20),
        LOC VARCHAR2(20)
);

-- 테이블 삭제하기 - 테이블 내 내용 삭제
DROP TABLE TB_DEPARTMENT;

-- 테이블 복사하기 - 테이블 폼(구조) 및 내용 전체 복사
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT;

CREATE TABLE TB_DEPARTMENT2
AS
SELECT *
FROM DEPARTMENT
WHERE 1=2; -- 거짓으로 조회

DROP TABLE TB_DEPARTMENT;
DROP TABLE TB_DEPARTMENT2;

-- 20번 부서 소속 사원에 대한 정보를 포함한 DEPT20 테이블 생성하기
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM EMPLOYEE
WHERE DNO = 20;

-- 테이블 구조를 변경하는 명령어
-- ALTER TABLE ~
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE 1=2;

-- TB_DEPARTMENT 테이블에 컬럼 추가
ALTER TABLE TB_DEPARTMENT
ADD(BIRTH DATE); -- 컬럼 BIRTH 자료형 DATE

-- TB_DEPARTMENT 테이블에 컬럼 변경
-- DNAME VARCHAR2(14) -> VARCHAR2(20) 변경
ALTER TABLE TB_DEPARTMENT
MODIFY DNAME VARCHAR2(20);

-- TB_DEPARTMENT 테이블에 컬럼 삭제
-- BIRTH 컬럼 삭제, 한번에 하나만 삭제 가능
ALTER TABLE TB_DEPARTMENT
DROP COLUMN BIRTH;

-- 테이블 이름을 변경하는 명령어
-- 문법) RENAME A TO B : A테이블명을 B테이블명으로 바꾸기
RENAME TB_DEPARTMENT02 TO TB_DEPARTMENT;

-- 테이블의 모든 데이터를 제거하는 명령어(데이터 + 할당된 공간(메모리))
-- 테스트 데이터 생성
CREATE TABLE TB_DEPARTMENT02
AS
SELECT *
FROM DEPARTMENT;

-- 데이터 삭제
TRUNCATE TABLE TB_DEPARTMENT02;

-- 추가로 오라클 DB에서 사용하는 메타정보
-- (생성된 테이블, 컬럼정보, 유저정보 등)를 볼 수 있는 테이블
-- USER_xxx : 접속된 유저에 대한 여러가지 정보들을 보여줌(컬럼, 테이블 등)
-- ALL_XXX : 접속된 유저 + 다른 유저에 대한 정보들을 보여줌(컬럼, 테이블 등)
-- DBA_XXX : 모든 유저에 대한 정보들을 보여줌(컬럼, 테이블 등)
SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES;

DROP TABLE TB_DEPARTMENT02;

--  DDL(데이터 정의어) 실습
-- 연습문제 1) 다음 표에 명시된대로 DEPT 테이블을 생성하세요
-- 컬럼명 : DNO / 데이터타입 : NUMBER / 크기 : 2
-- 컬럼명 : DNAME / 데이터타입 : VARCHAR2 / 크기 : 14
-- 컬럼명 : LOC / 데이터타입 : VARCHAR2 / 크기 : 13
CREATE TABLE DEPT(
       DNO NUMBER(2),
       DNAME VARCHAR2(14),
       LOC VARCHAR2(13)
);

-- 연습문제 2) 다음 표에 명시된 대로 EMP 테이블을 생성하세요
-- 컬럼명 : DNO / 데이터타입 : NUMBER / 크기 : 4
-- 컬럼명 : DNAME / 데이터타입 : VARCHAR2 / 크기 : 10
-- 컬럼명 : LOC / 데이터타입 : NUMBER / 크기 : 2
CREATE TABLE EMP(
       DNO NUMBER(4),
       DNAME VARCHAR2(10),
       LOC NUMBER(2)
);

-- 연습문제 3) 긴 이름을 저장할 수 있도록 EMP 테이블을 수정하시오
-- ENAME VARCHAR2(10) -> VARCHAR2(25) 수정

ALTER TABLE EMP
MODIFY DNAME VARCHAR2(25);

-- 연습문제 4) EMPLOYEE 테이블을 복사해서 EMPLOYEE2 테이블을 생성하되,
--                  사원번호, 이름, 급여, 부서번호 컬럼만 복사하세요
CREATE TABLE EMPLOYEE2(ENO_ID, NAME, SAL, DEPT_ID)
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

-- 연습문제 5) EMP 테이블을 삭제하시오
DROP TABLE EMP;

-- 연습문제 6) DEPT 테이블에서 DNAME 컬럼을 제거하시오
ALTER TABLE DEPT
DROP COLUMN DNAME;

-- 연습문제 7) EMPLOYEE2 이름을 EMP로 변경하시오
RENAME EMPLOYEE2 TO EMP;
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

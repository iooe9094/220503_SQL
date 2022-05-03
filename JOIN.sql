-- 2022-05-03 JOIN 실습

-- [ 조인 ]
-- 사원 번호가 7788인 직원의 부서명은 ?
SELECT DNO FROM EMPLOYEE WHERE ENO = 7788;

SELECT DNAME FROM DEPARTMENT WHERE DNO = 20;

SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*) FROM DEPARTMENT;

-- 성능을 좋게 하기 위해서는 목록이 작은 것을 FROM 앞에서 사용
-- 일반 JOIN(EQUAL(=) JOIN, INNER JOIN) : 교집합
SELECT A.DNO, A.DNAME, A.LOC
           FROM DEPARTMENT A,
           EMPLOYEE B
WHERE B.DNO = A.DNO;
-- AS 생략 가능

-- [ 일반 JOIN ]
SELECT A.DNO, B.ENAME, A.DNAME, A.LOC
FROM DEPARTMENT A,
          EMPLOYEE B;

-- [ 곱 JOIN (CARTESIAN PRODUCT) ]
-- DEPARTMENT 건수 4건 * EMPLOYEE 건수 14건 = 56
-- EX) 10만 * 100만 = 1000만 이렇게 되면 과부하로 인한 성능 떨어짐
SELECT COUNT(*)
FROM DEPARTMENT A,
          EMPLOYEE B;
          
-- [ EQUAL JOIN (= JOIN) ]
-- 조인 대상 테이블에서 공통 컬럼을 =(EQUAL) 비교를 통해
-- 같은 값을 가지는 행을 연결하여 결과를 생성
-- 성능 향상 팁 : 항상 작은 건 수 테이블이 먼저 ACCESS 되도록 만드는 것
-- 문법 :
-- SELECT 테이블1.컬럼, 테이블2.컬럼
-- FROM 테이블1, 테이블2
-- WHERE 테이블2.컬럼 = 테이블1.컬럼

-- 문제 1) 각 사원들이 소속된 부서 정보 모두 출력하기 (단, =조인 사용)
SELECT *
          FROM DEPARTMENT A,
                    EMPLOYEE B
WHERE A.DNO = B.DNO; -- 공통 컬럼을 찾아 조인

-- 문제 2) 사원번호가 7499, 7900인 사원들의 소속된 부서 정보 모두 출력하기
SELECT *
          FROM DEPARTMENT A,
                    EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.ENO IN (7499, 7900);

-- 문제 3) 사원번호가 7500 ~ 7700 사이에 있는 사원들의 소속된 부서 정보를 출력하되,
-- 부서 이름이 SALES인 파트만 출력하세요.
SELECT *
          FROM DEPARTMENT A,
                    EMPLOYEE B
WHERE A.DNO = B.DNO
AND ENO BETWEEN 7500 AND 7700
AND DNAME = 'SALES';

-- [ 테이블 주석 및 컬럼 주석 넣기 ]
-- 테이블 주석
-- COMMENT ON TABLE 컬럼 IS '주석이름'
-- COMMENT ON COLUMN 컬럼.이름 IS '주석이름'
-- 해당 컬럼 들어가서 SQL 메뉴 들어가면 하단에 추가 되어있음

COMMENT ON TABLE DEPARTMENT IS '부서정보';
COMMENT ON COLUMN DEPARTMENT.DNAME IS '부서이름';
COMMENT ON COLUMN DEPARTMENT.DNO IS '부서번호';
COMMENT ON COLUMN DEPARTMENT.LOC IS '부서지역';

COMMENT ON TABLE EMPLOYEE IS '직원정보';
COMMENT ON COLUMN EMPLOYEE.ENO IS '사원번호';
COMMENT ON COLUMN EMPLOYEE.ENAME IS '사원이름';
COMMENT ON COLUMN EMPLOYEE.JOB IS '직급';
COMMENT ON COLUMN EMPLOYEE.MANAGER IS '매니저';
COMMENT ON COLUMN EMPLOYEE.HIREDATE IS '고용일';
COMMENT ON COLUMN EMPLOYEE.SALARY IS '급여';
COMMENT ON COLUMN EMPLOYEE.COMMISSION IS '커미션';
COMMENT ON COLUMN EMPLOYEE.DNO IS '사원부서번호';

COMMENT ON TABLE BNOUS IS '보너스정보';
COMMENT ON COLUMN BONUS.ENAME IS '사원이름';
COMMENT ON COLUMN BONUS.JOB IS '직급';
COMMENT ON COLUMN BONUS.SAL IS '월급';
COMMENT ON COLUMN BONUS.COMM IS '보너스';

COMMENT ON TABLE SALGRADE IS '월급정보';
COMMENT ON COLUMN SALGRADE.GRADE IS '등급';
COMMENT ON COLUMN SALGRADE.LOSAL IS '최저월급';
COMMENT ON COLUMN SALGRADE.HISAL IS '최대월급';

-- [ 특수용 예) NOT EQUAL JOIN ]
-- =(EQUAL) 조인이 아닌 범위 조인
-- 월급등급(SALGRADE) 테이블
-- 1등급 : 700 ~ 1200
-- 2등급 : 1201 ~ 1400
-- ...
-- 5등급 : 3001 ~ 9999
-- 급여 등급을 기준으로 사원의 급여가 몇등급에 속하는지 알아보기
SELECT ENAME, SALARY, GRADE
FROM SALGRADE A,
          EMPLOYEE B
WHERE SALARY BETWEEN LOSAL AND HISAL;

-- 상기 예시에서 추가 부서 정보 보여주기
SELECT ENAME, DNAME, SALARY, GRADE
FROM SALGRADE A,
          DEPARTMENT C,
          EMPLOYEE B
WHERE B.DNO = C.DNO
AND SALARY BETWEEN LOSAL AND HISAL;

-- [ 특수용 예2) SELF JOIN ]
-- 사원테이블에 MANAGER 컬럼 (그 사원 매니저의 사번)
SELECT ENO, ENAME, MANAGER
FROM EMPLOYEE
WHERE ENAME LIKE 'SMITH%';

SELECT ENO, ENAME
FROM EMPLOYEE
WHERE ENO = 7902;

-- 위 처럼 쿼리가 2개로 나뉘어져 있으면 비효율적이므로, 아래처럼 하나로 쿼리 작성

SELECT MAN.ENO,
           MAN.ENAME AS "직원",
           MAN.MANAGER AS "매니저 사원번호",
           EMP.ENAME AS "매니저"
FROM EMPLOYEE EMP,
          EMPLOYEE MAN
WHERE EMP.ENO = MAN.MANAGER
AND MAN.ENAME LIKE 'SMITH%';

-- *** (중요) [ 특수용 예 3) OUTER 조인 ]
-- 보통 =(EQUAL) 조인은 공통 컬럼을 연결하여 데이터를 보여주는데
-- NULL값은 = 연산이 안되므로 데이터에서 제외가 된다
-- NULL값에 해당되는 다른 컬럼을 보여줘야 할 때가 있음
-- 그러므로 = 대신 OUTER 조인을 사용함 (+)
SELECT EMP.ENAME, MAN.ENAME
FROM EMPLOYEE EMP,
          EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.ENO(+);

-- JOIN 연습문제 1) 조인을 이용해서 SCOTT 사원의 부서번호와 부서이름을 출력하세요
SELECT B.ENAME, A.DNO, A.DNAME
FROM DEPARTMENT A,
           EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.ENAME LIKE 'SCOTT%';
        
-- 연습문제 2) 모든 사원의 사원 이름과 그 사원이 소속된 부서 이름과 지역명을 출력하세요
SELECT B.ENAME, A.DNAME, A.LOC
FROM DEPARTMENT A,
         EMPLOYEE B
WHERE A.DNO = B.DNO;

-- 연습문제 3) 10번 부서에 속하는 사원에 대해 직급과 지역명을 출력하세요
SELECT JOB, LOC
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND A.DNO LIKE 10;

-- 연습문제 4) 커미션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력하세요
SELECT ENAME, DNAME, LOC
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.COMMISSION IS NOT NULL
AND B.COMMISSION > 0;

-- 연습문제 5) = 조인과 와일드카드(%)를 사용하여 이름에 A가 포함된 모든 사원의 이름과 부서명을 출력하세요
SELECT B.ENAME, A.DNAME
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.ENAME LIKE '%A%';

-- 연습문제 6) NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하세요
SELECT B.ENAME, B.JOB, A.DNO, A.DNAME
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND A.LOC LIKE 'NEW YORK';
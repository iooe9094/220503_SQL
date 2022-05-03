-- DDL : ������ ���Ǿ�
-- ���̺� �����, ���̺� �����ϱ�, �÷� �����ϱ�, �÷� �߰��ϱ�

-- ���̺� �����
-- ��) �μ� ������ �����ϱ� ���� ���̺� �����ϱ�
-- ���̺��: TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT(
        DNO NUMBER(2),
        DNAME VARCHAR2(20),
        LOC VARCHAR2(20)
);

-- ���̺� �����ϱ� - ���̺� �� ���� ����
DROP TABLE TB_DEPARTMENT;

-- ���̺� �����ϱ� - ���̺� ��(����) �� ���� ��ü ����
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT;

CREATE TABLE TB_DEPARTMENT2
AS
SELECT *
FROM DEPARTMENT
WHERE 1=2; -- �������� ��ȸ

DROP TABLE TB_DEPARTMENT;
DROP TABLE TB_DEPARTMENT2;

-- 20�� �μ� �Ҽ� ����� ���� ������ ������ DEPT20 ���̺� �����ϱ�
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM EMPLOYEE
WHERE DNO = 20;

-- ���̺� ������ �����ϴ� ��ɾ�
-- ALTER TABLE ~
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE 1=2;

-- TB_DEPARTMENT ���̺� �÷� �߰�
ALTER TABLE TB_DEPARTMENT
ADD(BIRTH DATE); -- �÷� BIRTH �ڷ��� DATE

-- TB_DEPARTMENT ���̺� �÷� ����
-- DNAME VARCHAR2(14) -> VARCHAR2(20) ����
ALTER TABLE TB_DEPARTMENT
MODIFY DNAME VARCHAR2(20);

-- TB_DEPARTMENT ���̺� �÷� ����
-- BIRTH �÷� ����, �ѹ��� �ϳ��� ���� ����
ALTER TABLE TB_DEPARTMENT
DROP COLUMN BIRTH;

-- ���̺� �̸��� �����ϴ� ��ɾ�
-- ����) RENAME A TO B : A���̺���� B���̺������ �ٲٱ�
RENAME TB_DEPARTMENT02 TO TB_DEPARTMENT;

-- ���̺��� ��� �����͸� �����ϴ� ��ɾ�(������ + �Ҵ�� ����(�޸�))
-- �׽�Ʈ ������ ����
CREATE TABLE TB_DEPARTMENT02
AS
SELECT *
FROM DEPARTMENT;

-- ������ ����
TRUNCATE TABLE TB_DEPARTMENT02;

-- �߰��� ����Ŭ DB���� ����ϴ� ��Ÿ����
-- (������ ���̺�, �÷�����, �������� ��)�� �� �� �ִ� ���̺�
-- USER_xxx : ���ӵ� ������ ���� �������� �������� ������(�÷�, ���̺� ��)
-- ALL_XXX : ���ӵ� ���� + �ٸ� ������ ���� �������� ������(�÷�, ���̺� ��)
-- DBA_XXX : ��� ������ ���� �������� ������(�÷�, ���̺� ��)
SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES;

DROP TABLE TB_DEPARTMENT02;

--  DDL(������ ���Ǿ�) �ǽ�
-- �������� 1) ���� ǥ�� ��õȴ�� DEPT ���̺��� �����ϼ���
-- �÷��� : DNO / ������Ÿ�� : NUMBER / ũ�� : 2
-- �÷��� : DNAME / ������Ÿ�� : VARCHAR2 / ũ�� : 14
-- �÷��� : LOC / ������Ÿ�� : VARCHAR2 / ũ�� : 13
CREATE TABLE DEPT(
       DNO NUMBER(2),
       DNAME VARCHAR2(14),
       LOC VARCHAR2(13)
);

-- �������� 2) ���� ǥ�� ��õ� ��� EMP ���̺��� �����ϼ���
-- �÷��� : DNO / ������Ÿ�� : NUMBER / ũ�� : 4
-- �÷��� : DNAME / ������Ÿ�� : VARCHAR2 / ũ�� : 10
-- �÷��� : LOC / ������Ÿ�� : NUMBER / ũ�� : 2
CREATE TABLE EMP(
       DNO NUMBER(4),
       DNAME VARCHAR2(10),
       LOC NUMBER(2)
);

-- �������� 3) �� �̸��� ������ �� �ֵ��� EMP ���̺��� �����Ͻÿ�
-- ENAME VARCHAR2(10) -> VARCHAR2(25) ����

ALTER TABLE EMP
MODIFY DNAME VARCHAR2(25);

-- �������� 4) EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 ���̺��� �����ϵ�,
--                  �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϼ���
CREATE TABLE EMPLOYEE2(ENO_ID, NAME, SAL, DEPT_ID)
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

-- �������� 5) EMP ���̺��� �����Ͻÿ�
DROP TABLE EMP;

-- �������� 6) DEPT ���̺��� DNAME �÷��� �����Ͻÿ�
ALTER TABLE DEPT
DROP COLUMN DNAME;

-- �������� 7) EMPLOYEE2 �̸��� EMP�� �����Ͻÿ�
RENAME EMPLOYEE2 TO EMP;
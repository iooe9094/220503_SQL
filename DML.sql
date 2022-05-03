-- DML : DATA MANIPULATION LANGUAGE ( ������ ���۾� )
-- INSERT / UPDATE / DELETE

-- ���� ������ ���� ���̺� ��� ����
SELECT * FROM USER_TABLES;
-- �ʿ���� ���̺��� �����ϱ� (���� ���������� ���� �͵�)
DROP TABLE DEPT;
DROP TABLE EMP;

-- �׽�Ʈ�� ���̺� �� ������ �����
CREATE TABLE DEPT_COPY
AS
SELECT *
FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;

-- ������ ���� ( TRUNCATE TABLE )
TRUNCATE TABLE DEPT_COPY;

-- ������ �߰� ( INSERT )
INSERT INTO DEPT_COPY
VALUES (50, 'ACCOUNTING', 'NEW YORK'); -- DNO, DNAME, LOC / 1�� �߰�

COMMIT; -- COMMIT�� �Ϸ��ؾ� �����Ϳ� ���� �ݿ���

-- ���� DNO, DNAME, LOC ������� ������ VALUE�� ������ �ִ���
-- �÷��� �ڿ� (DNO, LOC, DNAME) ���� ������ �°� ó���� ���������� ���� ��� �ƴ�
INSERT INTO DEPT_COPY(DNO, LOC, DNAME)
VALUES (20, 'DALLAS', 'RESEARCH'); 

INSERT INTO DEPT_COPY
VALUES (30, 'SALES', 'CHICAGO');

INSERT INTO DEPT_COPY
VALUES (40, 'OPERATION', 'BOSTON');

-- ������ �߰�
-- 1) NULL�� ���� �����ϰ� �߰��ϴ� ���
INSERT INTO DEPT_COPY(DNO, DNAME)
VALUES(50, 'SALES');

-- 2) ��������� NULL �߰��ϴ� ��� (��õ)
INSERT INTO DEPT_COPY
VALUES(60, 'OPERATIONS', NULL);

-- �׽�Ʈ ������ �� ENP_COPY ���̺� �����
CREATE TABLE EMP_COPY
AS
SELECT *
FROM EMPLOYEE
WHERE 1=2; -- ������ ����

-- EMP_COPY ���̺� ������ �ֱ�
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7000, 'CANDY', 'MANAGER', SYSDATE, 10); -- ��¥���� �ڵ����� TO_DATE ���·� �ٲ������� �־��ִ°� ����

SELECT * FROM EMP_COPY; -- Ȯ�ο�

-- �ѹ� : �ڷḦ �߸� �־� �ǵ����� �� ��� ���, Ŀ�� �� ���·� ���ư� (�۾� ���) <-> COMMIT
ROLLBACK;

-- �ٸ� ���̺��� �����͸� �����ؼ� INSERT �ϱ�
SELECT * FROM DEPT_COPY;
-- ������ / ���� ���� (����)
TRUNCATE TABLE DEPT_COPY;
-- �ٸ� ���̺��� �����͸� �����ؼ� INSERT �ϱ�
INSERT INTO DEPT_COPY
SELECT * FROM DEPARTMENT;

-- ������ �����ϱ� ( UPDATE )
SELECT * FROM DEPT_COPY;

-- �Ϲ����� ��� : UPDATE + WHERE ������
-- ���� )
-- UPDATE ���̺�� SET �÷���(�����Ұ�) WHERE ����
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING'
WHERE DNO = 20;

-- ���� ���
ROLLBACK;

-- DB ���� �ݿ�
COMMIT;

-- ���� 1) DEPT_COPY ���̺� LOC �÷��� 'PUSAN'���� �����ϴµ�, �μ����� 'SALES'�� ���� �ǵ��� ó���ϱ�
UPDATE DEPT_COPY
SET LOC = 'PUSAN'
WHERE DNAME = 'SALES';

-- ���빮�� 2) DEPT_COPY ���̺��� �μ���ȣ�� 20�� �μ��� �μ��̸��� 'JAVA'�� �����ϰ�, LOC �÷��� 'SEOUL'�� �����ϱ�
UPDATE DEPT_COPY
SET DNAME = 'JAVA',
      LOC = 'SEOUL'
WHERE DNO = 20;

-- Ư���� ��) DEPT_COPY ���̺��� �μ� ��ȣ�� 10�� �����͸� �����ͼ� 
--                �μ���ȣ�� 20�� LOC �����ͷ� �����ϱ�
UPDATE DEPT_COPY
SET LOC = (SELECT LOC FROM DEPT_COPY WHERE DNO = 20)
WHERE DNO = 10;

-- DELETE : ���̺��� ������ �����ϴ� DML ��ɾ�
-- COMMIT �ؾ� ���������� ó��
-- ����)
-- DELETE [FROM] ���̺�� WHERE ����
DELETE FROM DEPT_COPY -- FROM ���� ����
WHERE DNO = 10;

-- ���� 2) DEPT_COPY ���̺��� �μ���ȣ(DNO)�� 20 30�� �����͸� �����Ͻÿ�
DELETE FROM DEPT_COPY
WHERE DNO IN (20, 30);

-- ���� : DELETE ~ �������� ��� ����
DELETE FROM DEPT_COPY
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME = 'SALES');
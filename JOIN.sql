-- 2022-05-03 JOIN �ǽ�

-- [ ���� ]
-- ��� ��ȣ�� 7788�� ������ �μ����� ?
SELECT DNO FROM EMPLOYEE WHERE ENO = 7788;

SELECT DNAME FROM DEPARTMENT WHERE DNO = 20;

SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*) FROM DEPARTMENT;

-- ������ ���� �ϱ� ���ؼ��� ����� ���� ���� FROM �տ��� ���
-- �Ϲ� JOIN(EQUAL(=) JOIN, INNER JOIN) : ������
SELECT A.DNO, A.DNAME, A.LOC
           FROM DEPARTMENT A,
           EMPLOYEE B
WHERE B.DNO = A.DNO;
-- AS ���� ����

-- [ �Ϲ� JOIN ]
SELECT A.DNO, B.ENAME, A.DNAME, A.LOC
FROM DEPARTMENT A,
          EMPLOYEE B;

-- [ �� JOIN (CARTESIAN PRODUCT) ]
-- DEPARTMENT �Ǽ� 4�� * EMPLOYEE �Ǽ� 14�� = 56
-- EX) 10�� * 100�� = 1000�� �̷��� �Ǹ� �����Ϸ� ���� ���� ������
SELECT COUNT(*)
FROM DEPARTMENT A,
          EMPLOYEE B;
          
-- [ EQUAL JOIN (= JOIN) ]
-- ���� ��� ���̺��� ���� �÷��� =(EQUAL) �񱳸� ����
-- ���� ���� ������ ���� �����Ͽ� ����� ����
-- ���� ��� �� : �׻� ���� �� �� ���̺��� ���� ACCESS �ǵ��� ����� ��
-- ���� :
-- SELECT ���̺�1.�÷�, ���̺�2.�÷�
-- FROM ���̺�1, ���̺�2
-- WHERE ���̺�2.�÷� = ���̺�1.�÷�

-- ���� 1) �� ������� �Ҽӵ� �μ� ���� ��� ����ϱ� (��, =���� ���)
SELECT *
          FROM DEPARTMENT A,
                    EMPLOYEE B
WHERE A.DNO = B.DNO; -- ���� �÷��� ã�� ����

-- ���� 2) �����ȣ�� 7499, 7900�� ������� �Ҽӵ� �μ� ���� ��� ����ϱ�
SELECT *
          FROM DEPARTMENT A,
                    EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.ENO IN (7499, 7900);

-- ���� 3) �����ȣ�� 7500 ~ 7700 ���̿� �ִ� ������� �Ҽӵ� �μ� ������ ����ϵ�,
-- �μ� �̸��� SALES�� ��Ʈ�� ����ϼ���.
SELECT *
          FROM DEPARTMENT A,
                    EMPLOYEE B
WHERE A.DNO = B.DNO
AND ENO BETWEEN 7500 AND 7700
AND DNAME = 'SALES';

-- [ ���̺� �ּ� �� �÷� �ּ� �ֱ� ]
-- ���̺� �ּ�
-- COMMENT ON TABLE �÷� IS '�ּ��̸�'
-- COMMENT ON COLUMN �÷�.�̸� IS '�ּ��̸�'
-- �ش� �÷� ���� SQL �޴� ���� �ϴܿ� �߰� �Ǿ�����

COMMENT ON TABLE DEPARTMENT IS '�μ�����';
COMMENT ON COLUMN DEPARTMENT.DNAME IS '�μ��̸�';
COMMENT ON COLUMN DEPARTMENT.DNO IS '�μ���ȣ';
COMMENT ON COLUMN DEPARTMENT.LOC IS '�μ�����';

COMMENT ON TABLE EMPLOYEE IS '��������';
COMMENT ON COLUMN EMPLOYEE.ENO IS '�����ȣ';
COMMENT ON COLUMN EMPLOYEE.ENAME IS '����̸�';
COMMENT ON COLUMN EMPLOYEE.JOB IS '����';
COMMENT ON COLUMN EMPLOYEE.MANAGER IS '�Ŵ���';
COMMENT ON COLUMN EMPLOYEE.HIREDATE IS '�����';
COMMENT ON COLUMN EMPLOYEE.SALARY IS '�޿�';
COMMENT ON COLUMN EMPLOYEE.COMMISSION IS 'Ŀ�̼�';
COMMENT ON COLUMN EMPLOYEE.DNO IS '����μ���ȣ';

COMMENT ON TABLE BNOUS IS '���ʽ�����';
COMMENT ON COLUMN BONUS.ENAME IS '����̸�';
COMMENT ON COLUMN BONUS.JOB IS '����';
COMMENT ON COLUMN BONUS.SAL IS '����';
COMMENT ON COLUMN BONUS.COMM IS '���ʽ�';

COMMENT ON TABLE SALGRADE IS '��������';
COMMENT ON COLUMN SALGRADE.GRADE IS '���';
COMMENT ON COLUMN SALGRADE.LOSAL IS '��������';
COMMENT ON COLUMN SALGRADE.HISAL IS '�ִ����';

-- [ Ư���� ��) NOT EQUAL JOIN ]
-- =(EQUAL) ������ �ƴ� ���� ����
-- ���޵��(SALGRADE) ���̺�
-- 1��� : 700 ~ 1200
-- 2��� : 1201 ~ 1400
-- ...
-- 5��� : 3001 ~ 9999
-- �޿� ����� �������� ����� �޿��� ���޿� ���ϴ��� �˾ƺ���
SELECT ENAME, SALARY, GRADE
FROM SALGRADE A,
          EMPLOYEE B
WHERE SALARY BETWEEN LOSAL AND HISAL;

-- ��� ���ÿ��� �߰� �μ� ���� �����ֱ�
SELECT ENAME, DNAME, SALARY, GRADE
FROM SALGRADE A,
          DEPARTMENT C,
          EMPLOYEE B
WHERE B.DNO = C.DNO
AND SALARY BETWEEN LOSAL AND HISAL;

-- [ Ư���� ��2) SELF JOIN ]
-- ������̺� MANAGER �÷� (�� ��� �Ŵ����� ���)
SELECT ENO, ENAME, MANAGER
FROM EMPLOYEE
WHERE ENAME LIKE 'SMITH%';

SELECT ENO, ENAME
FROM EMPLOYEE
WHERE ENO = 7902;

-- �� ó�� ������ 2���� �������� ������ ��ȿ�����̹Ƿ�, �Ʒ�ó�� �ϳ��� ���� �ۼ�

SELECT MAN.ENO,
           MAN.ENAME AS "����",
           MAN.MANAGER AS "�Ŵ��� �����ȣ",
           EMP.ENAME AS "�Ŵ���"
FROM EMPLOYEE EMP,
          EMPLOYEE MAN
WHERE EMP.ENO = MAN.MANAGER
AND MAN.ENAME LIKE 'SMITH%';

-- *** (�߿�) [ Ư���� �� 3) OUTER ���� ]
-- ���� =(EQUAL) ������ ���� �÷��� �����Ͽ� �����͸� �����ִµ�
-- NULL���� = ������ �ȵǹǷ� �����Ϳ��� ���ܰ� �ȴ�
-- NULL���� �ش�Ǵ� �ٸ� �÷��� ������� �� ���� ����
-- �׷��Ƿ� = ��� OUTER ������ ����� (+)
SELECT EMP.ENAME, MAN.ENAME
FROM EMPLOYEE EMP,
          EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.ENO(+);

-- JOIN �������� 1) ������ �̿��ؼ� SCOTT ����� �μ���ȣ�� �μ��̸��� ����ϼ���
SELECT B.ENAME, A.DNO, A.DNAME
FROM DEPARTMENT A,
           EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.ENAME LIKE 'SCOTT%';
        
-- �������� 2) ��� ����� ��� �̸��� �� ����� �Ҽӵ� �μ� �̸��� �������� ����ϼ���
SELECT B.ENAME, A.DNAME, A.LOC
FROM DEPARTMENT A,
         EMPLOYEE B
WHERE A.DNO = B.DNO;

-- �������� 3) 10�� �μ��� ���ϴ� ����� ���� ���ް� �������� ����ϼ���
SELECT JOB, LOC
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND A.DNO LIKE 10;

-- �������� 4) Ŀ�̼��� �޴� ��� ����� �̸�, �μ��̸�, �������� ����ϼ���
SELECT ENAME, DNAME, LOC
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.COMMISSION IS NOT NULL
AND B.COMMISSION > 0;

-- �������� 5) = ���ΰ� ���ϵ�ī��(%)�� ����Ͽ� �̸��� A�� ���Ե� ��� ����� �̸��� �μ����� ����ϼ���
SELECT B.ENAME, A.DNAME
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND B.ENAME LIKE '%A%';

-- �������� 6) NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����ϼ���
SELECT B.ENAME, B.JOB, A.DNO, A.DNAME
FROM DEPARTMENT A,
          EMPLOYEE B
WHERE A.DNO = B.DNO
AND A.LOC LIKE 'NEW YORK';
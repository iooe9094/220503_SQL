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

1. ������� (�� �����������) �����, �� �������� �������� SCAPS ("SCAPS Folder") ��  ������ ���������� ���������� ("Results Folder") 


��� ����� ������� ���� �� ������������ ���� � ���:

2.������������ �������� ������� ���� �� ������������ ���� � ���

3. ������ ".scaps file create" - ��������� settings-����� 
  "FeD*.scaps" ��� ���������� ��� ��� �������� ���� ������������ �����
  "D1�*.scaps" ��� ���������� �������� ������� �� ������
  "FeBD*.scaps" ��� ���������� ��� ��� ��� �����-��� �� ������������ �����

��� ����� �����������

4. � SCAPS ����������� ���� "FeD*.scaps",
    ��������� "Clear all simulation",
    ��������� "Calculate: batch",
    �������� *.iv ����.

5."��������" ��� (������ "Select .iv file" �� "Extract IV files")

6.� SCAPS ����������� ���� "D1�*.scaps",
    ��������� "Clear all simulation",
    ��������� "Calculate: single shot",
    �������� *.eb ����.

7. ��������� ����� �������� ������� �� ������ - ������ "Fe(x) and FeB(x) create".

8. � SCAPS ����������� ���� "FeBD*.scaps",
    ��������� "Clear all simulation",
    ��������� "Calculate: batch",
    �������� *.iv ����.

9."��������" ��� (������ "Select .iv file" �� "Extract IV files")

��� ����� ����� � ������� ("Fe" �� "FeB")

10. ��������� ��������� ���:
   ��������� �������� Shottky.exe
   �������� ����� � ������� (������ "�hose directory" �� ������� "Directory operation")
   �������� ������� D-diod (������ "Select")
   ������������ ������� ��������� (������ "Option")
     * "Iteration Number" - 3000
     *  "Evolution Type" - MABC
     *  n1 - Constant, 1     
     *  Rs -  Constant, 0
     *  Io1 - Logarithmic, Initial 1e-13, 1e-10;  Limit 1e-28, 1e-8
     *  Rsh - Constant, 1e20
     *  n2 - Normal, Initial 1, 1.5;  Limit 1, 2.5
     *  Io2 - Logarithmic, Initial 1e-9, 1e-5;  Limit 1e-18, 1e-5
     *  Evolution  Algoritm, Xmin = 0, Xmax = 0.4, Ymin =0, Ymax = No
   ��������� ���������� (������ "Create dates.dat") 

11. ������� ����������: ������ "dates.dat convert" � �������� ������� � ������������ ����� dates.dat.



sscanf % ��� ���������� ����� �� ������ 
%% �������� �� �������� 
char ('a') % ����������� � ������ ���������� ���������
str1='aaa', str2='bbb' 
sumstr = [str1, str2] % sumstr = aaabbb
%% ������� ������� ������
str = ['left hand side of equation =', ... 
' right hand side of equation '] 
%% �������������� �������� � ������� ����������� ���������
c= sqrt(3) % c = 1.7321 
sym(c) %  ans = 3^(1/2) = sqrt(3)
sym('l+sqrt(3)') % ��������� ���������� ��������� ��������� ��� sym ����� ���������� ��� � ��������� �������
%% ��������� ���� isnumeric, ischar 
C{1,1} = pi;                 % double
C{1,2} = 'John Doe';         % char array
C{1,3} = 2 + 4i;             % complex double
C{1,4} = ispc;               % logical
C{1,5} = magic(3)            % double array
% C =  [3.1416]    'John Doe'    [2.0000 + 4.0000i]    [1]    [3x3 double]
for i=1:5, x(i)=isnumeric(C{1,i}); end
% x =  1     0     1     0     1
%% ��������� �����
if strcmp(Name, 'NewYork'), Params=0; end % ������������ Name � 'NewYork'
if ~isequal(answer, 'yes'), return, end % isequal ��� ��������� ������ �� ������� 'yes', �.�. ���� == ����� ������������ ������ ��� ��������� �������� ���������� �����. 
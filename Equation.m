%% ���������� ���������� ����������
vpa (ans)   % 16 ������ ����� �������
vpa (ans,7)  % 7 ������ ����� �������
vpa ('3^45') % ����� ������ �����
vpa ('sqrt(2)', 2) % ans = 1.4  �������� ����������
vpa ('sqrt(2)', 6) % ans = 1.41421
digits (3)
%%
cos (pi/2)% ans=6.1232�-17 
cos (sym('pi/2')) % ans = 0
%% 
sym ('1/2') + sym ('1/3') % ans = 5/6
double (ans) %ans = 0.8333   ����� ���������� ������ ������.

%% ������ ���������� ���������
solve ('x^2 - 2*x -4 = 0') %  ����� ����� � ���������� �����  
double (ans) % 4 ����� ����� �������
%% ������� ��������� x^2-3*x+7
syms x % ������� ���������� ��� ������������� � �������� ����������.   
solve (x^2 - 3*x + 7) 
%% ������� ��������� ��� ������ ����������
solve('x+y =3')     % ans=3-y  �� ��������� �������� ��� � 
solve('x+y =3','y') % ans=3-x  �������� ��� y 
%% ������� ��������� x^2-y=2 , y-2*x=5
[x,y] = solve ('x^2 - y = 2', 'y - 2*x =5') 
%% ����� ��������� exp(-x) - sin(x) = 0
h =@(x) exp(-x) - sin(x); 
fzero (h, 0.5) % ���� ������� �������� ������ ������� � �������� ��������� �������� �. 

%% ���������������� ��������� ����:  xy' + 1 = y
dsolve('x*Dy+1=y','x') % ans = C2*x + 1
%% ===================================================================
x = [0.1, 0.01, 0.001] 
% ������ �/� ������ ��������� �*� = sin(x) ��� y ������� ���������� ���������: 
y = sin(x)/x % ans: y =  0.9984
%  ����� ��������� ��� ������� �����������, ���������� ������ ������� �./�
y = sin(x)./x % ans: y = 0.9983  1.0000  1.0000
format long % ����� ������������ 15 ������ 
y = sin(x)./x %  ans: y = 0.998334166468282   0.999983333416666   0.999999833333342
%% ��������� ���������
syms x y 
(x-y)*(x-y)^2 % ans = (x - y)^3
expand(ans) % ans = x^3 - 3*x^2*y + 3*x*y^2 - y^3
factor(ans) % ans =(x - y)^3
%%
simplify ((x^3-y^3)/(x-y)) % ��������� �������:  ans = x^2 + x*y + y^2 
simple (sin(x) *cos(y) + cos(x) *sin(y)) % ����������� �� ���������
%%
subs (x+1, x, 2) % ans 3.  � ��������� x+1  ���������� x ������� ��������� 2 .



%����������, ������� ������������ � �-�����-�������, �������� ���������� 
%% ������������! ������� �������
f = 'x^3 - 1' 
f(7) % ans=1 - ��������� �� ������� ������ � ������ 'x^3 - 1'
%% ���������� ��������� 
h = @(t) t^3; 
syms t % ���������� ����������� h ��������� �� ���������� ��������� h(t) ����� ����������� ��������������
int(h(t), t) %ans =1/4*t^4 
int(t^3) %ans =1/4*t^4
%% �������������� �������� x^2
syms x, int('x^2','x')
%% �������� ��������
quadl(@(x) log(1 + x.^2).*exp(-x.^2), 0, 1) % ans =  0.153886076719216 
%% ������������������
syms x, diff (x^3) % ans = 3*x^2 %% 
f=@(x)x^3;  % �� �� ����� ����� �������
diff(f(x))  % ans = 3*x^2 
diff (f(x), 2) % ����������� ������� ������� 
%% �������
syms x; limit(sin(x)/x, x, 0) 
%% ����������� ����� 1/k - 1/(k+1)  ��� �=1..n
syms k n; 
symsum(1/k - 1/(k+1), 1, n)
symsum(1/n^2, 1, Inf) % ����� 1/n^2  ��  1 �� ������������� 
%% ���������� �������� ������� ����� ����������
x = 5.0 : 0.001 : 20.0 ; 
y = 24 - 2* x/3 + x.^2/30 ; 
% xlim(axes1,[5 25]);
axes1 = axes('Parent',figure,'XMinorTick','on'); % Create axes
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');
plot(x,y);
[x,y] = fminbnd ( '(24 - 2* x/3 + x.^2/30)', 5, 20)
%% �������� ������� � ������ ��������� =========================
sc2=@(x,y)sin(x).^2+cos(y).^2 % ���� �� ������� sc2=inline('sin(x).^2+cos(y).^2') 
f = @(x)x^2 % ���� �� ������� f = inline('x^2','x')

%% �������� ������� � m ����� sc2.m =============================================
%  %����� �������, ������������ ��� ����� ������� help. 
%  function y=sc2(x,y)
%  y=sin(x).^2+cos(y).^2 
%===================================================================
%  sc2(1,2) %��������� � ������� sc2
%  type sc2 - ����� �������� �������  sc2
%===================================================================

%% ���� ������� "polarcoordinates.m" � ����� ����������� ����� � � ����� ����������� ������: 
% function [r, theta] = polarcoordinates (x, y) 
% r = sqrt(x^2 + y^2); 
% theta = atan2 (x, y); 
%===================================================================
% [r, theta] = polarcoordinates (3, 4) % ����� �-��� "polarcoordinates"
% r = 5 
% theta = 0.9273 
%====================================================================

%% ����� �������� ������� ���������� ���������� f(x, y) = (x^2 + y^2 - 3)^2 + (x^2 + y^2 - 2*x - 3)^2 + 1
% ���� ��������� ����� ������ ����� ���������� M0 (1; 1)  
[x,y] = meshgrid([-1:1,1:3]); % -1:1 - �������� ��� �,  1:3 - ��� y.  ����� �� ����� � ������������� ������� � �������� ����������. 
z = (x^2 + y^2 - 3)^2 + (x^2 + y^2 - 2*x - 3)^2 + 1 ; 
plot3(x,y,z) % �������� �� �������

f= @(x,y)(x^2 + y^2 - 3)^2 + (x^2 + y^2 - 2*x - 3)^2 + 1 ; % ��������� �������
xlim([5 25])
%%  nargin - �������� ���������� ������� ����������
% function s = add(x, y, z) 
% if nargin<2, error('At least two input arguments are required.'), end 
% if nargin==2, s=x+y; 
% else          s=x+y+z; 
% end 

s = sum([varargin{:}]); % ��������� ������ ���������� �����, �����������  ��������. 
%% ghghgh
%cftool  Curve Fitting Tool  - ����� ������������� ������
% Data - ����� ����������, ������� ����� �������� ����� ��������������� ������������ ���� 
% Create data set - ������� �������� ������� ������
% Fitting / New fit  - ������� ����������������� �����������, � ��������� �� �������� Apply
%  help iofun


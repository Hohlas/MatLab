%% ������ � ���������� ������������ 
close all % Remove all figures
z = -2 : 0.01 : 2; 
plot3(cos(2*pi*z), sin(2*pi*z), z) % ���������� ��� �������: ���� ������ ��� ���������� �, ����  ��� � � ����  ��� z. 
title('plot3: ������� � ������������ x=cos(2\piz), y=sin(2\piz) ') 

figure % create figure graphics object
ezplot3('cos(2*pi*z)', 'sin(2*pi*z)', 'z', [-2, 2]) 
title('ezplot3: ������� � ������������ x=cos(2\piz), y=sin(2\piz), z=-2..2')

%% ����������� � ���������� ������������ z = f (�, �) = x^2 - y^2
close all % Remove all figures
[X, Y] = meshgrid(-2 : 0.1 : 2,   -2 : 0.1 : 2); 
Z = X.^2 - Y.^2;
mesh(X,Y,Z) % ������������� ���������� �������� �����������
title('mesh')
% view(2) % ���������� ����������� �� ��������� �-� (��� ������, �� ������� ��� z) 
% view(3) % ���������� ��� � ������� �� ��������� � ���������� ����
figure % create figure graphics object 
surf(X,Y,Z) % ������������� ���������� �������� �����������
title('surf')

figure % create figure graphics object
ezmesh('x^2-y^2', [-2,2 -2,2]) % ����������� ������� ezmesh � ezurf 
title('����������� ������� ezmesh')

%% �����������   ��� ������� �������� � ������� ��������� ��������� � ����������
clear %Remove items from workspace 
figure % create figure graphics object
help graph 3d 
m=3.32e-27; k=1.38e-23;
p=sqrt(pi); a=4/p; b=m/2/k;
[v, t] = meshgrid(30:30:3000, 203:3:500);   % X and Y arrays for 3-D plots
z3=v.^2; z4=t.^(-1);
z1=log(a*b^1.5*z4.^1.5); z2=log(z3);
z5=b*z3.*z4; z6=z1+z2-z5;
%% �������� ������ ���������������, � ����� �������������
z=exp(z6);
mesh(v, t, z)
set(gca,'FontName','Arial Cyr');
title('������������� ���������','FontSize',14)
xlabel('������� (�/�)'); ylabel('T(K)') 

%%
figure % create figure graphics object
[X,Y]=meshgrid(-5:0.1:5);
Z=X.*sin(X+Y);
meshc(X,Y,Z)
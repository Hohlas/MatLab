clear
m=3.32e-27; k=1.38e-23; T=250; 
step=1; % ���������� �������� (���)
number=500;% ����� ������
np=20; d=m/2/k/T; a=4/sqrt(pi)*d^1.5;% ����� ����� ����������
x=zeros; hz=zeros; nv=zeros;
for mv=1:number
    y=rand(1);
    s=0;  v=0;  f=0;
    while s<y
        v=v+step; f=a*exp(2*log(v)-d*v^2); s=s+f*step;
    end
    nv(mv)=v;
end
    vmax=max(nv);% ������������ ��������
    hz=hist(nv,np)/number; hist(nv,np);% ������ ��������� ����� ��� �������

for j=1:np; % ������ ��������� ����� ��� ������
    x(j)=j*vmax/np; 
end
title ('Maxwell distribution')
xlabel('v(m/s)'); ylabel('f(v)')
%hgt=gtext('T=250K'); gtext%������� �� ��������� �������� 
%hgt=gtext('N=500');  %����� ������� �������� �� ����� � �������� �������. ��������� ���������� �� ������ � ������ m-�����. 
cftool % Open Curve Fitting Tool

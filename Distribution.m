clear
m=3.32e-27; k=1.38e-23; T=250; 
step=1; % Приращение скорости (шаг)
number=500;% Число частиц
np=20; d=m/2/k/T; a=4/sqrt(pi)*d^1.5;% Число ячеек гисограммы
x=zeros; hz=zeros; nv=zeros;
for mv=1:number
    y=rand(1);
    s=0;  v=0;  f=0;
    while s<y
        v=v+step; f=a*exp(2*log(v)-d*v^2); s=s+f*step;
    end
    nv(mv)=v;
end
    vmax=max(nv);% Максимальная скорость
    hz=hist(nv,np)/number; hist(nv,np);% Массив координат вдоль оси ординат

for j=1:np; % Массив координат вдоль оси абцисс
    x(j)=j*vmax/np; 
end
title ('Maxwell distribution')
xlabel('v(m/s)'); ylabel('f(v)')
%hgt=gtext('T=250K'); gtext%Надписи на двумерных графиках 
%hgt=gtext('N=500');  %Нужно указать курсором на место в основном рисунке. Результат передается на график в тексте m-книги. 
cftool % Open Curve Fitting Tool

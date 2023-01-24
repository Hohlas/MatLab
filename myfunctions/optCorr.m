function Correlation = optCorr(optRisk)
% ���������� ��������, ���������� �����������.
% ���������� �������� � ������ �� �������� ���������
% Risk - ������ ������ ���������
load('TestsResults');
Bal = bal(Deals,Time,FullTime,optRisk);
Pay=sum(Bal); % ��������� ������ ��������� � ������ ����� �������

Days=length(Pay);
Experts=size(Deals,1);
Correlation=1;
for Ex=1:Experts
   Corr=corrcoef(Pay,Bal(Ex,:)); % ���������� �������� � ����� �� �������� ���������
   Correlation=Correlation*Corr(1,2); % ������������ ����������, ���������� �����������
end
% Correlation=-(Pay(Days)-Pay(1))/Correlation/100;
Correlation=-(1/Correlation-1)*1000;
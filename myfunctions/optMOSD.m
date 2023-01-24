function MOSD = optMOSD(optRisk)
% ���������� ��������, ���������� ����������� - MO/STD
% Risk - ������ ������ ���������
load('TestsResults'); % read file "TestsResults.mat", created by "csv2mat.m" function:  ID, Risk, Deals, Time, FullTime, Start, End, Rows, Cols, Days
Pay=sum(bal(Deals,Time,FullTime,optRisk)); % ��������� ������ ��������� � ������ ����� �������
Mo=Pay(Days)/Days; % ��� ��  
std=0;
for i=2:Days 
    std=std+abs(Mo-(Pay(i)-Pay(i-1)));
end
MOSD=-Pay(Days)/std;

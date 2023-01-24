function MOSD = optMOSD(optRisk)
% возвращает критерий, подлежащий минимизации - MO/STD
% Risk - вектор рисков экспертов
load('TestsResults'); % read file "TestsResults.mat", created by "csv2mat.m" function:  ID, Risk, Deals, Time, FullTime, Start, End, Rows, Cols, Days
Pay=sum(bal(Deals,Time,FullTime,optRisk)); % суммарный баланс экспертов с учетом риска каждого
Mo=Pay(Days)/Days; % мат ож  
std=0;
for i=2:Days 
    std=std+abs(Mo-(Pay(i)-Pay(i-1)));
end
MOSD=-Pay(Days)/std;

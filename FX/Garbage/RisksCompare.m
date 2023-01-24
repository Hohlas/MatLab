% ���������� �������� �� ��������� ����� MatLabTest.csv
% ���������� �������� � ���������� TestsResults.m ��� ���������� ��������� 
% ���������� ����������� ������� ��������� � �������������� ������� frontcon ��� portopt... 
% � ����� �������� �������� portalloc
% ID - ������ ���������������
% Bal - ������ ��������, ���������� �� ����� ������� FullTime
% FullTime - ����� ������ ������� ������� = StartDate:EndDate:Hour
% Deals - ������ ������
% Time - ������ ��������������� ��� ������� �������� ������� ������
%% ���������� ��������
% clear % clear workspace and memory
close all % Remove all figures
Lines=7; % ���������� ����� �� ����� �������
CheckPeriod='min'; % ������ ��������� ��������: 'min'-����������� �� �����������
%% ��������� ���� � �������
Folder='D:\WORK\MatLab\FX\'; % ���� ���������� ������� �������
FileName='TestsResults';     % �������� �����/������� �������
TestFile='MatLabTest.csv';   % ���� � ������ ������/�������� �� ����������
[ID,Risk,Deals,Time]=csv2mat(TestFile); % �������� ������� ����: 1373393 ; 1.7 ; -5770 ; 2000.04.04 22:50 , ��� -5770-���. ������, ���������� �� 100 
if ID==-1, disp('��������� ����������'); return, end
[Rows,Cols] = size(Deals); % ���-�� ���������, ������������ ����� �������
%% ��������� ����� ����� ������� � ����� � ����
Start=floor(min(Time(:,1)))-1; % ������� �������� ������� ������� �������� �� �������� ������ (�� ����)
End=ceil(max(max(Time))); % ���� �������� ������� �������� �� �������� ������ (�� ����)
FullTime=Start:1:End; % ��������� �������� Start-End, �� ������� ������������ ��������� �� ������ ����� . ������ � ���
Days=length(FullTime); % ����������� ����� �������
disp(['������ �������� ',datestr(Start,'dd.mm.yyyy'),' - ',datestr(End,'dd.mm.yyyy'),', ����� ',num2str(Days),' ���� / ',num2str(floor(Days/365)),' ���']);
save([Folder,FileName], 'ID','FullTime','Deals','Time','Rows'); 
%% ������� ������: ����������� ������������, ���������
ManualRisk=[2.0 7.3  3.3 3.1 3.2 4.4 ... % ������� ����������� ����� ...
      1.2 0.65 2.3 4.0 1.3 4.6 ...% ������������� ������������
      4.6 2.6 ];
NoRisk= [99  164  125   99  115   27   88  116   60   29   91  100   90  138]; % ������ ��������� ������
GARisk=[812  940  816   661  1091  612  646  334  946  128  1597  345  500  1217];
%% 
ManualRisk=ManualRisk/max(ManualRisk); 
NoRisk=NoRisk/max(NoRisk);
GARisk=GARisk/max(GARisk);
% CsvRisk=CsvRisk/max(CsvRisk);
%% ��������������� ���������� ������� �������
Bal=bal(Deals,Time,FullTime,Risk); %����������� ������� ���� ��������� �� ����� ������� StartDate:Hour:EndDate
Max=max(Bal'); % ������ ������������ �������� ������� Bal
Max=max(Max); % ������������ �������� �������, �������, ����� ������� ��� �� 1
Bal=Bal/Max; % ��������� � 1
%% ���������� ���������� / ����������
% Prf=Bal(:,Hours)'; % ������ ����������� ���� ������ (��������� �������� � �������� ��������) 
% ���������� - ���� �������� ����������� ���� ��������� �������, ������ ���. �������� ������������ ���������� ��������� ������� �� �� ���. ��������
% �������������� ������� - �������, ������������ �� �������� ���������� ��������� ������ ��� ���� ��������� �������� 
Cor=corrcoef(Bal'); % ������� ����������
Std=std(Bal');% ����������� ���������� ��� ������ ������ ��������
%Cov=corr2cov(Std,Cor); % �������������� �������
Cov2=cov(Bal');  % �������������� ������� (2-� ������ ����������)
%% ���������� �-��
% [PortSTD,Profit,OptRisks]=portopt(Prf,Cov2,25);
% Risk - ������ ������ ��� ������� �������� (�������������������� ���������� ���������� �� ���������)
% Profit - ������ ��������� ����������� ��� ������� ��������
% Parts - ������, ������ ������ �������� ������������ ���� ������� � ��������.
%% 
% Index_Risk = 2;
% R_Freeasset = 0.095;
% R_Borrow = 0.13;
% [TP_Risk2, TP_Ret2, TP_Ass2, R_Fraction2, OP_Risk2, OP_Ret2] = portalloc(PortSTD,Profit,OptRisks, ...
% R_Freeasset, R_Borrow, Index_Risk);
% portalloc(PortSTD,Profit,OptRisks, R_Freeasset, R_Borrow, Index_Risk);
%% GA
% A=[]; b=[]; % A*x<=b
% Aeq(1:Experts)=1; beq=1; % Aeq*x=beq
% Aeq=[]; beq=[];
% LB(1:Experts)=0; LB=LB'; UB=[]; % lb<=x<=ub
% [GARisk] = ga(@PortRF,Experts,[],[],Aeq,beq,LB,UB);
%% ������������ ��������� � ������ �������� (�� ������� ������� �������� ������������� ��������)
Portfolio0=sum(bal(Deals,Time,FullTime,ManualRisk)); % 
Portfolio1=sum(bal(Deals,Time,FullTime,NoRisk)); % 
Portfolio2=sum(bal(Deals,Time,FullTime,GARisk)); %
Portfolio3=sum(bal(Deals,Time,FullTime,CsvRisk)); % 
% Max=max([Portfolio(Hours),Portfolio1(Hours),Portfolio2(Hours),Portfolio3(Hours)]);
% Portfolio =Portfolio *(Max/Portfolio (Hours)); 
% Portfolio1=Portfolio1*(Max/Portfolio1(Hours));
% Portfolio2=Portfolio2*(Max/Portfolio2(Hours));
% Portfolio3=Portfolio3*(Max/Portfolio3(Hours));
%% 
[Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD]=PayProperties(Portfolio0);
disp(['ManualRisk RF=',num2str(round(RF)),' iRF=',num2str(round(iRF)),' Profit=',num2str(round(Profit/10000)),' MaxDD=',num2str(round(maxDD))]);
[Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD]=PayProperties(Portfolio1);
disp(['NoRisk RF=',num2str(round(RF)),' iRF=',num2str(round(iRF)),' Profit=',num2str(round(Profit/10000)),' MaxDD=',num2str(round(maxDD))]);
[Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD]=PayProperties(Portfolio2);
disp(['GARisk RF=',num2str(round(RF)),' iRF=',num2str(round(iRF)),' Profit=',num2str(round(Profit/10000)),' MaxDD=',num2str(round(maxDD))]);
[Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD]=PayProperties(Portfolio3);
disp(['CsvRisk RF=',num2str(round(RF)),' iRF=',num2str(round(iRF)),' Profit=',num2str(round(Profit/10000)),' MaxDD=',num2str(round(maxDD))]);
Plot('ManualRisk NoRisk GARisk CsvRisk', FullTime, [Portfolio0;Portfolio1;Portfolio2;Portfolio3], [0;1;2;3], 5); % (PlotName, X, Y, ID, Lines)
%% ��������� �� �������� ������� Bal, � �������������� ID (����� ����� ���������� �� ��������)
Bal=Deals2Balances(Deals,Time,FullTime,CsvRisk); % ������� � ������ ������ �� csv ������
Max=max(Bal'); % ������ ������������ �������� ������� Bal
Bal(:,(length(Bal)+1))=Max; % �������� � ����� ������� �������� ������� � ������������ ���������� 
Bal=sortrows(Bal,length(Bal)); % ����������� ������ �������� �� ���������� ����������� �������
Bal(:,length(Bal))=[]; % ������ ��������� ������� � ������������� ����������
ID(2,:)=Max; % �������� � ����� ������� ��������������� ������� � ������������ ���������� 
ID=sortrows(ID',2); % ��� �� ��������� ������ ���������������
ID(:,2)=[]; % ������� ������ ������� � ����. ����������, �������� ���� �������������� 
%% ������ ���� ��������� � ����� ���� 
% Plot('BalCsvRsk', FullTime, Bal, ID, Lines); % (PlotName, X, Y, ID, Lines)

%% ��������� ������� ����������� ������

% clear % ����� ���
% load('TestsResults'); % ��������������� ������ ����������� ������

% ���������� ������ ��������� ��� �������� ������ MO/SD, RF, iRF...
% ��� ������ �� ����� #.csv � ��������� ������
% ����� ��������� �������� Optimisation.m � ����������� � OptResults.m
% ���������� �������� ������ 
% ���������� �������� ��������� ��� ������ �������� ������
% ���������� �������� ��������� �� ��������� ����� MatLabTest.csv 
% �������� ����� NewRsk.xlsx � ��������� ������ � ���������������� ��
% ����������������� ���������  

% ���������� ����������� ������� ��������� � �������������� ������� frontcon ��� portopt... 
% � ����� �������� �������� portalloc
% ID - ������ ���������������
% Bal - ������ ��������, ���������� �� ����� ������� FullTime
% FullTime - ����� ������ ������� ������� = StartDate:EndDate:Hour
% Deals - ������ ������
% Time - ������ ��������������� ��� ������� �������� ������� ������
%% ���������� ��������
% guide - ������ ��������� 
clear % clear workspace and memory
close all % Remove all figures
Lines=7; % ���������� ����� �� ����� �������
%% ��������� ���� � �������
Path=['D:\WORK\MatLab\FX\'];
csv2mat('MatLabTest.csv');  % create file "TestsResults.mat"
load([Path,'TestsResults']);       % ID, Risk, Deals, Time, FullTime, Start, End, Rows, Cols, Days
OneRisk=ones(length(Risk));          % ������� ��� ������
OneRisk=sum(OneRisk)/length(Risk);   % ������ �� � ������
%% TEST

%% ������� ������: ����������� ������������, ���������
load([Path,'OptResults']);
%% ������� ������ ������
x=[1:length(Risk)];
Legend=[{'MOSD'},{'MOSDga'}];       Plot('Rsk MOSD',    x, [rMOSD; rMOSDga],    Legend,Lines);
Legend=[{'rRF'},{'rIRF'}];          Plot('Rsk RF,iRF',  x, [rRF; rIRF],         Legend,Lines);
Legend=[{'ALL'},{'CSV'}];           Plot('Rsk All,CSV', x, [rALL; Risk],        Legend,Lines);
%% ������������ ������ � ��������� 0..1
% ManualRisk=ManualRisk/max(ManualRisk); % ����������� ������� � 1
% optiRF=optiRF/max(optiRF); % ����������� ������� � 1
% optRF=optRF/max(optRF); % ����������� ������� � 1
%% ������������ ���������
Portfolio0=sum(bal(Deals,Time,FullTime,rMOSD));   
Portfolio1=sum(bal(Deals,Time,FullTime,rIRF));     
Portfolio2=sum(bal(Deals,Time,FullTime,rRF));    
Portfolio3=sum(bal(Deals,Time,FullTime,Risk));     
Portfolio4=sum(bal(Deals,Time,FullTime,OneRisk)); 
%% ������������ � 1
Portfolio0=Portfolio0/max(Portfolio0);
Portfolio1=Portfolio1/max(Portfolio1);
Portfolio2=Portfolio2/max(Portfolio2);
Portfolio3=Portfolio3/max(Portfolio3);
Portfolio4=Portfolio4/max(Portfolio4);
%% ���������� ��������� ��������� � ����� ���� � ������� �� �������������
[Profit,RF0,iRF0,curDD,maxDD,DDIndex,MOSD0]=PayProperties(Portfolio0); disp(['rMOSD RF=',num2str(round(RF0)),' iRF=',num2str(round(iRF0)),' MOSD=',num2str(round(MOSD0,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF1,iRF1,curDD,maxDD,DDIndex,MOSD1]=PayProperties(Portfolio1); disp(['rIRF  RF=',num2str(round(RF1)),' iRF=',num2str(round(iRF1)),' MOSD=',num2str(round(MOSD1,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF2,iRF2,curDD,maxDD,DDIndex,MOSD2]=PayProperties(Portfolio2); disp(['rRF   RF=',num2str(round(RF2)),' iRF=',num2str(round(iRF2)),' MOSD=',num2str(round(MOSD2,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF3,iRF3,curDD,maxDD,DDIndex,MOSD3]=PayProperties(Portfolio3); disp(['rCSV  RF=',num2str(round(RF3)),' iRF=',num2str(round(iRF3)),' MOSD=',num2str(round(MOSD3,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF4,iRF4,curDD,maxDD,DDIndex,MOSD4]=PayProperties(Portfolio4); disp(['rOne  RF=',num2str(round(RF4)),' iRF=',num2str(round(iRF4)),' MOSD=',num2str(round(MOSD4,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
% Plt('All Portfolios', FullTime, Balances(Deals,Time,FullTime,CsvRisk));
Legend=[{'SD'},{'csv'}];   Plot('Portfolios SD,csv',FullTime, [Portfolio0; Portfolio3],Legend,Lines); % (PlotName, X, Y, ID, Lines)
Legend=[{'RF'},{'IRF'}];   Plot('Portfolios RF,IRF',FullTime, [Portfolio2; Portfolio1],Legend,Lines); % (PlotName, X, Y, ID, Lines)
Legend=[{'R1'},{'IRF'}];   Plot('Portfolios R1,IRF',FullTime, [Portfolio4; Portfolio1],Legend,Lines);
% Plot('���������� �������� � ������ ������', FullTime, Portfolio3, [0], 5); % (PlotName, X, Y, ID, Lines)
%% ��� ���������� ������������
Mo=Portfolio0(Days)/Days;  for i=1:Days, Portfolio0(i)=Portfolio0(i)-Mo*i; end 
Mo=Portfolio1(Days)/Days;  for i=1:Days, Portfolio1(i)=Portfolio1(i)-Mo*i; end  
Mo=Portfolio2(Days)/Days;  for i=1:Days, Portfolio2(i)=Portfolio2(i)-Mo*i; end  
Mo=Portfolio3(Days)/Days;  for i=1:Days, Portfolio3(i)=Portfolio3(i)-Mo*i; end 
Mo=Portfolio4(Days)/Days;  for i=1:Days, Portfolio4(i)=Portfolio4(i)-Mo*i; end 
Legend=[{'IRF'},{'RF'},{'R1'}];
Plot('NoMO', FullTime, [Portfolio1; Portfolio2; Portfolio4],Legend,Lines);
%% Exel file create
Handle={'Magic','csv_Risk','RF_Risk','iRF_Risk','MOSD_Risk'};
List=   [ID',   Risk',      rRF',     rIRF',     rMOSD']; % �������������� ������ ID,Risk,... � ������� � ���������� �� � ������� List
StrData=vertcat(Handle,num2cell(List)); % ������������ �������� ��������� �������� - ��������� ������ � ������� ������ ��������� 
StrData=vertcat(StrData,{'RF',  round(RF3),     round(RF2),     round(RF1),     round(RF0)});
StrData=vertcat(StrData,{'IRF', round(iRF3),    round(iRF2),    round(iRF1),    round(iRF0)});
StrData=vertcat(StrData,{'MOSD',round(MOSD3,3), round(MOSD2,3), round(MOSD1,3), round(MOSD0,3)});
xlswrite([Path,'NewRsk.xlsx'],StrData);
%% ������� ���� ��������� � ����� ���� ��� ������ �� ������� ������
Bal=bal(Deals,Time,FullTime,Risk); % ������� � ������ ������ �� csv ������
% Max=max(Bal'); % ������ ������������ �������� ������� Bal
% Bal(:,(length(Bal)+1))=Max; % �������� � ����� ������� �������� ������� � ������������ ���������� 
% Bal=sortrows(Bal,length(Bal)); % ����������� ������ �������� �� ���������� ����������� �������
% Bal(:,length(Bal))=[]; % ������ ��������� ������� � ������������� ����������
% ID(2,:)=Max; % �������� � ����� ������� ��������������� ������� � ������������ ���������� 
% ID=sortrows(ID',2); % ��� �� ��������� ������ ���������������
% ID(:,2)=[]; % ������� ������ ������� � ����. ����������, �������� ���� �������������� 
Legend={num2str(ID(1))}; 
for i=2:Rows, Legend(i)={num2str(ID(i))}; end % ��������� ������� �������� �� Magi�-��
Plot('All Experts', FullTime, Bal, Legend, Lines);
%% ��������������� ���������� ������� �������
Risk1(1:Rows)=1;
Bal=bal(Deals,Time,FullTime,Risk1); % ����������� ������� ���� ��������� �� ����� ������� StartDate:Hour:EndDate
Max=max(Bal');  % ������ ������������ �������� ������� Bal
Max=max(Max);   % ������������ �������� �������, �������, ����� ������� ��� �� 1
Bal=Bal/Max;    % ��������� � 1
%% ���������� ���������� / ����������
Prf=Bal(:,Days)'; % ������ ����������� ���� ������ (��������� �������� � �������� ��������) 
% ���������� - ���� �������� ����������� ���� ��������� �������, ������ ���. �������� ������������ ���������� ��������� ������� �� �� ���. ��������
% �������������� ������� - �������, ������������ �� �������� ���������� ��������� ������ ��� ���� ��������� �������� 
Cor=corrcoef(Bal'); % ������� ����������
Std=std(Bal');% ����������� ���������� ��� ������ ������ ��������
% Cov=corr2cov(Std,Cor); % �������������� �������
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
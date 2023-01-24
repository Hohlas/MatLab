% Построение кривых портфелей для векторов рисков MO/SD, RF, iRF...
% Для рисков из файла #.csv и единичных рисков
% Риски считаются функцией Optimisation.m и сохраняются в OptResults.m
% Построение векторов рисков 
% Построение графиков портфелей для разных векторов рисков
% Построение графиков экспертов из тестового файла MatLabTest.csv 
% создание файла NewRsk.xlsx с векторами рисков и соответствующими им
% характерсистиками портфелей  

% построение эффективной границы Марковица с использованием функций frontcon ИЛИ portopt... 
% и выбор портфеля функцией portalloc
% ID - массив идентификаторов
% Bal - массив балансов, растянутый на шкалу времени FullTime
% FullTime - общий массив времени баланса = StartDate:EndDate:Hour
% Deals - массив сделок
% Time - массив индивидуального для каждого эксперта времени сделок
%% Изменяемые значения
% guide - запуск редактора 
clear % clear workspace and memory
close all % Remove all figures
Lines=7; % количество линий на одном графике
%% открываем файл с тестами
Path=['D:\WORK\MatLab\FX\'];
csv2mat('MatLabTest.csv');  % create file "TestsResults.mat"
load([Path,'TestsResults']);       % ID, Risk, Deals, Time, FullTime, Start, End, Rows, Cols, Days
OneRisk=ones(length(Risk));          % матрица АхА единиц
OneRisk=sum(OneRisk)/length(Risk);   % вектор из А единиц
%% TEST

%% векторы рисков: нормирующий прибыльность, единичный
load([Path,'OptResults']);
%% Пострим график рисков
x=[1:length(Risk)];
Legend=[{'MOSD'},{'MOSDga'}];       Plot('Rsk MOSD',    x, [rMOSD; rMOSDga],    Legend,Lines);
Legend=[{'rRF'},{'rIRF'}];          Plot('Rsk RF,iRF',  x, [rRF; rIRF],         Legend,Lines);
Legend=[{'ALL'},{'CSV'}];           Plot('Rsk All,CSV', x, [rALL; Risk],        Legend,Lines);
%% Нормализация рисков к диапазону 0..1
% ManualRisk=ManualRisk/max(ManualRisk); % нормализуем матрицу к 1
% optiRF=optiRF/max(optiRF); % нормализуем матрицу к 1
% optRF=optRF/max(optRF); % нормализуем матрицу к 1
%% формирование портфелей
Portfolio0=sum(bal(Deals,Time,FullTime,rMOSD));   
Portfolio1=sum(bal(Deals,Time,FullTime,rIRF));     
Portfolio2=sum(bal(Deals,Time,FullTime,rRF));    
Portfolio3=sum(bal(Deals,Time,FullTime,Risk));     
Portfolio4=sum(bal(Deals,Time,FullTime,OneRisk)); 
%% нормализация к 1
Portfolio0=Portfolio0/max(Portfolio0);
Portfolio1=Portfolio1/max(Portfolio1);
Portfolio2=Portfolio2/max(Portfolio2);
Portfolio3=Portfolio3/max(Portfolio3);
Portfolio4=Portfolio4/max(Portfolio4);
%% Построение различных портфелей в одном окне с выводом их характеристик
[Profit,RF0,iRF0,curDD,maxDD,DDIndex,MOSD0]=PayProperties(Portfolio0); disp(['rMOSD RF=',num2str(round(RF0)),' iRF=',num2str(round(iRF0)),' MOSD=',num2str(round(MOSD0,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF1,iRF1,curDD,maxDD,DDIndex,MOSD1]=PayProperties(Portfolio1); disp(['rIRF  RF=',num2str(round(RF1)),' iRF=',num2str(round(iRF1)),' MOSD=',num2str(round(MOSD1,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF2,iRF2,curDD,maxDD,DDIndex,MOSD2]=PayProperties(Portfolio2); disp(['rRF   RF=',num2str(round(RF2)),' iRF=',num2str(round(iRF2)),' MOSD=',num2str(round(MOSD2,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF3,iRF3,curDD,maxDD,DDIndex,MOSD3]=PayProperties(Portfolio3); disp(['rCSV  RF=',num2str(round(RF3)),' iRF=',num2str(round(iRF3)),' MOSD=',num2str(round(MOSD3,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
[Profit,RF4,iRF4,curDD,maxDD,DDIndex,MOSD4]=PayProperties(Portfolio4); disp(['rOne  RF=',num2str(round(RF4)),' iRF=',num2str(round(iRF4)),' MOSD=',num2str(round(MOSD4,2)),' Profit=',num2str(round(Profit*1000)),' MaxDD=',num2str(round(maxDD*1000))]);
% Plt('All Portfolios', FullTime, Balances(Deals,Time,FullTime,CsvRisk));
Legend=[{'SD'},{'csv'}];   Plot('Portfolios SD,csv',FullTime, [Portfolio0; Portfolio3],Legend,Lines); % (PlotName, X, Y, ID, Lines)
Legend=[{'RF'},{'IRF'}];   Plot('Portfolios RF,IRF',FullTime, [Portfolio2; Portfolio1],Legend,Lines); % (PlotName, X, Y, ID, Lines)
Legend=[{'R1'},{'IRF'}];   Plot('Portfolios R1,IRF',FullTime, [Portfolio4; Portfolio1],Legend,Lines);
% Plot('Доходность портфеля с учетом рисков', FullTime, Portfolio3, [0], 5); % (PlotName, X, Y, ID, Lines)
%% Без постоянной составляющей
Mo=Portfolio0(Days)/Days;  for i=1:Days, Portfolio0(i)=Portfolio0(i)-Mo*i; end 
Mo=Portfolio1(Days)/Days;  for i=1:Days, Portfolio1(i)=Portfolio1(i)-Mo*i; end  
Mo=Portfolio2(Days)/Days;  for i=1:Days, Portfolio2(i)=Portfolio2(i)-Mo*i; end  
Mo=Portfolio3(Days)/Days;  for i=1:Days, Portfolio3(i)=Portfolio3(i)-Mo*i; end 
Mo=Portfolio4(Days)/Days;  for i=1:Days, Portfolio4(i)=Portfolio4(i)-Mo*i; end 
Legend=[{'IRF'},{'RF'},{'R1'}];
Plot('NoMO', FullTime, [Portfolio1; Portfolio2; Portfolio4],Legend,Lines);
%% Exel file create
Handle={'Magic','csv_Risk','RF_Risk','iRF_Risk','MOSD_Risk'};
List=   [ID',   Risk',      rRF',     rIRF',     rMOSD']; % переворачиваем строки ID,Risk,... в столбцы и складываем их в матрицу List
StrData=vertcat(Handle,num2cell(List)); % вертикальное сложение строковых массивов - добавляем сверху к массиву данных заголовок 
StrData=vertcat(StrData,{'RF',  round(RF3),     round(RF2),     round(RF1),     round(RF0)});
StrData=vertcat(StrData,{'IRF', round(iRF3),    round(iRF2),    round(iRF1),    round(iRF0)});
StrData=vertcat(StrData,{'MOSD',round(MOSD3,3), round(MOSD2,3), round(MOSD1,3), round(MOSD0,3)});
xlswrite([Path,'NewRsk.xlsx'],StrData);
%% графики всех экспертов в одном окне для одного из наборов рисков
Bal=bal(Deals,Time,FullTime,Risk); % балансы с учетом рисков из csv файлов
% Max=max(Bal'); % вектор максимальных значений матрицы Bal
% Bal(:,(length(Bal)+1))=Max; % припишем в конец массива балансов столбец с максималными значениями 
% Bal=sortrows(Bal,length(Bal)); % отсортируем массив балансов по последнему дописанному столбцу
% Bal(:,length(Bal))=[]; % удалим последний столбец с максимальными значениями
% ID(2,:)=Max; % припишем в конец массива идентификаторов столбец с максималными значениями 
% ID=sortrows(ID',2); % так же сортируем массив идентификаторов
% ID(:,2)=[]; % удаляем второй столбец с макс. значениями, оставляя одни идентификаторы 
Legend={num2str(ID(1))}; 
for i=2:Rows, Legend(i)={num2str(ID(i))}; end % формируем легенду графиков из Magiс-ов
Plot('All Experts', FullTime, Bal, Legend, Lines);
%% предварительная нормировка массива баланса
Risk1(1:Rows)=1;
Bal=bal(Deals,Time,FullTime,Risk1); % растягиваем массивы всех экспертов на шкалу времени StartDate:Hour:EndDate
Max=max(Bal');  % вектор максимальных значений матрицы Bal
Max=max(Max);   % максимальное значение вектора, матрицы, чтобы принять его за 1
Bal=Bal/Max;    % нормируем к 1
%% вычисление ковариации / корреляции
Prf=Bal(:,Days)'; % вектор доходностей всех систем (последнее значение в массивах балансов) 
% ковариация - мера линейной зависимости двух случайных величин, равная мат. ожиданию произведения отклонений случайных величин от из мат. ожиданий
% ковариационная матрица - матрица, составленная из попарных ковариаций элементов одного или двух случайных векторов 
Cor=corrcoef(Bal'); % матрица корреляций
Std=std(Bal');% стандартное отклонение для каждой строки балансов
% Cov=corr2cov(Std,Cor); % ковариационная матрица
Cov2=cov(Bal');  % ковариационная матрица (2-й способ нахождения)
%% Вычисление Р-ка
% [PortSTD,Profit,OptRisks]=portopt(Prf,Cov2,25);
% Risk - вектор рисков для каждого портфеля (среднеквадратические отклонения доходности от ожидаемой)
% Profit - вектор ожидаемых доходностей для каждого портфеля
% Parts - массив, каждая строка которого представляет доли активов в портфеле.
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
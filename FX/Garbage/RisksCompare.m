% построение графиков из тестового файла MatLabTest.csv
% сохранение массивов в переменную TestsResults.m для дальнейшей обработки 
% построение эффективной границы Марковица с использованием функций frontcon ИЛИ portopt... 
% и выбор портфеля функцией portalloc
% ID - массив идентификаторов
% Bal - массив балансов, растянутый на шкалу времени FullTime
% FullTime - общий массив времени баланса = StartDate:EndDate:Hour
% Deals - массив сделок
% Time - массив индивидуального для каждого эксперта времени сделок
%% Изменяемые значения
% clear % clear workspace and memory
close all % Remove all figures
Lines=7; % количество линий на одном графике
CheckPeriod='min'; % период сравнения графиков: 'min'-минимальный из тестируемых
%% открываем файл с тестами
Folder='D:\WORK\MatLab\FX\'; % путь сохранения рабочей области
FileName='TestsResults';     % название файла/рабочей области
TestFile='MatLabTest.csv';   % файл с резами сделок/временем их совершения
[ID,Risk,Deals,Time]=csv2mat(TestFile); % получаем массивы вида: 1373393 ; 1.7 ; -5770 ; 2000.04.04 22:50 , где -5770-рез. сделки, умноженный на 100 
if ID==-1, disp('программа остаовлена'); return, end
[Rows,Cols] = size(Deals); % кол-во экспертов, максимальное число записей
%% формируем новые шкалы времени с шагом в день
Start=floor(min(Time(:,1)))-1; % меньшее значение первого столбца округлим до меньшего целого (до дней)
End=ceil(max(max(Time))); % макс значение матрицы округлим до большего целого (до дней)
FullTime=Start:1:End; % Разбиваем диапазон Start-End, на котором производится сравнение на равные части . длиной в час
Days=length(FullTime); % размерность шкалы времени
disp(['Период проверки ',datestr(Start,'dd.mm.yyyy'),' - ',datestr(End,'dd.mm.yyyy'),', всего ',num2str(Days),' дней / ',num2str(floor(Days/365)),' лет']);
save([Folder,FileName], 'ID','FullTime','Deals','Time','Rows'); 
%% векторы рисков: нормирующий прибыльность, единичный
ManualRisk=[2.0 7.3  3.3 3.1 3.2 4.4 ... % вручную подобранные риски ...
      1.2 0.65 2.3 4.0 1.3 4.6 ...% выравнивающие прибыльность
      4.6 2.6 ];
NoRisk= [99  164  125   99  115   27   88  116   60   29   91  100   90  138]; % массив единичных рисков
GARisk=[812  940  816   661  1091  612  646  334  946  128  1597  345  500  1217];
%% 
ManualRisk=ManualRisk/max(ManualRisk); 
NoRisk=NoRisk/max(NoRisk);
GARisk=GARisk/max(GARisk);
% CsvRisk=CsvRisk/max(CsvRisk);
%% предварительная нормировка массива баланса
Bal=bal(Deals,Time,FullTime,Risk); %растягиваем массивы всех экспертов на шкалу времени StartDate:Hour:EndDate
Max=max(Bal'); % вектор максимальных значений матрицы Bal
Max=max(Max); % максимальное значение вектора, матрицы, чтобы принять его за 1
Bal=Bal/Max; % нормируем к 1
%% вычисление ковариации / корреляции
% Prf=Bal(:,Hours)'; % вектор доходностей всех систем (последнее значение в массивах балансов) 
% ковариация - мера линейной зависимости двух случайных величин, равная мат. ожиданию произведения отклонений случайных величин от из мат. ожиданий
% ковариационная матрица - матрица, составленная из попарных ковариаций элементов одного или двух случайных векторов 
Cor=corrcoef(Bal'); % матрица корреляций
Std=std(Bal');% стандартное отклонение для каждой строки балансов
%Cov=corr2cov(Std,Cor); % ковариационная матрица
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
%% Нормализация портфелей к одному значению (за единицу берется значение максимального портфеля)
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
%% сортируем по размерам массивы Bal, и соответственно ID (чтобы лучше смотрелось на графиках)
Bal=Deals2Balances(Deals,Time,FullTime,CsvRisk); % балансы с учетом рисков из csv файлов
Max=max(Bal'); % вектор максимальных значений матрицы Bal
Bal(:,(length(Bal)+1))=Max; % припишем в конец массива балансов столбец с максималными значениями 
Bal=sortrows(Bal,length(Bal)); % отсортируем массив балансов по последнему дописанному столбцу
Bal(:,length(Bal))=[]; % удалим последний столбец с максимальными значениями
ID(2,:)=Max; % припишем в конец массива идентификаторов столбец с максималными значениями 
ID=sortrows(ID',2); % так же сортируем массив идентификаторов
ID(:,2)=[]; % удаляем второй столбец с макс. значениями, оставляя одни идентификаторы 
%% график всех экспертов в одном окне 
% Plot('BalCsvRsk', FullTime, Bal, ID, Lines); % (PlotName, X, Y, ID, Lines)

%% сохраняем массивы необходимых данных

% clear % херим все
% load('TestsResults'); % восстанавливаем только необходимые данные

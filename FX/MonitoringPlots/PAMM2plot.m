clear % clear workspace and memory
%% отдельный график PAMM2
[StrData, Days, Columns] =  csv2cell('04_monitoring_PAMM2.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
Time=datenum(char(StrData(:,1)),'dd.mm.yyyy'); % перевод строки вида "18.02.2011;23:30" в массив [7.345379652777778e+05]
PerCent=str2num(char(StrData(:,2))); % перевод строки в число (результаты сделок)
Pay=PerCent+100; % формируем цену пая из массива процентов
StartDate=Time(1);
EndDate=Time(Days);
X = linspace(StartDate,EndDate,Days); % разбивает диапазон StartDate..EndDate на Days равных частей
Y=Pay
%% расчет рыночных показателей
[CurProfit,MaxProfit,CurDD,MaxDD,DateDD,maxIncrease,DateIncrease]=PayProperties(Pay);
disp (['curProfit=',num2str(round(CurProfit)),'%, curDD=',num2str(round(CurDD)),'%']);
disp (['maxProfit=',num2str(round(MaxProfit)),'%, maxDD=',num2str(round(MaxDD)),'% (',datestr(DateDD,'dd.mm.yyyy'),')']);
disp (['maxIncrease=',num2str(round(maxIncrease)),'% (',datestr(DateIncrease,'dd.mm.yyyy'),')']);
disp (['RF=',num2str(round(MaxProfit/MaxDD)),', Period: ',datestr(StartDate,'dd.mm.yyyy'),'-',datestr(EndDate,'dd.mm.yyyy')]);
%% Рисуем график в паях
BorderColor=[1 1 1];
GridColor=[0 0 0];% цвет оси
BackGroundColor=[1 1 1]; % цвет заливки графика *0.95
hold on;% наложение двух или более графиков 
close all % Remove all figures
figure1 = figure('Color',BorderColor); % цвет заливки бордюра
axes1 = axes('Parent',figure1,...% Create axes
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
    'YColor',GridColor,...% цвет оси Y
    'XColor',GridColor,...% цвет оси X
    'Color',BackGroundColor); % цвет заливки графика
hold(axes1,'all');
plot(X,Y,'LineWidth',1,'Color',[0 0 0]);
ylabel('EUR'); 
%xlabel(' Date'); 
datetick('x','yyyy')
grid on
title('Динамика баланса второго ПАММ счета (цена пая)','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','PAMM2'];
h=figure1;
print ('-dpng','-r100',path);
%% График в процентах
figure2 = figure('Color',BorderColor); % цвет заливки бордюра
axes2 = axes('Parent',figure2,...% Create axes
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
    'YColor',GridColor,...% цвет оси Y
    'XColor',GridColor,...% цвет оси X
    'Color',BackGroundColor); % цвет заливки графика
grid(axes2,'on');
hold(axes2,'all');
datetick('x','yyyy')
plot(X, Y,'LineWidth',1,'Color',[0 0 0]);
%ylabel('%'); 
%xlabel(' Date'); 
datetick('x','yyyy')
title('Динамика баланса второго ПАММ счета, %','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','PAMM2percent'];
h=figure1;
print ('-dpng','-r100',path);


%% только для 2013г
% Pay(1:466)=[]; Time(1:466)=[];
% [CurProfit,MaxProfit,CurDD,MaxDD,DateDD,maxIncrease,DateIncrease]=PayProperties(Pay,Time);
% Days=length(Time);
% StartDate=Time(1);
% EndDate=Time(Days);
% disp('-------------');
% disp (['curProfit=',num2str(round(CurProfit)),'%, curDD=',num2str(round(CurDD)),'%']);
% disp (['maxProfit=',num2str(round(MaxProfit)),'%, maxDD=',num2str(round(MaxDD)),'% (',datestr(DateDD,'dd.mm.yyyy'),')']);
% disp (['maxIncrease=',num2str(round(maxIncrease)),'% (',datestr(DateIncrease,'dd.mm.yyyy'),')']);
% disp (['RF=',num2str(round(MaxProfit/MaxDD)),', Period: ',datestr(StartDate,'dd.mm.yyyy'),'-',datestr(EndDate,'dd.mm.yyyy')]);

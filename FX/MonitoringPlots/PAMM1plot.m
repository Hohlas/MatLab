clear % clear workspace and memory
%% отдельный график PAMM1
[StrData, Lines, Columns] =  csv2cell('02_monitoring_PAMM1.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
[Time,PerCent]=cell2data(StrData);% из строк вида '18.02.2011' '23:30' '5.47' делаем два массива: "врем€" и "сделки"
Balance(1)=490; % начальное значение баланса (то, что осталось от микро1)
for i=2:Lines % суммиру€ резы сделок
   Balance(i)=Balance(1)*(1+PerCent(i)/100); % формируем массив баланса, бер€ процент от начального дл€ данного счета баланса Balance(Deals-1)
%    PerCent(i)=(Balance(i)-Balance(1))/Balance(1)*100; % и массив процента от начального баланса
end
StartDate=Time(1);
EndDate=Time(Lines);
X = linspace(StartDate,EndDate,Lines); % разбивает диапазон StartDate..EndDate на Lines равных частей
Y=Balance;
%% –исуем график
BorderColor=[1 1 1];
GridColor=[0 0 0];% цвет оси
BackGroundColor=[1 1 1]; % цвет заливки графика *0.95
hold on;% наложение двух или более графиков 
close all % Remove all figures
figure1 = figure('Color',BorderColor); % цвет заливки бордюра
axes1 = axes('Parent',figure1,...% Create axes
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на ос€х
    'YColor',GridColor,...% цвет оси Y
    'XColor',GridColor,...% цвет оси X
    'Color',BackGroundColor); % цвет заливки графика
hold(axes1,'all');
plot(X,Y,'LineWidth',1,'Color',[0 0 0]);
ylabel('EUR'); 
%xlabel(' Date'); 
datetick('x','mm/yyyy')
grid on
title('ƒинамика баланса первого ѕјћћ счета','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','PAMM1'];
h=figure1;
print ('-dpng','-r100',path);
clear % clear workspace and memory
%% 
[StrData, Lines, Columns] =  csv2cell('01_monitoring_micro1.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
[Time,Dial]=cell2data(StrData);% из строк вида '18.02.2011' '23:30' '5.47' делаем два массива: "врем€" и "сделки"
Balance(1)=Dial(1); % начальное значение баланса
for i=2:Lines % суммиру€ резы сделок,
   Balance(i)=Balance(i-1)+Dial(i); % формируем массив баланса 
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
title('ƒинамика баланса первого микро счета','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','Micro1'];
h=figure1;
print ('-dpng','-r100',path);
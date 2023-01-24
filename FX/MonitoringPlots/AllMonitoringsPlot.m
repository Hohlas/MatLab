%% сшивание файлов мониторинга, преобразование в непрерывный баланс (ЕВРО) и построение графиков баланса, процентов и логарифма баланса
% 01_monitoring_micro1.csv - VIAC
% 02_monitoring_PAMM1.csv 
% 03_monitoring_micro2.csv 
% 04_monitoring_PAMM2.csv - pamm2(now using)
clear % clear workspace and memory
BorderColor=[1 1 1];
GridColor=[0 0 0];% цвет оси
BackGroundColor=[1 1 1]*0.95; % цвет заливки графика
%% 01 формирование из результатов сделок массива баланса для файла "01_monitoring_micro1.csv"
[StrData, Lines, Columns] =  csv2cell('01_monitoring_micro1.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
[Time1,Dial]=cell2data(StrData);% из строк вида '18.02.2011' '23:30' '5.47' делаем два массива: "время" и "сделки"
Balance(1)=Dial(1); % начальное значение баланса 
for i=2:Lines % суммируя резы сделок,
   Balance(i)=Balance(i-1)+Dial(i); % формируем массив баланса 
   %    PerCent(i)=(Balance(i)-Balance(1))/Balance(1)*100; % и массив процента от начального баланса
end
Time=Time1'; % общая шкала времени складываемых массивов
Deals=Lines; % запоминаем количество сделок для последующего подсчета
%% 02 формирование из процентов прибыли массива баланса для файла "02_monitoring_PAMM1.csv"
[StrData, Lines, Columns] =  csv2cell('02_monitoring_PAMM1.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
[Time2,PerCent]=cell2data(StrData);% из строк вида '18.02.2011' '23:30' '5.47' делаем два массива: "время" и "прибыль"
for i=1:Lines % суммирем резы сделок, сдесь дается не результат сделки, а процент от начального баланса
   Balance(Deals+i)=Balance(Deals)*(1+PerCent(i)/100); % формируем массив баланса, беря процент от начального для данного счета баланса Balance(Deals-1)
   Time(Deals+i)=Time2(i);
end
Deals=Deals+Lines; % суммируем количество сделок для последующего подсчета
%% 03 формирование из результатов сделок массива баланса для файла "03_monitoring_micro2.csv"
[StrData, Lines, Columns] =  csv2cell('03_monitoring_micro2.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
[Time3,Dial]=cell2data(StrData);% из строк вида '18.02.2011' '23:30' '5.47' делаем два массива: "время" и "сделки"
for i=1:Lines % суммирем резы сделок
   Balance(Deals+i)=Balance(Deals+i-1)+Dial(i); % формируем массив баланса
   Time(Deals+i)=Time3(i);
end
Deals=Deals+Lines; % суммируем количество сделок для последующего подсчета
%% 04 формирование  из процентов прибыли массива баланса для файла "04_monitoring_PAMM2.csv"
[StrData, Lines, Columns] =  csv2cell('04_monitoring_PAMM2.csv'); % формирование из файла *.csv структуры строковых данных StrData[Lines, Columns] 
Time4=datenum(char(StrData(:,1)),'dd.mm.yyyy'); % перевод строки вида "18.02.2011;23:30" в массив [7.345379652777778e+05]
PerCent=str2num(char(StrData(:,2))); % перевод строки в число (проценты прибыли)
for i=1:Lines % суммирем резы сделок, сдесь дается не результат сделки, а процент от начального баланса
   Balance(Deals+i)=Balance(Deals)*(1+PerCent(i)/100); % формируем массив баланса, беря процент от начального для данного счета баланса Balance(Deals-1)
   Time(Deals+i)=Time4(i);
end
Deals=Deals+Lines; % суммируем количество сделок для последующего подсчета
%% расчет процентов, логарифма
StartDate=datenum(Time(1))-1;
EndDate=datenum(Time(Deals))+1;
for i=1:Deals % формируем массивы процентов и логарифма
   PerCent(i)=(Balance(i)-Balance(1))/Balance(1)*100; % и массив процента от начального баланса
   if Balance(i)>0, LogBalance(i)=log10(Balance(i)); else LogBalance(i)=0; end % не берем логарифм отрицательного числа
end
i=1; k=0;
Y1(1)=PerCent(1);
Y2(1)=LogBalance(1);
Y3(1)=Balance(1);
for day=StartDate:EndDate
   k=k+1;
   X(k)=day;
   if k>1,     
      Y1(k)=Y1(k-1); % присваиваем на всякий случай новому члену прошлое значение... 
      Y2(k)=Y2(k-1); % чтобы оно не осталось пустым, если за этот день не будет сделок
      Y3(k)=Y3(k-1);
   end
   while (Time(i)<=day && i<Deals),
      Y1(k)=PerCent(i);
      Y2(k)=LogBalance(i);
      Y3(k)=Balance(i);
      i=i+1; 
   end
end
%%  рисуем график процентов
close all % Remove all figures
% hold on;% наложение двух или более графиков 
figure1 = figure('Color',BorderColor); % цвет заливки бордюра
axes1 = axes('Parent',figure1,...% Create axes
    'YTickLabel',{'20000%','40000%','60000%','80000%','100000%','120000%','140000%','160000%','180000%','200000%'},...
    'YTick',     [ 20000    40000    60000    80000    100000    120000    140000    160000    180000    200000],...
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
    'YColor',GridColor,...% цвет оси Y
    'XColor',GridColor,...% цвет оси X
    'Color',BackGroundColor); % цвет заливки графика
xlim(axes1,[StartDate EndDate]);
ylim(axes1,[0 max(Y1)+3000]);
% box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');
datetick('x','yyyy')
plot(X,Y1,'LineWidth',1,'Color',[0 0 0]);
title('Profit, %','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','balance'];
h=figure1;
print ('-dpng','-r100',path);
%%  рисуем логарифмический график баланса
figure2 = figure('Color',BorderColor); % цвет заливки бордюра
axes2 = axes('Parent',figure2,...% Create axes
    'YTickLabel',{'25','50','100','200','400','800','1,600','3,200','6,400','12,800','25,600','51,200'},...
    'YTick',     [ 1.4  1.7   2    2.3   2.6   2.9    3.2     3.5     3.8      4.1     4.4       4.7],...
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
    'YColor',GridColor,...% цвет оси Y
    'XColor',GridColor,...% цвет оси X
    'Color',BackGroundColor); % цвет заливки графика
xlim(axes2,[StartDate EndDate]);
% box(axes1,'on');
grid(axes2,'on');
hold(axes2,'all');
datetick('x','yyyy')
plot(X, Y2,'LineWidth',1,'Color',[0 0 0]);
%ylabel('Евро'); 
title('Logarithm Balance, EUR','FontSize',12);
%% рисуем график баланса
figure3 = figure('Color',BorderColor); % цвет заливки бордюра
axes3 = axes('Parent',figure3,...% Create axes
    'YTickLabel',{'0','5,000','10,000','15,000','20,000','25,000','30,000','40,000','50,000','60,000','70,000'},...
    'YTick',[0 5000 10000 15000 20000 25000 30000 40000 50000 60000 70000],...
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
    'YColor',GridColor,...% цвет оси Y
    'XColor',GridColor,...% цвет оси X
    'Color',BackGroundColor); % цвет заливки графика 
xlim(axes3,[StartDate EndDate]);
grid(axes3,'on');
hold(axes3,'all');
datetick('x','yyyy')
plot(X, Y3,  'LineWidth',1,'Color',[0 0 0]);
%ylabel('EUR'); 
title('Balance, EUR','FontSize',12);
%% 
clear i Columns Deals Dial Lines StrData Time1 Time2 Time3 Time4 axes1 axes2 axes3 figure1 figure2 figure3 StartDate EndDate 
%plot(X,Yl,'r-', X,Y2,'b:'); 
%'у' -желтый, 'm' -пурпурный, 'с' -голубой, 'r' -красный, 'g' - зеленый, 'b' - синий, 'w' - белый и 'k' - черный. 
%'о' - кружок, 'х' - крест, '+' - плюс, '*' - звездочка. 


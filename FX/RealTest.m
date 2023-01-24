%%
% Преобразование данных файлов MatLabTest.csv, MatLabUSD.csv,... содержащих
% список сделок в массивы балансов. 
% Сохранение результатов в переменную TestsResults.m :
% Cols, Rows - кол-во столбцов, строк массивов балансов
% Days, - кол-во дней всей истории, 
% Risk - вектор рисков из файла #.csv
% Deals, Time - массив сделок и их времени. 
% Start, End - начало, конец полного периода тестирования.  
% FullTime - массив времени с интервалом в день для полного периода тестирования. 
%% Загрузка данных из csv файлов
clear % clear workspace and memory
tFile='MatLabTest.csv';
eFile='MatLabEUR.csv';
rFile='MatLabRUR.csv';
uFile='MatLabUSD.csv'; 
%% считывание массива с Теста  получаем массивы вида: 1373393 ; -5770 ; 2000.04.04 22:50 , где -5770-рез. сделки, умноженный на 100 
[ID, Risk,TPips,TTime]=csv2mat(tFile); % считывание массива с Теста(Т)
[eID,Risk,ePips,eTime]=csv2mat(eFile); % считывание массива с Реала(E)
[rID,Risk,rPips,rTime]=csv2mat(rFile); % считывание массива с Реала(R) 
[uID,Risk,uPips,uTime]=csv2mat(uFile); % считывание массива с Реала(U) 
Experts = size(TPips,1); % кол-во экспертов, (в первом измерении массива)
%% Заведем новые массивы UPips, EPips, RPips 
ECols = size(ePips,2); % максимальное число записей ...
RCols = size(rPips,2); % в оставшихся массивах 
UCols = size(uPips,2); %
TCols = size(TPips,2); 
UPips(1:Experts,UCols)=0; UTime(1:Experts,UCols)=0; % заведем массивы ...
EPips(1:Experts,ECols)=0; ETime(1:Experts,ECols)=0; % с нулевыми значениями ...
RPips(1:Experts,RCols)=0; RTime(1:Experts,RCols)=0; % в которые будем переписывать отобранные массивы
%% поиск общих (парных) ID в массивах реалов, т.е отбор только тех данных, которые имеются в файле теста
for Ex=1:Experts % перебираем массивы Теста
   for i=1:size(uPips,1) % перебираем массивы U
      if uID(i)==ID(Ex), UPips(Ex,:)=uPips(i,:); UTime(Ex,:)=uTime(i,:);  end
   end
   for i=1:size(ePips,1) % перебираем массивы E
      if eID(i)==ID(Ex), EPips(Ex,:)=ePips(i,:); ETime(Ex,:)=eTime(i,:);  end
   end
   for i=1:size(rPips,1) % перебираем массивы R
      if rID(i)==ID(Ex), RPips(Ex,:)=rPips(i,:); RTime(Ex,:)=rTime(i,:);  end
   end
end
%% на реалах ищем минимальную дату начала, на тесте максимальную дату конца
for Ex=1:Experts 
   End(Ex)=max(TTime(Ex,:));
   if max(UTime(Ex,:))>End(Ex), End(Ex)=max(UTime(Ex,:)); end
   if max(ETime(Ex,:))>End(Ex), End(Ex)=max(ETime(Ex,:)); end
   if max(RTime(Ex,:))>End(Ex), End(Ex)=max(RTime(Ex,:)); end
   Start(Ex)=End(Ex);
   if UTime(Ex,1)>0 && UTime(Ex,1)<Start(Ex), Start(Ex)=UTime(Ex,1); end
   if ETime(Ex,1)>0 && ETime(Ex,1)<Start(Ex), Start(Ex)=ETime(Ex,1); end
   if RTime(Ex,1)>0 && RTime(Ex,1)<Start(Ex), Start(Ex)=RTime(Ex,1); end
end
%% формируем новые шкалы времени с шагом в час
Start=floor(Start); % округлим до меньшего целого (до дней)
End=ceil(End); % округлим до большего целого (до дней)
for Ex=1:Experts 
    if End(Ex)-Start(Ex)>500, Start(Ex)=End(Ex)-500; end % ограничиваем длину периода до 500 дней
end    
disp(['Период проверки ',datestr(min(Start),'dd.mm.yyyy'),' - ',datestr(max(End),'dd.mm.yyyy')]);
Hour=(1/24); % шаг изменения шкалы времени 0.0417 (1день/24)
for Ex=1:Experts % диапазон пересечения Start(Ex)..End(Ex) теста и реала
   CompareTime{Ex}=Start(Ex):Hour:End(Ex); % Разбиваем диапазон Start-End, на котором производится сравнение на равные части . длиной в час
   Hours(Ex)=length(CompareTime{Ex}); % размерность шкалы времени
end
%% формируем массивы балансов, растягивая их на новую шкалу,
for Ex=1:Experts 
   t=1; r=1; e=1; u=1; 
   T{Ex}(1)=0; E{Ex}(1)=0; R{Ex}(1)=0; U{Ex}(1)=0;
   aaa=length(TTime);
   while CompareTime{Ex}(1)>TTime(Ex,t), 
       t=t+1;      if t>=length(TTime), break; end
   end % подгоняем индексы времени теста к моменту начала сравнения...
  
   for CT=2:Hours(Ex), % перебираем весь период сравнения по часу
      T{Ex}(CT)=T{Ex}(CT-1); % вытягиваем массив баланса для Теста...
      E{Ex}(CT)=E{Ex}(CT-1); % и для реалов
      R{Ex}(CT)=R{Ex}(CT-1); % 
      U{Ex}(CT)=U{Ex}(CT-1); % 
      if (CompareTime{Ex}(CT)>=TTime(Ex,t)), % если время периода достигло времени сделки ...
         aCT=CompareTime{Ex}(CT); aTT=TTime(Ex,t); aH=Hour; aDelta=CompareTime{Ex}(CT)-TTime(Ex,t);  
         if  CompareTime{Ex}(CT)-TTime(Ex,t)<=Hour, % но разница не превысила часа ...
            T{Ex}(CT)=T{Ex}(CT)+TPips(Ex,t); % изменяем значение баланса на величину сделки
         end
         if t<TCols, t=t+1; end % переходим на новую сделку с проверкой, чтобы не переполнить индекс массива 
      end
      if (CompareTime{Ex}(CT)>=ETime(Ex,e)), % если время периода достигло времени сделки ...
         if  CompareTime{Ex}(CT)-ETime(Ex,e)<=Hour, % но разница не превысила часа ...
            E{Ex}(CT)=E{Ex}(CT)+EPips(Ex,e); % изменяем значение баланса на величину сделки
         end
         if e<ECols, e=e+1; end % переходим на новую сделку с проверкой, чтобы не переполнить индекс массива 
      end
      if (CompareTime{Ex}(CT)>=RTime(Ex,r)), % если время периода достигло времени сделки ...
         if  CompareTime{Ex}(CT)-RTime(Ex,r)<=Hour, % но разница не превысила часа ...
            R{Ex}(CT)=R{Ex}(CT)+RPips(Ex,r); % изменяем значение баланса на величину сделки
         end
         if r<RCols, r=r+1; end % переходим на новую сделку с проверкой, чтобы не переполнить индекс массива 
      end
      if (CompareTime{Ex}(CT)>=UTime(Ex,u)), % если время периода достигло времени сделки ...
         if  CompareTime{Ex}(CT)-UTime(Ex,u)<=Hour, % но разница не превысила часа ...
            U{Ex}(CT)=U{Ex}(CT)+UPips(Ex,u); % изменяем значение баланса на величину сделки
         end
         if u<UCols, u=u+1; end % переходим на новую сделку с проверкой, чтобы не переполнить индекс массива 
      end
   end
end  
%% строим графики
% UnitePlots=0; % строим все в отдельных окнах, 1-в одном окне
% figure % create figure graphics object
% hold on;% наложение двух или более графиков 
close all % Remove all figures
CL=0.3; 
for Ex=1:Experts % перебираем строки
   figure1 = figure('Color',[0.76 0.87 0.78]); % цвет заливки бордюра
   axes1 = axes('Parent',figure1,...% Create axes
      'ZColor',[CL CL CL],'YColor',[CL CL CL],'XColor',[CL CL CL],...
      'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
      'FontName','Arial Cyr',...
      'Color',[0.8 0.8 0.8]); % цвет заливки графика
   grid(axes1,'on');
   hold(axes1,'all');
   X=CompareTime{Ex};
   YT=T{Ex}; % выбираем одну строку баланса из теста
   YR=R{Ex}; % выбираем одну строку баланса из реала
   YU=U{Ex}; % выбираем одну строку баланса из теста
   YE=E{Ex}; % выбираем одну строку баланса из реала
   plot(X,YT,'LineWidth',2, 'Color','black');
   plot(X,YE,'LineWidth',1, 'Color','blue');
   plot(X,YR,'LineWidth',1, 'Color','red');
   plot(X,YU,'LineWidth',1, 'Color','green');
   if length(X)<30, datetick('x','dd.mmm.yyyy'); 
   else             datetick('x','mmm.yyyy');   end
   title(num2str(ID(Ex)),'FontSize',12);
   legend('Test','E','R','U','Location','NorthWest');
   ylabel('Pips','Color',[CL CL CL]); %,'Orientation','horizontal'
   xlabel('Time','Color',[CL CL CL]);
   path=['D:\WORK\MatLab\FX\print\',num2str(ID(Ex))];
   print ('-dpng','-r100',path);
   hold off;% наложение двух или более графиков
end
%% 
% clear all 
%    CL CT Col Color Compare CompareTime End Experts Ex Hour Hours ID ...
%        R RealCols RealDeals PlotName T X YT YR
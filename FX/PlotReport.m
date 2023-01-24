%% строит графики из файла #.csv 
% и формирует массив Data и структуру Ex из считанных данных
%
echo off
clear % clear workspace and memory
Ex = struct; % структура, содержащая параметры эксперта
Ex.File='#.csv';
%for i=1:127, code=i, ascii=char(i), end    % 32=" "  35=#   36=$  48=0  57=9  59=;  13=RowEnd  10=FileEnd 
fid = fopen(Ex.File,'r'); %open file for reading
Code = fread(fid); % ASCII коды считанного csv файла сохраняем в массив "Code"
fclose(fid);
%%  формируем массив Data(данные, эксперт)
i=0;  % номер считываемого символа csv файла
Expert=1; % столбец файла данных эксперта 
Line=1;% строка в файле данных эксперта 
Str='';  
Data{Line,Expert}=''; % создаем массив ячеек, в который перепишем содержимое csv.файла
for i=1:length(Code)% перебираем все ASCII коды csv.файла
   if Code(i)==10 continue;  end % "10"-символ переноса каретки
   if Code(i)==13 % "13"-Конец строки
      if ~isempty(Data{16,Expert}) % если 16-й столбец (ID) не пустой, значит считанная строка не пустая 
         Expert=Expert+1; end % новый столбец данных для очередного эксперта
      Line=1; % сбрасываем строку  
      Data{Line,Expert}=''; % добавляем новую пустую ячейку
      continue;  
   end
   Str=char(Code(i));% читаем символ ячейки csv файла
   if Str==';', % конец ячейки csv файла
      Line=Line+1;
      Data{Line,Expert}=''; % добавляем новую пустую ячейку
   else
      Data{Line,Expert}=[Data{Line,Expert}, Str]; % дописываем символ к имеющимся данным
   end
end
%% считываем необходимые параметры, "причесываем" 
Ex.Header=Data(1:50,1); % считываем заголовки из первых 50-ти строк первого столбца (преобразуем в строковый вид)
Data(:,1)=[]; % удаляем перый столбец с заголовками
[Rows,Cols] = size(Data);% узнаем размерность массива [строки, столбцы]
Data(:,Cols)=[]; % удаляем последний столбец с пустыми ячейками
Ex.ID=str2num(char(Data(16,:)))'; % преобразуем в числа идентификаторы "ххххххх" в 16-й строке
Ex.Number=Cols-1; % кол-во экспертов
%% разбиваем первую ячейку на название эксперта, периоды теста, спреды...
for Expert=1:Ex.Number
   Str=char(Data(1,Expert)); % преобразуем в массив Str строку вида "Ye$$ 2000.01.03-2013.02.14, Sprd=13, StpLev=0, Swaps=-6.40"
   Block=1;
   Ex.Name{Expert}='';
   TestDate{Expert}='';
   Ex.Spred(Expert)=0;
   Ex.StpLev(Expert)=0;
   Swap{Expert}=''; 
   CanRead=0;
   for i=1:length(Str) % перебираем посимвольно полученный массив
      if (Str(i)==' ') Block=Block+1; end % попался пробел, переходим к следующему блооку данных. '-' разделяет периоды теста
      if Block==1,  % имя (Yess, Skc)
         Ex.Name{Expert}=[Ex.Name{Expert}, Str(i)]; end 
      if Block==2 % Дата начала + Дата конца тестирования
         if (Str(i)=='.' || Str(i)=='-' || Str(i)==',') Str(i)=' '; end % заменяем '.' '-' ',' пробелами
         TestDate{Expert}=[TestDate{Expert}, Str(i)]; end
      if Block==3 && Str(i)>47 && Str(i)<58 % Spred (ищем цифры от 0 до 9)
         Ex.Spred(Expert)=Ex.Spred(Expert)*10+str2num(Str(i)); end % формируем число из цифр; 
      if Block==4 && Str(i)>47 && Str(i)<58 % StpLev
         Ex.StpLev(Expert)=Ex.StpLev(Expert)*10+str2num(Str(i)); end % формируем число из цифр; 
      if Block==5 % Swaps
         if CanRead==1, Swap{Expert}=[Swap{Expert}; Str(i)]; end
         if Str(i)=='=', CanRead=1; end % читаем после знака '='
      end % формируем число из цифр;   
   end
   TestDate{Expert}=str2num(TestDate{Expert}); % переводим строку в число
   Ex.Swaps(Expert)=str2double(Swap{Expert});  % переводим строку в число
    % преобразуем строку даты к дате МатЛаба
   A=TestDate{Expert}; % записываем в отдельный массив
   A1=A(1:3); A1=[A1,0,0,0];  % Берем первые три числа, дописываем нулями для приведения к виду  [2009, 4, 2, 11, 7, 18]
   A2=A(4:6); A2=[A2,0,0,0];  % Берем вторые три числа, дописываем нулями для приведения к виду  [2009, 4, 2, 11, 7, 18]
   Ex.DateFrom{Expert}=datestr(A1); % записываем все в структуру Ex.DateFrom,
   Ex.DateTo{Expert}=datestr(A2); % приводя к виду ['03-Jan-2000']
    
end
%% Разбиваем вторую ячейку на "Инструмент" + "ТФ"
for Expert=1:Ex.Number
   Str=char(Data(2,Expert)); % преобразуем в массив Str строку вида ['EURUSD60';]
   Ex.TF(Expert)=0;
   Ex.Sym{Expert}='';
   for i=1:length(Str) % перебираем посимвольно полученный массив
      if Str(i)>47 && Str(i)<58 % если цифры, значит ТФ
         Ex.TF(Expert)=Ex.TF(Expert)*10+str2num(Str(i)); % формируем число из цифр; 
      else   % если буквы, значит Инструмент
         Ex.Sym{Expert}=[Ex.Sym{Expert},Str(i)]; 
      end % формируем число из цифр;
   end
   Ex.Params(:,Expert)=str2num(char(Data(17:50,Expert))); % копируем входные параметры в отдельный массив double
end
%% преобразуем массив Data из типа "ячеек" в массив типа "double"
% Copy=Data; 
Data(1:50,:)=[]; % удаляем перые 50 строк с параметрами (т.к. они сохранены в других переменных)
[Rows,Cols] = size(Data);% узнаем размерность массива [строки, столбцы]
%A = zeros(Rows,Cols); %  создаем матрицу A(Rows х Cols) с нулевыми значениями
for i=1:Rows
   for j=1:Cols
      B=char(Data(i,j)); 
      if isempty(B) A(i,j)=0;
      else A(i,j)=str2num(B); end
   end
end
Data=A;
% получаем массив вида 
%[ID, массив эквити;
% ID, массив эквити;
% ...................
% ID, массив эквити;]
%% строим графики
% UnitePlots=0; % строим все в отдельных окнах, 1-в одном окне
close all % Remove all figures
% figure % create figure graphics object
%Color=['k','m','r','g','b','c']; % палитра цветов
[Rows,Cols] = size(Data);
X=1:Rows;
hold on;% наложение двух или более графиков 
PlotName='Ex';
Color=colormap(lines); % палитра цветов colormap(lines)
%LegendName=num2str(Ex.ID);
for Expert=1:Ex.Number %перебираем строки
    PlotName=[PlotName,' ',num2str(Ex.ID(Expert))];% формируем имя графика складывая ID(Ex) в одну строку
    Y=Data(:,Expert);
    %legend(LegendName(2));%,
    %legend(axes1,'show');
    plot(X,Y, 'Color',Color(Expert,:)); 
end
title(PlotName,'FontSize',14);
set(gca,...
   'XTickLabel',{'00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15'},...
   'XTick',0:261:max(X),...
   'FontName','Arial Cyr')
    %grid(gca,'minor');
legend(num2str(Ex.ID'),'Location','NorthWest');
grid on
ylabel('$','FontAngle','italic'); %,'Orientation','horizontal' 
xlabel('Year');
%ylim(axes1,[0 6000]);
%% 
hold off;% наложение двух или более графиков 
clear YY i
%plot(X,Yl,'r-', X,Y2,'b:'); 
%'у' -желтый, 'm' -пурпурный, 'с' -голубой, 'r' -красный, 'g' - зеленый, 'b' - синий, 'w' - белый и 'k' - черный. 
%'о' - кружок, 'х' - крест, '+' - плюс, '*' - звездочка. 
% Create figure
% Y=Data(:,Expert);
% figure1 = figure;
% axes1 = axes('Parent',figure1,...
%    'XTickLabel',{'00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15'},...
%    'XTick',0:261:max(X),...
%    'FontName','Arial Cyr');
% ylim(axes1,[0 6000]);
% box(axes1,'on');
% hold(axes1,'all');
% plot(X,Y,'Parent',axes1,'DisplayName','data1');
%% очищаем ненужные переменные
clear  fid i j Line Code Str Expert Rows Cols Swap ans TestDate A A1 A2 B Block CanRead Color PlotName X Y
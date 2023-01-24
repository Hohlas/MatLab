function [ID,Risk,Deals,Time] = csv2mat(FileName)
% формирование массивов ID, Risk, Deals, Pips и Time 
% из файла отчета MatLabTest.csv, MatLabEUR.csv, MatLabRUR.csv, MatLabUSD.csv
% Deal - резы сделок в валюте депо для расчета рисков портфеля
% Pips - резы сделок в пунктах
% для включения периода оптимизации закомментировать блок "CUT OPTIMISATION PERIOD 2008-2018
% 
Path=['D:\WORK\MatLab\FX\'];
MatFileName='TestsResults';  % название файла/рабочей области
%% анализируем ошибки открытия файла
[fid,missage] = fopen([Path,FileName],'r'); % входной csv файл 
if ~isempty(missage)
   disp([missage,': ',FileName]);
   ID=-1; Risk=0; Deals=0; Time=0;
   return;
end
% формат файла:  ID ; TickVal ; Risk ; Deal/Time ; Deal/Time ; Deal/Time ;
Str = fgetl(fid); % считывание строки заголовков (без разделителя строк) с переходом на новую строку
Str = fgetl(fid); % считывание первой строки данных (без разделителя строк) с переходом на новую строку
Row=0;
%% читаем строки файлаМы покупаем, пока удерживаются уровни на покупку. Как только один из них пробивается, значит покупателей на этом уровне нет, и можно продавать. 
while ischar(Str) % перебираем все строки
   Row=Row+1; % переход на новую строку
   StrSum=''; % обнулили буфер символов
   Col=-2; % начнем считать столбцы с -2, чтобы данные (Deal/Time) начались с первого столбца
   for i=1:length(Str) % перебираем символы в строке
      switch Str(i)
         case '/' % т.е. предыдущие символы содержали данные
            Deals(Row,Col)=str2num(StrSum);
            StrSum='';
         case ';'  % разделитель ячеек в csv файлах
            if Col==-2, ID(Row)     =str2num(StrSum); end % первым попадается ID
            if Col==-1, TickVal(Row)=str2num(StrSum); end % второй TickVal
            if Col== 0, Risk(Row)   =str2num(StrSum); end % третий Риск
            if Col>0,   StrTime{Row,Col}=char(StrSum); end % в остальных случаях это время
            StrSum=''; % обнулили буфер символов
            Col=Col+1; % перевели на новый столбец
         otherwise
            StrSum=[StrSum,Str(i)]; % формируем строку из символов, пока не попадется разделитель
      end
   end
   if Col>0, StrTime{Row,Col}=char(StrSum); end % фиксируем последний столбец времени
   Str = fgetl(fid); % считывание полной строки файла без разделителя строк с переходом на новую строку
end
fclose(fid);
%% приводим строковые даты '2000.04.04 22:50' к виду ХХХХХХ.ХХ..., кол-во дней от 01.01.0000, т.е. час=1/24=0.0417  
[Rows,Cols]=size(Deals);
for Row=1:Rows 
   for Col=1:Cols
      if isempty(StrTime{Row,Col}), % если ячейка пустая 
         Time(Row,Col)=0;   % прописываем 0
      else Time(Row,Col)=datenum(StrTime{Row,Col},'yyyy.mm.dd HH:MM');  end % преобразуем строковое время в число 
   end
end
%% CUT OPTIMISATION PERIOD 2008-2018
for T=1:Cols, % перебор по столбцам сделок
    for Ex=1:Rows  % перебор по строкам экспертов
        DealYear=year(datetime(Time(Ex,T),'ConvertFrom','datenum')); % год сделки
        if DealYear>=2008 & DealYear<2018, % вырезаем данные оптимизации 
            Deals(Ex,T)=0; 
        end
    end
end
%% Create MatFile
Start=floor(min(Time(:,1)))-1; % меньшее значение первого столбца округлим до меньшего целого (до дней)
End=ceil(max(max(Time))); % макс значение матрицы округлим до большего целого (до дней)
FullTime=Start:1:End; % Разбиваем диапазон Start-End, на котором производится сравнение на равные части . длиной в час
Days=length(FullTime); % размерность шкалы времени
disp(['файл ',FileName,' открыт. Период ',datestr(Start,'dd.mm.yyyy'),' - ',datestr(End,'dd.mm.yyyy'),', всего ',num2str(Days),' дней / ',num2str(floor(Days/365)),' лет']);
save([Path,MatFileName], 'ID','Risk','Deals','Time','FullTime','Start','End','Rows','Cols','Days'); 
%% «агрузка данных из csv файлов
clear % clear workspace and memory
File='#.csv';
%File='#simple.csv';
[fid,missage] = fopen(File,'r'); % входной csv файл 
if ~isempty(missage)% анализируем ошибки открыти€ файла
   disp([missage,': ',File]);
   return;
end
%% читаем строки файла
Row=0;
ex=(2:3);
Str = fgetl(fid); % считывание строки заголовков (без разделител€ строк) с переходом на новую строку
%Deal=zeros(100,4000); 
while ischar(Str) % перебираем все строки
    Str = fgetl(fid); % считывание полной строки файла без разделител€ строк с переходом на новую строку
    if Str<0 | Str(1)==';', continue; end % конец файла, либо пуста€ строка из одних разделителей
    Col=0; %  столбцы 
    for i=1:length(Str) % перебор строки по символам
        if Str(i)==';',     Col=Col+1;  end % перевели на новый столбец
        if Col==14,         break;      end % в 15-м столбце будет Risk, потом Magiс
    end 
    [Num,Status]=str2num(Str(i:length(Str))); % строка с разделител€ми переводитс€ в массив
    %Dim=size(Num,1);   % размерность считанного массива дл€ проверки на пустую строку
    if Status==true,    % в массиве Str были корректные данные, содержащие только символы цифр и разделителей
        Row=Row+1;      % переход на новую строку
        List(Row,2)=Num(1); % Risk
        List(Row,1)=Num(2); % Magic
        for i=38:length(Num), Deals(i-37,Row)=Num(i);    end % с 38-го столбца начинаютс€ данные
    end
end    
%% 
Corr=corrcoef(Deals);
%%
iCorr(Row)=0; % среднее значение коррел€ции дл€ каждого
for i=1:Row, 
    for j=1:Row,    iCorr(i)=iCorr(i)+Corr(i,j);    end % суммарна€ коррел€ци€ с остальными членами, включа€ свой р€д
end
nCorr=iCorr-1;
sCorr=(iCorr-1)/(Row-1); % средн€€ коррел€ци€ с остальными, за исключением коррел€ции с собой
iCorr=sCorr;
iCorr=sCorr-min(sCorr);
iCorr=iCorr/max(iCorr)+1;
for i=1:Row, 
    List(i,3)=iCorr(i);
    List(i,4)=List(i,2)/iCorr(i); 
end
%%
Handle={'Magic','Risk','Corr','NewRisk'};
% STRR=num2str(List,1);
StrData=vertcat(Handle,num2cell(List));
xlswrite('NewRsk.xlsx',StrData);
xlswrite('NewRsk.xlsx',List);
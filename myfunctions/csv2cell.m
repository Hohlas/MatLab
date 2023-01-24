function [StrData,Lines,Columns] = csv2cell(FileName)
% формирование строковой структуры StrData из файла FileName.csv
% возвращает так же число  строк и столбцов
fid = fopen(FileName,'r'); % входной csv файл вида  02.02.2011 ; 23:00 ; -0.2 
Str = fgetl(fid); % считывание полной строки файла без разделителя строк с переходом на новую строку
Line=1; 
while ischar(Str) % пока не кончатся символы перебираем все строки
   Column=1;
   StrData{Line,Column}='';
   %if ~isempty(
   for i=1:length(Str) 
      if (Str(i)==';' || Str(i)==' ') % попался один их возможных разделителей
          Column=Column+1; % добавляем новый столбец
          StrData{Line,Column}='';
      else % символы данных группируем в массив
        StrData{Line,Column}=[StrData{Line,Column},Str(i)]; % вписываем
      end
   end
   Line=Line+1;
   Str = fgetl(fid); % считывание полной строки файла без разделителя строк с переходом на новую строку
end
Columns=Column;
Lines=Line-1;
fclose(fid);

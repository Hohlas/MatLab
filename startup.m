%% пути
WorkFolder='D:\WORK\MatLab'; % путь к рабочим файлам 
RestoreFolder='D:\WORK\MatLab\BackUp'; % путь к папке резервирования
addpath (WorkFolder); % показываем матлабу папку для поиска
cd (WorkFolder); % показываем матлабу папку с рабочими файлами 
% pwd %  показывает текущую раб. папку 
% winopen(prefdir)  - открывает папку с файлами конфигурацией
CurDate = datestr(now, 'yyyy-mm-dd');
WorkFiles=[WorkFolder,'\*'];  % формируем путь D:/WORK/MatLab/*  для копирования всех файлов
SettingsFiles=[prefdir,'\*'];  % формируем путь C:\Users\Сергей\AppData\Roaming\MathWorks\MATLAB\R2010b\*
WorkRestore=[RestoreFolder,'\',CurDate]; % формируем путь к созданной папке E:/Сохраненка/WORK/MatLab/2013-07-17
SettingsRestore=[WorkRestore,'\Settings']; % формируем путь к созданной папке E:/Сохраненка/WORK/MatLab/Settings
%% Сохранение настроек, разработок...
[status, message, messageId] = copyfile(WorkFiles, WorkRestore);
if status==1, disp (['все файлы из папки ',WorkFiles,' переписались в папку ',WorkRestore]);
else  disp (['ничего не вышло: ',message]); end
[status, message, messageId] = copyfile(SettingsFiles, SettingsRestore);% restore all settins
if status==1,  disp (['файлы настроек переписались в папку ',SettingsRestore]);
else  disp (['ничего не вышло: ',message]); end

%% Запись журнала
% reply = input('Записывать файл протокола? y/n [y]: ', 's');
% if isempty (reply),  reply = 'y'; end
% if reply=='y' 
%    disp ('запись журнала будет вестись в файл task.txt' )% чтобы отобразить сообщение перед паузой. 
%    warning off
%    delete task.txt 
%    diary task.txt % сохраняет в файл "taskl.txt" из сессии весь текстовый вывод 
%    % echo on % при использовании команды echo on и ввод тоже
% else disp ('журнал записываться не будет'), end
%% в конце m-файла необходимо отключить функции
clear
warning on
echo off 
%diary off 

% не пригодились
%mkdir(RestoreFolder,CurDate) % создаем папку E:/Сохраненка/WORK/MatLab/2013-07-17
%mkdir(RestoreFolder,'Settings') % создаем папку E:/Сохраненка/WORK/MatLab/Settings
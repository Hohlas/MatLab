sscanf % для извлечения чисел из строки 
%% Действия со строками 
char ('a') % преобразует в строку символьное выражение
str1='aaa', str2='bbb' 
sumstr = [str1, str2] % sumstr = aaabbb
%% перенос длинной строки
str = ['left hand side of equation =', ... 
' right hand side of equation '] 
%% восстановление точности с помощью символьного выражения
c= sqrt(3) % c = 1.7321 
sym(c) %  ans = 3^(1/2) = sqrt(3)
sym('l+sqrt(3)') % запретить вычисление числового аргумента для sym путем заключения его в одинарные кавычки
%% различные типы isnumeric, ischar 
C{1,1} = pi;                 % double
C{1,2} = 'John Doe';         % char array
C{1,3} = 2 + 4i;             % complex double
C{1,4} = ispc;               % logical
C{1,5} = magic(3)            % double array
% C =  [3.1416]    'John Doe'    [2.0000 + 4.0000i]    [1]    [3x3 double]
for i=1:5, x(i)=isnumeric(C{1,i}); end
% x =  1     0     1     0     1
%% сравнение строк
if strcmp(Name, 'NewYork'), Params=0; end % сравнивается Name и 'NewYork'
if ~isequal(answer, 'yes'), return, end % isequal для сравнения ответа со строкой 'yes', т.к. знак == можно использовать только при сравнении массивов одинаковой длины. 
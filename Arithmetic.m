%% ???????? ??????? 
A = [1, 1, 1, 1;  2, 2, 2, 2;  3, 3, 3, 3]  % [?????? ; ?????? ; ?????? ]
A = zeros(4, 6)% ??????? ?? 00
A = ones(2, 5)*6;% ??????? ?? 6
B = [4, 4, 4, 4;  5, 5, 5, 5;  6, 6, 6, 6]
B(2,3)=2 % (??????,???????)
A(1:5)=1 % ?????? ? [1 1 1 1 1]
B =
     4     4     4     4
     5     5     2     5
     6     6     6     6
% ?????? lxN - ???????? ??????
% ?????? Mxl - ?????????? ??????
% MxN - ??????? 
[A,B] % ?????????????? ???????????? (???????????) ?????? A ? B.  ? ? B ?????? ????? ?????????? ?????????? ?????
[A;B] % ???????????? ???????????? (???????????) ?????? ? ? B. ? ? ? ?????? ????? ?????????? ????? ????????. 
%% ??????
C = cell(1,5); % Allocate memory for the array
C{1,1} = pi;                 % double
C{1,2} = 'John Doe';         % char array
C{1,3} = 2 + 4i;             % complex double
C{1,4} = ispc;               % logical
C{1,5} = magic(3)            % double array
%% ?????????
sa = struct('data',[1 4 9 16 25], 'description', 'perfect squares') % 1-? ?????? ????????
sa = struct;  % 2-? ?????? ????????
sa.data = [1 4 9 16 25]; 
sa.description = 'perfect squares' ;


%% ???????? ? ????????? (???. 155 -  ?????????? ?????????)
x1 = [2 3 4]; 
x2 = [4, 5, 6]; 
x3 = 0:2:10;

u=x1+x2
x1.^2 % ???????? ? ??????? ???????? ??????? x1
Trans=x2' % ????????????????
u=x1*Trans;
u=x1.*x2 %???????????? ?????????
u=x1./x2 % ????????????? ??????? ????????
u=min(x1) %??????????? ???????? 
u=mean(x1)%???????  
u=sum(x1)
u=length(x1)%???-?? ??.-??? 
u=sort(x1)%?????????? ?? ????????
x1(:,2)=[] %??????? ?????? ???????
x4=[4, 4, 4, 4;  5, 5, 5, 5;  6, 6, 6, 6]
x4(1,:)=[] %??????? ?????? ??????

%% ??????? ?????. ??????? ??????? ??????????? ?????? ?? ????? ?????? ?????. ?????????? ??? ????? ?????????? ? ??????? ??????? ????????
format short 1.3333           % 0.0000
format short e 1.3333E+000    % 1.2345E-006
format long 1.333333333333338 %0.000001234500000
format long e 1.333333333333338E+000 % 1.234500000000000E-006
format bank 1.33              % 0.00 

%% ???? ??????
double % ???????? ?????? ????? 
Sym % ???????? ??????? sym ??? syms 
char % ???? ??????, ??????????? ? '????????' 
function_handle % ???? ??????? @
inline % ???? ??????? inline




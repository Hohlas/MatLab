function [Time,Data]=cell2data(StrData)
% ?? ????????? ????????? StrData
% ????????? ??? ??????? [Time, Data] ???? [7.345379652777778e+05] ? [5.47]
Lines=size(StrData);
a(1:Lines)=';'; a=a'; % ????????? ??????? ???????????? ";"
b=[char(StrData(:,1)),a,char(StrData(:,2))]; % ?????????? 1-? ? 2-? ??????? ?????, ???????? ????? ???? ??????????? ";"
Time=datenum(b,'dd.mm.yyyy;HH:MM'); % ??????? ?????? ???? "18.02.2011;23:30" ? ?????? [7.345379652777778e+05]
Data=str2num(char(StrData(:,3))); % ??????? ?????? ? ????? (?????????? ??????)
%% �������� ������ �� csv ������
clear % clear workspace and memory
File='#.csv';
%File='#simple.csv';
[fid,missage] = fopen(File,'r'); % ������� csv ���� 
if ~isempty(missage)% ����������� ������ �������� �����
   disp([missage,': ',File]);
   return;
end
%% ������ ������ �����
Row=0;
ex=(2:3);
Str = fgetl(fid); % ���������� ������ ���������� (��� ����������� �����) � ��������� �� ����� ������
%Deal=zeros(100,4000); 
while ischar(Str) % ���������� ��� ������
    Str = fgetl(fid); % ���������� ������ ������ ����� ��� ����������� ����� � ��������� �� ����� ������
    if Str<0 | Str(1)==';', continue; end % ����� �����, ���� ������ ������ �� ����� ������������
    Col=0; %  ������� 
    for i=1:length(Str) % ������� ������ �� ��������
        if Str(i)==';',     Col=Col+1;  end % �������� �� ����� �������
        if Col==14,         break;      end % � 15-� ������� ����� Risk, ����� Magi�
    end 
    [Num,Status]=str2num(Str(i:length(Str))); % ������ � ������������� ����������� � ������
    %Dim=size(Num,1);   % ����������� ���������� ������� ��� �������� �� ������ ������
    if Status==true,    % � ������� Str ���� ���������� ������, ���������� ������ ������� ���� � ������������
        Row=Row+1;      % ������� �� ����� ������
        List(Row,2)=Num(1); % Risk
        List(Row,1)=Num(2); % Magic
        for i=38:length(Num), Deals(i-37,Row)=Num(i);    end % � 38-�� ������� ���������� ������
    end
end    
%% 
Corr=corrcoef(Deals);
%%
iCorr(Row)=0; % ������� �������� ���������� ��� �������
for i=1:Row, 
    for j=1:Row,    iCorr(i)=iCorr(i)+Corr(i,j);    end % ��������� ���������� � ���������� �������, ������� ���� ���
end
nCorr=iCorr-1;
sCorr=(iCorr-1)/(Row-1); % ������� ���������� � ����������, �� ����������� ���������� � �����
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
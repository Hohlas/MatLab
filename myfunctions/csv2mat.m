function [ID,Risk,Deals,Time] = csv2mat(FileName)
% ������������ �������� ID, Risk, Deals, Pips � Time 
% �� ����� ������ MatLabTest.csv, MatLabEUR.csv, MatLabRUR.csv, MatLabUSD.csv
% Deal - ���� ������ � ������ ���� ��� ������� ������ ��������
% Pips - ���� ������ � �������
% ��� ��������� ������� ����������� ���������������� ���� "CUT OPTIMISATION PERIOD 2008-2018
% 
Path=['D:\WORK\MatLab\FX\'];
MatFileName='TestsResults';  % �������� �����/������� �������
%% ����������� ������ �������� �����
[fid,missage] = fopen([Path,FileName],'r'); % ������� csv ���� 
if ~isempty(missage)
   disp([missage,': ',FileName]);
   ID=-1; Risk=0; Deals=0; Time=0;
   return;
end
% ������ �����:  ID ; TickVal ; Risk ; Deal/Time ; Deal/Time ; Deal/Time ;
Str = fgetl(fid); % ���������� ������ ���������� (��� ����������� �����) � ��������� �� ����� ������
Str = fgetl(fid); % ���������� ������ ������ ������ (��� ����������� �����) � ��������� �� ����� ������
Row=0;
%% ������ ������ ������� ��������, ���� ������������ ������ �� �������. ��� ������ ���� �� ��� �����������, ������ ����������� �� ���� ������ ���, � ����� ���������. 
while ischar(Str) % ���������� ��� ������
   Row=Row+1; % ������� �� ����� ������
   StrSum=''; % �������� ����� ��������
   Col=-2; % ������ ������� ������� � -2, ����� ������ (Deal/Time) �������� � ������� �������
   for i=1:length(Str) % ���������� ������� � ������
      switch Str(i)
         case '/' % �.�. ���������� ������� ��������� ������
            Deals(Row,Col)=str2num(StrSum);
            StrSum='';
         case ';'  % ����������� ����� � csv ������
            if Col==-2, ID(Row)     =str2num(StrSum); end % ������ ���������� ID
            if Col==-1, TickVal(Row)=str2num(StrSum); end % ������ TickVal
            if Col== 0, Risk(Row)   =str2num(StrSum); end % ������ ����
            if Col>0,   StrTime{Row,Col}=char(StrSum); end % � ��������� ������� ��� �����
            StrSum=''; % �������� ����� ��������
            Col=Col+1; % �������� �� ����� �������
         otherwise
            StrSum=[StrSum,Str(i)]; % ��������� ������ �� ��������, ���� �� ��������� �����������
      end
   end
   if Col>0, StrTime{Row,Col}=char(StrSum); end % ��������� ��������� ������� �������
   Str = fgetl(fid); % ���������� ������ ������ ����� ��� ����������� ����� � ��������� �� ����� ������
end
fclose(fid);
%% �������� ��������� ���� '2000.04.04 22:50' � ���� ������.��..., ���-�� ���� �� 01.01.0000, �.�. ���=1/24=0.0417  
[Rows,Cols]=size(Deals);
for Row=1:Rows 
   for Col=1:Cols
      if isempty(StrTime{Row,Col}), % ���� ������ ������ 
         Time(Row,Col)=0;   % ����������� 0
      else Time(Row,Col)=datenum(StrTime{Row,Col},'yyyy.mm.dd HH:MM');  end % ����������� ��������� ����� � ����� 
   end
end
%% CUT OPTIMISATION PERIOD 2008-2018
for T=1:Cols, % ������� �� �������� ������
    for Ex=1:Rows  % ������� �� ������� ���������
        DealYear=year(datetime(Time(Ex,T),'ConvertFrom','datenum')); % ��� ������
        if DealYear>=2008 & DealYear<2018, % �������� ������ ����������� 
            Deals(Ex,T)=0; 
        end
    end
end
%% Create MatFile
Start=floor(min(Time(:,1)))-1; % ������� �������� ������� ������� �������� �� �������� ������ (�� ����)
End=ceil(max(max(Time))); % ���� �������� ������� �������� �� �������� ������ (�� ����)
FullTime=Start:1:End; % ��������� �������� Start-End, �� ������� ������������ ��������� �� ������ ����� . ������ � ���
Days=length(FullTime); % ����������� ����� �������
disp(['���� ',FileName,' ������. ������ ',datestr(Start,'dd.mm.yyyy'),' - ',datestr(End,'dd.mm.yyyy'),', ����� ',num2str(Days),' ���� / ',num2str(floor(Days/365)),' ���']);
save([Path,MatFileName], 'ID','Risk','Deals','Time','FullTime','Start','End','Rows','Cols','Days'); 
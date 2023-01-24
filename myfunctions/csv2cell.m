function [StrData,Lines,Columns] = csv2cell(FileName)
% ������������ ��������� ��������� StrData �� ����� FileName.csv
% ���������� ��� �� �����  ����� � ��������
fid = fopen(FileName,'r'); % ������� csv ���� ����  02.02.2011 ; 23:00 ; -0.2 
Str = fgetl(fid); % ���������� ������ ������ ����� ��� ����������� ����� � ��������� �� ����� ������
Line=1; 
while ischar(Str) % ���� �� �������� ������� ���������� ��� ������
   Column=1;
   StrData{Line,Column}='';
   %if ~isempty(
   for i=1:length(Str) 
      if (Str(i)==';' || Str(i)==' ') % ������� ���� �� ��������� ������������
          Column=Column+1; % ��������� ����� �������
          StrData{Line,Column}='';
      else % ������� ������ ���������� � ������
        StrData{Line,Column}=[StrData{Line,Column},Str(i)]; % ���������
      end
   end
   Line=Line+1;
   Str = fgetl(fid); % ���������� ������ ������ ����� ��� ����������� ����� � ��������� �� ����� ������
end
Columns=Column;
Lines=Line-1;
fclose(fid);

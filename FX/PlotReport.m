%% ������ ������� �� ����� #.csv 
% � ��������� ������ Data � ��������� Ex �� ��������� ������
%
echo off
clear % clear workspace and memory
Ex = struct; % ���������, ���������� ��������� ��������
Ex.File='#.csv';
%for i=1:127, code=i, ascii=char(i), end    % 32=" "  35=#   36=$  48=0  57=9  59=;  13=RowEnd  10=FileEnd 
fid = fopen(Ex.File,'r'); %open file for reading
Code = fread(fid); % ASCII ���� ���������� csv ����� ��������� � ������ "Code"
fclose(fid);
%%  ��������� ������ Data(������, �������)
i=0;  % ����� ������������ ������� csv �����
Expert=1; % ������� ����� ������ �������� 
Line=1;% ������ � ����� ������ �������� 
Str='';  
Data{Line,Expert}=''; % ������� ������ �����, � ������� ��������� ���������� csv.�����
for i=1:length(Code)% ���������� ��� ASCII ���� csv.�����
   if Code(i)==10 continue;  end % "10"-������ �������� �������
   if Code(i)==13 % "13"-����� ������
      if ~isempty(Data{16,Expert}) % ���� 16-� ������� (ID) �� ������, ������ ��������� ������ �� ������ 
         Expert=Expert+1; end % ����� ������� ������ ��� ���������� ��������
      Line=1; % ���������� ������  
      Data{Line,Expert}=''; % ��������� ����� ������ ������
      continue;  
   end
   Str=char(Code(i));% ������ ������ ������ csv �����
   if Str==';', % ����� ������ csv �����
      Line=Line+1;
      Data{Line,Expert}=''; % ��������� ����� ������ ������
   else
      Data{Line,Expert}=[Data{Line,Expert}, Str]; % ���������� ������ � ��������� ������
   end
end
%% ��������� ����������� ���������, "�����������" 
Ex.Header=Data(1:50,1); % ��������� ��������� �� ������ 50-�� ����� ������� ������� (����������� � ��������� ���)
Data(:,1)=[]; % ������� ����� ������� � �����������
[Rows,Cols] = size(Data);% ������ ����������� ������� [������, �������]
Data(:,Cols)=[]; % ������� ��������� ������� � ������� ��������
Ex.ID=str2num(char(Data(16,:)))'; % ����������� � ����� �������������� "�������" � 16-� ������
Ex.Number=Cols-1; % ���-�� ���������
%% ��������� ������ ������ �� �������� ��������, ������� �����, ������...
for Expert=1:Ex.Number
   Str=char(Data(1,Expert)); % ����������� � ������ Str ������ ���� "Ye$$ 2000.01.03-2013.02.14, Sprd=13, StpLev=0, Swaps=-6.40"
   Block=1;
   Ex.Name{Expert}='';
   TestDate{Expert}='';
   Ex.Spred(Expert)=0;
   Ex.StpLev(Expert)=0;
   Swap{Expert}=''; 
   CanRead=0;
   for i=1:length(Str) % ���������� ����������� ���������� ������
      if (Str(i)==' ') Block=Block+1; end % ������� ������, ��������� � ���������� ������ ������. '-' ��������� ������� �����
      if Block==1,  % ��� (Yess, Skc)
         Ex.Name{Expert}=[Ex.Name{Expert}, Str(i)]; end 
      if Block==2 % ���� ������ + ���� ����� ������������
         if (Str(i)=='.' || Str(i)=='-' || Str(i)==',') Str(i)=' '; end % �������� '.' '-' ',' ���������
         TestDate{Expert}=[TestDate{Expert}, Str(i)]; end
      if Block==3 && Str(i)>47 && Str(i)<58 % Spred (���� ����� �� 0 �� 9)
         Ex.Spred(Expert)=Ex.Spred(Expert)*10+str2num(Str(i)); end % ��������� ����� �� ����; 
      if Block==4 && Str(i)>47 && Str(i)<58 % StpLev
         Ex.StpLev(Expert)=Ex.StpLev(Expert)*10+str2num(Str(i)); end % ��������� ����� �� ����; 
      if Block==5 % Swaps
         if CanRead==1, Swap{Expert}=[Swap{Expert}; Str(i)]; end
         if Str(i)=='=', CanRead=1; end % ������ ����� ����� '='
      end % ��������� ����� �� ����;   
   end
   TestDate{Expert}=str2num(TestDate{Expert}); % ��������� ������ � �����
   Ex.Swaps(Expert)=str2double(Swap{Expert});  % ��������� ������ � �����
    % ����������� ������ ���� � ���� �������
   A=TestDate{Expert}; % ���������� � ��������� ������
   A1=A(1:3); A1=[A1,0,0,0];  % ����� ������ ��� �����, ���������� ������ ��� ���������� � ����  [2009, 4, 2, 11, 7, 18]
   A2=A(4:6); A2=[A2,0,0,0];  % ����� ������ ��� �����, ���������� ������ ��� ���������� � ����  [2009, 4, 2, 11, 7, 18]
   Ex.DateFrom{Expert}=datestr(A1); % ���������� ��� � ��������� Ex.DateFrom,
   Ex.DateTo{Expert}=datestr(A2); % ������� � ���� ['03-Jan-2000']
    
end
%% ��������� ������ ������ �� "����������" + "��"
for Expert=1:Ex.Number
   Str=char(Data(2,Expert)); % ����������� � ������ Str ������ ���� ['EURUSD60';]
   Ex.TF(Expert)=0;
   Ex.Sym{Expert}='';
   for i=1:length(Str) % ���������� ����������� ���������� ������
      if Str(i)>47 && Str(i)<58 % ���� �����, ������ ��
         Ex.TF(Expert)=Ex.TF(Expert)*10+str2num(Str(i)); % ��������� ����� �� ����; 
      else   % ���� �����, ������ ����������
         Ex.Sym{Expert}=[Ex.Sym{Expert},Str(i)]; 
      end % ��������� ����� �� ����;
   end
   Ex.Params(:,Expert)=str2num(char(Data(17:50,Expert))); % �������� ������� ��������� � ��������� ������ double
end
%% ����������� ������ Data �� ���� "�����" � ������ ���� "double"
% Copy=Data; 
Data(1:50,:)=[]; % ������� ����� 50 ����� � ����������� (�.�. ��� ��������� � ������ ����������)
[Rows,Cols] = size(Data);% ������ ����������� ������� [������, �������]
%A = zeros(Rows,Cols); %  ������� ������� A(Rows � Cols) � �������� ����������
for i=1:Rows
   for j=1:Cols
      B=char(Data(i,j)); 
      if isempty(B) A(i,j)=0;
      else A(i,j)=str2num(B); end
   end
end
Data=A;
% �������� ������ ���� 
%[ID, ������ ������;
% ID, ������ ������;
% ...................
% ID, ������ ������;]
%% ������ �������
% UnitePlots=0; % ������ ��� � ��������� �����, 1-� ����� ����
close all % Remove all figures
% figure % create figure graphics object
%Color=['k','m','r','g','b','c']; % ������� ������
[Rows,Cols] = size(Data);
X=1:Rows;
hold on;% ��������� ���� ��� ����� �������� 
PlotName='Ex';
Color=colormap(lines); % ������� ������ colormap(lines)
%LegendName=num2str(Ex.ID);
for Expert=1:Ex.Number %���������� ������
    PlotName=[PlotName,' ',num2str(Ex.ID(Expert))];% ��������� ��� ������� ��������� ID(Ex) � ���� ������
    Y=Data(:,Expert);
    %legend(LegendName(2));%,
    %legend(axes1,'show');
    plot(X,Y, 'Color',Color(Expert,:)); 
end
title(PlotName,'FontSize',14);
set(gca,...
   'XTickLabel',{'00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15'},...
   'XTick',0:261:max(X),...
   'FontName','Arial Cyr')
    %grid(gca,'minor');
legend(num2str(Ex.ID'),'Location','NorthWest');
grid on
ylabel('$','FontAngle','italic'); %,'Orientation','horizontal' 
xlabel('Year');
%ylim(axes1,[0 6000]);
%% 
hold off;% ��������� ���� ��� ����� �������� 
clear YY i
%plot(X,Yl,'r-', X,Y2,'b:'); 
%'�' -������, 'm' -���������, '�' -�������, 'r' -�������, 'g' - �������, 'b' - �����, 'w' - ����� � 'k' - ������. 
%'�' - ������, '�' - �����, '+' - ����, '*' - ���������. 
% Create figure
% Y=Data(:,Expert);
% figure1 = figure;
% axes1 = axes('Parent',figure1,...
%    'XTickLabel',{'00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15'},...
%    'XTick',0:261:max(X),...
%    'FontName','Arial Cyr');
% ylim(axes1,[0 6000]);
% box(axes1,'on');
% hold(axes1,'all');
% plot(X,Y,'Parent',axes1,'DisplayName','data1');
%% ������� �������� ����������
clear  fid i j Line Code Str Expert Rows Cols Swap ans TestDate A A1 A2 B Block CanRead Color PlotName X Y
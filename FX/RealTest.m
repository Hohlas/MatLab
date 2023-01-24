%%
% �������������� ������ ������ MatLabTest.csv, MatLabUSD.csv,... ����������
% ������ ������ � ������� ��������. 
% ���������� ����������� � ���������� TestsResults.m :
% Cols, Rows - ���-�� ��������, ����� �������� ��������
% Days, - ���-�� ���� ���� �������, 
% Risk - ������ ������ �� ����� #.csv
% Deals, Time - ������ ������ � �� �������. 
% Start, End - ������, ����� ������� ������� ������������.  
% FullTime - ������ ������� � ���������� � ���� ��� ������� ������� ������������. 
%% �������� ������ �� csv ������
clear % clear workspace and memory
tFile='MatLabTest.csv';
eFile='MatLabEUR.csv';
rFile='MatLabRUR.csv';
uFile='MatLabUSD.csv'; 
%% ���������� ������� � �����  �������� ������� ����: 1373393 ; -5770 ; 2000.04.04 22:50 , ��� -5770-���. ������, ���������� �� 100 
[ID, Risk,TPips,TTime]=csv2mat(tFile); % ���������� ������� � �����(�)
[eID,Risk,ePips,eTime]=csv2mat(eFile); % ���������� ������� � �����(E)
[rID,Risk,rPips,rTime]=csv2mat(rFile); % ���������� ������� � �����(R) 
[uID,Risk,uPips,uTime]=csv2mat(uFile); % ���������� ������� � �����(U) 
Experts = size(TPips,1); % ���-�� ���������, (� ������ ��������� �������)
%% ������� ����� ������� UPips, EPips, RPips 
ECols = size(ePips,2); % ������������ ����� ������� ...
RCols = size(rPips,2); % � ���������� �������� 
UCols = size(uPips,2); %
TCols = size(TPips,2); 
UPips(1:Experts,UCols)=0; UTime(1:Experts,UCols)=0; % ������� ������� ...
EPips(1:Experts,ECols)=0; ETime(1:Experts,ECols)=0; % � �������� ���������� ...
RPips(1:Experts,RCols)=0; RTime(1:Experts,RCols)=0; % � ������� ����� ������������ ���������� �������
%% ����� ����� (������) ID � �������� ������, �.� ����� ������ ��� ������, ������� ������� � ����� �����
for Ex=1:Experts % ���������� ������� �����
   for i=1:size(uPips,1) % ���������� ������� U
      if uID(i)==ID(Ex), UPips(Ex,:)=uPips(i,:); UTime(Ex,:)=uTime(i,:);  end
   end
   for i=1:size(ePips,1) % ���������� ������� E
      if eID(i)==ID(Ex), EPips(Ex,:)=ePips(i,:); ETime(Ex,:)=eTime(i,:);  end
   end
   for i=1:size(rPips,1) % ���������� ������� R
      if rID(i)==ID(Ex), RPips(Ex,:)=rPips(i,:); RTime(Ex,:)=rTime(i,:);  end
   end
end
%% �� ������ ���� ����������� ���� ������, �� ����� ������������ ���� �����
for Ex=1:Experts 
   End(Ex)=max(TTime(Ex,:));
   if max(UTime(Ex,:))>End(Ex), End(Ex)=max(UTime(Ex,:)); end
   if max(ETime(Ex,:))>End(Ex), End(Ex)=max(ETime(Ex,:)); end
   if max(RTime(Ex,:))>End(Ex), End(Ex)=max(RTime(Ex,:)); end
   Start(Ex)=End(Ex);
   if UTime(Ex,1)>0 && UTime(Ex,1)<Start(Ex), Start(Ex)=UTime(Ex,1); end
   if ETime(Ex,1)>0 && ETime(Ex,1)<Start(Ex), Start(Ex)=ETime(Ex,1); end
   if RTime(Ex,1)>0 && RTime(Ex,1)<Start(Ex), Start(Ex)=RTime(Ex,1); end
end
%% ��������� ����� ����� ������� � ����� � ���
Start=floor(Start); % �������� �� �������� ������ (�� ����)
End=ceil(End); % �������� �� �������� ������ (�� ����)
for Ex=1:Experts 
    if End(Ex)-Start(Ex)>500, Start(Ex)=End(Ex)-500; end % ������������ ����� ������� �� 500 ����
end    
disp(['������ �������� ',datestr(min(Start),'dd.mm.yyyy'),' - ',datestr(max(End),'dd.mm.yyyy')]);
Hour=(1/24); % ��� ��������� ����� ������� 0.0417 (1����/24)
for Ex=1:Experts % �������� ����������� Start(Ex)..End(Ex) ����� � �����
   CompareTime{Ex}=Start(Ex):Hour:End(Ex); % ��������� �������� Start-End, �� ������� ������������ ��������� �� ������ ����� . ������ � ���
   Hours(Ex)=length(CompareTime{Ex}); % ����������� ����� �������
end
%% ��������� ������� ��������, ���������� �� �� ����� �����,
for Ex=1:Experts 
   t=1; r=1; e=1; u=1; 
   T{Ex}(1)=0; E{Ex}(1)=0; R{Ex}(1)=0; U{Ex}(1)=0;
   aaa=length(TTime);
   while CompareTime{Ex}(1)>TTime(Ex,t), 
       t=t+1;      if t>=length(TTime), break; end
   end % ��������� ������� ������� ����� � ������� ������ ���������...
  
   for CT=2:Hours(Ex), % ���������� ���� ������ ��������� �� ����
      T{Ex}(CT)=T{Ex}(CT-1); % ���������� ������ ������� ��� �����...
      E{Ex}(CT)=E{Ex}(CT-1); % � ��� ������
      R{Ex}(CT)=R{Ex}(CT-1); % 
      U{Ex}(CT)=U{Ex}(CT-1); % 
      if (CompareTime{Ex}(CT)>=TTime(Ex,t)), % ���� ����� ������� �������� ������� ������ ...
         aCT=CompareTime{Ex}(CT); aTT=TTime(Ex,t); aH=Hour; aDelta=CompareTime{Ex}(CT)-TTime(Ex,t);  
         if  CompareTime{Ex}(CT)-TTime(Ex,t)<=Hour, % �� ������� �� ��������� ���� ...
            T{Ex}(CT)=T{Ex}(CT)+TPips(Ex,t); % �������� �������� ������� �� �������� ������
         end
         if t<TCols, t=t+1; end % ��������� �� ����� ������ � ���������, ����� �� ����������� ������ ������� 
      end
      if (CompareTime{Ex}(CT)>=ETime(Ex,e)), % ���� ����� ������� �������� ������� ������ ...
         if  CompareTime{Ex}(CT)-ETime(Ex,e)<=Hour, % �� ������� �� ��������� ���� ...
            E{Ex}(CT)=E{Ex}(CT)+EPips(Ex,e); % �������� �������� ������� �� �������� ������
         end
         if e<ECols, e=e+1; end % ��������� �� ����� ������ � ���������, ����� �� ����������� ������ ������� 
      end
      if (CompareTime{Ex}(CT)>=RTime(Ex,r)), % ���� ����� ������� �������� ������� ������ ...
         if  CompareTime{Ex}(CT)-RTime(Ex,r)<=Hour, % �� ������� �� ��������� ���� ...
            R{Ex}(CT)=R{Ex}(CT)+RPips(Ex,r); % �������� �������� ������� �� �������� ������
         end
         if r<RCols, r=r+1; end % ��������� �� ����� ������ � ���������, ����� �� ����������� ������ ������� 
      end
      if (CompareTime{Ex}(CT)>=UTime(Ex,u)), % ���� ����� ������� �������� ������� ������ ...
         if  CompareTime{Ex}(CT)-UTime(Ex,u)<=Hour, % �� ������� �� ��������� ���� ...
            U{Ex}(CT)=U{Ex}(CT)+UPips(Ex,u); % �������� �������� ������� �� �������� ������
         end
         if u<UCols, u=u+1; end % ��������� �� ����� ������ � ���������, ����� �� ����������� ������ ������� 
      end
   end
end  
%% ������ �������
% UnitePlots=0; % ������ ��� � ��������� �����, 1-� ����� ����
% figure % create figure graphics object
% hold on;% ��������� ���� ��� ����� �������� 
close all % Remove all figures
CL=0.3; 
for Ex=1:Experts % ���������� ������
   figure1 = figure('Color',[0.76 0.87 0.78]); % ���� ������� �������
   axes1 = axes('Parent',figure1,...% Create axes
      'ZColor',[CL CL CL],'YColor',[CL CL CL],'XColor',[CL CL CL],...
      'XMinorTick','on','YMinorTick','on',... % ������������� ������ �� ����
      'FontName','Arial Cyr',...
      'Color',[0.8 0.8 0.8]); % ���� ������� �������
   grid(axes1,'on');
   hold(axes1,'all');
   X=CompareTime{Ex};
   YT=T{Ex}; % �������� ���� ������ ������� �� �����
   YR=R{Ex}; % �������� ���� ������ ������� �� �����
   YU=U{Ex}; % �������� ���� ������ ������� �� �����
   YE=E{Ex}; % �������� ���� ������ ������� �� �����
   plot(X,YT,'LineWidth',2, 'Color','black');
   plot(X,YE,'LineWidth',1, 'Color','blue');
   plot(X,YR,'LineWidth',1, 'Color','red');
   plot(X,YU,'LineWidth',1, 'Color','green');
   if length(X)<30, datetick('x','dd.mmm.yyyy'); 
   else             datetick('x','mmm.yyyy');   end
   title(num2str(ID(Ex)),'FontSize',12);
   legend('Test','E','R','U','Location','NorthWest');
   ylabel('Pips','Color',[CL CL CL]); %,'Orientation','horizontal'
   xlabel('Time','Color',[CL CL CL]);
   path=['D:\WORK\MatLab\FX\print\',num2str(ID(Ex))];
   print ('-dpng','-r100',path);
   hold off;% ��������� ���� ��� ����� ��������
end
%% 
% clear all 
%    CL CT Col Color Compare CompareTime End Experts Ex Hour Hours ID ...
%        R RealCols RealDeals PlotName T X YT YR
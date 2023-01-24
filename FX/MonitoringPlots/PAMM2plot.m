clear % clear workspace and memory
%% ��������� ������ PAMM2
[StrData, Days, Columns] =  csv2cell('04_monitoring_PAMM2.csv'); % ������������ �� ����� *.csv ��������� ��������� ������ StrData[Lines, Columns] 
Time=datenum(char(StrData(:,1)),'dd.mm.yyyy'); % ������� ������ ���� "18.02.2011;23:30" � ������ [7.345379652777778e+05]
PerCent=str2num(char(StrData(:,2))); % ������� ������ � ����� (���������� ������)
Pay=PerCent+100; % ��������� ���� ��� �� ������� ���������
StartDate=Time(1);
EndDate=Time(Days);
X = linspace(StartDate,EndDate,Days); % ��������� �������� StartDate..EndDate �� Days ������ ������
Y=Pay
%% ������ �������� �����������
[CurProfit,MaxProfit,CurDD,MaxDD,DateDD,maxIncrease,DateIncrease]=PayProperties(Pay);
disp (['curProfit=',num2str(round(CurProfit)),'%, curDD=',num2str(round(CurDD)),'%']);
disp (['maxProfit=',num2str(round(MaxProfit)),'%, maxDD=',num2str(round(MaxDD)),'% (',datestr(DateDD,'dd.mm.yyyy'),')']);
disp (['maxIncrease=',num2str(round(maxIncrease)),'% (',datestr(DateIncrease,'dd.mm.yyyy'),')']);
disp (['RF=',num2str(round(MaxProfit/MaxDD)),', Period: ',datestr(StartDate,'dd.mm.yyyy'),'-',datestr(EndDate,'dd.mm.yyyy')]);
%% ������ ������ � ����
BorderColor=[1 1 1];
GridColor=[0 0 0];% ���� ���
BackGroundColor=[1 1 1]; % ���� ������� ������� *0.95
hold on;% ��������� ���� ��� ����� �������� 
close all % Remove all figures
figure1 = figure('Color',BorderColor); % ���� ������� �������
axes1 = axes('Parent',figure1,...% Create axes
    'XMinorTick','on','YMinorTick','on',... % ������������� ������ �� ����
    'YColor',GridColor,...% ���� ��� Y
    'XColor',GridColor,...% ���� ��� X
    'Color',BackGroundColor); % ���� ������� �������
hold(axes1,'all');
plot(X,Y,'LineWidth',1,'Color',[0 0 0]);
ylabel('EUR'); 
%xlabel(' Date'); 
datetick('x','yyyy')
grid on
title('�������� ������� ������� ���� ����� (���� ���)','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','PAMM2'];
h=figure1;
print ('-dpng','-r100',path);
%% ������ � ���������
figure2 = figure('Color',BorderColor); % ���� ������� �������
axes2 = axes('Parent',figure2,...% Create axes
    'XMinorTick','on','YMinorTick','on',... % ������������� ������ �� ����
    'YColor',GridColor,...% ���� ��� Y
    'XColor',GridColor,...% ���� ��� X
    'Color',BackGroundColor); % ���� ������� �������
grid(axes2,'on');
hold(axes2,'all');
datetick('x','yyyy')
plot(X, Y,'LineWidth',1,'Color',[0 0 0]);
%ylabel('%'); 
%xlabel(' Date'); 
datetick('x','yyyy')
title('�������� ������� ������� ���� �����, %','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','PAMM2percent'];
h=figure1;
print ('-dpng','-r100',path);


%% ������ ��� 2013�
% Pay(1:466)=[]; Time(1:466)=[];
% [CurProfit,MaxProfit,CurDD,MaxDD,DateDD,maxIncrease,DateIncrease]=PayProperties(Pay,Time);
% Days=length(Time);
% StartDate=Time(1);
% EndDate=Time(Days);
% disp('-------------');
% disp (['curProfit=',num2str(round(CurProfit)),'%, curDD=',num2str(round(CurDD)),'%']);
% disp (['maxProfit=',num2str(round(MaxProfit)),'%, maxDD=',num2str(round(MaxDD)),'% (',datestr(DateDD,'dd.mm.yyyy'),')']);
% disp (['maxIncrease=',num2str(round(maxIncrease)),'% (',datestr(DateIncrease,'dd.mm.yyyy'),')']);
% disp (['RF=',num2str(round(MaxProfit/MaxDD)),', Period: ',datestr(StartDate,'dd.mm.yyyy'),'-',datestr(EndDate,'dd.mm.yyyy')]);

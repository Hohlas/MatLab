clear % clear workspace and memory
%% ��������� ������ micro2
[StrData, Lines, Columns] =  csv2cell('03_monitoring_micro2.csv'); % ������������ �� ����� *.csv ��������� ��������� ������ StrData[Lines, Columns] 
[Time,Dial]=cell2data(StrData);% �� ����� ���� '18.02.2011' '23:30' '5.47' ������ ��� �������: "�����" � "������"
Balance(1)=301; % ��������� �������� ������� (��, ��� �������� �� ����1)
for i=2:Lines % �������� ���� ������
   Balance(i)=Balance(i-1)+Dial(i); % ��������� ������ ������� 
%    PerCent(i)=(Balance(i)-Balance(1))/Balance(1)*100; % � ������ �������� �� ���������� �������
end
StartDate=Time(1);
EndDate=Time(Lines);
X = linspace(StartDate,EndDate,Lines); % ��������� �������� StartDate..EndDate �� Lines ������ ������
Y=Balance;
%% ������ ������
BorderColor=[1 1 1];
GridColor=[0 0 0];% ���� ���
BackGroundColor=[1 1 1]; % ���� ������� ������� *0.95
hold on;% ��������� ���� ��� ����� �������� 
close all % Remove all figures
% figure1 = figure('Color',[0.7 0.7 0.7]); % ���� ������� �������
% axes1 = axes('Parent',figure1,...% Create axes
%     'XMinorTick','on','YMinorTick','on',... % ������������� ������ �� ����
%     'Color',[0.8 0.8 0.8]); % ���� ������� �������
%xlim(axes1,[StartDate EndDate]);
%ylim(axes1,[0 max(Y)]);
% box(axes1,'on');
% grid(axes1,'on');
% hold(axes1,'all');
% datetick('x','mm/yyyy')
figure1=figure('Color',BorderColor);
axes1 = axes('Parent',figure1,...% Create axes
    'XMinorTick','on','YMinorTick','on',... % ������������� ������ �� ����
     'YColor',GridColor,...% ���� ��� Y
    'XColor',GridColor,...% ���� ��� X
    'Color',BackGroundColor); % ���� ������� �������
hold(axes1,'all');
plot(X,Y,'LineWidth',1,'Color',[0 0 0]);
ylabel('EUR'); 
%xlabel(' Date'); 
datetick('x','mm/yyyy')
grid on
title('�������� ������� ������� ����� �����','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','Micro2'];
h=figure1;
print ('-dpng','-r100',path);
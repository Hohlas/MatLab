clear % clear workspace and memory
%% 
[StrData, Lines, Columns] =  csv2cell('01_monitoring_micro1.csv'); % ������������ �� ����� *.csv ��������� ��������� ������ StrData[Lines, Columns] 
[Time,Dial]=cell2data(StrData);% �� ����� ���� '18.02.2011' '23:30' '5.47' ������ ��� �������: "�����" � "������"
Balance(1)=Dial(1); % ��������� �������� �������
for i=2:Lines % �������� ���� ������,
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
datetick('x','mm/yyyy')
grid on
title('�������� ������� ������� ����� �����','FontSize',12);
path=['D:\WORK\MatLab\FX\MonitoringPlots\MonitoringPNG\','Micro1'];
h=figure1;
print ('-dpng','-r100',path);
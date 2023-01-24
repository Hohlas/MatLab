function [Bal] = bal(Deals,Time,FullTime,Risk)
% ������������ �������� �������� �� �������� �� ������, �� �������, � ������� ������ 
% Deals - ������� ������ � ������ ���� (���� ���) ��� ������� �������� 
% Time  - ������� ������� ������ ��� ������� ��������
% FullTime - ������ ��������� �����, �� ������� ����� �������������� ��������
% Risk  - ������ ������ ��� ������� ��������
%% ��������� ����� ����� ������� � ����� � ���
Days=length(FullTime); % ����������� ����� �������
[Rows,Cols] = size(Deals); % ���-�� ���������, ������������ ����� �������
%% ��������� ������� ��������, ���������� �� �� ����� �����,
for Ex=1:Rows  % ������� ��������� �� �������
    Bal(Ex,1)=0; 
    t=1;
    for D=2:Days, % ���������� ���� ������ ��������� �� ����
        Bal(Ex,D)=Bal(Ex,D-1); % ���������� ������ ������� ��� �����...
        while t<Cols && FullTime(D)>Time(Ex,t),
            Bal(Ex,D)=Bal(Ex,D)+Deals(Ex,t)*Risk(Ex); % �������� �������� ������� �� �������� ������
            t=t+1; % ������� �� ����� ������
        end
    end
end

%         TimeYear=year(datetime(FullTime(D),'ConvertFrom','datenum'));
%         if TimeYear>=CutFrom | TimeYear<=CutTo, continue; end  
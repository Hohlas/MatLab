function All = PortAll(Risk)
% ���������� ��������, ���������� �����������.
% type=1: STD/MO,  type=2: 1/RF,  type=3: 1/iRF
% Risk - ������ ������ ���������
load('TestsResults');
Pay=sum(bal(Deals,Time,FullTime,Risk)); % ��������� ������ ��������� � ������ ����� �������
Days=length(Pay);
maxPay=0; iDD=0; maxDD=0; curDD=0; Std=0;
Mo=Pay(Days)/Days; % ��� ��
for i=2:Days 
   Std=Std+abs(Mo-(Pay(i)-Pay(i-1)));
   if Pay(i)>maxPay, 
      maxPay=Pay(i); 
   else
      if maxPay>0, curDD=maxPay-Pay(i); end % ������ ������� ��������
      iDD=iDD+curDD;
      if curDD>maxDD, 
         maxDD=curDD; % ����� ������������ ��������
      end 
   end
end
Profit=Pay(Days)-Pay(1);
All=-Pay(Days)/Std/maxDD;


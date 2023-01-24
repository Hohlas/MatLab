function RF = optRF(optRisk)
% ���������� ��������, ���������� �����������.
% type=1: STD/MO,  type=2: 1/RF,  type=3: 1/iRF
% Risk - ������ ������ ���������
load('TestsResults');
Pay=sum(bal(Deals,Time,FullTime,optRisk)); % ��������� ������ ��������� � ������ ����� �������
Days=length(Pay);
maxPay=0; iDD=0; maxDD=0; curDD=0;
for i=1:Days 
   if Pay(i)>maxPay, 
      maxPay=Pay(i); 
   else
      if maxPay>0, curDD=maxPay-Pay(i); end % ������ ������� ��������
      iDD=iDD+(maxPay-Pay(i));
      if curDD>maxDD, 
         maxDD=curDD; % ����� ������������ ��������
      end 
   end
end
Profit=Pay(i)-Pay(1);
RF=-Profit/maxDD; 
iRF=-Profit/iDD;

function All = PortAll(Risk)
% возвращает критерий, подлежащий минимизации.
% type=1: STD/MO,  type=2: 1/RF,  type=3: 1/iRF
% Risk - вектор рисков экспертов
load('TestsResults');
Pay=sum(bal(Deals,Time,FullTime,Risk)); % суммарный баланс экспертов с учетом риска каждого
Days=length(Pay);
maxPay=0; iDD=0; maxDD=0; curDD=0; Std=0;
Mo=Pay(Days)/Days; % мат ож
for i=2:Days 
   Std=Std+abs(Mo-(Pay(i)-Pay(i-1)));
   if Pay(i)>maxPay, 
      maxPay=Pay(i); 
   else
      if maxPay>0, curDD=maxPay-Pay(i); end % расчет текущей просадки
      iDD=iDD+curDD;
      if curDD>maxDD, 
         maxDD=curDD; % поиск максимальной просадки
      end 
   end
end
Profit=Pay(Days)-Pay(1);
All=-Pay(Days)/Std/maxDD;


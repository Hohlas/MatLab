function RF = optRF(optRisk)
% возвращает критерий, подлежащий минимизации.
% type=1: STD/MO,  type=2: 1/RF,  type=3: 1/iRF
% Risk - вектор рисков экспертов
load('TestsResults');
Pay=sum(bal(Deals,Time,FullTime,optRisk)); % суммарный баланс экспертов с учетом риска каждого
Days=length(Pay);
maxPay=0; iDD=0; maxDD=0; curDD=0;
for i=1:Days 
   if Pay(i)>maxPay, 
      maxPay=Pay(i); 
   else
      if maxPay>0, curDD=maxPay-Pay(i); end % расчет текущей просадки
      iDD=iDD+(maxPay-Pay(i));
      if curDD>maxDD, 
         maxDD=curDD; % поиск максимальной просадки
      end 
   end
end
Profit=Pay(i)-Pay(1);
RF=-Profit/maxDD; 
iRF=-Profit/iDD;

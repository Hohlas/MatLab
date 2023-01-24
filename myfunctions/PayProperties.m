function [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Pay)
% Возвращает рыночные характеристики цены пая(Pay) 
Days=length(Pay);
maxPay=0; iDD=0; maxDD=0; curDD=0;
std=0; 
Mo=Pay(Days)/Days; % мат ож
for i=2:Days 
   std=std+abs(Mo-(Pay(i)-Pay(i-1)));
   if Pay(i)>maxPay, 
      maxPay=Pay(i); 
   else
      if maxPay>0, curDD=maxPay-Pay(i); end % расчет текущей просадки
      iDD=iDD+(maxPay-Pay(i));
      if curDD>maxDD, 
         maxDD=curDD; % поиск максимальной просадки
         DDIndex=i; % дата возникновения макс. просадки
      end 
   end
end
Profit=Pay(Days)-Pay(1);
RF=Profit/maxDD; 
iRF=Profit/iDD*10000;
MOSD=Pay(Days)/std;
function Correlation = optCorr(optRisk)
% возвращает критерий, подлежащий минимизации.
%  оррел€цию потрфел€ с каждым из балансов экспертов
% Risk - вектор рисков экспертов
load('TestsResults');
Bal = bal(Deals,Time,FullTime,optRisk);
Pay=sum(Bal); % суммарный баланс экспертов с учетом риска каждого

Days=length(Pay);
Experts=size(Deals,1);
Correlation=1;
for Ex=1:Experts
   Corr=corrcoef(Pay,Bal(Ex,:)); % коррел€ци€ портфел€ с одним из балансов экспертов
   Correlation=Correlation*Corr(1,2); % произведение коррел€ций, подлежащее минимизации
end
% Correlation=-(Pay(Days)-Pay(1))/Correlation/100;
Correlation=-(1/Correlation-1)*1000;
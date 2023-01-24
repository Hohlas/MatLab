%% 
% Оптимизация вектора рисков для портфеля экспертов по лучшему MO/SD, RF, iRF, 
% Результаты записываются в файл OptResults.m 
% Исходные данные (массивы балансов) берутся через ф-ции optMOSD, optRF... 
% из файла TestsResult.mat.
% Он создается запуском csv2mat.m, использующий файл MatLabTest.csv из МТ.
% Анализ полученных портфелей производится через PortfolioAnalysis.mat
% период оптимизации исключается снятием комментариев 
% в файле csv2matблок "CUT OPTIMISATION PERIOD 2008-2018
% clear
close all % Remove all figures
clear % clear workspace and memory
csv2mat('MatLabTest.csv');  % create file "TestsResults.mat"
Path=['D:\WORK\MatLab\FX\'];
OptFile=[Path,'OptResults']; % saved filename
load([Path,'TestsResults']);       % ID, Risk, Deals, Time, FullTime, Start, End, Rows, Cols, Days
%% ограничения функции оптимизации
A=[]; b=[]; % A*x<=b
Aeq(1:Rows)=1; beq=1; % Aeq*x=beq
Aeq=[]; beq=[];
LB(1:Rows)=0.1; %LB=LB'; 
UB(1:Rows)=3; %UB=UB';  LB<=x<=UB
x0(1:Rows)=0.1;
%% вызов функции оптимизации
options = gaoptimset('PlotFcns',{@gaplotbestf,@gaplotstopping});
% options = gaoptimset(options,'TolFun', 1e-3);
% fprintf('The number of generations was : %d\n', Output.generations);
% fprintf('The number of function evaluations was : %d\n', Output.funccount);
% options = gaoptimset(options,'CreationFcn', @gacreationlinearfeasible);
% options = gaoptimset(options,'MutationFcn', @mutationadaptfeasible);
% options = gaoptimset(options,'Display', 'off');
disp({'start',datetime('now','TimeZone','local','Format','HH:mm:ss')}); 
rMOSD(1:Rows)=1;
rMOSDga(1:Rows)=1;
rRF(1:Rows)=1;
rIRF(1:Rows)=1;
rALL(1:Rows)=1;
%%
% [rMOSD,Fval,exitFlag,Output]= patternsearch(@optMOSD,x0,A,b,Aeq,beq,LB,UB,[]);    disp({'rMOSDptrn',datetime('now','TimeZone','local','Format','HH:mm:ss')});   
%[rMOSDga,Fval,exitFlag,Output]  = patternsearch(@optMOSD,x0,A,b,Aeq,beq,LB,UB,[]);    disp({'rMOSDga' ,datetime('now','TimeZone','local','Format','HH:mm:ss')});
[rRF,Fval,exitFlag,Output]      = patternsearch(@optRF,  x0,A,b,Aeq,beq,LB,UB,[]);    disp({'rRF'     ,datetime('now','TimeZone','local','Format','HH:mm:ss')});
[rIRF,Fval,exitFlag,Output]     = patternsearch(@optiRF, x0,A,b,Aeq,beq,LB,UB,[]);    disp({'rIRF'    ,datetime('now','TimeZone','local','Format','HH:mm:ss')});
%[rALL,Fval,exitFlag,Output]     = patternsearch(@optAll, x0,A,b,Aeq,beq,LB,UB,[]);    disp({'rALL'    ,datetime('now','TimeZone','local','Format','HH:mm:ss')});

% [rMOSDga,Fval,exitFlag,Output]  = ga(@optMOSD,Rows,A,b,Aeq,beq,LB,UB,[],[],options);    disp({'rMOSDga' ,datetime('now','TimeZone','local','Format','HH:mm:ss')});
% [rIRF,Fval,exitFlag,Output]     = ga(@optRF,  Rows,A,b,Aeq,beq,LB,UB,[],[],options);    disp({'rRF'     ,datetime('now','TimeZone','local','Format','HH:mm:ss')});
% [rIRF,Fval,exitFlag,Output]     = ga(@optiRF, Rows,A,b,Aeq,beq,LB,UB,[],[],options);    disp({'rIRF'    ,datetime('now','TimeZone','local','Format','HH:mm:ss')});
% [rALL,Fval,exitFlag,Output]     = ga(@optAll, Rows,A,b,Aeq,beq,LB,UB,[],[],options);    disp({'rALL'    ,datetime('now','TimeZone','local','Format','HH:mm:ss')});

rMOSD=round(rMOSD,2);
rMOSDga=round(rMOSDga,2);
rRF=round(rRF,2);
rIRF=round(rIRF,2);
rALL=round(rALL,2);
save(OptFile,'ID','rMOSD','rMOSDga','rRF','rIRF','rALL'); % сохраняем рабочую область в файл OptResults.mat
%% Risk normalaize
% rMOSDptrn=rMOSDptrn/max(rMOSDptrn); % нормализуем матрицу к 1
% rMOSDga=rMOSDga/max(rMOSDga); % нормализуем матрицу к 1
% rRF=rRF/max(rRF); % нормализуем матрицу к 1
% rIRF=rIRF/max(rIRF); % нормализуем матрицу к 1
% rALL=rALL/max(rALL); % нормализуем матрицу к 1
%% формирование портфелей
% Portfolio0=sum(bal(Deals,Time,FullTime,rMOSD)); 
% Portfolio1=sum(bal(Deals,Time,FullTime,rMOSDga)); 
% Portfolio2=sum(bal(Deals,Time,FullTime,rRF)); 
% Portfolio3=sum(bal(Deals,Time,FullTime,rIRF)); 
% Portfolio4=sum(bal(Deals,Time,FullTime,rALL)); 
% Portfolio5=sum(bal(Deals,Time,FullTime,Risk));
% 
% Portfolio0=Portfolio0/max(Portfolio0);
% Portfolio1=Portfolio1/max(Portfolio1);
% Portfolio2=Portfolio2/max(Portfolio2);
% Portfolio3=Portfolio3/max(Portfolio3);
% Portfolio4=Portfolio4/max(Portfolio4);
% Portfolio5=Portfolio5/max(Portfolio5);
% 
% [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Portfolio0);   disp(['opt MOSD:    RF=',num2str(round(RF)),' MOSD=',num2str(round(MOSD*100000)),' iRF=',num2str(round(iRF))]);
% [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Portfolio1);   disp(['opt MOSDga:  RF=',num2str(round(RF)),' MOSD=',num2str(round(MOSD*100000)),' iRF=',num2str(round(iRF))]);
% [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Portfolio2);   disp(['opt RF:      RF=',num2str(round(RF)),' MOSD=',num2str(round(MOSD*100000)),' iRF=',num2str(round(iRF))]);
% [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Portfolio3);   disp(['opt IRF:     RF=',num2str(round(RF)),' MOSD=',num2str(round(MOSD*100000)),' iRF=',num2str(round(iRF))]);
% [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Portfolio4);   disp(['opt ALL:     RF=',num2str(round(RF)),' MOSD=',num2str(round(MOSD*100000)),' iRF=',num2str(round(iRF))]);
% [Profit,RF,iRF,curDD,maxDD,DDIndex,MOSD] = PayProperties(Portfolio5);   disp(['original CSV: RF=',num2str(round(RF)),' MOSD=',num2str(round(MOSD*100000)),' iRF=',num2str(round(iRF))]);
% Lines=6; % кол-во графиков в одном окне
% Legend=[{'rMOSD'},{'rRF'},{'rIRF'},{'csv'}];
% Plot('All Portfolios', FullTime, [Portfolio0; Portfolio2; Portfolio3; Portfolio5],Legend,Lines);
%% 
PortfolioAnalysis
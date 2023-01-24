function [x,fval,exitflag,output,population,score] = myGA(nvars,lb,ub,TolFun_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = gaoptimset;
%% Modify options setting
options = gaoptimset(options,'TolFun', TolFun_Data);
options = gaoptimset(options,'CreationFcn', @gacreationlinearfeasible);
options = gaoptimset(options,'MutationFcn', @mutationadaptfeasible);
options = gaoptimset(options,'Display', 'off');
options = gaoptimset(options,'PlotFcns', {  @gaplotbestf @gaplotstopping });
[x,fval,exitflag,output,population,score] = ...
ga(@PortiRF,nvars,[],[],[],[],lb,ub,[],[],options);

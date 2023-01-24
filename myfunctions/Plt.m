function [] = Plt(PlotName, X, Y)
hold on;% наложение двух или более графиков 
close all % Remove all figures
CL=0.3; % цвет цифр и букв
%% 
Figure1 = figure('Color',[0.76 0.87 0.78],...% цвет заливки бордюра
    'GraphicsSmoothing','off',...  % размытость
    'Name',PlotName); % название окна);  
% 'Position',[30 30 1500 800],... % положение окна: [XYнижнего_угла XYверхнего_угла]
% Color=colormap(lines); % палитра цветов colormap(lines) 
Axes1 = axes('Parent',Figure1,...% Create axes
    'ZColor',[CL CL CL],'YColor',[CL CL CL],'XColor',[CL CL CL],...        
    'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
    'FontName','Arial Cyr',...
    'Color',[0.9 0.9 0.9]); % цвет заливки графика
grid(Axes1,'on');
hold(Axes1,'all');
plot(X,Y,'LineWidth',1); % , 'Color','black'
% colormap(lines);
datetick('x','yyyy'); % проставляем года оси Х, если она значительная
title(PlotName,'FontSize',12);
% set(gca,...
%    'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16'},...
%    'XTick',min(X):365:max(X),...
%    'FontName','Arial Cyr')
legend('Location','NorthWest');
ylabel('$','Color',[CL CL CL]); %,'Orientation','horizontal' 
xlabel('Year','Color',[CL CL CL]);
% hold off;% наложение двух или более графиков откл
end


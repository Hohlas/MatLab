function [] = Plot(PlotName, X, Y, ID, Lines)
% построение графиков ф-ций по Lines линий в одном окне
% ID - массив идентификаторов для легенды
% Lines - кол-во линий в одном окне
%% строим графики ()
Graphs=size(Y,1); % количество линий для прорисовки
CL=0.5; % цвет цифр и букв
FigCnt=0; Gr=0;
%% 
while Gr<Graphs,% перебираем все массивы балансов
    FigCnt=FigCnt+1; % номер окна графика
    Figure(FigCnt) = figure('Color',[0.76 0.87 0.78],...% цвет заливки бордюра
        'GraphicsSmoothing','off',...  % размытость
        'Name',PlotName); % название окна); 
%       'Position',[30 30 1500 800],... % положение окна: [XYнижнего_угла XYверхнего_угла]
    Color=colormap(lines); % палитра цветов colormap(lines) 
    Axes(FigCnt) = axes('Parent',Figure(FigCnt),...% Create axes
       'ZColor',[CL CL CL],'YColor',[CL CL CL],'XColor',[CL CL CL],...        
       'XMinorTick','on','YMinorTick','on',... % промежуточные штрихи на осях
       'Color',[0.9 0.9 0.9]); % цвет заливки графика
    grid(Axes(FigCnt),'on');
    hold(Axes(FigCnt),'all');
    clear Legend;
    for i=1:Lines % по Lines линий на одном графике
        if Gr<Graphs, Gr=Gr+1; else break; end
        Legend(i)=ID(Gr); % массив легенды из идентификаторов
        plot(X,Y(Gr,:),'LineWidth',1, 'Color',Color(i,:)); 
    end
    if length(X)>300, datetick('x','yyyy'); end % проставляем года оси Х, если она значительная
    title(PlotName,'FontSize',12);
    set(gca,'FontName','Arial Cyr')
    legend(Legend,'Location','NorthWest');
    ylabel('$','FontAngle','italic','Color',[CL CL CL]); %,'Orientation','horizontal' 
    xlabel('Year','Color',[CL CL CL]);
    path=['D:\WORK\MatLab\FX\print\',PlotName,num2str(FigCnt)];
    print ('-dpng','-r100',path);
end
hold off;% наложение двух или более графиков откл

end


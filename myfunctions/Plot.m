function [] = Plot(PlotName, X, Y, ID, Lines)
% ���������� �������� �-��� �� Lines ����� � ����� ����
% ID - ������ ��������������� ��� �������
% Lines - ���-�� ����� � ����� ����
%% ������ ������� ()
Graphs=size(Y,1); % ���������� ����� ��� ����������
CL=0.5; % ���� ���� � ����
FigCnt=0; Gr=0;
%% 
while Gr<Graphs,% ���������� ��� ������� ��������
    FigCnt=FigCnt+1; % ����� ���� �������
    Figure(FigCnt) = figure('Color',[0.76 0.87 0.78],...% ���� ������� �������
        'GraphicsSmoothing','off',...  % ����������
        'Name',PlotName); % �������� ����); 
%       'Position',[30 30 1500 800],... % ��������� ����: [XY�������_���� XY��������_����]
    Color=colormap(lines); % ������� ������ colormap(lines) 
    Axes(FigCnt) = axes('Parent',Figure(FigCnt),...% Create axes
       'ZColor',[CL CL CL],'YColor',[CL CL CL],'XColor',[CL CL CL],...        
       'XMinorTick','on','YMinorTick','on',... % ������������� ������ �� ����
       'Color',[0.9 0.9 0.9]); % ���� ������� �������
    grid(Axes(FigCnt),'on');
    hold(Axes(FigCnt),'all');
    clear Legend;
    for i=1:Lines % �� Lines ����� �� ����� �������
        if Gr<Graphs, Gr=Gr+1; else break; end
        Legend(i)=ID(Gr); % ������ ������� �� ���������������
        plot(X,Y(Gr,:),'LineWidth',1, 'Color',Color(i,:)); 
    end
    if length(X)>300, datetick('x','yyyy'); end % ����������� ���� ��� �, ���� ��� ������������
    title(PlotName,'FontSize',12);
    set(gca,'FontName','Arial Cyr')
    legend(Legend,'Location','NorthWest');
    ylabel('$','FontAngle','italic','Color',[CL CL CL]); %,'Orientation','horizontal' 
    xlabel('Year','Color',[CL CL CL]);
    path=['D:\WORK\MatLab\FX\print\',PlotName,num2str(FigCnt)];
    print ('-dpng','-r100',path);
end
hold off;% ��������� ���� ��� ����� �������� ����

end


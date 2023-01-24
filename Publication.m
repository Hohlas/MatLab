%% publish the file to HTML, and then view the published document
% publish('file', options)
publish('Plot2DFunction.m', 'html') % saves the code, comments, and results to html
web('html/Plot2DFunction.html') % View the published output file in the Web browser:

%% publish the file to DOC format by using a structure, and then view the published document
options_doc_nocode.format='pdf' % publish to PDF format
options_doc_nocode.showCode=false % to exclude code from the output
options_doc_nocode.outputDir='' %  folder to which you want MATLAB to publish the output document
publish('Plot2DFunction.m',options_doc_nocode)% Publish with "options_doc_nocode"
winopen('html/Plot2DFunction.doc') % View the published output file in Microsoft Word:
%% fprintf
dim1=55; dim2=66;  typ=class(dim2);
fprintf('\n����� ����� %d � %d ��������������. \n�� ���- %s ������.\n', ...
    dim1, dim2, typ);
 %% disp
 x = 2 + 2; disp(['2 + 2 = ' num2str(x) '!']) 
 %% pause, keyboard, input. 
answer = input(['Algorithm is converging slowly; ', 'continue (yes/no)? '], 's'); % 's' ���� ��������� MATLAB �������� �� ��������� �����, ��������� �������������, � ��������� ��� ��� ������ �������� ���������� answer. 
if ~isequal(answer, 'yes'), return, end 
keyboard % keyboard ���������������� ���������� �-����� � ������ ������������ �����������, ���� �� ����� ������� ������� return ��� ����������� ���������� �-�����.  
% ������ ����� �������, ��� ���������� ������, ��� ����� �������� ��������� �������� �������� Workspace 
pause % ���������������� ���������� �-�����, ���� ������������ �� ������ ����� ������� 
dbstop % ��������� ���������� ��� �������


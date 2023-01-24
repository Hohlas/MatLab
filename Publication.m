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
fprintf('\nЧисла равны %d и %d соответственно. \nИх тип- %s массив.\n', ...
    dim1, dim2, typ);
 %% disp
 x = 2 + 2; disp(['2 + 2 = ' num2str(x) '!']) 
 %% pause, keyboard, input. 
answer = input(['Algorithm is converging slowly; ', 'continue (yes/no)? '], 's'); % 's' дает программе MATLAB указание не вычислять ответ, введенный пользователем, а присвоить его как строку символов переменной answer. 
if ~isequal(answer, 'yes'), return, end 
keyboard % keyboard приостанавливает выполнение М-файла и выдает пользователю приглашение, пока не будет введена команда return для продолжения выполнения М-файла.  
% ставят перед строкой, где появляется ошибка, так чтобы например проверить «Рабочую область» Workspace 
pause % приостанавливает выполнение М-файла, пока пользователь не нажмет любую клавишу 
dbstop % остановка выполнения при условии


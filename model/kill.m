function kill
% For aesthetic appeal from: http://www.mathworks.com/matlabcentral/answers/96076
% KILL  close all open figures and simulink models.
% Close all figures.
    % h=findall(0);
    % delete(h(2:end));
delete(findall(0,'Type','figure'))
% Close all Simulink models.
bdclose('all')
% If you have a GUI that opens plot windows and you would like to have a way to close all plots, without closing the GUI at the same time, then you can use the following code:
% 
% % Find all windows of type figure, which have an empty FileName attribute.
% allPlots = findall(0, 'Type', 'figure', 'FileName', []);
% % Close.
% delete(allPlots);
end
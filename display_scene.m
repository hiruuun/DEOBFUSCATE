close all;
set(gcf,'Visible','on')
hFigure = figure(2);

hFigure.Position =  [0 0 1500 1000]; %900;
%f.Position = [100 100 540 400];

hPanel1 = uipanel(hFigure,'Units','Normalized','Position',[0 1/4 1 3/4],'Title','Scenario Plot');
hPanel2 = uipanel(hFigure,'Units','Normalized','Position',[0  0  1 1/4],'Title','States Plot');
%hPanel3 = uipanel(hFigure,'Units','Normalized','Position',[1/2 1/4 1/2 0.8],'Title','Bird''s-Eye Plot');

hAxes1 = axes('Parent',hPanel1);
hAxes2 = axes('Parent',hPanel2);
% hAxes3 = axes('Parent',hPanel3);

% 
% fig_h = figure(1);
% hAxes1 = axes('Parent',fig_h);
% 
% fig_h1 = figure(2);
% hAxes2 = axes('Parent',fig_h1);
set(2,'Toolbar','figure') % Make figure undocked/*******************************************
% set(2,'Toolbar','figure') 
set(gcf,'Visible','on')

plot(scenario, 'Parent', hAxes1);
hAxes1.CameraPosition=[-627 1370 680];
hAxes1.View=[-159.4038   41.2522];



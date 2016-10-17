% 20160728
% plot timestamps

clc; clear all;

file = 'E:\Shared\519\20161003\nick\01_all\names.mat';

load(file);

times = zeros(100,8);

for i = 1:size(n,1)
    for j = 1:size(n,2)
        t = n(i,j);
        disp(t);
        t = num2str(t);
        h = str2double(t(1:2));
        m = str2double(t(3:4));
        s = str2double(t(5:6));
        d = str2double(t(7));
%         t = datenum(0,0,0,h,m,s.d);
        tt = (s+m*60+h*60*60)+d/10;
%         disp(tt);
        times(i,j) = tt;
    end
end

% plot(times,'.')
% legend('1','2','3','4','5','6','7','8');

n = 100;

figure;
plot(times(1:n,1),ones(1,n),'<','MarkerEdgeColor','red');
hold on;
% plot(times(1:n,2),ones(1,n)*2,'.');
% plot(times(1:n,3),ones(1,n)*3,'.');
% plot(times(1:n,4),ones(1,n)*4,'.');
% plot(times(1:n,5),ones(1,n)*5,'.');
% plot(times(1:n,6),ones(1,n)*6,'.');
% plot(times(1:n,7),ones(1,n)*7,'.');
% plot(times(1:n,8),ones(1,n)*8,'.');
plot(times(1:n,2),ones(1,n)*2,'o','MarkerEdgeColor','blue');
plot(times(1:n,3),ones(1,n)*3,'+','MarkerEdgeColor','black');
plot(times(1:n,4),ones(1,n)*4,'*','MarkerEdgeColor','blue');
plot(times(1:n,5),ones(1,n)*5,'x','MarkerEdgeColor','magenta');
plot(times(1:n,6),ones(1,n)*6,'s','MarkerEdgeColor','black');
plot(times(1:n,7),ones(1,n)*7,'d','MarkerEdgeColor','black');
plot(times(1:n,8),ones(1,n)*8,'^','MarkerEdgeColor','black');

set(gca,'FontSize',14)

ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'off';

% legend('1','2','3','4','5','6','7','8');
legend(...
    '\fontsize{14}1: i5-3450, 3.1GHz, 12GB (4+8),     Intel Graphics                     (1792MB)',...
    '\fontsize{14}2: i5-4590, 3.3GHz, 12GB (2+2+8), Intel Graphics 4600            (2160MB)',...
    '\fontsize{14}3: i7-2600, 3.4GHz, 12GB (8+2+2), NVIDIA GeForce GTX 750 (8117MB)',...
    '\fontsize{14}4: i5-4590, 3.3GHz, 12GB (4+8),     Intel Graphics 4600            (2160MB)',...
    '\fontsize{14}5: i7-3770, 3.4GHz, 12GB (4+8),     Intel(R) HD Graphics 4000 (1792MB)',...
    '\fontsize{14}6: i7-2600, 3.4GHz, 12GB (8+4),     NVIDIA GeForce GT 430    (7118MB)',...
    '\fontsize{14}7: i7-2600, 3.4GHz, 12GB (2+8+2), NVIDIA GeForce GTX 750 (8139MB)',...
    '\fontsize{14}8: i7-2600, 3.4GHz, 12GB (8+4),     NVIDIA GeForce GT 610    (7118MB)');

xlim([min(times(:)) max(times(:))]);
ylim([0.5 11.5]);
set(gca,'YTickLabel',['1';'2';'3';'4';'5';'6';'7';'8';' ';' ';' ']);
xlabel('Timestamp (seconds)','FontSize',28);
ylabel('Kinect ID','FontSize',28);
title(strcat('Timestamps of frames (',file,')'),'FontSize',28);

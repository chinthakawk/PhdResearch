% 20160728
% plot timestamps

clc; clear all;

file = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160728_PlotTimestamps/timestamps_Chin_20160728.mat';

load(file);

times = zeros(100,8);

for i = 1:size(n,1)
    for j = 1:size(n,2)
        t = n(i,j);
%         disp(t);
        t = num2str(t);
        h = str2double(t(1:2));
        m = str2double(t(3:4));
        s = str2double(t(5:6));
        d = str2double(t(7));
%         t = datenum(0,0,0,h,m,s.d);
        tt = (s+m*60+h*60*60)+d/10;
        disp(tt);
        times(i,j) = tt;
    end
end

% plot(times,'.')
% legend('1','2','3','4','5','6','7','8');

n = 100;

figure;
plot(times(1:n,1),ones(1,n),'.');
hold on;
plot(times(1:n,2),ones(1,n)*2,'.');
plot(times(1:n,3),ones(1,n)*3,'.');
plot(times(1:n,4),ones(1,n)*4,'.');
plot(times(1:n,5),ones(1,n)*5,'.');
plot(times(1:n,6),ones(1,n)*6,'.');
plot(times(1:n,7),ones(1,n)*7,'.');
plot(times(1:n,8),ones(1,n)*8,'.');

legend('1','2','3','4','5','6','7','8');

xlabel('Timestamp (seconds)');
ylabel('Kinect ID');
title('Timestamps of frames');

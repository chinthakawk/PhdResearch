% 20160201
% can we separte object based on the depth histogram

clear all; clc;

fol = '/Users/mac/Documents/KinectData/Lab2/20160129/Mickey/01_TestDepthThreshold/';
name = '1_1147504.mat';

file = strcat(fol, name);

load(file);

% fileID = fopen(strcat(fol2,name(1:numel(name)-4),'_oP=',num2str(oP),'.txt'),'w');
% fprintf(fileID,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
% fprintf(fileID,'\n\ndensity calculation for noise removal');
% fprintf(fileID,'\n\nfile:\t%s', strcat(fol, name));

% b = max(mean(abs(diff(pc(:,1:3)))));
% 
% fprintf(fileID,'\nsearch cube size (b):\t%f', b);
% 
% fprintf(fileID,'\noutlier percentage:\t%f', oP);
% 
% density = zeros(size(pc,1),1);
% noise = [];
% zmin = min(pc(:,3));
% zmax = max(pc(:,3));
% 
% i = 1;
% while i <= size(pc,1)
%     x = pc(i,1);
%     y = pc(i,2);
%     z = pc(i,3);
%     xl = x-b;
%     xh = x+b;
%     yl = y-b;
%     yh = y+b;
%     zl = z-b;
%     zh = z+b;
% 
%     [r, c] = find(pc(:,1)>xl & pc(:,1)<xh & pc(:,2)>yl & pc(:,2)<yh ...
%         & pc(:,3)>zl & pc(:,3)<zh); 
% 
%     density(i,1) = numel(r);
% 
%     i = i+1;
% end

z = pc(:,3);

[h, e] = histcounts(z,150);
stem(h,'b');

hmean = mean(h);
[hmax, hmaxi] = max(h);
% hmaxi = e(hmaxi);

hold on;
xh = xlim; yh = [hmean hmean];
% % % xv = [0 0]; yv = [-10 10];
plot(xh,yh,'r');
% 
% % xh = xlim; yh = [hmax hmax];
% % % xv = [0 0]; yv = [-10 10];
plot(hmaxi,hmax,'r*');


for i = hmaxi:numel(h)
    if h(i)< hmean
        hTh = i;
        break;
    end
end

line([hTh hTh], ylim, 'Color','r');

disp(hTh);
disp(e(hTh));
% zth = e(hTh);
zth = e(hmaxi);

i = find(z>zth);
pc(i,:) = [];

save(strcat(fol,name(1:numel(name)-4),'_objectOnly.mat'), 'pc');

% nBins = h.NumBins;
% val = h.Values;
% valMax = max(val);
% val2 = valMax - val;
% 
% % z2 = max(z) - pc(:,3);
% figure;
% h = histogram(val2);
% figure;
% hist(pc(:,3));

% fFindLocalMinima(h);
% nbins = numel(unique(pc(:,3)));
% hm = min(unique(pc(:,3)));
% h = histc(pc(:,3), (hm:150));
% stem(h,'b')

% p = zeros(nbins,1);
% 
% for j = 1:nbins
%     p(j,1) = h(j)/sum(h);
% end
% P = cumsum(p);
% 
% pD = hm + find(P<oP,1,'last') - 1;
% fprintf(fileID,'\npoint density:\t\t%f', pD);
% 
% figure;
% h1 = histogram(pc(:,3), (hm:nbins));
% title(strcat(name, '     oP=', num2str(oP), '     b=', num2str(b),...
%     '     pD=', num2str(pD)));
% xlabel('Points density');
% ylabel('Frequency');
% hold on;
% line([pD pD], ylim, 'Color','r');
% 
% saveas(h1, strcat(fol2,name(1:numel(name)-4),'_oP=',num2str(oP),'.jpg'))
% 
fprintf('\nDone\n');
% end

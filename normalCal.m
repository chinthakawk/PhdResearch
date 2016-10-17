% 20160308
% surface normal calculation

clc; clear all;

fol = 'D:\Matlab\02_RgbF1\K1\';
name = '1_1545057_rgbd';
file = strcat(fol,name);

load(file);

% b = 0.0000001;

b = max(mean(abs(diff(pc(:,1:3)))));
fprintf('search cube size (b):\t%f\n', b);
n = 6; % no of neighbors selected for normal calculation
m = size(pc,1);
% m = 100;

% figure;
% hax1 = axes;
% scatter3(hax1,pc(1:m,1),pc(1:m,2),pc(1:m,3),1);
% hold on;

figure;
hax2 = axes;
scatter3(hax2,pc(1:m,1),pc(1:m,2),pc(1:m,3),1);
hold on;
% data = pc(1:100:end,1:3);

% for i = 1:100:size(pc,1)
for i = 1:m
    
    [r,d] = knnsearch(pc(1:m,1:3),pc(i,1:3),'K',6);
    
    
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
%     [r, c] = find(pc(:,1)>xl & pc(:,1)<xh & pc(:,2)>yl & pc(:,2)<yh & ...
%         pc(:,3)>zl & pc(:,3)<zh);
    
%     nn = numel(r);
%     fprintf('%d:\tneighbor count = %d', i, nn);
%     if nn<n
%         r = r(1:nn);
%     else
%         r = r(1:n);
%     end
%     c = c(1:n);
%     fprintf('\tnormal count = %d\n', numel(r));
%     for j = 1:numel(r)
%         fprintf('(%f,%f,%f)\n',pc(r(j),1),pc(r(j),2),pc(r(j),3));
%     end
    v = normnd(pc(r,1:3));
    % Plot
%     figure; scatter3(data(:,1),data(:,2),data(:,3));
%     hold on; 
%     quiver3(hax1,mean(pc(r,1)),mean(pc(r,2)),mean(pc(r,3)),v(1),v(2),v(3));
    quiver3(hax2,pc(i,1),pc(i,2),pc(i,3),v(1),v(2),v(3));
    clear r c;
end
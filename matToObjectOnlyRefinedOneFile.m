% 20150506
% object only ply to object only ply refined
% 2016019
% edited

clear all;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha/set01/01/04_f1_refined/';
name = '8_0935037_oo.mat';

file = strcat(fol, name);
load(file);

s = 2;
figure;
scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),10,pc(1:s:size(pc,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

[x, y] = ginput;

x(numel(x)+1) = x(1);
y(numel(y)+1) = y(1);

in = inpolygon(pc(1:size(pc,1),1),pc(1:size(pc,1),2),x,y);

pc = pc(in,:);

figure;
scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),10,pc(1:s:size(pc,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

save(strcat(fol,name(1:numel(name)-4),'_refined.mat'), 'pc');
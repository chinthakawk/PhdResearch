% 20150524
% reads a mat file and allows user to select min and max values for x, y,
% and z directions
% then this file extract things inside that region and saves as another mat
% file
% edited on 20150607: user sets the box parameters only once, then same
% values are applied to the all the mat files in the same folder

clc; clear;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Den/set2/01_extracted/';
files = dir(strcat(fol, '8*.mat'));

name = files(1).name;
file = strcat(fol, name);
disp(file);
load(file);

p = 2;
s = 10;

figure('units','normalized','outerposition',[0 0 1 1])
scatter(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), 5, pc(1:s:size(pc,1),4:6)/255,'filled');
hold on;
axis equal;
xlabel('x'); ylabel('y');

title('xmin');
[xmin, ~] = ginput(1);
title('xmax');
[xmax, ~] = ginput(1);

title('ymin');
[~, ymin] = ginput(1);
title('ymax');
[~, ymax] = ginput(1);
hold off;
close all;

figure('units','normalized','outerposition',[0 0 1 1])
scatter(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),3), 5, pc(1:s:size(pc,1),4:6)/255, 'filled');
hold on;
axis equal;
xlabel('x'); ylabel('z');

title('zmin');
[~, zmin] = ginput(1);
title('zmax');
[~, zmax] = ginput(1);
hold off;
close all;
clear pc;

for f = 1:numel(files)
    name = files(f).name;
    file = strcat(fol, name);
    disp(file);
    load(file);
    
    i = find(pc(:,1)<xmin | pc(:,1)>xmax);
    pc(i,:) = [];
    clear i;
    
    i = find(pc(:,2)<ymin | pc(:,2)>ymax);
    pc(i,:) = [];
    clear i;
    
    i = find(pc(:,3)<zmin | pc(:,3)>zmax);
    pc(i,:) = [];

    save(strcat(fol,name(1:numel(name)-4),'_oO.mat'), 'pc');
    clear pc;
end
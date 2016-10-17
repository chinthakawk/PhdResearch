
% 20150524
% reads a mat file and allows user to select min and max values for x, y,
% and z directions
% then this file extract things inside that region and saves as another mat
% file

clc; clear;

fol = 'D:\KinectData\20150620_Kolis\Kolis_SlowMoving\All2\';
files = dir(strcat(fol, '1*.mat'));

for f = 1:numel(files)
% for f = 1:1
    name = files(f).name;
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
    
    i = find(pc(:,1)<xmin | pc(:,1)>xmax);
    pc(i,:) = [];
    clear i;
    
    i = find(pc(:,2)<ymin | pc(:,2)>ymax);
    pc(i,:) = [];
    clear i;
    
    i = find(pc(:,3)<zmin | pc(:,3)>zmax);
    pc(i,:) = [];

    save(strcat(fol,name(1:numel(name)-4),'_objectOnly.mat'), 'pc');
end
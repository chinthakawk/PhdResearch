% 20150506
% object only ply to object only ply refined
% 2016019
% edited

clear all;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha2/01/12_mf_matchingFramesOnly/';
s = 2;

files = dir(strcat(fol, '*.mat'));

for f = 1:numel(files)
    fprintf('\n%d',f);
    name = files(f).name;
    fprintf('\t%s',name);
%     fprintf('\t%s',name(numel(name)-11:end-4));
    if strcmp(name(numel(name)-11:end-4),'_refined')==1
        continue
    end
    
    file = strcat(fol, name);
    file2 = strcat(fol,name(1:numel(name)-4),'_refined.mat');
    
    if exist(file2, 'file') == 2
        fprintf('\texists');
        continue;
    end
    
    load(file);

    figure;
    scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2),...
        pc(1:s:size(pc,1),3),10,pc(1:s:size(pc,1),4:6)/255,'filled');
    axis equal;
    xlabel('x'); ylabel('y'); xlabel('x');
    view(-180, -90);

    [x, y] = ginput;

    x(numel(x)+1) = x(1);
    y(numel(y)+1) = y(1);

    in = inpolygon(pc(1:size(pc,1),1),pc(1:size(pc,1),2),x,y);

    pc = pc(in,:);

    figure;
    scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2),...
        pc(1:s:size(pc,1),3),10,pc(1:s:size(pc,1),4:6)/255,'filled');
    axis equal;
    xlabel('x'); ylabel('y'); xlabel('x');
    view(-180, -90);

    pause(.2);
    close all;
    save(file2, 'pc');
    clear pc;
end

fprintf('\ndone\n');
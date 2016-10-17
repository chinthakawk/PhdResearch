% 20150321
% inputs: points cloud saved in mat
% output: points cloud with xyz and rgb as a ply file
% edited on 20150607: now it converts all mat files in a folder to ply

clear all;

step = 1;

folder = 'E:\Shared\519\20161003\nick\03_f1Oo\';
files = dir(strcat(folder, '*.mat'));

for f = 1:numel(files)
% for f = 1:1
    name = files(f).name;
    fileName = strcat(folder, name);
    disp(fileName);

    load(fileName);

    dataAll = pc;

    fid = fopen(strcat(folder, name(1:numel(name)-4),'.ply'), 'w');

    fprintf(fid, 'ply\n');
    fprintf(fid, 'format ascii 1.0\n');
    fprintf(fid, 'element vertex %d\n', length(1:step:size(dataAll,1)));
    fprintf(fid, 'property float x\n');
    fprintf(fid, 'property float y\n');
    fprintf(fid, 'property float z\n');
    fprintf(fid, 'property uchar red\n');
    fprintf(fid, 'property uchar green\n');
    fprintf(fid, 'property uchar blue\n');
    fprintf(fid, 'property uchar alpha\n');
    fprintf(fid, 'end_header\n');

    for r=1:step:size(dataAll,1)
        fprintf(fid, '%f %f %f %d %d %d 0\n',...
            dataAll(r,1), dataAll(r,2), dataAll(r,3),...
            dataAll(r,4), dataAll(r,5), dataAll(r,6));
    end

    fclose(fid);
    clear pc dataAll;
end

disp('done');

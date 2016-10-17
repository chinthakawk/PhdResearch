% 20150321
% inputs: points cloud saved in mat
% output: points cloud with xyz and rgb as a ply file

clear all;

step = 1;

folder = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/';
fileName = '1_1545057_rgbd.mat';
disp(fileName);
load(strcat(folder, fileName));

dataAll = pc;

fid = fopen(strcat(folder, fileName(1:numel(fileName)-4),'_indexed.ply'), 'w');

fprintf(fid, 'ply\n');
fprintf(fid, 'format ascii 1.0\n');
fprintf(fid, 'element vertex %d\n', length(1:step:size(dataAll,1)));
fprintf(fid, 'property float x\n');
fprintf(fid, 'property float y\n');
fprintf(fid, 'property float z\n');
fprintf(fid, 'property uchar red\n');
fprintf(fid, 'property uchar green\n');
fprintf(fid, 'property uchar blue\n');
fprintf(fid, 'property float alpha\n');
% fprintf(fid, 'property uchar index\n');
fprintf(fid, 'end_header\n');

% i = 0;
for r=1:step:size(dataAll,1)
%     i = i+1;
%     if i~=r
%         fprintf('%d\t%d',r,i);
%     end
    fprintf(fid, '%f %f %f %d %d %d %f\n',...
        dataAll(r,1), dataAll(r,2), dataAll(r,3),...
        dataAll(r,4), dataAll(r,5), dataAll(r,6),...
        r);
end

fclose(fid);

disp('done');

% 20150507
% rough alignment of two clouds based on 4 user inputs
% update on 20150518
% can i mark the points selected with the order
% updated on 20160113
% just cleaned the code
% 20160119
% merge pairs if distance is less than a threshold
% 20160121
% merge pairs based on user defined percentage
% 20160217
% can we try to use color information as well

clear all; clc;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Hannibal/01/07_roughIcp/12t34_set2/';
nameR = '34.mat';
nameS = '12.mat';
tol = .005; % icp correspondance distance tolerance
ctol = 20;   % icp color difference tolerance
mP = 0.99;  % merge percentage
result = strcat(nameS(1:numel(nameS)-4),'_t_',nameR(1:numel(nameR)-4));

fprintf('\nreference:\t%s', nameR);
fprintf('\nsource:\t\t%s', nameS);

fileID = fopen(strcat(fol,result,'.txt'),'w');
fprintf(fileID,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fileID,'\n\nfolder: %s', fol);
fprintf(fileID,'\n\nsource:\t\t%s', nameS);
fprintf(fileID,'\ndestination:\t%s', nameR);

file = strcat(fol, nameR);
load(file);
pc1 = pc;

pc(:,4) = 0;
pc(:,5) = 0;
pc(:,6) = 255;
save(strcat(fol,nameR(1:numel(nameR)-4),'_static.mat'), 'pc');

clear pc;

file = strcat(fol, nameS);
load(file);
pc2 = pc;

pc(:,4) = 255;
pc(:,5) = 0;
pc(:,6) = 0;
save(strcat(fol,nameS(1:numel(nameS)-4),'_static.mat'), 'pc');

clear pc;
    
% ICP Align

data1 = pc1';
data2 = pc2';

fprintf(fileID,'\n\nicp alignment\n');
fprintf(fileID,'\n\ntol = %f\n', tol);
fprintf('\n\nicp alignment\n');

[R, t, corr, data2r] = icp2(data1(1:3,:), data2(1:3,:), tol, fileID);

fprintf('\n\nicp alignment\n');
disp(R);
disp(t);

M = [R t];
fprintf(fileID,'\n\n');
for ii = 1:size(M,1)
    fprintf(fileID,'\t%f',M(ii,:));
    fprintf(fileID,'\n');
end

data2r = [data2r; data2(4:6,:)];

% saving icp aligned source cloud
pc = data2r';
save(strcat(fol,nameS(1:numel(nameS)-4),'_icpAligned.mat'), 'pc');

% saving icp aligned source cloud in green
pc = data2r';
pc(:,4) = 0;
pc(:,5) = 255;
pc(:,6) = 0;
save(strcat(fol,nameS(1:numel(nameS)-4),'_icpAlignedStatic.mat'), 'pc');

% saving icp aligned source cloud, duplicates are in red
pc2md = data2r';
pc2md(corr(:,2),4) = 255;
pc2md(corr(:,2),5) = 0;
pc2md(corr(:,2),6) = 0;
pc = pc2md;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpAlignedMarkedDuplicates.mat'), 'pc');

% saving icp aligned source cloud, duplicates are in red, others in yellow
pc2mds = data2r';
pc2mds(:,4) = 255;
pc2mds(:,5) = 255;
pc2mds(:,6) = 0;
pc2mds(corr(:,2),4) = 255;
pc2mds(corr(:,2),5) = 0;
pc2mds(corr(:,2),6) = 0;
pc = pc2mds;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpAlignedMarkedDuplicatesStatic.mat'), 'pc');

% saving reference cloud, duplicates are in red
pc1md = pc1;
pc1md(corr(:,1),4) = 255;
pc1md(corr(:,1),5) = 0;
pc1md(corr(:,1),6) = 0;
pc = pc1md;
save(strcat(fol,nameR(1:numel(nameR)-4),...
    '_markedDuplicates.mat'), 'pc');

% saving reference cloud, duplicates are in red, others in yellow
pc1mds = pc1;
pc1mds(:,4) = 255;
pc1mds(:,5) = 255;
pc1mds(:,6) = 0;
pc1mds(corr(:,1),4) = 255;
pc1mds(corr(:,1),5) = 0;
pc1mds(corr(:,1),6) = 0;
pc = pc1mds;
save(strcat(fol,nameR(1:numel(nameR)-4),...
    '_markedDuplicatesStatic.mat'), 'pc');

% saving source duplicates
pc2d = data2r';
pc2d = pc2d(corr(:,2),:);
pc = pc2d;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpAlignedDuplicates.mat'), 'pc');

% saving source without duplicates
pc2nd = data2r';
pc2nd(corr(:,2),:) = [];
pc = pc2nd;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpAlignedNoDuplicates.mat'), 'pc');

% saving merged point cloud
pc = data2r';
pc = [pc1; pc];
save(strcat(fol,result,'.mat'), 'pc');

% saving merged point cloud with duplicates (red: source, blue: target)
pc2amd = data2r';
pc2amd(corr(:,2),4) = 255;
pc2amd(corr(:,2),5) = 0;
pc2amd(corr(:,2),6) = 0;
pc1amd = pc1;
pc1amd(corr(:,1),4) = 0;
pc1amd(corr(:,1),5) = 0;
pc1amd(corr(:,1),6) = 255;
pc = [pc1amd; pc2amd];
save(strcat(fol,result,'_markedDuplicatesRedSourceBlueTarget.mat'), 'pc');

% saving merged point cloud with duplicates
% source: green, duplicates: red
% target: yellow, duplicates: blue
pc2amd = data2r';
pc2amd(:,4) = 0;
pc2amd(:,5) = 255;
pc2amd(:,6) = 0;
pc2amd(corr(:,2),4) = 255;
pc2amd(corr(:,2),5) = 0;
pc2amd(corr(:,2),6) = 0;
pc1amd = pc1;
pc1amd(:,4) = 255;
pc1amd(:,5) = 255;
pc1amd(:,6) = 0;
pc1amd(corr(:,1),4) = 0;
pc1amd(corr(:,1),5) = 0;
pc1amd(corr(:,1),6) = 255;
pc = [pc1amd; pc2amd];
save(strcat(fol,result,...
    '_markedDuplicatesSourceGreenRedTargetYellowBlueStatic.mat'), 'pc');

% saving merged point cloud without duplicates
pc = pc2nd;
pc = [pc1; pc];
save(strcat(fol,result,'_noDuplicates.mat'), 'pc');

withColor = 0;
fmergeBasedOnPercentage(pc1, data2r', corr, mP, fileID, fol, result, ...
    withColor);

% =========================================================================
% icpWithColor stats from here

fprintf('\n\ncolor based icp alignment\n');
fprintf(fileID,'\n\ncolor based icp alignment\n');
fprintf(fileID,'\n\ncolor tol = %f\n', ctol);

color1 = data1(4:6,:);
color2 = data2(4:6,:);

[R, t, corr, data2r] = icp2WithColor(data1(1:3,:), data2(1:3,:), tol,...
    fileID, color1, color2, ctol);

fprintf('\n\ncolor based icp alignment\n');
disp(R);
disp(t);

M = [R t];
fprintf(fileID,'\n\n');
for ii = 1:size(M,1)
    fprintf(fileID,'\t%f',M(ii,:));
    fprintf(fileID,'\n');
end

data2r = [data2r; data2(4:6,:)];

% saving icpWithColor aligned source cloud
pc = data2r';
save(strcat(fol,nameS(1:numel(nameS)-4),'_icpWithColorAligned.mat'), 'pc');

% saving icpWithColor aligned source cloud in green
pc = data2r';
pc(:,4) = 0;
pc(:,5) = 255;
pc(:,6) = 0;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpWithColorAlignedStatic.mat'), 'pc');

% saving icpWithColor aligned source cloud, duplicates are in red
pc2md = data2r';
pc2md(corr(:,2),4) = 255;
pc2md(corr(:,2),5) = 0;
pc2md(corr(:,2),6) = 0;
pc = pc2md;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpWithColorAlignedMarkedDuplicates.mat'), 'pc');

% saving icpWithColor aligned source cloud, duplicates are in red, 
% others in yellow
pc2mds = data2r';
pc2mds(:,4) = 255;
pc2mds(:,5) = 255;
pc2mds(:,6) = 0;
pc2mds(corr(:,2),4) = 255;
pc2mds(corr(:,2),5) = 0;
pc2mds(corr(:,2),6) = 0;
pc = pc2mds;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpWithColorAlignedMarkedDuplicatesStatic.mat'), 'pc');

% saving reference cloud, duplicates are in red
pc1md = pc1;
pc1md(corr(:,1),4) = 255;
pc1md(corr(:,1),5) = 0;
pc1md(corr(:,1),6) = 0;
pc = pc1md;
save(strcat(fol,nameR(1:numel(nameR)-4),...
    '_markedDuplicatesIcpWithColor.mat'), 'pc');

% saving reference cloud, duplicates are in red, others in yellow
pc1mds = pc1;
pc1mds(:,4) = 255;
pc1mds(:,5) = 255;
pc1mds(:,6) = 0;
pc1mds(corr(:,1),4) = 255;
pc1mds(corr(:,1),5) = 0;
pc1mds(corr(:,1),6) = 0;
pc = pc1mds;
save(strcat(fol,nameR(1:numel(nameR)-4),...
    '_markedDuplicatesStaticIcpWithColor.mat'), 'pc');

% saving source duplicates
pc2d = data2r';
pc2d = pc2d(corr(:,2),:);
pc = pc2d;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpWithColorAlignedDuplicates.mat'), 'pc');

% saving source without duplicates
pc2nd = data2r';
pc2nd(corr(:,2),:) = [];
pc = pc2nd;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_icpWithColorAlignedNoDuplicates.mat'), 'pc');

% saving merged point cloud
pc = data2r';
pc = [pc1; pc];
save(strcat(fol,result,'_icpWithColor.mat'), 'pc');

% saving merged point cloud with duplicates (red: source, blue: target)
pc2amd = data2r';
pc2amd(corr(:,2),4) = 255;
pc2amd(corr(:,2),5) = 0;
pc2amd(corr(:,2),6) = 0;
pc1amd = pc1;
pc1amd(corr(:,1),4) = 0;
pc1amd(corr(:,1),5) = 0;
pc1amd(corr(:,1),6) = 255;
pc = [pc1amd; pc2amd];
save(strcat(fol,result,...
    '_markedDuplicatesRedSourceBlueTargetIcpWithColor.mat'), 'pc');

% saving merged point cloud with duplicates
% source: green, duplicates: red
% target: yellow, duplicates: blue
pc2amd = data2r';
pc2amd(:,4) = 0;
pc2amd(:,5) = 255;
pc2amd(:,6) = 0;
pc2amd(corr(:,2),4) = 255;
pc2amd(corr(:,2),5) = 0;
pc2amd(corr(:,2),6) = 0;
pc1amd = pc1;
pc1amd(:,4) = 255;
pc1amd(:,5) = 255;
pc1amd(:,6) = 0;
pc1amd(corr(:,1),4) = 0;
pc1amd(corr(:,1),5) = 0;
pc1amd(corr(:,1),6) = 255;
pc = [pc1amd; pc2amd];
save(strcat(fol,result,...
'_markedDuplicatesSourceGreenRedTargetYellowBlueStaticIcpWithColor.mat')...
    , 'pc');

% saving merged point cloud without duplicates
pc = pc2nd;
pc = [pc1; pc];
save(strcat(fol,result,'_noDuplicatesIcpWithColor.mat'), 'pc');

withColor = 1;
fmergeBasedOnPercentage(pc1, data2r', corr, mP, fileID, fol, result,...
    withColor);

fclose(fileID);

fprintf('\ndone\n');
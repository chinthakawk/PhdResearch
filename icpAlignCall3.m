% 20150507
% rough alignment of two clouds based on 4 user inputs
% update on 20150518
% can i mark the points selected with the order
% updated on 20160113
% just cleaned the code
% 20160119
% merge pairs if distance is less than a threshold

clear all; clc;

fol = '/Users/mac/Documents/KinectData/Lab/6K/teddy_20150418_164919/frame0_20160119/07_oO2_refined_DbNR_movedToOrigin_manualRoughAlignICPAlignCall3/1t2_On20160420_ForSaitmPaper/';
nameR = '2.mat';
nameS = '1.mat';
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

tol = .005; 

fprintf(fileID,'\n\nicp alignment\n');

[R, t, corr, data2r] = icp2(data1(1:3,:), data2(1:3,:), tol, fileID);

disp(' ');
disp('ICP alignment');
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
save(strcat(fol,result,'_markedDuplicatesSourceGreenRedTargetYellowBlueStatic.mat'), 'pc');

% saving merged point cloud without duplicates
pc = pc2nd;
pc = [pc1; pc];
save(strcat(fol,result,'_noDuplicates.mat'), 'pc');

% ===============
% merging duplicates based on a threshold
pc1mp = pc1; % pc1 merged points
pc2mp = data2r';
corrD = pdist2(pc1mp(corr(:,1),1:3),pc2mp(corr(:,2),1:3),'euclidean');
corrD = diag(corrD);
meanCD = mean(corrD);

fprintf(fileID,'\n\nmerging of the corresponding pairs');
fprintf(fileID,'\n\tmean intra-pair distance:%f\t',meanCD);

% saving histogram
figure;
h1 = histogram(corrD,numel(corrD));
title('Intra-pair distance histogram');
xlabel('Inter-pair distance');
ylabel('Frequency');
hold on;
line([meanCD meanCD], ylim, 'Color','r');
text(meanCD,5.5,strcat('\leftarrow Mean = ',{' '}, num2str(meanCD)),...
    'fontsize',24,'Fontname','Times New Roman');
set(gca,'ygrid','on')
set(gca,'fontsize',24,'Fontname','Times New Roman');


saveas(h1, strcat(fol,result,...
    '_intra-pairHist_mean=',num2str(meanCD),'.jpg'));

% saving: if intra-pair d > th, we remove both, else merge both
% th is the meanCD
corr1 = corr;
corr1g = corr1(corrD>meanCD,:); % > values, deleted points
corr1l = corr1(corrD<=meanCD,:); % <= values, merged points
pc1mp1 = pc1mp;
pc2mp1 = pc2mp;
% merged point coordinates
pc12mp1 = (pc1mp1(corr1l(:,1),1:3)+pc2mp1(corr1l(:,2),1:3))/2; 
% source: green, deleted duplicates: red, merged duplicates: majenta
% target: yellow, deleted duplicates: blue, merged duplicates: majenta
pc1mp1(:,4) = 255; % all points in yellow
pc1mp1(:,5) = 255;
pc1mp1(:,6) = 0;
pc1mp1(corr1g(:,1),4) = 0; % deleted points in blue
pc1mp1(corr1g(:,1),5) = 0;
pc1mp1(corr1g(:,1),6) = 255;
pc1mp1(corr1l(:,1),:) = []; % merged points removed
pc2mp1(:,4) = 0; % all points in green
pc2mp1(:,5) = 255;
pc2mp1(:,6) = 0;
pc2mp1(corr1g(:,2),4) = 255; % deleted points in red
pc2mp1(corr1g(:,2),5) = 0;
pc2mp1(corr1g(:,2),6) = 0;
pc2mp1(corr1l(:,2),:) = []; % merged points removed
pc12mp1(:,4) = 255;
pc12mp1(:,5) = 0;
pc12mp1(:,6) = 255;
pc = [pc1mp1; pc2mp1; pc12mp1];
save(strcat(fol,result,...
    '_markedDuplicatesSourceGreenRedTargetYellowBlue_magenta_merged.mat'),...
    'pc');

% saving: if intra-pair d > th, we remove both, else merge both
% th is the meanCD
pc1mp2 = pc1mp;
pc2mp2 = pc2mp;
% merged points points
pc12mp2p = (pc1mp2(corr1l(:,1),1:3)+pc2mp2(corr1l(:,2),1:3))/2;
% merged points colors
pc12mp2c = round((pc1mp2(corr1l(:,1),4:6)+pc2mp2(corr1l(:,2),4:6))/2,0);
pc12mp2 = [pc12mp2p pc12mp2c];
% visible only merged duplicates
pc1mp2(corr1(:,1),:) = []; % merged points removed
pc2mp2(corr1(:,2),:) = []; % merged points removed
pc = [pc1mp2; pc2mp2; pc12mp2];
save(strcat(fol,result,...
    '_merged.mat'), 'pc');

fclose(fileID);

disp('done');
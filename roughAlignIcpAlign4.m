% 20150507
% rough alignment of two clouds based on 4 user inputs
% update on 20150518
% can i mark the points selected with the order
% updated on 20160113
% just cleaned the code
% 20160615: try to align 2 clouds by selecting 5 points

clear all; clc;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Hannibal/01/08_roughIcp_try2/';
nameR = '2.mat';
nameS = '1.mat';
result = strcat(nameS(1:numel(nameS)-4),'_t_',nameR(1:numel(nameR)-4));

fprintf('\nreference:\t%s', nameR);
fprintf('\nsource:\t%s', nameS);

fileID = fopen(strcat(fol,result,'.txt'),'w');
fprintf(fileID,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fileID,'\n\nfolder: %s', fol);
fprintf(fileID,'\n\nsource:\t\t%s', nameS);
fprintf(fileID,'\ndestination:\t%s', nameR);

file = strcat(fol, nameR);
load(file);
pc1 = pc;
clear pc;

file = strcat(fol, nameS);
load(file);
pc2 = pc;
clear pc;
    
p = 5;
pS = 10;
s = 1;

figure('units','normalized','outerposition',[0 0 .5 1])
scatter3(pc2(1:s:size(pc2,1),1), pc2(1:s:size(pc2,1),2),...
    pc2(1:s:size(pc2,1),3),pS,pc2(1:s:size(pc2,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

figure('units','normalized','outerposition',[.5 0 .5 1])
scatter3(pc1(1:s:size(pc1,1),1), pc1(1:s:size(pc1,1),2),...
    pc1(1:s:size(pc1,1),3),pS,pc1(1:s:size(pc1,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

b = .003;

labels = cellstr( num2str([1:p]') );  %' # labels correspond to their order

A = [];
for i = 1:p
    dMin = Inf;
    [x1, y1] = ginput(1);
    x = [x1-b; x1+b; x1+b; x1-b; x1-b];
    y = [y1-b; y1-b; y1+b; y1+b; y1-b;];
    in = inpolygon(pc1(1:size(pc1,1),1),pc1(1:size(pc1,1),2),x,y);
    ini = find(in);
    for j = 1:sum(in)
        d = pdist([x1 y1; pc1(ini(j),1:2)],'euclidean');
        if d<dMin
            jMin = ini(j);
        end
    end
    text(pc1(jMin,1), pc1(jMin,2), labels(i), 'VerticalAlignment',...
        'bottom', 'HorizontalAlignment','right')
    A = [A; pc1(jMin,1:3)];
end
fprintf('\n\nselected points in reference\n');
fprintf('\n(%f,%f,%f)',A);

figure('units','normalized','outerposition',[0 0 .5 1])
scatter3(pc2(1:s:size(pc2,1),1), pc2(1:s:size(pc2,1),2),...
    pc2(1:s:size(pc2,1),3),pS,pc2(1:s:size(pc2,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

B = [];
for i = 1:p
    dMin = Inf;
    [x2, y2] = ginput(1);
    x = [x2-b; x2+b; x2+b; x2-b; x2-b];
    y = [y2-b; y2-b; y2+b; y2+b; y2-b;];
    in = inpolygon(pc2(1:size(pc2,1),1),pc2(1:size(pc2,1),2),x,y);
    ini = find(in);
    for j = 1:sum(in)
        d = pdist([x2 y2; pc2(ini(j),1:2)],'euclidean');
        if d<dMin
            jMin = ini(j);
        end
    end
    text(pc2(jMin,1), pc2(jMin,2), labels(i), 'VerticalAlignment',...
        'bottom', 'HorizontalAlignment','right')
    B = [B; pc2(jMin,1:3)];
end
fprintf('\n\nselected points in source\n');
fprintf('\n(%f,%f,%f)',B);

n = size(A,1);

[ret_R, ret_t] = rigid_transform_3D(B, A);

fprintf('\n');
disp('rough alignment');
disp(ret_R);
disp(ret_t);

fprintf(fileID,'\n\nrough alignment\n');
M = [ret_R ret_t];
for ii = 1:size(M,1)
    fprintf(fileID,'\t%f',M(ii,:));
    fprintf(fileID,'\n');
end

B2 = (ret_R*B') + repmat(ret_t, 1, n);
B2 = B2';

close all;

figure;
plot3(A(:,1),A(:,2),A(:,3),'ro',...
    B(:,1),B(:,2),B(:,3),'go',...
    B2(:,1),B2(:,2),B2(:,3),'bx');
view(0, 90);
legend('A', 'B', 'B2');
xlabel('X');
ylabel('Y');
zlabel('Z');

n = size(pc2,1);
pc2t = (ret_R*pc2(:,1:3)') + repmat(ret_t, 1, n);
pc2 = [pc2t' pc2(:,4:6)];

% save(strcat(fol,nameS(1:numel(nameS)-4),'_roughAligned.mat'), 'pc2');

% ICP Align

data1 = pc1';
data2 = pc2';

color1 = data1(4:6,:);
color2 = data2(4:6,:);

tol = .005; % icp correspondance distance tolerance
ctol = 20;   % icp color difference tolerance
% mP = 0.99;  % merge percentage

fprintf(fileID,'\n\nicp alignment\n');

% [R, t, corr, data2r] = icp2(data1(1:3,:), data2(1:3,:), tol, fileID);
% icp2WithColor(data1, data2, tol, fileID,...
%     color1, color2, ctol)
[R, t, corr, data2r] = icp2WithColor(data1(1:3,:), data2(1:3,:),...
    tol, fileID, color1, color2, ctol);

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

pc = data2r';
save(strcat(fol,nameS(1:numel(nameS)-4),'_roughIcpAligned.mat'), 'pc');

pc2nd = pc;
pc2nd(corr(:,2),:) = [];
pc = pc2nd;
save(strcat(fol,nameS(1:numel(nameS)-4),...
    '_roughIcpAlignedNoDuplicates.mat'), 'pc');

pc = data2r';
pc = [pc1; pc];
save(strcat(fol,result,'.mat'), 'pc');

pc = pc2nd;
pc = [pc1; pc];
save(strcat(fol,result,'_noDuplicates.mat'), 'pc');

R_t = R*ret_R;
t_t = R*ret_t + t; 

disp('rough and ICP alignment');
disp(R_t);
disp(t_t);

fprintf(fileID,'\n\nrough and icp alignment\n');
M = [R_t t_t];
for ii = 1:size(M,1)
    fprintf(fileID,'\t%f',M(ii,:));
    fprintf(fileID,'\n');
end

fclose(fileID);

disp('done');
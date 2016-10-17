% 20160225: try to align clouds based on surf features
% 20160617: what about marking matching pairs manually on images and try
% icp
% 20160619: use icp only using the extracted object

close all;
clear all;
clc;
 
fol = 'C:\FromE\20161003extra\test5frames\03_f1\';

rk = 1; % reference kinect
sk = 2; % source kinect

p = 3; % no. of ginputs

files = dir(strcat(fol, num2str(rk),'*.mat'));
name1 = files(1).name(1:9); % reference

files = dir(strcat(fol, num2str(sk),'*.mat'));
name2 = files(1).name(1:9); % source

labels = cellstr( num2str([1:p]')); 

% color images
color1 = imread(strcat(fol,name1,'.jpg'));
color2 = imread(strcat(fol,name2,'.jpg'));
color1o = color1;
color2o = color2;

% relations
relationsName1 = strcat(name1,'_rgbd.txt');
relationsName2 = strcat(name2,'_rgbd.txt');

% relations 1
fidr = fopen(strcat(fol,relationsName1));
C = textscan(fidr,['%f: (rd,cd)=(%f, %f) d=%f (x,y,z)=(%f, %f, %f) ',...
    '(rc,cc)=(%f, %f) (r,g,b)=(%f, %f, %f)'],'TreatAsEmpty',{'-Infinity'});
fclose(fidr);
relations1 = cell2mat(C);

% relations 2
fidr = fopen(strcat(fol,relationsName2));
C = textscan(fidr,['%f: (rd,cd)=(%f, %f) d=%f (x,y,z)=(%f, %f, %f) ',...
    '(rc,cc)=(%f, %f) (r,g,b)=(%f, %f, %f)'],'TreatAsEmpty',{'-Infinity'});
fclose(fidr);
relations2 = cell2mat(C);

% point clouds
file = strcat(fol,name1,'.mat');
nameR = strcat(name1,'.mat');
load(file);
pc1 = pc;
clear pc;

file = strcat(fol,name2,'.mat');
nameS = strcat(name2,'.mat');
load(file);
pc2 = pc;
clear pc;

result = strcat(nameS(1:numel(nameS)-4),'_t_',nameR(1:numel(nameR)-4));

fid = fopen(strcat(fol,name1,'_',name2,'-log_',...
    datestr(now,'yyyymmddHHMM'),'.txt'),'w');
fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol = %s',fol);
fprintf(fid,'\nname1 (reference) = %s',name1);
fprintf(fid,'\nname2 (source) = %s',name2);

depth1 = relations1((...
    relations1(:,4)>0 &...
    relations1(:,8)>=0 & relations1(:,8)<size(color1,1) &...
    relations1(:,9)>=0 & relations1(:,9)<size(color1,2)),8:9);

depth2 = relations2((...
    relations2(:,4)>0 &...
    relations2(:,8)>=0 & relations2(:,8)<size(color2,1) &...
    relations2(:,9)>=0 & relations2(:,9)<size(color2,2)),8:9);

depth1 = depth1+1;
depth2 = depth2+1;

for i=1:size(depth1,1)
    color1(depth1(i,1),depth1(i,2),1) = 255;
    color1(depth1(i,1),depth1(i,2),2) = 0;
    color1(depth1(i,1),depth1(i,2),3) = 0;
end

for i=1:size(depth2,1)
    color2(depth2(i,1),depth2(i,2),1) = 255;
    color2(depth2(i,1),depth2(i,2),2) = 0;
    color2(depth2(i,1),depth2(i,2),3) = 0;
end

imshowpair(color1, color2, 'montage')
fprintf(fid,'\n\nno. of matching pairs selected by user = %d',p);
fprintf(fid,'\n\ncoordinates of the points selected by the user');
fprintf(fid,'\n(ref(x,y)), src(x,y)');

xy1 = zeros(p,2);
xy2 = xy1;
for i = 1:p
    xy1(i,:) = round(ginput(1),0);
    fprintf(fid,'\n(%d,%d)',xy1(i,:));
    text(xy1(i,1), xy1(i,2), labels(i),...
        'VerticalAlignment','bottom','HorizontalAlignment','right',...
        'Color','blue','FontSize',18);
    xy2(i,:) = round(ginput(1),0);
    fprintf(fid,'\t(%d,%d)',xy2(i,:));
    text(xy2(i,1), xy2(i,2), labels(i),...
        'VerticalAlignment','bottom','HorizontalAlignment','right',...
        'Color','blue','FontSize',18);
end

fr = getframe(gcf);
fi = frame2im(fr);
imwrite(fi,strcat(fol,result,'_selected points_p=',num2str(p),'.png'));
    
xy2(:,1) = xy2(:,1)-size(color2,2);

fprintf(fid,'\n\ncorrected (x,y)');
fprintf(fid,'\nref(x,y)\tsrc(x,y)');
fprintf(fid,'\n(%d,%d)\t(%d,%d)',xy1(:,:),xy2(:,:));

% close all;

% ====================
% finding 3d coordinates of the selected points

fprintf(fid,'\n\n3d coordinates of the selected points');


A = [];
B = A;

ms = 3;

fprintf(fid,'\npoint searching cube size = %dx%d',2*ms+1,2*ms+1);
fprintf(fid,...
    '\nref(relations row no.,x,y,z)\tsrc(relations row no.,x,y,z)');

for i = 1:p
    fprintf('\n%d',i);
    cimg1 = xy1(i,1);
    rimg1 = xy1(i,2);
%     fprintf('\tcrimg1=(%d\t%d)',rimg1,cimg1);
    ri1 = find(relations1(:,8)==rimg1 & relations1(:,9)==cimg1);
%     fprintf('\t%d',ri1);
    found = 0;
    if isempty(ri1)
%         fprintf('\tempty ri');
        for r = -ms:ms
            for c = -ms:ms
%                 fprintf('\n%d\t%d',r,c);
                if ~(r==0 && c==0)
%                     fprintf('\n%d\t%d',r,c);
                    ri1 = find(relations1(:,8)==rimg1+r &...
                        relations1(:,9)==cimg1+c);
                    if ~isempty(ri1)
                        ri1 = ri1(1);
%                         fprintf('\t(%d,%d)',r,c);
                        fprintf('\t%d',ri1);
                        found = 1;
%                         ri1f=ri1;
                        break;
                    end
                end
                if found==1
                    break;
                end
%                 fprintf('\t%d',ri1);
            end
            if found==1
                break;
            end
        end
%         A = [A; relations1(ri1,5:7)];
    end
    
    cimg2 = xy2(i,1);
    rimg2 = xy2(i,2);
%     fprintf('\tcrimg2=(%d\t%d)',rimg2,cimg2);
    ri2 = find(relations2(:,8)==rimg2 & relations2(:,9)==cimg2);
%     fprintf('\t%d',ri2);
%     A(i,1:3) = relations1(ri,5:7);
    found = 0;
    if isempty(ri2)
%         fprintf('\tempty ri');
        for r = -ms:ms
            for c = -ms:ms
%                 fprintf('\n%d\t%d',r,c);
                if ~(r==0 && c==0)
%                     fprintf('\n%d\t%d',r,c);
                    ri2 = find(relations2(:,8)==rimg2+r &...
                        relations2(:,9)==cimg2+c);
                    if ~isempty(ri2)
                        ri2 = ri2(1);
%                         fprintf('\nnumel(ri2)=%d',numel(ri2));
                        fprintf('\t%d',ri2);
%                         fprintf('\t(%d,%d)',r,c);
%                         fprintf('\t%d',ri2);
                        found = 1;
                        break;
                    end
                end
                if found==1
                    break;
                end
%                 fprintf('\t%d',ri2);
            end
            if found==1
                break;
            end
        end
%         A = [A; relations1(ri1,5:7)];
    end

    if ~isempty(ri1) && ~isempty(ri2)
        ri1 = ri1(1);
        ri2 = ri2(1);
        fprintf('\n%d(%f,%f,%f)\t%d(%f,%f,%f)',ri1,relations1(ri1,5:7),...
            ri2,relations2(ri2,5:7));
        fprintf(fid,'\n%d(%f,%f,%f)\t%d(%f,%f,%f)',...
            ri1,relations1(ri1,5:7),ri2,relations2(ri2,5:7));
        A = [A; relations1(ri1,5:7)];
        B = [B; relations2(ri2,5:7)];
    end
end

n = size(A,1);

% ==========
% rough align

[ret_R, ret_t] = rigid_transform_3D(B, A); % B to A

fprintf('\n');
disp('rough alignment');
disp(ret_R);
disp(ret_t);

fprintf(fid,'\n\nrough alignment\n');
M = [ret_R ret_t];
for ii = 1:size(M,1)
    fprintf(fid,'\t%f',M(ii,:));
    fprintf(fid,'\n');
end

B2 = (ret_R*B') + repmat(ret_t, 1, n);
B2 = B2';

figure;
plot3(A(:,1),A(:,2),A(:,3),'ro');
text(A(:,1),A(:,2),A(:,3),labels,...
    'VerticalAlignment','bottom','HorizontalAlignment','right',...
    'Color','red');
hold on;
plot3(B(:,1),B(:,2),B(:,3),'go');
text(B(:,1),B(:,2),B(:,3),labels,...
    'VerticalAlignment','bottom','HorizontalAlignment','right',...
    'Color','green','FontSize',12);
plot3(B2(:,1),B2(:,2),B2(:,3),'bx');
text(B2(:,1),B2(:,2),B2(:,3),labels,...
    'VerticalAlignment','bottom','HorizontalAlignment','right',...
    'Color','blue');
view(0, 90);
legend('A', 'B', 'B2');
xlabel('X');
ylabel('Y');
zlabel('Z');

fr = getframe(gcf);
fi = frame2im(fr);
imwrite(fi,strcat(fol,result,'_roughAlign.png'));

n = size(pc2,1);
pc2t = (ret_R*pc2(:,1:3)') + repmat(ret_t, 1, n);
pc2 = [pc2t' pc2(:,4:6)];

% save(strcat(fol,nameS(1:numel(nameS)-4),'_roughAligned.mat'), 'pc2');

% ==========
% ICP Align

data1 = pc1'; % reference
data2 = pc2'; % source

color1 = data1(4:6,:);
color2 = data2(4:6,:);

tol = .005; % icp correspondance distance tolerance
ctol = 20;   % icp color difference tolerance
% mP = 0.99;  % merge percentage

fprintf(fid,'\n\nicp with color alignment');
fprintf(fid,'\ndistance tolerance (tol) = %f',tol);
fprintf(fid,'\ncolor tolerance (ctol) = %d',ctol);

% [R, t, corr, data2r] = icp2(data1(1:3,:), data2(1:3,:), tol, fid);
% icp2WithColor(data1, data2, tol, fid,...
%     color1, color2, ctol)
[R, t, corr, data2r] = icp2WithColor(data1(1:3,:), data2(1:3,:),...
    tol, fid, color1, color2, ctol);

disp(' ');
disp('ICP alignment');
disp(R);
disp(t);

M = [R t];
fprintf(fid,'\n\n');
for ii = 1:size(M,1)
    fprintf(fid,'\t%f',M(ii,:));
    fprintf(fid,'\n');
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

fprintf(fid,'\n\nrough and icp alignment\n');
rtm = [R_t t_t];
for ii = 1:size(rtm,1)
    fprintf(fid,'\t%f',rtm(ii,:));
    fprintf(fid,'\n');
end

% saving rotation matrix
rname = strcat('r',num2str(sk),'t',num2str(rk));
assignin('base',rname,R_t)
save(strcat(fol,rname,'.mat'), 'rname');

% saving translation matrix
tname = strcat('t',num2str(sk),'t',num2str(rk));
assignin('base',tname,t_t)
save(strcat(fol,tname,'.mat'), 'tname');

% saving merged point cloud
pc = data2r';
pc = [pc1; pc];
save(strcat(fol,result,'_icpWithColor.mat'), 'pc');

fMatToPlyWithRgbOneFile(fol,strcat(result,'_icpWithColor.mat'));

fclose(fid);

fprintf('\ndone\n');
   
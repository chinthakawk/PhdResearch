% 20160330
% 3d gradient direction and magnitude
% use 3*3 cube

% 20160411: corrected the matrix based on the following link
% https://en.wikipedia.org/wiki/Sobel_operator

tic;

clc; clear all;

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/11_3dGradinet_3dCubeCorrected_20160411/';
name = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat';
% step = 1;
ms = 3;
ss = 1;
sf = .001; % quiver scale factor

load(strcat(fol,name));
acc = 3;
pc = [fix((pc(:,1:3)*10^acc))/10^acc, pc(:,4:6)/255];
% pc = [round(pc(:,1:3),4), pc(:,4:6)];
pcg = pc(:,4)*0.2989 + pc(:,5)*0.5870 + pc(:,6)*0.1140;

% figure;
% hax1 = axes;
% scatter3(hax1,pc(:,1),pc(:,2),pc(:,3),ss,[pcg pcg pcg]/255);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% view(2);
% colorbar;
% axis equal;

s = 1*10^(-acc);
% n = 9;
gx = zeros(size(pc,1),1);
gy = zeros(size(pc,1),1);
gz = zeros(size(pc,1),1);


fid = fopen(strcat(fol,name(1:numel(name)-4),'_3dGradient_',...
    num2str(ms),'x',num2str(ms),'_log',datestr(now,'yyyymmdd_HHMMSS'),...
    '.txt'), 'w');

fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol:\t%s',fol);
fprintf(fid,'\nfile name:\t%s',name);
fprintf(fid,'\nss (point size of scatter3):\t%d',ss);
fprintf(fid,'\nsf (quiver scale factor):\t%f',sf);
fprintf(fid,'\nms (mask size):\t%d',ms);
fprintf(fid,'\nacc (setp accuracy of pc cube):\t%d',acc);
fprintf(fid,'\ns (step size of the pc cube):\t%f',s);
% fprintf(fid,'\nmc (min max of pc cube):\t%f',mc);

fprintf(fid,'\nsize of pc:\t%d',size(pc,1));

% mx = repmat(([ 1 2 1 ]' * [1 0 -1]),1,1,3);
% my = repmat(([ 1 2 1 ]' * [1 0 -1])',1,1,3);
% mz1 = [1 1 1; 2 2 2; 1 1 1];
% mz2 = zeros(3,3);
% mz3 = [-1 -1 -1; -2 -2 -2; -1 -1 -1];
% mz(:,:,1) = mz1;
% mz(:,:,2) = mz2;
% mz(:,:,3) = mz3;

[mx, my, mz] = fSobelCalculator();

fprintf(fid,strcat('\n\nsobel mask x(:,:,1:',num2str(ms),')\n'));
for i = 1:ms
   fprintf(fid, '\t%d', mx(i,:,1));
   fprintf(fid, '\n');
end

fprintf(fid,strcat('\nsobel mask y(:,:,1:',num2str(ms),')\n'));
for i = 1:ms
   fprintf(fid, '\t%d', my(i,:,1));
   fprintf(fid, '\n');
end

fprintf(fid,'\n');
for k = 1:ms
    fprintf(fid,strcat('sobel mask z(:,:,',num2str(ms),')\n'));
    for i = 1:ms
       fprintf(fid, '\t%d', mz(i,:,k));
       fprintf(fid, '\n');
    end
end

fprintf(fid, '\n\nfile content');
fprintf(fid, '\n1: point id');
fprintf(fid, '\n2: no. of found neighbors');
fprintf(fid, '\n');

% for i = 1:10
for i = 1:size(pc,1)
    k = 0;
    fprintf('\n%d',i);
    fprintf(fid,'\n%d',i);
%     fprintf('\t%f',pcg(i));
%     fprintf('\t(%f,%f,%f)',pc(i,1:3));
    p = zeros(3,3,3);
    x = pc(i,1);
    y = pc(i,2);
    z = pc(i,3);
    p(2,2,2) = pcg(i,1);
    % z-s layer
    q = find(pc(:,1)==x-s & pc(:,2)==y-s & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,1,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x-s & pc(:,2)==y & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,2,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x-s & pc(:,2)==y+s & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,3,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y-s & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,1,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,2,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y+s & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,3,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y-s & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,1,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,2,1) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y+s & pc(:,3)==z-s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,3,1) = pcg(q,1); k = k+1; end
    
    % z layer
    q = find(pc(:,1)==x-s & pc(:,2)==y-s & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,1,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x-s & pc(:,2)==y & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,2,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x-s & pc(:,2)==y+s & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,3,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y-s & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,1,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,2,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y+s & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,3,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y-s & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,1,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,2,2) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y+s & pc(:,3)==z, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,3,2) = pcg(q,1); k = k+1; end
    
    % z+s layer
    q = find(pc(:,1)==x-s & pc(:,2)==y-s & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,1,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x-s & pc(:,2)==y & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,2,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x-s & pc(:,2)==y+s & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(1,3,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y-s & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,1,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,2,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x & pc(:,2)==y+s & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(2,3,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y-s & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,1,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,2,3) = pcg(q,1); k = k+1; end
    q = find(pc(:,1)==x+s & pc(:,2)==y+s & pc(:,3)==z+s, 1);
%     fprintf('\t%d',q);
    if ~isempty(q);  p(3,3,3) = pcg(q,1); k = k+1; end
    
    fprintf(fid,'\t%d',k);
    
%     fprintf('\t%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',p);
%     % my 3d sobel mask
%     mx = repmat([-1 0 +1; -2 0 +2; -1 0 +1],1,1,3);
%     my = repmat([-1 -2 -1; 0 0 0; +1 +2 +1],1,1,3);
%     mz1 = [-1 -1 -1; -2 -2 -2; -1 -1 -1];
%     mz2 = zeros(3,3);
%     mz3 = [1 1 1; 2 2 2; 1 1 1];
%     mz(:,:,1) = mz1;
%     mz(:,:,2) = mz2;
%     mz(:,:,3) = mz3;

%     mx = [ 1 2 1 ]' * [1 0 -1];
%     my = mx';
%     mz1 = [1 1 1; 2 2 2; 1 1 1];
%     mz2 = zeros(3,3);
%     mz3 = [-1 -1 -1; -2 -2 -2; -1 -1 -1];
%     mz(:,:,1) = mz1;
%     mz(:,:,2) = mz2;
%     mz(:,:,3) = mz3;

%     % 3d sobel mask as per wikipedia 
%     % https://en.wikipedia.org/wiki/Sobel_operator
%     m1 = [1 2 1; 2 4 2; 1 2 1];
%     m2 = zeros(3,3);
%     m3 = -[1 2 1; 2 4 2; 1 2 1];
% 
%     mx(1,:,:) = m1;
%     mx(2,:,:) = m2;
%     mx(3,:,:) = m3;
%     
%     my(:,1,:) = m1;
%     my(:,2,:) = m2;
%     my(:,3,:) = m3;
%     
%     mz(:,:,1) = m1;
%     mz(:,:,2) = m2;
%     mz(:,:,3) = m3;

%     % 5 by 5 sobel
%     m = [1  2 0  -2 -1;
%          4  8 0  -8 -4;
%          6 12 0 -12 -6;
%          4  8 0  -8 -4;
%          1  2 0  -2 -1];
%     mx = repmat(m,1,1,5);
    
    gx(i,1) = sum(sum(sum(mx.*p)));
    gy(i,1) = sum(sum(sum(my.*p)));
    gz(i,1) = sum(sum(sum(mz.*p)));
    
end
    
% mag(Gx,Gy,Gz)  = sqrt ( Gx^2 + Gy^2 + Gz^2 )
mag  = sqrt ( gx(:,1).^2 + gy(:,1).^2 + gz(:,1).^2 );
% angle(Gx,Gy,Gz) = [Gx,Gy,Gz]/mag(Gx,Gy,Gz)
angle = [gx, gy, gz]./repmat(mag,1,3);


save(strcat(fol,name(1:numel(name)-4),'_3dGradient_mag_',num2str(ms),...
    'x',num2str(ms),'.mat'), 'mag');

dir = angle;
save(strcat(fol,name(1:numel(name)-4),'_3dGradient_dir_',num2str(ms),...
    'x',num2str(ms),'.mat'), 'dir');


mag = (mag-min(mag(:)))./(max(mag(:))-min(mag(:)));
% angle = (angle-min(angle(:)))./(max(angle(:))-min(angle(:)));

figure;
hax1 = axes;
scatter3(hax1,pc(:,1),pc(:,2),pc(:,3),ss,[mag mag mag]);
xlabel('x');
ylabel('y');
zlabel('z');
view(2);
colorbar;
axis equal;


figure;
hax4 = axes;
hold on;
color = colormap(jet(8));
%1
r = (angle(:,1)>pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(1,:),'MaxHeadSize',.002,'AutoScale','off');
%2
r = (angle(:,1)>pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(2,:),'MaxHeadSize',.002,'AutoScale','off');
%3
r = (angle(:,1)>pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(3,:),'MaxHeadSize',.002,'AutoScale','off');
%4
r = (angle(:,1)>pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(4,:),'MaxHeadSize',.002,'AutoScale','off');
%5
r = (angle(:,1)<pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(5,:),'MaxHeadSize',.002,'AutoScale','off');
%6
r = (angle(:,1)<pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(6,:),'MaxHeadSize',.002,'AutoScale','off');
%7
r = (angle(:,1)<pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(7,:),'MaxHeadSize',.002,'AutoScale','off');
%8
r = (angle(:,1)<pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(8,:),'MaxHeadSize',.002,'AutoScale','off');

xlabel('x');
ylabel('y');
zlabel('z');
view(2);
colorbar;
axis equal;

pcmag = [pc(:,1:3), round([mag mag mag]*255,0)];
% angle = round(((angle+1)/2)*255,0);
angle2 = (angle-min(angle(:)))./(max(angle(:))-min(angle(:)));
angle2(isnan(angle2)) = 0 ;
pcdir = [pc(:,1:3), round(angle2*255,0)];

% pc = pcmag;
% save(strcat(fol,name(1:numel(name)-4),'_3dGradientMag.mat'), 'pc');
% 
% pc = pcdir;
% save(strcat(fol,name(1:numel(name)-4),'_3dGradientDir.mat'), 'pc');

pc = pcmag;
save(strcat(fol,name(1:numel(name)-4),'_3dGradientMagPC_',num2str(ms),...
    'x',num2str(ms),'.mat'), 'pc');

pc = pcdir;
save(strcat(fol,name(1:numel(name)-4),'_3dGradientDirPC_',num2str(ms),...
    'x',num2str(ms),'.mat'), 'pc');

toc;
fprintf(fid,'\n\nElapsed time is %f seconds',toc);

fclose(fid);
fprintf('\n');

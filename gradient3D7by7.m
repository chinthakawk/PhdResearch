% 20160330
% 3d gradient direction and magnitude
% 20160407: use 5*5 cube
% http://stackoverflow.com/questions/9567882/sobel-filter-kernel-of-large-size

tic;

clc; clear all;

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/10_3dGradinet_3dCube_20160407/';
name = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat';

ss = 1;             % point size of scatter3
sf = .001;          % quiver scale factor
ms = 7;             % mask size
acc = 3;            % step accuracy of pc cube
s = 1*10^(-acc);    % step size of the pc cube
mc = floor(ms/2)*s; % min max of pc cube

fid = fopen(strcat(fol,name(1:numel(name)-4),'_3dGradient_',...
    num2str(ms),'x',num2str(ms),'_log.txt'), 'w');

fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol:\t%s',fol);
fprintf(fid,'\nfile name:\t%s',name);
fprintf(fid,'\nss (point size of scatter3):\t%d',ss);
fprintf(fid,'\nsf (quiver scale factor):\t%f',sf);
fprintf(fid,'\nms (mask size):\t%d',ms);
fprintf(fid,'\nacc (setp accuracy of pc cube):\t%d',acc);
fprintf(fid,'\ns (step size of the pc cube):\t%f',s);
fprintf(fid,'\nmc (min max of pc cube):\t%f',mc);

load(strcat(fol,name));

fprintf(fid,'\nsize of pc:\t%d',size(pc,1));

pc = [fix((pc(:,1:3)*10^acc))/10^acc, pc(:,4:6)/255];
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

gx = zeros(size(pc,1),1);
gy = zeros(size(pc,1),1);
gz = zeros(size(pc,1),1);

% sobel mask
sob3x3 = [ 1 2 1 ]' * [1 0 -1];
sob5x5 = conv2( [ 1 2 1 ]' * [1 2 1], sob3x3 );
sob7x7 = conv2( [ 1 2 1 ]' * [1 2 1], sob5x5 );
% disp(sob5x5);
% mx = repmat(sob5x5,1,1,5);  % x sobel
mx = repmat(sob7x7,1,1,ms);  % x sobel
% my = repmat(sob5x5',1,1,5);	% y sobel
my = repmat(sob7x7',1,1,ms);	% y sobel
% mz1 = repmat([1;4;6;4;1],1,5);
mz1 = repmat(sob7x7(:,1),1,ms);
% mz2 = repmat([1;4;6;4;1]*2,1,5);
mz2 = repmat(sob7x7(:,2),1,ms);
% mz3 = zeros(5,5);
mz3 = repmat(sob7x7(:,3),1,ms);
mz4 = zeros(ms,ms);
% mz(:,:,1) = mz1;            % z sobel
% mz(:,:,2) = mz2;
% mz(:,:,3) = mz3;
% mz(:,:,4) = -mz2;
% mz(:,:,5) = -mz1;
mz(:,:,1) = mz1;            % z sobel
mz(:,:,2) = mz2;
mz(:,:,3) = mz3;
mz(:,:,4) = mz4;
mz(:,:,5) = -mz3;
mz(:,:,6) = -mz2;
mz(:,:,7) = -mz1;

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
    fprintf('\n%d',i);
    fprintf(fid,'\n%d',i);
%     fprintf('\t%f',pcg(i));
%     fprintf('\t(%f,%f,%f)',pc(i,1:3));
    p = zeros(ms,ms,ms);
    x = pc(i,1);
    y = pc(i,2);
    z = pc(i,3);
    cx = x-mc:s:x+mc; % pc cube one size
    cy = y-mc:s:y+mc; % pc cube one size
    cz = z-mc:s:z+mc; % pc cube one size
    
    j = 0;
    for xi = 1:ms
        for yi = 1:ms
            for zi = 1:ms
                j = j+1;
                cxv = cx(xi); % cube x value
                cyv = cy(yi); % cube y value
                czv = cz(zi); % cube z value
%                 fprintf('\n%d\t%f\t%f\t%f',j,cxv,cyv,czv);
                q = find(pc(:,1)==cxv & pc(:,2)==cyv & pc(:,3)==czv, 1);
%                 fprintf('\t%d',q);
                if ~isempty(q)
                    p(xi,yi,zi) = pcg(q,1);
%                     fprintf('\t%d',pcg(q,1));
                end
            end
        end
    end
    
    fprintf(fid,'\t%d',nnz(p));

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

mag = (mag-min(mag(:)))./(max(mag(:))-min(mag(:))); % normalize mag

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

pcmag = [pc(:,1:3), round([mag mag mag]*255,0)]; % mag point cloud

% normalize angle
angle2 = (angle-min(angle(:)))./(max(angle(:))-min(angle(:)));
angle2(isnan(angle2)) = 0 ;
pcdir = [pc(:,1:3), round(angle2*255,0)]; % angle point cloud

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

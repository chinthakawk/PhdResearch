% 20160330
% 3d gradient direction and magnitude

clc; clear all;

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/08_3dGradinet/';
name = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat';
% step = 1;
s = 1;
% sf = .002; % quiver scale factor

load(strcat(fol,name));
pcg = pc(:,4)*0.2989 + pc(:,5)*0.5870 + pc(:,6)*0.1140;

n = 9;
gx = zeros(size(pc,1),1);
gy = zeros(size(pc,1),1);
gz = zeros(size(pc,1),1);

% for i = 1:1
for i = 1:size(pc,1)
    fprintf('\n%d',i);
    
    % x gradient
    [r,~] = knnsearch(pc(1:size(pc,1),1:3),pc(i,1:3),'K',n);
    
    r2 = (abs(pc(r,2)-pc(i,2))<0.005) & (abs(pc(r,3)-pc(i,3))<0.005);
    r2(~r2)=[];
    for j = 1:numel(r2)
        if r2(j) == 1
            r3(j) = r(j);
        end
    end
    r3(r3 == i)=[];
    
    xp = pc(r3,1)-pc(i,1);
    xp(xp<0) = [];
    [~, xpi] = min(xp);
    xpi = r3(xpi);
    
    xn = pc(i,1)-pc(r3,1);
    xn(xn<0) = [];
    [~, xni] = min(xn);
    xni = r3(xni);
    
    if (numel(xpi)==0) && (numel(xni)==0)
        gx(i,1) = 0;
    elseif numel(xpi)==0
        gx(i,1) = pcg(xni,1)*(-2);
    elseif numel(xni)==0
        gx(i,1) = pcg(xpi,1)*2;
    else
        gx(i,1) = pcg(xpi,1)*2 + pcg(xni,1)*(-2);
    end
    
    % y gradient
    [r,~] = knnsearch(pc(1:size(pc,1),1:3),pc(i,1:3),'K',n);
    
    r2 = (abs(pc(r,1)-pc(i,1))<0.005) & (abs(pc(r,3)-pc(i,3))<0.005);
    r2(~r2)=[];
    for j = 1:numel(r2)
        if r2(j) == 1
            r3(j) = r(j);
        end
    end
    r3(r3 == i)=[];
    
    yp = pc(r3,2)-pc(i,2);
    yp(yp<0) = [];
    [~, ypi] = min(yp);
    ypi = r3(ypi);
    
    yn = pc(i,2)-pc(r3,2);
    yn(yn<0) = [];
    [~, yni] = min(yn);
    yni = r3(yni);
    
    if (numel(ypi)==0) && (numel(yni)==0)
        gy(i,1) = 0;
    elseif numel(ypi)==0
        gy(i,1) = pcg(yni,1)*(-2);
    elseif numel(yni)==0
        gy(i,1) = pcg(ypi,1)*2;
    else
        gy(i,1) = pcg(ypi,1)*2 + pcg(yni,1)*(-2);
    end
    
    % z gradient
    [r,~] = knnsearch(pc(1:size(pc,1),1:3),pc(i,1:3),'K',n);
    
    r2 = (abs(pc(r,1)-pc(i,1))<0.005) & (abs(pc(r,2)-pc(i,2))<0.005);
    r2(~r2)=[];
    for j = 1:numel(r2)
        if r2(j) == 1
            r3(j) = r(j);
        end
    end
    r3(r3 == i)=[];
    
    zp = pc(r3,3)-pc(i,3);
    zp(zp<0) = [];
    [~, zpi] = min(zp);
    zpi = r3(zpi);
    
    zn = pc(i,3)-pc(r3,3);
    zn(zn<0) = [];
    [~, zni] = min(zn);
    zni = r3(zni);
    
    if (numel(zpi)==0) && (numel(zni)==0)
        gz(i,1) = 0;
    elseif numel(zpi)==0
        gz(i,1) = pcg(zni,1)*(-2);
    elseif numel(zni)==0
        gz(i,1) = pcg(zpi,1)*2;
    else
        gz(i,1) = pcg(zpi,1)*2 + pcg(zni,1)*(-2);
    end
    
end

% scatter3(pc(:,1),pc(:,2),pc(:,3),s,pcg/255);

% mag(Gx,Gy,Gz)  = sqrt ( Gx^2 + Gy^2 + Gz^2 )
mag  = sqrt ( gx(:,1).^2 + gy(:,1).^2 + gz(:,1).^2 );

% figure;
% hax1 = axes;
% scatter3(hax1,pc(1:step:m,1),pc(1:step:m,2),pc(1:step:m,3),s,mag);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% view(2);
% colorbar;
% axis equal;
% % hold on;

% angle(Gx,Gy,Gz) = [Gx,Gy,Gz]/mag(Gx,Gy,Gz)
angle = [gx, gy, gz]./repmat(mag,1,3);

% figure;
% hax2 = axes;
% quiver3(hax2,pc(:,1),pc(:,2),pc(:,3),...
%     angle(:,1),angle(:,2),angle(:,3));
% % quiver3(hax2,pc(:,1),pc(:,2),pc(:,3),...
% %     angle(:,1)*sf,angle(:,2)*sf,angle(:,3)*sf,...
% %     'MaxHeadSize',.002,'AutoScale','off');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% % view(2);
% % colorbar;
% axis equal;
% 
% % figure;
% % hax3 = axes;
% % hl = quiver3(pc(:,1),pc(:,2),pc(:,3),angle(:,1),angle(:,2),angle(:,3));
% % xlabel('x');
% % ylabel('y');
% % zlabel('z');
% % view(2);
% % colorbar;
% % axis equal;
% % % colquiver(hl,mag);
% 
% % figure;
% % hax3 = axes;
% % hold on;
% % color = colormap(jet(10));
% % range = 0:.1:1;
% % for i = 1:10
% %     if i<10
% %         r = (mag>=range(i)) & (mag<range(i+1));
% %     else
% %         r = (mag>=range(i));
% %     end
% %     quiver3(hax3,pc(r,1),pc(r,2),pc(r,3),...
% %         angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
% %         'color',color(i,:),'MaxHeadSize',.002,'AutoScale','off');
% % end
% % xlabel('x');
% % ylabel('y');
% % zlabel('z');
% % % view(2);
% % colorbar;
% % axis equal;
% 
% figure;
% hax3 = axes;
% hold on;
% maxR = round(max(mag),1);
% minR = round(min(mag),1);
% color = colormap(jet(5));
% range = minR:(maxR-minR)/5:maxR;
% for i = 1:numel(range)-1
%     disp(i);
%     if i<numel(range)
%         r = (mag>=range(i)) & (mag<range(i+1));
%     elseif i==numel(range)
%         r = (mag>=range(i));
%     end
%     quiver3(hax3,pc(r,1),pc(r,2),pc(r,3),...
%         angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%         'color',color(i,:),'MaxHeadSize',.002,'AutoScale','off');
% end
% xlabel('x');
% ylabel('y');
% zlabel('z');
% % view(2);
% colorbar;
% axis equal;
% 
% figure;
% hax4 = axes;
% hold on;
% color = colormap(jet(8));
% %1
% r = (angle(:,1)>pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)>pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(1,:),'MaxHeadSize',.002,'AutoScale','off');
% %2
% r = (angle(:,1)>pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)<pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(2,:),'MaxHeadSize',.002,'AutoScale','off');
% %3
% r = (angle(:,1)>pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)>pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(3,:),'MaxHeadSize',.002,'AutoScale','off');
% %4
% r = (angle(:,1)>pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)<pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(4,:),'MaxHeadSize',.002,'AutoScale','off');
% %5
% r = (angle(:,1)<pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)>pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(5,:),'MaxHeadSize',.002,'AutoScale','off');
% %6
% r = (angle(:,1)<pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)<pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(6,:),'MaxHeadSize',.002,'AutoScale','off');
% %7
% r = (angle(:,1)<pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)>pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(7,:),'MaxHeadSize',.002,'AutoScale','off');
% %8
% r = (angle(:,1)<pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)<pc(:,3));
% quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
%     angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
%     'color',color(8,:),'MaxHeadSize',.002,'AutoScale','off');
% 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% view(2);
% colorbar;
% axis equal;


fprintf('\n');

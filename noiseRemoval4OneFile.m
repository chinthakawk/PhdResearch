% 20150611
% how to remove the noises in the clouds, can we try with eucledian
% distance method

clear all;

fol = '/Users/mac/Documents/LabPC_D/KinectData/Kolis_20151017/AllOo/';

b = 0.01;
s = 1;
p = 1;
% pD = 15;
pD = 3;

% files = dir(strcat(fol, '*.mat'));

% for f = 1:numel(files)
% for f = 1:1
%     name = files(f).name;
    name = '1_1728393_oO.mat';
%     file = strcat(fol, name);
%     fprintf('\n%d\t%s\n',f,strcat(fol, name));
    
    load(strcat(fol, name));
    
    noise = [];

%     figure('units','normalized','outerposition',[0 0 1 1])
%     scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),p,pc(1:s:size(pc,1),4:6)/255,'filled');
%     axis equal;
%     xlabel('x'); ylabel('y'); xlabel('x');
%     view(90, 0);
%     hold on;

    i = 1;
    while i <= size(pc,1)
        x = pc(i,1);
        y = pc(i,2);
        z = pc(i,3);
        xl = x-b;
        xh = x+b;
        yl = y-b;
        yh = y+b;
        zl = z-b;
        zh = z+b;

    %     scatter3(pc(i,1), pc(i,2), pc(i,3),p*10,'r','filled');
    %     drawnow;

        [r, c] = find(pc(:,1)>xl & pc(:,1)<xh & pc(:,2)>yl & pc(:,2)<yh & pc(:,3)>zl & pc(:,3)<zh); 

    %     scatter3(pc(r,1), pc(r,2), pc(r,3),p*10,'b','filled');
    %     drawnow;

        if numel(r)<pD
    %         scatter3(pc(i,1), pc(i,2), pc(i,3),p*10,'r','filled');
    %         drawnow;
    %         pc(i,:) = [];
            noise = [noise; i];
        end
    %     
    %     for j = 1:size(pc,1)
    %         if i ~= j
    % %             d = pdist([pc(i,1:3); pc(j,1:3)],'euclidean');
    %             d = pdist2(pc(i,1:3); pc(j,1:3)],'euclidean');
    % %             d = nthroot((pc(i,1)-pc(j,1))^2 + (pc(i,2)-pc(j,2))^2 + (pc(i,3)-pc(j,3))^2, 3);
    %             if d<dMin
    %                 dMin = d;
    %                 jMin = j;
    %             end
    %         end
    %     end
    %     pc(i,7) = dMin;
    %     pc(i,8) = jMin;
%         fprintf('\n%d: r = %d', i, numel(r));
%         fprintf('\t%d', i);
        if (mod(i,10000)==0)
%             fprintf('.');
            fprintf('%d ',i);
        end
        i = i+1;
    end
%     save(strcat(fol,name(1:numel(name)-4),'_noise_pointDensity=',num2str(pD),'.mat'),'noise');
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(1,2,1);
    scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),p,pc(1:s:size(pc,1),4:6)/255,'filled');
    hold on;
    scatter3(pc(noise,1), pc(noise,2), pc(noise,3),p,'r','filled');
    axis equal;
    xlabel('x'); ylabel('y'); zlabel('z');
    view(90, 0);
%     hold off;
    pc(noise,:) = [];
    subplot(1,2,2);
    scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),p,pc(1:s:size(pc,1),4:6)/255,'filled');
    axis equal;
    xlabel('x'); ylabel('y'); zlabel('z');
    view(90, 0);
    
    fr = getframe(gcf);
    fi = frame2im(fr);
    imwrite(fi,strcat(fol,name(1:numel(name)-4),'_comparison_pointDensity=',num2str(pD),'.png'));
    
    save(strcat(fol,name(1:numel(name)-4),'_noiseRemoved_pointDensity=',num2str(pD),'.mat'),'pc');
    close all;
    clear pc noise;
    fprintf('\n');
% end

% scatter3(pc(noise,1), pc(noise,2), pc(noise,3),p,'r','filled');
% figure;
% scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),p,pc(1:s:size(pc,1),4:6)/255,'filled');
% axis equal;
% xlabel('x'); ylabel('y'); xlabel('x');
% view(90, 0);
% hold on;

% save(strcat(fol,file(1:numel(file)-3),'_dis.mat'),'pc');

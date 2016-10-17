% 20151103
% slicing

clear all;

fol = '';
name = '1_2226301_Oo.mat';

load(strcat(fol, name));

s = 1;
p = 4;
    
% figure;
% scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), ...
%     pc(1:s:size(pc,1),3),p,pc(1:s:size(pc,1),4:6)/255,'filled');
% axis equal;
% xlabel('x'); ylabel('y'); xlabel('x');
% % view(7, 70);
% hold on;

z = unique(pc(:,3));

% writerObj = VideoWriter(strcat(fol,'1_2226301_Oo.avi'));
% writerObj.FrameRate = 4;
% open(writerObj);

xmin = min(pc(:,1));
xmax = max(pc(:,1));
ymin = min(pc(:,2));
ymax = max(pc(:,2));
    
for zi = 1:size(z,1)
    if mod(zi-1,12)==0
        figure('units','normalized','outerposition',[0 0 1 1]);
    end
%     figure;
    if mod(zi,12)~=0
        subplot(3,4,mod(zi,12));
    else
        subplot(3,4,12);
    end
    scatter(pc(pc(:,3)==z(zi),1),pc(pc(:,3)==z(zi),2),20,...
        pc(pc(:,3)==z(zi),4:6)/255,'filled');
    title(num2str(z(zi)));
%     drawnow;
    axis([xmin xmax ymin ymax]);
    if mod(zi,12)==0
        saveas(gcf,strcat(num2str(zi-11),'-',num2str(zi),'.png'))
    else
        if zi == size(z,1)
            saveas(gcf,strcat(num2str(fix(zi/12)*12+1),'-',num2str(zi),'.png'))
        end
    end
%     drawnow;
%     f = getframe;
%     fi = frame2im(f);
%     writeVideo(writerObj,fi);    
end

% close(writerObj);
close all;
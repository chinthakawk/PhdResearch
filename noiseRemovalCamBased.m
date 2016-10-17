% 20151101
% noise removal based on camera position

clear all;

fol = '';
name = '1_2226301_Oo.mat';

load(strcat(fol, name));

s = 1;
p = 4;
    
% figure('units','normalized','outerposition',[0 0 1 1])
figure;
scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), ...
    pc(1:s:size(pc,1),3),p,pc(1:s:size(pc,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
% % view(90, 0);
% view(7, 70);
hold on;

plot3(pc(3986,1),pc(3986,2),pc(3986,3),'.r','MarkerSize', 12);
plot3(pc(9240,1),pc(9240,2),pc(9240,3),'.b','MarkerSize', 12);

% origin = zeros(size(pc,1),3);
% 
% figure;
% plot3(origin, pc(:,1:3));

% figure;
% hold on;
% angles = zeros(size(pc,1),2);
% 
% for i = 1:size(pc,1)
% % for i = 1:5
%     plot3([0 pc(i,1)], [0 pc(i,2)], [0 pc(i,3)]);
%     angleMin = Inf;
% %     angleMax = 0;
%     for j = 1:size(pc,1)
% %     for j = 1:10
%         if i == j
%             continue;
%         end
%         v1 = pc(i,1:3) - [0,0,0];
%         v2 = [0,0,0] - pc(j,1:3);
%         angle = atan2(norm(cross(v1,v2)),dot(v1,v2));
%         if angle < angleMin
% %             angleMin2 = angleMin;
%             angleMin = angle;
%             angleMinJ = j;
% %             angles(i,2) = j;
% %             angles(i,3) = angleMin;
%         end
% %         fprintf('\n%d\t%d\t%f\t%d\t%f\t%f',i,j,angle,angleMinJ,angleMin,...
% %             angleMin2);
%     end
%     angles(i,1) = angleMinJ;
%     angles(i,2) = angleMin;
% %     fprintf('\n*%d\t%d\t%f',i,angleMinJ, angleMin);
% end


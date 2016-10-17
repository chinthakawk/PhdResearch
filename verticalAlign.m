% 20151230
% seems first align the clouds to vertical plane and bringing them to
% origin is better. This files tries to do that.

clear all;

fol = '/Users/mac/Documents/KinectData/ProfRoom2/Shared/Human/Kolis/AllOoFrame1/AllOo_NR3_TriedMatlab/';
% nameR = '5_1728410_oO_nR_pDs=5_pD=3.9918.mat';
% nameS = '1_1728393_oO_nR_pDs=5_pD=2.837.mat';
% result = '1t5.mat';

files = dir(strcat(fol, '*.mat'));

% for f = 1:numel(files)
for f = 1:1
    name = files(f).name;
    fileName = strcat(fol, name);
    disp(fileName);

    load(fileName);
    
    p = 2;
    s = 1;

    % figure;
    figure('units','normalized','outerposition',[0 0 1 1]);
%     scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2),...
%         pc(1:s:size(pc,1),3),5,pc(1:s:size(pc,1),4:6)/255,'filled');
    scatter(pc(1:s:size(pc,1),2),pc(1:s:size(pc,1),3),5,...
        pc(1:s:size(pc,1),4:6)/255,'filled');
    axis equal;
    xlabel('y'); ylabel('z');
%     view(-180, -90);
%     view(0, 0); %xz
%     view(90, 0); %yz
    
%     b = .003;
% 
%     labels = cellstr( num2str([1:p]') );  % # labels
% 
%     A = [];
%     for i = 1:p
%         dMin = Inf;
%         [x1, y1] = ginput(1);
%         x = [x1-b; x1+b; x1+b; x1-b; x1-b];
%         y = [y1-b; y1-b; y1+b; y1+b; y1-b;];
%         in = inpolygon(pc(1:size(pc,1),1),pc(1:size(pc,1),2),x,y);
%         ini = find(in);
%         for j = 1:sum(in)
%             d = pdist([x1 y1; pc(ini(j),1:2)],'euclidean');
%             if d<dMin
%                 jMin = ini(j);
%             end
%         end
%         text(pc(jMin,1), pc(jMin,2), labels(i), 'VerticalAlignment','bottom', ...
%                                  'HorizontalAlignment','right')
%         A = [A; pc(jMin,1:3)];
%     end

    hold on;
    
    [x, y] = ginput(2);
    plot(x,y,'r');
    
%     v1 = [x(2),y(2)] - [x(1),y(1)];
%     v2 = [x(1),y(1)] - [x(2)-5,y(2)];
    P0 = [x(1)-.3,y(1)];
    P1 = [x(1),y(1)];
    P2 = [x(2),y(2)];
    pa = [P0; P1; P2];
%     hold on;
    plot(pa(:,1),pa(:,2),'b*');
    plot([P0(1) max(pc(:,2))],[y(1) y(1)], 'g-');
    
    ang = atan2(abs(det([P2-P0;P1-P0])),dot(P2-P0,P1-P0));
%     disp(ang);
    
%     ang = ang * 180/pi;
%     Multiply by 180/pi to get degrees.
%     ang = pi/2 + ang;
    ang = ang * 180/pi;
    disp(ang);
    ang = -ang;
    disp(ang);
    
    pc(:,2) = pc(:,2) - x(1);
    pc(:,3) = pc(:,3) - y(1);
    
    
    R = [1 0 0;
        0 cos(ang) -sin(ang);
        0 sin(ang) cos(ang)];
    
%     P1 = (R * [P1 0]')';
%     plot([P1(1)-.3 P1(1)+.3],[P1(2) P1(2)], 'g-');
    
    pct = R * pc(:,1:3)';
    pc = [pct' pc(:,4:6)];
    
%     hold on;
%     figure('units','normalized','outerposition',[0 0 1 1]);
    scatter(pc(1:s:size(pc,1),2),pc(1:s:size(pc,1),3),5,...
        pc(1:s:size(pc,1),4:6)/255,'filled');
    axis equal;
    xlabel('y'); ylabel('z');
end


% 
% % clear pc x y
% % 
% % file = strcat(fol, name2);
% % load(file);
% % pc2 = pc;
% %     
% figure;
% scatter3(pc2(1:s:size(pc2,1),1), pc2(1:s:size(pc2,1),2), pc2(1:s:size(pc2,1),3),5,pc2(1:s:size(pc2,1),4:6)/255,'filled');
% axis equal;
% xlabel('x'); ylabel('y'); xlabel('x');
% view(-180, -90);
% 
% B = [];
% for i = 1:p
%     dMin = Inf;
%     [x2, y2] = ginput(1);
%     x = [x2-b; x2+b; x2+b; x2-b; x2-b];
%     y = [y2-b; y2-b; y2+b; y2+b; y2-b;];
%     in = inpolygon(pc2(1:size(pc2,1),1),pc2(1:size(pc2,1),2),x,y);
%     ini = find(in);
%     for j = 1:sum(in)
%         d = pdist([x2 y2; pc2(ini(j),1:2)],'euclidean');
%         if d<dMin
%             jMin = ini(j);
%         end
%     end
%     text(pc2(jMin,1), pc2(jMin,2), labels(i), 'VerticalAlignment','bottom', ...
%                              'HorizontalAlignment','right')
%     B = [B; pc2(jMin,1:3)];
% end
% 
% R = orth(rand(3,3)); % random rotation matrix
% if det(R) < 0
%     V(:,3) = V(:,3) * -1;
%     R = V*U';
% end
% t = rand(3,1); % random translation
% 
% n = size(A,1);
% 
% [ret_R, ret_t] = rigid_transform_3D(B, A);
% 
% fprintf('\n');
% disp('rough alignment');
% disp(ret_R);
% disp(ret_t);
% 
% B2 = (ret_R*B') + repmat(ret_t, 1, n);
% B2 = B2';
% 
% % % Find the error
% % err = A2 - B;
% % err = err .* err;
% % err = sum(err(:));
% % rmse = sqrt(err/n);
% 
% % disp(sprintf('RMSE: %f', rmse));
% % disp('If RMSE is near zero, the function is correct!');
% 
% figure;
% plot3(A(:,1),A(:,2),A(:,3),'ro',...
%     B(:,1),B(:,2),B(:,3),'go',...
%     B2(:,1),B2(:,2),B2(:,3),'bx');
% view(0, 90);
% legend('A', 'B', 'B2');
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% 
% % disp([ret_R, ret_t]);
% 
% n = size(pc2,1);
% pc2t = (ret_R*pc2(:,1:3)') + repmat(ret_t, 1, n);
% pc2 = [pc2t' pc2(:,4:6)];
% 
% save(strcat(fol,nameS(1:numel(nameS)-4),'_roughAligned.mat'), 'pc2');
% 
% % ICP Align
% 
% data1 = pc1';
% data2 = pc2';
% 
% tol = .005; 
% 
% % fprintf('\n\nICP call: data1 = %s, data2 = %s', file1, file2);
% [R, t, corr, data2r] = icp(data1(1:3,:), data2(1:3,:), tol);
% 
% disp(' ');
% disp('ICP alignment');
% disp(R);
% disp(t);
% 
% data2r = [data2r; data2(4:6,:)];
% 
% pc = data2r';
% % save(strcat(fol,'duck_20150504_103807_back2_objectOnly.mat'), 'pc');
% save(strcat(fol,nameS(1:numel(nameS)-4),'_roughIcpAligned.mat'), 'pc');
% % data2r = pc;
% 
% pc = [pc1; pc];
% % save(strcat(fol,'duck_20150504_103807_back2_objectOnly.mat'), 'pc');
% save(strcat(fol,result), 'pc');
% 
% % R = R1*R;
% % t = R1*t + t1; 
% R_t = R*ret_R;
% t_t = R*ret_t + t; 
% 
% disp('rough and ICP alignment');
% disp(R_t);
% disp(t_t);
% 
% % close all;
% 
% pc2 = pc;
% 
% 
% figure;
% % scatter3(data1(1,1:s:size(data1,2))', data1(2,1:s:size(data1,2))',...
% %     data1(3,1:s:size(data1,2))',5,data1(4:6,1:s:size(data1,2))/255,'filled');
% scatter3(pc1(1:s:size(pc1,1),1), pc1(1:s:size(pc1,1),2), pc1(1:s:size(pc1,1),3),5,pc1(1:s:size(pc1,1),4:6)/255,'filled');
% hold on;
% % scatter3(data2(1,1:s:size(data2,2))', data2(2,1:s:size(data2,2))', data2(3,1:s:size(data2,2))','.g');
% % scatter3(data2r(1,1:s:size(data2r,2))', data2r(2,1:s:size(data2r,2))',...
% %     data2r(3,1:s:size(data2r,2))',5,data2r(4:6,1:s:size(data2r,2))/255',...
% %     'filled');
% scatter3(pc2(1:s:size(pc2,1),1), pc2(1:s:size(pc2,1),2), pc2(1:s:size(pc2,1),3),5,pc2(1:s:size(pc2,1),4:6)/255,'filled');
% axis equal;
% % fclose(fileID);
% disp('done');
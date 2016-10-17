% 20150507
% rough alignment of two clouds based on 4 user inputs
% update on 20150518
% can i mark the points selected with the order

clear all;

fol = '/Users/mac/Documents/KinectData/Lab/24K/duck_20150324_170956_all/frame0_manuallyAligned/Degrees45_NoDuplicates_20160113/';
nameR = 'duck20150324_170956_0_03_objectOnly.ply';
nameS = 'duck20150324_170956_0_00_objectOnly.ply';
result = '1t5.mat';



fprintf('\nreference:\t%s', nameR);

fprintf('\nsource:\t%s', nameS);

file = strcat(fol, nameR);
load(file);
pc1 = pc;
clear pc;

file = strcat(fol, nameS);
load(file);
pc2 = pc;
clear pc;
    
p = 5;
s = 1;

% figure;
figure('units','normalized','outerposition',[0 0 1 1])
% subplot(1,2,1);
% scatter3(pc1(1:s:size(pc1,1),1), pc1(1:s:size(pc1,1),2), pc1(1:s:size(pc1,1),3),5,pc1(1:s:size(pc1,1),4:6)/255,'filled');
% axis equal;
% xlabel('x'); ylabel('y'); xlabel('x');
% view(-180, -90);
% subplot(1,2,2);
scatter3(pc2(1:s:size(pc2,1),1), pc2(1:s:size(pc2,1),2), pc2(1:s:size(pc2,1),3),5,pc2(1:s:size(pc2,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

figure;
scatter3(pc1(1:s:size(pc1,1),1), pc1(1:s:size(pc1,1),2), pc1(1:s:size(pc1,1),3),5,pc1(1:s:size(pc1,1),4:6)/255,'filled');
axis equal;
xlabel('x'); ylabel('y'); xlabel('x');
view(-180, -90);

% b = .0015;
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
    text(pc1(jMin,1), pc1(jMin,2), labels(i), 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
    A = [A; pc1(jMin,1:3)];
end

% clear pc x y
% 
% file = strcat(fol, name2);
% load(file);
% pc2 = pc;
%     
figure;
scatter3(pc2(1:s:size(pc2,1),1), pc2(1:s:size(pc2,1),2), pc2(1:s:size(pc2,1),3),5,pc2(1:s:size(pc2,1),4:6)/255,'filled');
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
    text(pc2(jMin,1), pc2(jMin,2), labels(i), 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
    B = [B; pc2(jMin,1:3)];
end

R = orth(rand(3,3)); % random rotation matrix
if det(R) < 0
    V(:,3) = V(:,3) * -1;
    R = V*U';
end
t = rand(3,1); % random translation

n = size(A,1);

[ret_R, ret_t] = rigid_transform_3D(B, A);

fprintf('\n');
disp('rough alignment');
disp(ret_R);
disp(ret_t);

B2 = (ret_R*B') + repmat(ret_t, 1, n);
B2 = B2';

% % Find the error
% err = A2 - B;
% err = err .* err;
% err = sum(err(:));
% rmse = sqrt(err/n);

% disp(sprintf('RMSE: %f', rmse));
% disp('If RMSE is near zero, the function is correct!');

figure;
plot3(A(:,1),A(:,2),A(:,3),'ro',...
    B(:,1),B(:,2),B(:,3),'go',...
    B2(:,1),B2(:,2),B2(:,3),'bx');
view(0, 90);
legend('A', 'B', 'B2');
xlabel('X');
ylabel('Y');
zlabel('Z');

% disp([ret_R, ret_t]);

n = size(pc2,1);
pc2t = (ret_R*pc2(:,1:3)') + repmat(ret_t, 1, n);
pc2 = [pc2t' pc2(:,4:6)];

save(strcat(fol,nameS(1:numel(nameS)-4),'_roughAligned.mat'), 'pc2');

% ICP Align

data1 = pc1';
data2 = pc2';

tol = .005; 

% fprintf('\n\nICP call: data1 = %s, data2 = %s', file1, file2);
[R, t, corr, data2r] = icp(data1(1:3,:), data2(1:3,:), tol);

disp(' ');
disp('ICP alignment');
disp(R);
disp(t);

data2r = [data2r; data2(4:6,:)];

pc = data2r';
% save(strcat(fol,'duck_20150504_103807_back2_objectOnly.mat'), 'pc');
save(strcat(fol,nameS(1:numel(nameS)-4),'_roughIcpAligned.mat'), 'pc');

pc = [pc1; pc];
% save(strcat(fol,'duck_20150504_103807_back2_objectOnly.mat'), 'pc');
save(strcat(fol,result), 'pc');

% R = R1*R;
% t = R1*t + t1; 
R_t = R*ret_R;
t_t = R*ret_t + t; 

disp('rough and ICP alignment');
disp(R_t);
disp(t_t);



% figure;
% scatter3(data1(1,1:s:size(data1,2))', data1(2,1:s:size(data1,2))', data1(3,1:s:size(data1,2))','.r');
% hold on;
% scatter3(data2(1,1:s:size(data2,2))', data2(2,1:s:size(data2,2))', data2(3,1:s:size(data2,2))','.g');
% scatter3(data2r(1,1:s:size(data2r,2))', data2r(2,1:s:size(data2r,2))', data2r(3,1:s:size(data2r,2))','.b');
% axis equal;
% fclose(fileID);
disp('done');
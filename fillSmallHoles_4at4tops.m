% 20160501
% used findHoles4 to find holes
% now can we fill small holes detected
% 20160511: added 4 points at the 4 top biggest angles

clc; clear all;

pcname = '/Users/mac/Documents/KinectData/102/Den/K1f301/11_fillsh-4at4tops/1_1437348_rgbd_oo_refined-nR_oP=0.05_pDs=4_pD=3.8519-sr_dis=0.001_np=8-findHoles_neig#=21-fsh_newd=0.001.mat';

name = '/Users/mac/Documents/KinectData/102/Den/K1f301/11_fillsh-4at4tops/1_1437348_rgbd_oo_refined-nR_oP=0.05_pDs=4_pD=3.8519-sr_dis=0.001_np=8-findHoles_neig#=21-fsh_newd=0.001-findh_neig#=20_';

newd = 0.001;

load(pcname);
m = size(pc,1);
% m = 5;

% neirad = 0.002; % radius of neighbors sphere
% n = 11; % no of nearest neighbors
% neico = zeros(size(pc,1),1); % to save the neighbors

% figure;
% scatter3(pc(:,1),pc(:,2),pc(:,3),1,pc(:,4:6)/255);
% axis equal;
% view(2);
% hold on;

load(strcat(name,'angle.mat'));
load(strcat(name,'halfdisk.mat'));
load(strcat(name,'boundary.mat'));
load(strcat(name,'g.mat'));
load(strcat(name,'gbeg.mat'));
load(strcat(name,'gend.mat'));
load(strcat(name,'normal.mat'));

prob = zeros(size(pc,1),1);
wangle = 1/3;
whalfdisk = 1/3;
wboundary = 1/3;

for i = 1:m
    prob(i) = angle(i)*wangle + halfdisk(i)*whalfdisk +...
        boundary(i)*wboundary;
end

res = zeros(size(pc,1),1);
res(prob>.6)=1;

pc2 = zeros(size(pc,1)+sum(res),6);

% figure;
% scatter3(pc(:,1),pc(:,2),pc(:,3),1,~[res res res]); 
% view(2);
% axis equal;

k = 0;
% newd = 0.002;

for i = 1:m
    k=k+1;
    pc2(k,:) = pc(i,:);
    if res(i)==1
        p = pc(i,1:3);
        bp = null(normal(i,:));
        
        for j = 1:4
            k = k+1;
            fprintf('\n%d\t%d\tg=%.2f\tgbeg=%d\tgend=%d',i,j,g(i,j),...
                gbeg(i,j),gend(i,j));

            bc = bsxfun(@minus,pc(gbeg(i,j),1:3),p)*bp; % plane coefficients
            pbeg = bsxfun(@plus,bc*bp.', p);
            bc = bsxfun(@minus,pc(gend(i,j),1:3),p)*bp; % plane coefficients
            pend = bsxfun(@plus,bc*bp.', p);

            v1 = pbeg-p;
            v1 = v1/norm(v1);
            v2 = pend-p;
            v2 = v2/norm(v2);
            vm = v1+v2;
            vn = p+vm*newd;
            pc2(k,1:3) = vn;
            pc2(k,4:6) = pc(i,4:6);
        end
    end
end

pc = pc2;
save(strcat(name(1:numel(name)-1),'-fsh_newd=',num2str(newd),'.mat'),'pc');


fprintf('\n');




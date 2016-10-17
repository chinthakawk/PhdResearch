% 20160416
% finding holes in point clouds
% 20160422: update with shape criterion

tic;

clc, clear all;

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/';
name = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat';

n = 10; % no of nearest neighbors

load(strcat(fol,name));
m = size(pc,1);

load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/neirad=0.05/nei.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/neirad=0.05/miup.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/neirad=0.05/angle.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/neirad=0.05/halfdisk.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/neirad=0.05/neic.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/neirad=0.05/neid.mat');

% nei = zeros(size(pc,1),n-1); % to save the neighbors
% neid = zeros(size(pc,1),n-1); % distances to neighbors
% neic = zeros(size(pc,1),1); % to save no of neighbors
% 
% % m = 10; % no of iterations
% m = size(pc,1);

% neirad = 0.05; % radius of neighbors sphere
% 
% % scatter3(pc(1:m,1),pc(1:m,2),pc(1:m,3),10,pc(1:m,4:6)/255);
% % axis equal;
% % hold on;
% 
% % ==============
% % neighborhood collection
% 
% fprintf('\nneighborhood collection\n');
% 
% % for i = 1:size(pc,1)
% for i = 1:m
%     if mod(i,100) == 0
%         fprintf('.');
%     elseif mod(i,10000)==0
%         fprintf('\n');
%     end
% %     fprintf('\n%d',i);
%     p1 = pc(i,1:3);
%     [j,d] = knnsearch(pc(:,1:3),p1,'K',n); % neighbors and distances
% 
%     di = find(d>neirad); % neighbors outside the sphere
%     
% %     fprintf('\t%f\t%f\t%d', min(d(2:end)),max(d(2:end)),numel(di));
%     j(di) = [];
%     d(di) = [];
%     nei(i,1:numel(j)-1) = j(2:end);
%     neid(i,1:numel(j)-1) = d(2:end);
%     neic(i,1) = numel(d)-1;
%     
% %     [x,y,z] = sphere;
% %     x0 = p1(1); 
% %     y0 = p1(2); 
% %     z0 = p1(3);
% %     [x,y,z] = sphere;
% %     x = x*r + x0;
% %     y = y*r + y0;
% %     z = z*r + z0;
% % %     surf(x+p1(1),y+p1(2),z+p1(3))
% %     lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
% %     surface(x,y,z,'FaceColor', 'none','EdgeColor',lightGrey);
% %     hold on;
% end
% 
% fprintf('\nneighborhood collection updating\n');
% 
% for i = 1:m
%     if mod(i,100) == 0
%         fprintf('.');
%     elseif mod(i,10000)==0
%         fprintf('\n');
%     end
%     p1 = pc(i,1:3);
%     k = n;
%     [r, c] = find(nei==i);
%     for j = 1:numel(r)
%         if isempty(find(nei(i,:)==r(j), 1))
%             nei(i,k) = r(j);
%             p2 = pc(r(j),1:3);
%             neid(i,k) = pdist([p1;p2],'euclidean');
%             neic(i,1) = neic(i,1)+1; 
%             k = k+1;
%         end
%     end
% end
% 
% % ==============
% % angle criterion
% 
% % scatter3(pc(:,1),pc(:,2),pc(:,3),1,pc(:,4:6)/255);
% % scatter3(pc(1:m,1),pc(1:m,2),pc(1:m,3),10,pc(1:m,4:6)/255);
% angle = zeros(size(pc,1),1);
% g = zeros(size(pc,1),1);
% normal = zeros(size(pc,1),3);
% 
% fprintf('\nangle criterion\n');
% 
% for i = 1:m
%     if mod(i,100) == 0
%         fprintf('.');
%     elseif mod(i,10000)==0
%         fprintf('\n');
%     end
% %     fprintf('\n%d',i);
%     p1 = pc(i,1:3);
%     r = nei(i,1:numel(find(nei(i,:))));
%     if ~isempty(r)
%         normal(i,:) = (normnd(pc(r,1:3)))'; % normal of p1
%     %     end
% 
%     %     syms x y z;
%     %     P = [x,y,z];
%     %     realdot = @(u, v) u*transpose(v);
%     % 
%     %     plane = realdot(P-p1,normal'); %dot(normal, P-p1);
%     %     zplane = solve(plane, z);
%     %     ezmesh(zplane, [min(pc(r,1)), max(pc(r,1)),...
%     %         min(pc(r,2)), max(pc(r,2))]);%, hold off
%     % %     ezmesh(zplane, 10);
%     %     hold on;
%     % 
%         pro = pc([i r],1:3)*null(normal(i,:));
%     %     basisPlane=null(normal'); %basis for the plane
%     %     basisCoefficients= bsxfun(@minus,pc(r,1:3),p1)*basisPlane ;
%     %     pro = bsxfun(@plus,basisCoefficients*basisPlane.', p1);
% 
%     %     scatter3(pc(r,1),pc(r,2),pc(r,3),10,'r');
%     %     scatter3(pro(:,1),pro(:,2),pro(:,3),10,'b');
%     %     figure;
%     % %     hax1 = axes;
%     %     scatter(pro(1,1),pro(1,2),'.r');
%     %     hold on;
%     %     scatter(pro(2:end,1),pro(2:end,2),'.b');
%     %     a = (1:numel(r))'; b = num2str(a); c = cellstr(b);
%     %     dx = 0.001; dy = 0.001; % displacement so the text does not overlay the data points
%     %     text(pro(2:end,1), pro(2:end,2), c);
% 
%         ang = zeros(1,numel(r));
% 
%         for j = 2:size(pro,1)
%             ang(j-1) = mod(atan2(pro(j,2)-pro(1,2),...
%                 pro(j,1)-pro(1,1)),2*pi)*180/pi;
%         end
% 
%         minang = min(ang);
%         maxang = max(ang);
%         lastang = 360-maxang+minang;
% 
%         ang = ang-minang;
%         [ang, angi] = sort(ang);
%     %     t = text(pro(angi+1,1), pro(angi+1,2), c, 'FontSize',16);
%     %     v = get(t,'FontSize');
%     %     a(1:numel(v),1) = 12;
%     %     set(v,'FontSize',mat2cell(a,2));
% 
%     %     fprintf('\t%f',ang);
%     %     maxang = max(ang);
%         ang = diff(ang);
%     %     lastang = max(maxang,360-maxang);
%         ang = [ang, lastang];
%     %     fprintf('\n');
%     %     fprintf('\t%f',ang);
%         [g(i), gii] = max(ang);
%     %     fprintf('\t%f',ang);
%     %     fprintf('\t%f\t%d',g(i),gii);
% 
%         angle(i) = min((g(i)-360/numel(r))/(180-360/numel(r)),1);
%     end
%     
% %     angs = sort(ang);
% %     
% %     for j = 1:numel(r)
% %         
% %     end
% end
% 
% % ==============
% % half disk criterion
% 
% halfdisk = zeros(size(pc,1),1);
% miup = zeros(size(pc,1),3);
% 
% fprintf('\nhalf disk criterion\n');
% for i = 1:m
%     if mod(i,100) == 0
%         fprintf('.');
%     elseif mod(i,10000)==0
%         fprintf('\n');
%     end
%     p1 = pc(i,1:3);
%     r = nei(i,1:neic(i,1));
%     avgd = mean(neid(i,:));
%     sigma = avgd/3;
%     gsigmad = exp((-neid(1,1:neic(i)).^2)./sigma^2);
%     
%     miup(i,:) = sum(repmat(gsigmad',1,3).*pc(r,1:3))/(sum(gsigmad));
%     
%     basisPlane=null(normal(i,:)); %basis for the plane
%     basisCoefficients= bsxfun(@minus,miup(i,:),p1)*basisPlane ;
%     miupproj = bsxfun(@plus,basisCoefficients*basisPlane.', p1);
%     
%     halfdisk(i) = min((pdist([p1;miupproj],'euclidean'))/(4*avgd/(3*pi)),1);
% end

% ==============
% shape criterion

piboundary = zeros(size(pc,1),1);
piinterior = zeros(size(pc,1),1);
picorner = zeros(size(pc,1),1);
piline = zeros(size(pc,1),1);
boundary = zeros(size(pc,1),1);

apiboundary = [2/3 1/3 0];
apiinterior = [1/2 1/2 0];
apicorner = [1/3 1/3 1/3];
apiline = [1 0 0];
centroid = mean([apiinterior; apicorner; apiline]);
sigmaboundary = (1/3)*(pdist([apiboundary;centroid],'euclidean'))^2;
sigmainterior = (1/3)*(pdist([apiinterior;centroid],'euclidean'))^2;
sigmacorner = (1/3)*(pdist([apicorner;centroid],'euclidean'))^2;
sigmaline = (1/3)*(pdist([apiline;centroid],'euclidean'))^2;

for i = 1:m
    p1 = pc(i,1:3);
    r = nei(i,1:neic(i,1));
    if ~isempty(r)
        cp = cov(miup(i)-pc(r,1:3));
        e = eig(cp);
        l2 = e(1);
        l1 = e(2);
        l0 = e(3);
        alpha = l0+l1+l2;
        ap = [l0 l1 l2]/alpha;
        
        d = pdist([ap;apiboundary],'euclidean');
        piboundary(i) = exp(-d^2./sigmaboundary^2);
        
        d = pdist([ap;apiinterior],'euclidean');
        piinterior(i) = exp(-d^2./sigmainterior^2);
        
        d = pdist([ap;apicorner],'euclidean');
        picorner(i) = exp(-d^2./sigmacorner^2);
        
        d = pdist([ap;apiline],'euclidean');
        piline(i) = exp(-d^2./sigmaline^2);
    end
    
    boundary(i) = piboundary(i)./(piinterior(i)+picorner(i)+piline(i));
    
%     cp = 0;
%     for j = 1:neic(i)
%         cpj = cov(miup(i)-pc(j,1:3));
%         cp = cp + cpj;
%     end
end

% ==============
% combining criteria

prob = zeros(size(pc,1),1);
wangle = .3;
whalfdisk = .3;
wboundary = .4;
for i = 1:m
%     prob(i) = angle(i)*.5 + halfdisk(i)*.5;
    prob(i) = angle(i)*wangle + halfdisk(i)*whalfdisk +...
        boundary(i)*wboundary;
end

res = ones(size(pc,1),1);
res(prob>.5)=0;

figure;
% scatter3(pc(1:m,1),pc(1:m,2),pc(1:m,3),1,[prob prob prob]);
scatter3(pc(:,1),pc(:,2),pc(:,3),1,[res res res]); 
view(2);
axis equal;

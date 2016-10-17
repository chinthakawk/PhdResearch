% 20160416
% finding holes in point clouds
% 20160422: update with shape criterion
% 20160429: save biggest angle location and tangent plane, trying to fill
% holes
% 20160511: find 4 biggest angles, and their beginning and ending points

tic;

clc, clear all;

fol = '/Users/mac/Documents/KinectData/102/Den/K1f301/12_findh3/';
name = '1_1437348_rgbd_oo_refined-nR_oP=0.05_pDs=4_pD=3.8519-sr_dis=0.001_np=8-findHoles_neig#=21-fsh_newd=0.001-findh_neig#=20_-fsh_newd=0.001.mat';

fid = fopen(strcat(fol,name(1:numel(name)-4),'-log_',...
    datestr(now,'yyyymmddHHMM'),'.txt'), 'w');

fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol:\t%s',fol);
fprintf(fid,'\nname:\t%s',name);

n = 21; % no of nearest neighbors

load(strcat(fol,name));
m = size(pc,1);
% m = 2;

fprintf(fid,'\n\nsize of point cloud (m):\t%d',m);
fprintf(fid,'\nno of nearest neighbors (n):\t%d',n);

% nei = zeros(size(pc,1),n-1); % to save the neighbors
% neid = zeros(size(pc,1),n-1); % distances to neighbors
% neic = zeros(size(pc,1),1); % to save no of neighbors

load('/Users/mac/Documents/KinectData/102/Den/K1f301/12_findh3/nei.mat');
load('/Users/mac/Documents/KinectData/102/Den/K1f301/12_findh3/neic.mat');
load('/Users/mac/Documents/KinectData/102/Den/K1f301/12_findh3/neid.mat');

neirad = 0.01; % radius of neighbors sphere

fprintf(fid,'\nradius of neighbors sphere (neirad):\t%f',neirad);

% % scatter3(pc(1:m,1),pc(1:m,2),pc(1:m,3),10,pc(1:m,4:6)/255);
% % axis equal;
% % hold on;
% 
% % ==============
% % neighborhood collection
% 
% fprintf('\nneighborhood collection\n');
% 
% [j,d] = knnsearch(pc(:,1:3),pc(:,1:3),'K',n); % neighbors and distances
% j = j(:,2:end);
% d = d(:,2:end);
% 
% for i = 1:m
%     jj = j(i,:);
%     dd = d(i,:);
%     
%     di = find(dd>neirad); % neighbors outside the sphere
%     
%     jj(di) = [];
%     dd(di) = [];
%     nei(i,1:numel(jj)) = jj;
%     neid(i,1:numel(jj)) = dd;
%     neic(i,1) = numel(dd);
% end
% 
% fprintf('\nneighborhood collection updating\n');
% 
% for i = 1:m
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

% ==============
% angle criterion

% scatter3(pc(:,1),pc(:,2),pc(:,3),1,pc(:,4:6)/255);
% scatter3(pc(1:m,1),pc(1:m,2),pc(1:m,3),10,pc(1:m,4:6)/255);
angle = zeros(size(pc,1),1);
g = zeros(size(pc,1),4); % largest angle
gbeg = zeros(size(pc,1),4); % largest angle beginning point
gend = zeros(size(pc,1),4); % largest angle ending point
normal = zeros(size(pc,1),3);

fprintf('\nangle criterion\n');

for i = 1:m
    if mod(i,100) == 0
        fprintf('.');
    elseif mod(i,10000)==0
        fprintf('\n');
    end
%     fprintf('\n%d:',i);
    p1 = pc(i,1:3);
    r = nei(i,1:numel(find(nei(i,:))));
    if ~isempty(r)
        if ~isempty(find(r==0, 1))==1
            ri = find(r==0);
            r(ri) = [];
%             nei(i,ri) = [];
%             neid(i,ri) = [];
            neic(i) = neic(i)-1;
        end
        rnan = (isnan(pc(r,1))==1 | isnan(pc(r,2))==1 |...
            isnan(pc(r,3))==1);
        r(rnan) = [];
        neic(i) = neic(i)-numel(rnan);
        
        
        normal(i,:) = (normnd(pc(r,1:3)))'; % normal of p1
    %     end

    %     syms x y z;
    %     P = [x,y,z];
    %     realdot = @(u, v) u*transpose(v);
    % 
    %     plane = realdot(P-p1,normal'); %dot(normal, P-p1);
    %     zplane = solve(plane, z);
    %     ezmesh(zplane, [min(pc(r,1)), max(pc(r,1)),...
    %         min(pc(r,2)), max(pc(r,2))]);%, hold off
    % %     ezmesh(zplane, 10);
    %     hold on;
    % 
        pro = pc([i r],1:3)*null(normal(i,:));
    %     basisPlane=null(normal'); %basis for the plane
    %     basisCoefficients= bsxfun(@minus,pc(r,1:3),p1)*basisPlane ;
    %     pro = bsxfun(@plus,basisCoefficients*basisPlane.', p1);

    %     scatter3(pc(r,1),pc(r,2),pc(r,3),10,'r');
    %     scatter3(pro(:,1),pro(:,2),pro(:,3),10,'b');
    %     figure;
    % %     hax1 = axes;
    %     scatter(pro(1,1),pro(1,2),'.r');
    %     hold on;
    %     scatter(pro(2:end,1),pro(2:end,2),'.b');
    %     a = (1:numel(r))'; b = num2str(a); c = cellstr(b);
    %     dx = 0.001; dy = 0.001; % displacement so the text does not overlay the data points
    %     text(pro(2:end,1), pro(2:end,2), c);

        ang = zeros(1,numel(r)); % to record angle between neighbors
        angstart = zeros(1,numel(r)); % starting neighbor index for angle
%         angstop = zeros(1,numel(r)); % ending neighbor index for angle

        
        for j = 2:size(pro,1)
            ang(j-1) = mod(atan2(pro(j,2)-pro(1,2),...
                pro(j,1)-pro(1,1)),2*pi)*180/pi;
            angstart(j-1) = r(j-1);
%             fprintf('\t%d',angstart(j-1));
        end

        minang = min(ang);
        maxang = max(ang);
        lastang = 360-maxang+minang;

%         fprintf('\nang');
%         fprintf('\t%.2f',ang);
        
        ang = ang-minang;
%         fprintf('\nang-min');
%         fprintf('\t%.2f',ang);
        [ang, angi] = sort(ang);
%         fprintf('\nangsort');
%         fprintf('\t%.2f',ang);
        angstart = angstart(angi);
%         fprintf('\nangsort');
%         fprintf('\t%d',angstart);
    %     t = text(pro(angi+1,1), pro(angi+1,2), c, 'FontSize',16);
    %     v = get(t,'FontSize');
    %     a(1:numel(v),1) = 12;
    %     set(v,'FontSize',mat2cell(a,2));

    %     fprintf('\t%f',ang);
    %     maxang = max(ang);
        ang = diff(ang);
    %     lastang = max(maxang,360-maxang);
        ang = [ang, lastang];
%         fprintf('\nangdiff');
%         fprintf('\t%.2f',ang);
    %     fprintf('\n');
    %     fprintf('\t%f',ang);
    
        % top1 angle
        [g(i,1), gii] = max(ang);
        gbeg(i,1) = angstart(gii);
        gendi = gii+1;
        if gendi>numel(r)
            gendi = 1;
        end
        gend(i,1) = angstart(gendi);
        
        % top2 angle
        if numel(r)>1
            ang(gii) = 0;
            [g(i,2), gii] = max(ang);
            gbeg(i,2) = angstart(gii);
            gendi = gii+1;
            if gendi>numel(r)
                gendi = 1;
            end
            gend(i,2) = angstart(gendi);
        end
        
        % top3 angle
        if numel(r)>2
            ang(gii) = 0;
            [g(i,3), gii] = max(ang);
            gbeg(i,3) = angstart(gii);
            gendi = gii+1;
            if gendi>numel(r)
                gendi = 1;
            end
            gend(i,3) = angstart(gendi);
        end
        
        % top4 angle
        if numel(r)>1
            ang(gii) = 0;
            [g(i,4), gii] = max(ang);
            gbeg(i,4) = angstart(gii);
            gendi = gii+1;
            if gendi>numel(r)
                gendi = 1;
            end
            gend(i,4) = angstart(gendi);
        end
        
%         fprintf('\ngend = %d',gend(i));
    %     fprintf('\t%f',ang);
    %     fprintf('\t%f\t%d',g(i),gii);

        angle(i) = min((g(i,1)-360/numel(r))/(180-360/numel(r)),1);
    end
    
%     angs = sort(ang);
%     
%     for j = 1:numel(r)
%         
%     end
end

% ==============
% half disk criterion

halfdisk = zeros(size(pc,1),1);
miup = zeros(size(pc,1),3);

fprintf('\nhalf disk criterion\n');
for i = 1:m
    if mod(i,100) == 0
        fprintf('.');
    elseif mod(i,10000)==0
        fprintf('\n');
    end
    p1 = pc(i,1:3);
    r = nei(i,1:neic(i,1));
    avgd = mean(neid(i,:));
    sigma = avgd/3;
    gsigmad = exp((-neid(1,1:neic(i)).^2)./sigma^2);
    
    miup(i,:) = sum(repmat(gsigmad',1,3).*pc(r,1:3))/(sum(gsigmad));
    
    basisPlane=null(normal(i,:)); %basis for the plane
    basisCoefficients= bsxfun(@minus,miup(i,:),p1)*basisPlane ;
    miupproj = bsxfun(@plus,basisCoefficients*basisPlane.', p1);
    
    halfdisk(i) = min((pdist([p1;miupproj],'euclidean'))/(4*avgd/(3*pi)),1);
end

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
        if isnan(cp)
            continue;
        end
        e = eig(cp);
        if numel(e)==1
            continue;
        end
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
wangle = 1/3;
whalfdisk = 1/3;
wboundary = 1/3;

fprintf(fid,'\n\nweight of angle criterion (wangle):\t%f',wangle);
fprintf(fid,'\nweight of half disk criterion (wangle):\t%f',whalfdisk);
fprintf(fid,'\nweight of boundary criterion (wangle):\t%f',wboundary);

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

names = {'angle' 'boundary' 'g' 'gbeg' 'gend' 'halfdisk' 'miup' 'nei'...
    'neic' 'neid' 'normal' 'piboundary' 'picorner' 'piinterior' 'piline'...
    'prob'};

for i = 1:numel(names)
    save(strcat(fol,name(1:numel(name)-4),'-findh_neig#=',...
        num2str(n-1),'_',names{i},'.mat'), names{i});
end

toc;
fprintf(fid,'\n\nElapsed time is %f seconds',toc);

fclose(fid);

fprintf('\ndone\n');

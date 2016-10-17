% 20160501
% used findHoles4 to find holes
% now can we fill small holes detected
% 20160511: added 4 points at the 4 top biggest angles
% 20160517: filling small holes using interpolation

tic;

clc; clear all;

fol = '/Users/mac/Documents/KinectData/102/Den/K1f301/17_fillsh-interpolations_Den_20160517/';
name = '1_1437348_rgbd_oo_refined-nR_oP=0.05_pDs=4_pD=3.8519-sr_dis=0.001_np=8-findHoles_neig#=21-fsh_newd=0.001.mat';

fid = fopen(strcat(fol,name(1:numel(name)-4),'-log_',...
    datestr(now,'yyyymmddHHMM'),'.txt'), 'w');

fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol:\t%s',fol);
fprintf(fid,'\nname:\t%s',name);

load(strcat(fol,name));

acc = 3;
pc = [fix((pc(:,1:3)*10^acc))/10^acc, pc(:,4:6)];

m = size(pc,1);
% m = 100;
m2 = size(pc,1);
pc2 = [pc; zeros(m2,6)];

ms = 3;             % mask size
s = 1*10^(-acc);    % step size of the pc cube
mc = floor(ms/2)*s;

fprintf(fid,'\n\nacc:\t%d',acc);
fprintf(fid,'\npc size:\t%d',m2);
fprintf(fid,'\nmask size (ms):\t%d',ms);
fprintf(fid,'\nstep size of pc cube (s):\t%f',s);

fprintf(fid,'\n\nvalues');
fprintf(fid,'\npoint index');
fprintf(fid,'\nx layer index in the 3d mask cube');
fprintf(fid,'\npoint indexes in that layer');
fprintf(fid,'\nno of points in that layer');
fprintf(fid,'\nnewly introduced points indexes in that layer\n\n');

for i = 1:m
    fprintf('\n%d:',i);
%     fprintf('\t%f',pc(i,:));
    fprintf(fid,'\n%d:',i);
%     p = zeros(ms,ms,ms);
    x = pc(i,1);
    y = pc(i,2);
    z = pc(i,3);
    cx = x-mc:s:x+mc; % pc cube one size
    cy = y-mc:s:y+mc; % pc cube one size
    cz = z-mc:s:z+mc; % pc cube one size
    
    j = 0;
    for xi = 1:ms
%         fprintf('\t%d:',xi);
        fprintf(fid,'\t%d:',xi);
        npoints = 0; % no of points with color values
        colorsum = [0 0 0]; % avg color of the color values
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
%                     fprintf('\t%d',q);
                    fprintf(fid,'\t%d',q);
                    npoints = npoints+1;
                    colorsum = colorsum+pc(q,4:6);
%                     p(xi,yi,zi) = pcg(q,1);
% %                     fprintf('\t%d',pcg(q,1));
                end
            end
        end
        
%         fprintf('\n');
%         fprintf('\t(%d)',npoints);
        fprintf(fid,'\t(%d)',npoints);
        
        coloravg = round(colorsum/npoints,0);
%         fprintf('\t%d',colorsum);
        
        if npoints>0
%             fprintf('e');
            for yi = 1:ms
                for zi = 1:ms
                    cxv = cx(xi); % cube x value
                    cyv = cy(yi); % cube y value
                    czv = cz(zi); % cube z value
%                     q = find(pc(:,1)==cxv & pc(:,2)==cyv & pc(:,3)==czv, 1);
                    q2 = find(pc2(:,1)==cxv & pc2(:,2)==cyv & pc2(:,3)==czv, 1);
                    if isempty(q2)
%                         fprintf('\t%d',q2);                        
                        m2 = m2+1;
%                         fprintf('\t%d',m2);
                        fprintf(fid,'\t%d',m2);
                        pc2(m2,:) = [cxv, cyv, czv,coloravg];

%                         npoints = npoints+1;
%                         coloravg = coloravg+pc(q,4:6);
    %                     p(xi,yi,zi) = pcg(q,1);
    % %                     fprintf('\t%d',pcg(q,1));
                    end
                end
            end
%             fprintf('\n');
        end
%         fprintf('\n');
        fprintf(fid,'\n');
        
    end
    
end

% % figure;
% % scatter3(pc(:,1),pc(:,2),pc(:,3),1,~[res res res]); 
% % view(2);
% % axis equal;

pc = pc2(1:m2,:);
save(strcat(fol,name(1:numel(name)-4),'-fshi_acc=',num2str(acc),...
    '_cube=',num2str(ms),'.mat'),'pc');
% 
% 
fprintf('\n');
fprintf(fid,'\nno. of points in resultant pc = %d',m2);

toc;
fprintf(fid,'\n\nElapsed time (sec) = %f',toc);


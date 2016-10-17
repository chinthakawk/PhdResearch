% 20160322
% mat to super resolution mat
%
% 1. open rgb-d text file. this file contains the relationships of rgb,
% depth, and point cloud files. no. of points = 424*512 = 217,088. And
% convert this file to a matrix
% 2. open the object only mat file (refined, noise removed)
% 3. find the normal for each point
% 4. find the colors in a 3*3 patch
%
% 20160326: can we copy 8 points
% 20160504: updated to handle multiple entries in cr or cc
% 20160506: normalize nor and nor2

tic;

clc, clear all;

fol = '/Users/mac/Documents/KinectData/102/Den/K1f301/05_oP=.05-sr8/';
relationsName = '1_1437348_rgbd.txt';
pcName = '1_1437348_rgbd_oo_refined_nR_oP=0.05_pDs=4_pD=3.8519.mat';
colorName = '1_1437348.jpg';

n = 6; % no of neighbors selected for normal calculation
s = 1;
dis = .001;
step = 1;
np = 8;

fid = fopen(strcat(fol,pcName(1:numel(pcName)-4),'_sr_dis=',...
    num2str(dis),'_np=',num2str(np),'_log.txt'), 'w');

fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol:\t%s',fol);
fprintf(fid,'\nrelationsName:\t%s',relationsName);
fprintf(fid,'\npcName:\t%s',pcName);
fprintf(fid,'\ncolorName:\t%s',colorName);

% 1
fidr = fopen(strcat(fol,relationsName));
C = textscan(fidr,['%f: (rd,cd)=(%f, %f) d=%f (x,y,z)=(%f, %f, %f) ',...
    '(rc,cc)=(%f, %f) (r,g,b)=(%f, %f, %f)'],'TreatAsEmpty',{'-Infinity'});
fclose(fidr);
relations = cell2mat(C);

% 2
load(strcat(fol,pcName));
color = imread(strcat(fol,colorName));
% pc2 = pc;
pc2 = zeros((np+1)*size(pc,1),6);

% 3
m = size(pc,1);

fprintf(fid,'\n\nnumber of neighbors considered to find normal:\t%d',n);
fprintf(fid,'\nsize of poing cloud:\t%d',m);
fprintf(fid,'\ndistance used to place new points:\t%f',dis);
fprintf(fid,'\nnumber of points copied:\t%d',np);

fprintf(fid,'\n\nparameters list');
fprintf(fid,'\n1. point index (i)');
fprintf(fid,'\n2. relations index (ri)');
fprintf(fid,'\n3. corresponding color pixel (row, col)');
fprintf(fid,'\n4. color from the relations file (r, g, b)');
fprintf(fid,'\n5. color from the color image (r, g, b)\n');

% figure;
% hax2 = axes;
% scatter3(hax2,pc(1:step:m,1),pc(1:step:m,2),pc(1:step:m,3),s);
% xlabel('x');
% ylabel('y');
% zlabel('z');

% figure;
% hax1 = axes;
% % scatter3(hax1,pc(1:m,1),pc(1:m,2),pc(1:m,3),1);
% hold on;
% xlabel('x');
% ylabel('y');
% zlabel('z');

k = 0;

for i = 1:step:size(pc,1)
% for i = 1:m
% for i = 1:1
    color2 = zeros(1,3);
    nei = zeros(1,3);
    
%     scatter3(hax1,pc(i,1),pc(i,2),pc(i,3),50,pc(i,4:6)/255,'o');
%     scatter3(hax1,pc(i,1),pc(i,2),pc(i,3),s,pc(i,4:6)/255);
%     drawnow;
%     scatter3(hax1,pc(i,1),pc(i,2),pc(i,3),s);

    p1 = pc(i,1:3);
    [r,~] = knnsearch(pc(1:m,1:3),p1,'K',n);
    
    v = normnd(pc(r,1:3)); % normal of p1
    normal = v;

%     quiver3(hax1,pc(i,1),pc(i,2),pc(i,3),v(1),v(2),v(3),'r');
%     quiver3(hax1,mean(pc(r,1)),mean(pc(r,2)),mean(pc(r,3)),v(1),v(2),v(3),'g');
%     quiver3(hax1,p1(1),p1(2),p1(3),p2(1),p2(2),p2(3),'b');
    clear r;
    
    % lets find the original color coordinates of this point
    
%     ri = find(round(relations(:,5),7)==round(pc(i,1),7) & ...
%         round(relations(:,6),7)==round(pc(i,2),7));
%     fix(X * 10^6)/10^6
    acc = 5;
    ri = find(...
        fix(relations(:,5)*10^acc)/10^acc==fix(pc(i,1)*10^acc)/10^acc & ...
        fix(relations(:,6)*10^acc)/10^acc==fix(pc(i,2)*10^acc)/10^acc);
%         fix(relations(:,7)*10^acc)/10^acc==fix(pc(i,3)*10^acc)/10^acc);
    cr = relations(ri,8)+1;
    cc = relations(ri,9)+1;
    
    fprintf('\ni=%d',i);
    fprintf(fid,'\n%d',i);
    
%     fprintf('\tri=%d',ri);
    if isempty(ri)
        fprintf(fid,'\tnull');
    else
        fprintf(fid,'\t%d',ri);
    end
    
%     fprintf('\t(%d,%d)',cr,cc);
    fprintf(fid,'\t(%d,%d)',cr,cc);
    
%     fprintf('\t(%d,%d,%d)',relations(ri,10),relations(ri,11),relations(ri,12));
    fprintf(fid,'\t(%d,%d,%d)',relations(ri,10),relations(ri,11),relations(ri,12));
    
%     fprintf('\t(%d,%d,%d)',color(cr,cc,1),color(cr,cc,2),color(cr,cc,3));
%     fprintf(fid,'\t(%d,%d,%d)',color(cr,cc,1),color(cr,cc,2),color(cr,cc,3));

    if numel(cr>1)
        cr(2:end) = [];
        cc(2:end) = [];
    elseif isempty(cr) || isempty(cc) || cr<=0 || cc<=0 || cr>size(color,1)...
            || cc>size(color,2)
        fprintf(fid,'\t(%d,%d,%d)',color(cr,cc,1),color(cr,cc,2),color(cr,cc,3));
        k = k+1;
%         disp(k);
        pc2(k,:) = pc(i,:);
        fprintf(fid,'\tignored');
        continue;
    end
    
    nor = find_perp(v);
    nor2 = cross(v, nor);
    
    nor = nor/norm(nor);
    nor2 = nor2/norm(nor2);
    
    % np = 4
    if np==4
        nei(1,:) = p1+nor'*dis;
        nei(2,:) = p1-nor'*dis;
        nei(3,:) = p1+nor2'*dis;
        nei(4,:) = p1-nor2'*dis;
    %     scatter3(hax1,n1(1),n1(2),n1(3),50,pc(i,4:6)/255,'o');
    %     V = null(v').';
    %     P = [.1 0;-.1 0;0 .1;0 -.1]*V;
    %     quiver3(hax1,pc(i,1),pc(i,2),pc(i,3),nor(1),nor(2),nor(3),'g');
    %     syms x y z;
    %     P = [x,y,z];
    %     realdot = @(u, v) u*transpose(v);
    %     
    %     planefunction = realdot(P-p1,normal'); %dot(normal, P-p1);
    %     zplane = solve(planefunction, z);
    %     ezplot3(line(1), line(2), line(3), [-1,3]), hold on
    %     ezmesh(zplane, [2, 8, 2, 8]);%, hold off
    %     ezmesh(zplane, 10);
    %     axis([2, 8, 2, 8, 0, 6]), title ''
        j = 0;
        for r2 = -1:1
            for c2 = -1:1
    %             if ~(r2==0 && c2==0)
    %             if (r2==0 || c2==0)
                if (xor(r2==0,c2==0)==true)
                    j = j+1;
%                     k = k+1;

    %                 fprintf('\n(%d,%d)',cr+r2,cc+c2);
    %                 fprintf('\t(%d,%d,%d)',color(cr+r2,cc+c2,:));
    %                 fprintf('\t(%f,%f,%f)',color(cr+r2,cc+c2,:)/255);

    %                 nor = find_perp(v);
    %                 V = null(v').';
    %                 P = [.1 0;-.1 0;0 .1;0 -.1]*V;
    %                 quiver3(hax1,pc(i,1),pc(i,2),pc(i,3),nor(1),nor(2),nor(3),'g');
    %                 plot3(P(:,1),P(:,2),P(:,3),color(cr+r2,cc+c2,:));

                    color2(j,1) = color(cr+r2,cc+c2,1);
                    color2(j,2) = color(cr+r2,cc+c2,2);
                    color2(j,3) = color(cr+r2,cc+c2,3);

    %                 scatter3(hax1,nei(j,1),nei(j,2),nei(j,3),50,color2(j,:)/3,'o');
                    scatter3(hax1,nei(j,1),nei(j,2),nei(j,3),s,color2(j,:)/255);
    %                 scatter3(hax1,nei(j,1),nei(j,2),nei(j,3),s);
                    drawnow;
    %                 scatter3(hax1,nei(j,1),nei(j,2),nei(j,3),s);
%                     pc2 = [pc2; nei(j,:), color2(j,:)];
%                     pc2(k,)
                end
            end
        end
    
    % np = 4 ends
    elseif np==8
        nei(1,:) = p1+nor'*dis;
        nei(5,:) = p1-nor'*dis;
        nei(3,:) = p1+nor2'*dis;
        nei(7,:) = p1-nor2'*dis;
        
        nei(2,:) = p1+nor'*dis+nor2'*dis;
        nei(4,:) = p1+nor2'*dis-nor'*dis;
        nei(6,:) = p1-nor'*dis-nor2'*dis;
        nei(8,:) = p1-nor2'*dis+nor'*dis;

        j = 0;
        for r2 = -1:1
            for c2 = -1:1
                if ~(r2==0 || c2==0 || (cr+r2)>size(color,1)...
                        || (cc+c2)>size(color,2))
                    j = j+1;
                    k = k+1;
%                     disp(k);
%                     disp(j);
                    if j>8
                        continue;
                    end

                    color2(j,1) = color(cr+r2,cc+c2,1);
                    color2(j,2) = color(cr+r2,cc+c2,2);
                    color2(j,3) = color(cr+r2,cc+c2,3);

%                     scatter3(hax1,nei(j,1),nei(j,2),nei(j,3),s,color2(j,:)/255);
% %                     scatter3(hax1,nei(j,1),nei(j,2),nei(j,3),s);                 
% %                     quiver3(hax1,pc(i,1),pc(i,2),pc(i,3),nei(j,1),nei(j,2),nei(j,3));
%                     drawnow;
                    
%                     pc2 = [pc2; nei(j,:), color2(j,:)];
                    pc2(k,:) = [nei(j,:), color2(j,:)];
                    
                end
            end
        end        
    end
    % np = 8 ends
    
%     scatter3(hax1,n1(1),n1(2),n1(3),50,[1 0 0],'o');
%     scatter3(hax1,n2(1),n2(2),n2(3),50,[0 1 0],'o');
%     scatter3(hax1,n3(1),n3(2),n3(3),50,[0 0 1],'o');
%     scatter3(hax1,n4(1),n4(2),n4(3),50,[1 0 1],'o');
%     scatter3(P(:,1),P(:,2),P(:,3),5,color2/255,'filled');
%     clear color2;
end

% pc = [pc; pc2];
% pc = pc2;
pc = pc2(1:k,:);
save(strcat(fol,pcName(1:numel(pcName)-4),'-sr_dis=',num2str(dis),...
    '_np=',num2str(np),'.mat'),'pc');

toc;
fprintf(fid,'\n\nElapsed time is %f seconds',toc);

fclose(fid);

fprintf('\ndone\n');
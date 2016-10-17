% 20150416
% this file creates boundary, bounded surface and displays both
% surface looks good, originals colors now can be applied
% for the paper purposes
% 20160202 update: selected only 4 views, triangles, colors, interpolated
% colors

clc;
clear all;

fol = '/Users/mac/Documents/KinectData/Lab2/20160129/Minnie/08_boundarySurface/';
name = '12345678_nR_oP=0.01_pD=26.mat';
file = strcat(fol,name);
load(file);

pcOrg = pc;
pc = pc(:,1:3);

maxW = max(max(pc)-min(pc));
for i = 1:3
    pc(:,i)=.15+(pc(:,i)-min(pc(:,i)))*0.7/maxW;
end

% plot3(pc(:,1),pc(:,2),pc(:,3),'.')

tri = boundary(pc,1);

% triP = unique(reshape(tri,[],1));

for i=1:size(tri,1)
    color(i,:) = ((pcOrg(tri(i,1),4:6)+pcOrg(tri(i,2),4:6)+...
        pcOrg(tri(i,3),4:6))/3)/255;
end

clear cdata;
cdata = pcOrg(:,4:6)/255;

% figure;

a = [0 90 180 270];
% el = [0 90 180 270];

for i = 1:4
	az = 270;
    el = a(i);

    % wireframe
    figure;
    h1 = trisurf(tri,pc(:,1),pc(:,2),pc(:,3),'FaceAlpha',.75,...
        'Facecolor','red','EdgeColor','c');
    axis equal;
    xlabel('x'); ylabel('y'); zlabel('z');
    view([az el]);
    camup([0 1 0]);
    h1name = strcat('wireframe. (view: ','[',num2str(az),',',...
        num2str(el),'])');
    title(h1name);
    saveas(h1, strcat(fol,h1name,'.jpg'));

    % surface color
    figure;
    h2 = trisurf(tri,pc(:,1),pc(:,2),pc(:,3),...
        'FaceVertexCData',cdata,'edgeColor','none');
    axis equal;
    xlabel('x'); ylabel('y'); zlabel('z');
    view([az el]);
    camup([0 1 0]);
    h2name = strcat('surface color. (view: ','[',num2str(az),',',...
        num2str(el),'])');
    title(h2name);
    saveas(h2, strcat(fol,h2name,'.jpg'));
    
    % surface color interpolation
    figure;
    h3 = trisurf(tri,pc(:,1),pc(:,2),pc(:,3),'FaceVertexCData',...
        cdata,'FaceColor','interp','edgeColor','none');
    axis equal; %grid on;
    xlabel('x'); ylabel('y'); zlabel('z');
    view([az el]);
    camup([0 1 0]);
    h3name = strcat('surface color interpolated. (view: ','[',...
        num2str(az),',',num2str(el),'])');
    title(h3name);
    saveas(h3, strcat(fol,h3name,'.jpg'));
end

fMatToPlyWithRgbWithPolygonOneFile(fol,name,pcOrg,tri)

clear i maxW

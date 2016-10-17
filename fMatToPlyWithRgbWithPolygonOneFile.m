function fMatToPlyWithRgbWithPolygonOneFile(fol,fileName,pc,tri)
    % 20150321
    % inputs: points cloud saved in mat
    % output: points cloud with xyz and rgb as a ply file
    % 20160202 update: include face information

    step = 1;

    folder = fol;
%     disp(fileName);
%     load(strcat(folder, fileName));

    dataAll = pc;
    tri = tri - 1;

    fid = fopen(strcat(folder, fileName(1:numel(fileName)-4),...
        '_withPolygon.ply'), 'w');

    fprintf(fid, 'ply\n');
    fprintf(fid, 'format ascii 1.0\n');
    
    fprintf(fid, 'element vertex %d\n', length(1:step:size(dataAll,1)));
    fprintf(fid, 'property float x\n');
    fprintf(fid, 'property float y\n');
    fprintf(fid, 'property float z\n');
    fprintf(fid, 'property uchar red\n');
    fprintf(fid, 'property uchar green\n');
    fprintf(fid, 'property uchar blue\n');
    fprintf(fid, 'property uchar alpha\n');
    
    fprintf(fid, 'element face %d\n', length(1:step:size(tri,1)));
    fprintf(fid, 'property list uchar int vertex_index\n');
    fprintf(fid, 'end_header');

    for r=1:step:size(dataAll,1)
        fprintf(fid, '\n%f %f %f %d %d %d 0',...
            dataAll(r,1), dataAll(r,2), dataAll(r,3),...
            dataAll(r,4), dataAll(r,5), dataAll(r,6));
    end
    
    for r=1:step:size(tri,1)
        fprintf(fid, '\n3 %d %d %d',...
            tri(r,1), tri(r,2), tri(r,3));
    end

    fclose(fid);

    disp('done');
end
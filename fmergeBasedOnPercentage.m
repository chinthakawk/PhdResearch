function fmergeBasedOnPercentage(pc1, pc2, corr, mP, fileID, fol,...
    result, withColor)
    % 20160120
    % merge points or delete points based on a user given percentage
    
    % ===============
    % merging duplicates based on a threshold
    pc1mp = pc1; % pc1 merged points
    pc2mp = pc2;
    corrD = pdist2(pc1mp(corr(:,1),1:3),pc2mp(corr(:,2),1:3),'euclidean');
    corrD = diag(corrD); % corrD: distances between corresponding pairs
%     meanCD = mean(corrD);

    nbins = numel(unique(corrD));
    fprintf('\nnbins: %d', nbins);
    hm = min(unique(corrD));
    fprintf('\nhm: %f', hm);
%     h = histc(corrD, nbins);
%     [N,edges] = histcounts(X)
    [h, ~] = histcounts(corrD, nbins);
%     fprintf('\nh: %f', h);
    % stem(h,'b')

    p = zeros(nbins,1);

    for j = 1:nbins
        p(j,1) = h(j)/sum(h);
    end
    P = cumsum(p);
    
%     fprintf('\nP: %f', P);
    
    corrDU = unique(corrD);
    mD = corrDU(find(P<=mP,1,'last')); % mD: merging distance threshold
    fprintf('\nmD: %f', mD);
    
    fprintf(fileID,'\n\nmerging of the corresponding pairs');
    fprintf(fileID,'\n\n\tmerging probability (mP):\t%f',mP);
    fprintf(fileID,'\n\tmerging distance threshold (mD):\t%f', mD);
    
    % saving histogram
    figure;
    h1 = histogram(corrD,numel(corrD));
    title(strcat('Intra-pair distance',...
        '  mP=', num2str(mP),...
        '  mD=', num2str(mD)));
    xlabel('Inter-pair distance');
    ylabel('Frequency');
    xlim([hm max(corrDU)]);
    hold on;
    line([mD mD], ylim, 'Color','r');

    if withColor == 0
        saveas(h1, strcat(fol,result,...
            '_intra-pairHist_mP=',num2str(mP),...
            '_mD=',num2str(mD),'.jpg'));
    elseif withColor == 1
        saveas(h1, strcat(fol,result,...
            '_intra-pairHist_mP=',num2str(mP),...
            '_mD=',num2str(mD),'_icpWithColor.jpg'));
    end

    % saving: if intra-pair d > th, we remove both, else merge both
    % th is the meanCD
    corr1 = corr;
    corr1g = corr1(corrD>mD,:); % > values, deleted points
    corr1l = corr1(corrD<=mD,:); % <= values, merged points
    pc1mp1 = pc1mp;
    pc2mp1 = pc2mp;
    
    fprintf(fileID,'\n\n\tno. of points in source:\t%d', size(pc2,1));
    fprintf(fileID,'\n\tno. of points in target:\t%d', size(pc1,1));
    fprintf(fileID,'\n\n\tno. of deleted pairs:\t%d', size(corr1g,1));
    fprintf(fileID,'\n\tno. of merged pairs:\t%d', size(corr1l,1));
    fprintf(fileID,'\n\tno. of correspoding pairs:\t%d', size(corr,1));
    % merged point coordinates
    pc12mp1 = (pc1mp1(corr1l(:,1),1:3)+pc2mp1(corr1l(:,2),1:3))/2; 
    % source: green, deleted duplicates: red, merged duplicates: majenta
    % target: yellow, deleted duplicates: blue, merged duplicates: majenta
    pc1mp1(:,4) = 255; % all points in yellow
    pc1mp1(:,5) = 255;
    pc1mp1(:,6) = 0;
    pc1mp1(corr1g(:,1),4) = 0; % deleted points in blue
    pc1mp1(corr1g(:,1),5) = 0;
    pc1mp1(corr1g(:,1),6) = 255;
    pc1mp1(corr1l(:,1),:) = []; % merged points removed
    pc2mp1(:,4) = 0; % all points in green
    pc2mp1(:,5) = 255;
    pc2mp1(:,6) = 0;
    pc2mp1(corr1g(:,2),4) = 255; % deleted points in red
    pc2mp1(corr1g(:,2),5) = 0;
    pc2mp1(corr1g(:,2),6) = 0;
    pc2mp1(corr1l(:,2),:) = []; % merged points removed
    pc12mp1(:,4) = 255;
    pc12mp1(:,5) = 0;
    pc12mp1(:,6) = 255;
    pc = [pc1mp1; pc2mp1; pc12mp1];
    
    if withColor == 0
        save(strcat(fol,result,...
            '_mP=',num2str(mP),...
            '_markedDuplicatesSourceGreenRedTargetYellowBlue_magenta_merged.mat'),...
            'pc');
    elseif withColor == 1
        save(strcat(fol,result,...
            '_mP=',num2str(mP),...
            '_markedDuplicatesSourceGreenRedTargetYellowBlue_magenta_merged_icpWithColor.mat'),...
            'pc');
    end

    % saving: if intra-pair d > th, we remove both, else merge both
    % th is the meanCD
    pc1mp2 = pc1mp;
    pc2mp2 = pc2mp;
    % merged points points
    pc12mp2p = (pc1mp2(corr1l(:,1),1:3)+pc2mp2(corr1l(:,2),1:3))/2;
    % merged points colors
    pc12mp2c = round((pc1mp2(corr1l(:,1),4:6)+pc2mp2(corr1l(:,2),4:6))/2,0);
    pc12mp2 = [pc12mp2p pc12mp2c];
    % visible only merged duplicates
    pc1mp2(corr1(:,1),:) = []; % merged points removed
    pc2mp2(corr1(:,2),:) = []; % merged points removed
    pc = [pc1mp2; pc2mp2; pc12mp2];
    
    if withColor == 0
        save(strcat(fol,result,...
            '_mP=',num2str(mP),...
            '_mergedSomeDuplicates.mat'), 'pc');
    elseif withColor == 1
        save(strcat(fol,result,...
            '_mP=',num2str(mP),...
            '_mergedSomeDuplicates_icpWithColor.mat'), 'pc');
    end

end
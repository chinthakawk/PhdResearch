function [b, pD] = fNoiseRemovalPointDensityCal(fol, name, oP)
    % 20151130
    % how to remove the noises in the clouds, can we try with eucledian
    % change the density parameter based on the z value
    % 20150117: changed to use static point density pD

    fol2 = fol;
    
    file = strcat(fol, name);

    load(strcat(fol, name));

    fileID = fopen(strcat(fol2,name(1:numel(name)-4),'_oP=',num2str(oP),...
        '-log_',datestr(now,'yyyymmddHHMM'),'.txt'),'w');
    fprintf(fileID,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
    fprintf(fileID,'\n\ndensity calculation for noise removal');
    fprintf(fileID,'\n\nfile:\t%s', strcat(fol, name));

    b = max(mean(abs(diff(pc(:,1:3)))));

    fprintf(fileID,'\nsearch cube size (b):\t%f', b);

    fprintf(fileID,'\noutlier percentage:\t%f', oP);

    density = zeros(size(pc,1),1);
    noise = [];
    zmin = min(pc(:,3));
    zmax = max(pc(:,3));

    i = 1;
    while i <= size(pc,1)
        x = pc(i,1);
        y = pc(i,2);
        z = pc(i,3);
        xl = x-b;
        xh = x+b;
        yl = y-b;
        yh = y+b;
        zl = z-b;
        zh = z+b;

        [r, c] = find(pc(:,1)>xl & pc(:,1)<xh & pc(:,2)>yl & pc(:,2)<yh ...
            & pc(:,3)>zl & pc(:,3)<zh); 

        density(i,1) = numel(r);

        i = i+1;
    end
    
    nbins = numel(unique(density));
    hm = min(unique(density));
    h = histc(density, (hm:nbins));
    % stem(h,'b')

    p = zeros(nbins,1);

    for j = 1:nbins
        p(j,1) = h(j)/sum(h);
    end
    P = cumsum(p);

    pD = hm + find(P<oP,1,'last') - 1;
    fprintf(fileID,'\npoint density:\t\t%f', pD);

    figure;
    h1 = histogram(density, (hm:nbins));
    title(strcat(name, '     oP=', num2str(oP), '     b=', num2str(b),...
        '     pD=', num2str(pD)),'interpreter','none');
    xlabel('Points density');
    ylabel('Frequency');
    hold on;
    line([pD pD], ylim, 'Color','r');

    saveas(h1, strcat(fol2,name(1:numel(name)-4),'_oP=',num2str(oP),'.jpg'))

    fprintf('\n');
end

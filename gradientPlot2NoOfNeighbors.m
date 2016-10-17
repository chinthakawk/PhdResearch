% 20160407
% plot no. of valid neighbors found in 3d gradient

x = [1,1000:1000:10000];

p = [2  3   6   4
     2  8   23  29
     7  17  34  49
     5  12  16  21
     6  18  30  69
     2  8   13  16
     14 25  41  37
     4  4   15  32
     5  15  25  22
     4  9   25  37
     10 12  35  77];

pz = 14;
figure;
% set(gca,'DefaultTextFontSize',pz);
% set(gca,'DefaultTextFontSize',14)
bar(x,p); %,x,p50(:,2),x,p50(:,3),x,p50(:,4));
set(gca,'ygrid','on');
% set(gca,'yminorgrid','on');
% set(gca,'ytick',[0:1:25]);
% xlim([1 10000]);
% ylim([0 5.1]);
xlabel('Point ID');
ylabel('No. of valid neighbors');
title('No. of valid neighbors vs Sobel mask size');
legend('3x3x3','5x5x5','7x7x7','9x9x9');
set(findall(gcf,'-property','FontSize'),'FontSize',pz)
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize','default')


q = round((p./repmat([3^3 5^3 7^3 9^3],11,1))*100,2);

figure;
% set(gca,'DefaultTextFontSize',pz);
bar(x,q); %,x,p50(:,2),x,p50(:,3),x,p50(:,4));
set(gca,'ygrid','on');
% set(gca,'yminorgrid','on');
% set(gca,'ytick',[0:1:25]);
% xlim([1 10000]);
% ylim([0 5.1]);
xlabel('Point ID');
ylabel('Percentage of neighbors');
title('Percentage of neighbors vs Sobel mask size');
legend('3x3x3','5x5x5','7x7x7','9x9x9');
set(findall(gcf,'-property','FontSize'),'FontSize',pz)
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize','default')
% set(gca,'DefaultTextFontSize',pz);

% ax = gca;
% % ax.XTick = x;
% grid on;
% 
% legend('Confidence','Data','Level','Priority',...
%     'Location','east');
% 
% p(1).Marker = 'd';
% p(1).LineStyle = '-';
% p(1).Color = 'b';
% p(1).MarkerFaceColor = 'b';
% 
% p(2).Marker = 'square';
% p(2).LineStyle = ':';
% p(2).Color = 'r';
% p(2).MarkerFaceColor = 'r';
% 
% p(3).Marker = '^';
% p(3).LineStyle = '-.';
% p(3).Color = 'g';
% p(3).MarkerFaceColor = 'g';
% 
% p(4).Marker = 'o';
% p(4).LineStyle = '--';
% p(4).Color = 'm';
% p(4).MarkerFaceColor = 'm';

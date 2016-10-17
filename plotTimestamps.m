% 20160728
% plot timestamps

clear all; clc;

cam = [1,2,3,4,5,7,8];

% for i = 1:numel(cam)
path = 'E:\Shared\519\20160727\Chinthaka\01_Extracted\';
files = dir(strcat(path, '*.ply'));

% filename = strcat(path, 'names.xlsx');

n1 = [];
n2 = [];
n3 = [];
n4 = [];
n5 = [];
n6 = [];
n7 = [];
n8 = [];

for f = 1:numel(files)
    name = files(f).name;
    if str2double(name(1))==1
        n1 = [n1; str2double(name(3:9))];
    elseif str2double(name(1))==2
        n2 = [n2; str2double(name(3:9))];
    elseif str2double(name(1))==3
        n3 = [n3; str2double(name(3:9))];
    elseif str2double(name(1))==4
        n4 = [n4; str2double(name(3:9))];
    elseif str2double(name(1))==5
        n5 = [n5; str2double(name(3:9))];
    elseif str2double(name(1))==6
        n6 = [n6; str2double(name(3:9))];
    elseif str2double(name(1))==7
        n7 = [n7; str2double(name(3:9))];
    elseif str2double(name(1))==8
        n8 = [n8; str2double(name(3:9))];
    end
end
% end

n = [n1 n2 n3 n4 n5 n6 n7 n8];

% xlswrite(filename,n);

plot(n1,1);

% p = plot(x,p50(:,1),x,p50(:,2),x,p50(:,3),x,p50(:,4));
% hold on;
% xlim([1 54]);
% ylim([0 5.1]);
% xlabel('Iteration');
% ylabel('Value (in log scale)');
% 
% ax = gca;
% % ax.XTick = x;
% grid on;
% 
% % legend('Confidence','Data','Level','Priority',...
% %     'Confidence','Data','Level','Priority',...
% %     'Location','east');
% 
% % p(1).Marker = 'd';
% p(1).LineStyle = '-';
% p(1).Color = 'b';
% p(1).MarkerFaceColor = 'b';
% 
% % p(2).Marker = 'square';
% p(2).LineStyle = '-';
% p(2).Color = 'r';
% p(2).MarkerFaceColor = 'r';
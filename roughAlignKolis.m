% 20150506
% rough alignment of two clouds based on 4 user inputs
% 20160125

clear all;

A = [	0.122829,-0.0386006,0.636;
        0.0632297,0.0528108,0.611;
        0.033034,0.067376,0.607;
        -7.34253e-05,0.0557287,0.606;
        -0.0332685,0.0177613,0.608;
        0.0325693,-0.0287538,0.64973];
    
B = [	0.129609,-0.0106579,0.634971;
        0.0371001,0.0520143,0.614971;
        0.00119701,0.0522932,0.602971;
        -0.0193635,0.0242957,0.595971;
        -0.0365904,-0.0190214,0.607971;
        0.0325693,-0.0287538,0.64973];

R = [1 0 0;
    0 1 0;
    0 0 1];
t = zeros(3,1); % random translation

n = size(A,1);

[ret_R, ret_t] = rigid_transform_3D(B, A);

B2 = (ret_R*B') + repmat(ret_t, 1, n);
B2 = B2';

% % Find the error
% err = A2 - B;
% err = err .* err;
% err = sum(err(:));
% rmse = sqrt(err/n);

% disp(sprintf('RMSE: %f', rmse));
% disp('If RMSE is near zero, the function is correct!');
labels = cellstr( num2str([0:5]') );

plot3(A(:,1),A(:,2),A(:,3),'ro',...
    B(:,1),B(:,2),B(:,3),'go',...
    B2(:,1),B2(:,2),B2(:,3),'bx');
view(0, 90);
legend('A', 'B', 'B2');
xlabel('X');
ylabel('Y');
zlabel('Z');
% hold on;
% text(A(:,1), A(:,2), labels, 'VerticalAlignment','bottom', ...
%                              'HorizontalAlignment','right')

disp([ret_R, ret_t]);

% n = size(pc2,1);
% pc2t = (ret_R*pc2(:,1:3)') + repmat(ret_t, 1, n);
% pc2 = [pc2t' pc2(:,4:6)];

% save(strcat(fol,name2(1:numel(name2)-4),'_roughAligned.mat'), 'pc2');
% load hald;
[pc,score,latent,tsquare] = princomp(A);
figure;
biplot(pc(:,1:2),'Scores',score(:,1:2))
text(A(:,1), A(:,2), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
                         

[pc,score,latent,tsquare] = princomp(B);
figure;
biplot(pc(:,1:2),'Scores',score(:,1:2))
text(B(:,1), B(:,2), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')



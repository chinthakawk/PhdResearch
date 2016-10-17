function [mx, my, mz] = fSobelCalculator()
% 20160411
% what is the correct sobel filter

% https://en.wikipedia.org/wiki/Sobel_operator

% clc; clear all;
% h(-1)=1, h(0)=2, h(1)=1 
h1 = [1 2 1];
% h'(-1)=1, h'(0)=0, h'(1)=-1
h2 = [1 0 -1];

%h'_x(x,y,z)=h'(x)h(y)h(z)
my = zeros(3,3,3); % hr
for r=1:3
    for c=1:3
        for z=1:3
            my(r,c,z) = h2(r)*h1(c)*h1(z);
        end
    end
end

mx = zeros(3,3,3); % hc
for r=1:3
    for c=1:3
        for z=1:3
            mx(r,c,z) = h1(r)*h2(c)*h1(z);
        end
    end
end

mz = zeros(3,3,3); % hz
for r=1:3
    for c=1:3
        for z=1:3
            mz(r,c,z) = h1(r)*h1(c)*h2(z);
        end
    end
end

end
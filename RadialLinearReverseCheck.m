% This file is to produce the image for checking the radiometric calibration
% and details of checking if the radiometric calibration is successful
% The plot should be linear
% Author: Chongzhao Mao

path = 'patch.mat';
patchCheck = load(path);

% normalization
patchCheck = (patchCheck-min(patchCheck))/(max(patchCheck)-min(patchCheck));
x = (0:255)/255;

% find the corresponding intensity
for jj = 1:256
    y = patchCheck;
    y = abs(y - x(jj));
    value(jj) = find(y == min(y))-1;
end

% this plot should be the y = x symetric to the patch plot
figure, plot(0:255, value(1:256));

% normalization
value = value/255;

% write into the image for projector
for i = 1:256
    image = ones(1500,2000)*value(i);
    s = strcat('C', num2str(i), '.tiff');   `
    imwrite(image, s);
    i
end

% capture the images and use Radial Calibration.m to plot
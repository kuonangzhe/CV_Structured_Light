% This file is written to check the camera parameters are proper that
% the image captured of some fixed intensity will have intensity be proportioanl 
% to the exposure time with no saturation(bend) or weird relationship
% Author: Chongzhao Mao

% test setting
intensityCheck  =   80;                 % image intensity
fileName        =   'IMG_XXXX.tiff';    % any image captured
patchSize       =   100;                % size of patch for calculation
row             =   3456;               % row number of image you want to create
col             =   5184;               % column number of image you want to create
startImage      =   172;                % in SD card of camera, series number that you want to start
endImage        =   194;                % end
expTimeStart    =   1.3;                % exposure time you want check, mostly from 1.3 to 1/100;
expTimeEnd      =   1/100;

patchNum        =   endImage - startImage + 1;
expTimeAll = [8, 6, 5, 4, 3.2, 2.5, 2, 1.6, 1.3, 1, 0.8, 0.6, 0.5, 0.4, 0.3, 1/4, 1/5, 1/6, 1/8, 1/10, 1/13, 1/15, 1/20, 1/25, 1/30, 1/40, 1/50, 1/60, 1/80, 1/100, 1/125, 1/160, 1/200, 1/250, 1/320, 1/400, 1/500, 1/640, 1/800, 1/1000, 1/1250, 1/1600, 1/2000, 1/2500, 1/3200, 1/4000];
expT            =   expTimeAll(find((expTimeAll == expTimeStart)):find((expTimeAll == expTimeEnd)));

% create an image for projector to project
imageCheck      =   ones(3456, 5184)*intensityCheck;
imwrite(uint8(x), 'image.bmp');

% patch setting
I               =   rgb2gray(imread(fileName));
[height, width] =   size(I);
y1              =   floor(height/2) - patchSize;
y2              =   floor(height/2) + patchSize;
x1              =   floor(width/2) - patchSize;
x2              =   floor(width/2) + patchSize;

% calculate mean value of patches
patch           =   zeros(patchNum,1);
ind             =   0;
for i   = startImage:endImage
    s   = strcat('IMG_', num2str(i), '.tiff');
    I   = im2double(rgb2gray(imread(s)));
    ind = ind + 1;
    patch(ind) = double(mean2(I(y1:y2,x1:x2)));
    ind
end

% plot the patch vs expT
plot(expT, patch);
xlabel('exposure time')
ylabel('scaled intensity value')

% Then if you like you can add fitting on plot
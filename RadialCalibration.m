% This scipt is to calculate the patch values of 256 images from intensity
% 0 to 255 and get the plot of gray original, gray, rgb, r, g, b
% Author: Chongzhao Mao

% deal with the 256 images captured from projector
% or check if the aperture and shutter speed is ok
firstImage = 'IMG_5704.tiff';
check = imread(firstImage);
[m,n] = size(rgb2gray(check));
mm = ceil(m/2); nn = ceil(n/2);

% initialize the patch of gray and rgb
patch = zeros(256,1);
patchR = zeros(256, 1);
patchG = zeros(256, 1);
patchB = zeros(256, 1);

% duplicate images
duImage = [5706, 5783];

% startp and endp are the start point and end point
startp = 5900;
endp = 5961;
index = 1;
%zero is used when the sery number of image is not 4 digit
%zero = '0';
%zeros = '000';
for i = startp:endp
    if any(duImage == i)
        continue
    end
    nameID = num2str(i);
    %if length(nameID) == 3
    %    nameID = strcat(zero, nameID);
    %elseif length(nameID) == 2
    %    nameID = strcat(zero, zero, nameID);
    %elseif length(nameID) == 1
    %    nameID = strcat(zeros, nameID);
    %end
    s = strcat('IMG_', nameID, '.tiff');
    image = im2double(imread(s));
    patchR(index) = mean2(squeeze(image(mm:(mm+200), nn:(nn+200), 1)));
    patchG(index) = mean2(squeeze(image(mm:(mm+200), nn:(nn+200), 2)));
    patchB(index) = mean2(squeeze(image(mm:(mm+200), nn:(nn+200), 3)));
    image = rgb2gray(image);
    patch(index) = mean2(image(mm:(mm+200), nn:(nn+200)));
    index = index + 1;

    index
end


% plot original gray patch
plot(patch),xlabel('Projected index from 180 to 240'), ylabel('Captured intensity');

% normalize
patch = (patch-min(patch))/(max(patch)- min(patch));
patchR = (patchR-min(patchR))/(max(patchR)- min(patchR));
patchG = (patchG-min(patchG))/(max(patchG)- min(patchG));
patchB = (patchB-min(patchB))/(max(patchB)- min(patchB));

range = 0:1:255;
% plot gray patch in [0, 1]
figure,     plot(range, patch), xlabel('Projected intensity'), ylabel('Captured intensity(scaled)');

% plot rgb together in [0, 1]
figure,     plot(range, patchR, 'red', x, patchG, 'green', x, patchB, 'blue'),    
            legend('Red', 'Green', 'Blue');
            xlabel('projected intensity'), ylabel('original intensity')

% plot r g b seperatey in [0, 1]                     
figure,     plot(range, patchR, 'red'), legend('Red');xlabel('projected intensity'), ylabel('original intensity')
figure,     plot(range, patchG, 'green'), legend('green'), xlabel('projected intensity'), ylabel('original intensity')
figure,     plot(range, patchB, 'blue'), legend('blue'), xlabel('projected intensity'), ylabel('original intensity')
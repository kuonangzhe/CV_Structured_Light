% This script is to %generate 256 images of intensity 0 - 255
% Author: Chongzhao Mao

size1 = 1000;
size2 = 1500;
dir = 'MATLAB/';
for i = 0:255
    i
    image = ones(size1, size2)*i/255;
    s = strcat(dir, num2str(i), '.tiff');
    imwrite(image, s);
end

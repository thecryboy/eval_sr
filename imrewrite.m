
% SET data dir
sourcedir = '/media/server-248/SSD/AIM_Dataset/AIM_Original_test';
savedir = '/media/server-248/SSD/AIM_Dataset/AIM_Original_gray';
% saveHRpath = fullfile(savedir, '', ['x' num2str(scale)]);



if ~exist(savedir, 'dir')
    mkdir(savedir);
end


filepaths = [dir(fullfile(sourcedir, '*.dcm'));dir(fullfile(sourcedir, '*.bmp'));dir(fullfile(sourcedir, '*.png'))];

for i = 1 : length(filepaths)
    
    filename = filepaths(i).name;
    fprintf('No.%d -- Processing %s\n', i, filename);
    [add, im_name, type] = fileparts(filepaths(i).name);    
    I = imread(fullfile(sourcedir, filename));
    I = rgb2gray(I);

    savefile = strcat(im_name, '.png');
    imwrite(I, fullfile(savedir, savefile));
end

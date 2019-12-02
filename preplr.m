clear;close all;
%% settings
folder = '/home/tangrui/Desktop/ADNI_ALL/ADNI100/x2_squared_mod_x4';
savepath = '/home/tangrui/Desktop/ADNI_ALL/ADNI100/x4_LR/';
scale = 4;

%%gt_path = [savepath, '/gt'];
% input_path = [savepath, '/bicubic'];


%%if(isdir(gt_path) == 0)
%%    mkdir(gt_path);
%%end
if(isdir(savepath) == 0)
    mkdir(savepath);
end

%% generate data
filepaths = dir(fullfile(folder,'*.png'));
count = 1
for i = 1 : length(filepaths)
    fprintf(num2str(i));
    fprintf('\n');
    im_gt = imread(fullfile(folder,filepaths(i).name));
    %%im_gt = modcrop(im_gt, scale); 
    im_input = imresize(im_gt, 1/scale, 'bicubic');
%     im_output = imresize(im_input, scale, 'bicubic');
    %%gt_name = [gt_path, '/', filepaths(i).name];
    input_name = [savepath, '/', filepaths(i).name];
    %%imwrite(im_gt, gt_name);
    imwrite(im_input, input_name);
    count = count +1 ;
end
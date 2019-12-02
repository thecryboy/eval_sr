clear;close all;
%% settings
folder = '/home/tangrui/Desktop/ANDI_ALL/ANDI';

HRpath = '/home/tangrui/Desktop/ANDI_ALL/LRHR/HR/x4';
LRpath = '/home/tangrui/Desktop/ANDI_ALL/LRHR/LR/x4';
SRpath = '/media/tangrui/data/eval_SR/SR/BI/Bicubic/ADNI/x2'
scale = 2;

%%gt_path = [savepath, '/gt'];
%%input_path = [savepath, '/bicubic'];


%%if(isdir(gt_path) == 0)
%%    mkdir(gt_path);
%%end
%%if(isdir(input_path) == 0)
%%    mkdir(input_path);
%%end

%% generate data
filepaths = []
filepaths = [filepaths; dir(fullfile(folder, '*.png'))];

count = 1
for i = 1 : length(filepaths)
    fprintf(num2str(i));
    fprintf('\n');
    im_gt = imread(fullfile(folder,filepaths(i).name));
    if size(im_gt, 3) == 1
        im_gt = cat(3, im_gt, im_gt, im_gt);
    end
    %%im_gt = double(im_gt);
    im_gt = modcrop(im_gt, scale); 
    im_gt = single(im_gt)/255;
    im_lr = imresize(im_gt, 1/scale, 'bicubic');
    im_sr = imresize(im_lr, scale, 'bicubic');
    
    im_sr = shave(uint8(im_sr * 255), [scale, scale]);
    
    
    %%im_input = imresize(im_gt, 1/scale, 'bicubic');
    %%im_output = imresize(im_input, scale, 'bicubic');
    %%gt_name = [gt_path, '/', filepaths(i).name];
    %%input_name = [input_path, '/', filepaths(i).name];
    %%imwrite(im_gt, gt_name);
    %%imwrite(im_output, input_name);
    HR_name = [HRpath, '/', num2str(count), '.png'];
    LR_name = [LRpath, '/', num2str(count), '.png'];
    SR_name = [SRpath, '/',filepaths(i).name];
    
    %%imwrite(im_gt, HR_name);
    %%imwrite(im_lr, LR_name);
    imwrite(im_sr,SR_name);
    count = count +1 ;
end
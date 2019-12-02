clear;close all;
%% settings
folder = '/home/tangrui/Desktop/ADNI_ALL/ADNI100/x2_squared_mod_x4';
savepath = '/home/tangrui/Desktop/ADNI_ALL/ADNI100-3D/x4_HR';

%%if(isdir(gt_path) == 0)
%%    mkdir(gt_path);
%%end
% if(isdir(input_path) == 0)
%     mkdir(input_path);
% end

%% generate data
filepaths = dir(fullfile(folder,'*.png'));
count = 1
for i = 1 : length(filepaths)
   fprintf(num2str(i));
   fprintf('\n');
%     im_gt = imread(fullfile(folder,filepaths(i).name));
%     %%im_gt = modcrop(im_gt, scale); 
%     im_input = imresize(im_gt, 1/scale, 'bicubic');
%     im_output = imresize(im_input, scale, 'bicubic');
%     %%gt_name = [gt_path, '/', filepaths(i).name];
%     input_name = [input_path, '/', filepaths(i).name];
%     %%imwrite(im_gt, gt_name);
%     imwrite(im_output, input_name);
%     count = count +1 ;
    im_ori = imread(fullfile(folder,filepaths(i).name));
    if size(im_ori, 3) == 1
        im_ori = cat(3, im_ori, im_ori, im_ori);
    end
%     output_name = [savepath, '/', filepaths(i).name];
%     output_name = [savepath, '/', filepaths(i).name(1:end-4),'.png'];
    output_name = [savepath, '/', filepaths(i).name];
    imwrite(im_ori, output_name);
end

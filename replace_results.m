function replace_results()

clear all; close all; clc
% dbstop if error

%% set path
degradation = 'BI'; % BI, BD
methods = {'SBNSR'};
% dataset = {'Manga109'};
dataset = {'Set5', 'Set14', 'B100', 'Urban100', 'Manga109'};
ext = {'*.jpg', '*.png', '*.bmp'};
num_method = length(methods);
num_set = length(dataset);

if strcmp(degradation, 'BI')
    %     scale_all = [2, 3, 4, 8];
    scale_all = 4;
else
    scale_all = 3;
end

for idx_method = 1:num_method
    
    for idx_set = 1:num_set
        fprintf('**********************\n');
        fprintf('Method_%d: %s; Set: %s\n', idx_method, methods{idx_method}, dataset{idx_set});
        for scale = scale_all
            filepaths = [];
            for idx_ext = 1:length(ext)
                filepaths = cat(1, filepaths, dir(fullfile('./HR', dataset{idx_set}, ['x', num2str(scale)], ext{idx_ext})));
            end

            for idx_im = 1:length(filepaths)
                name_HR = filepaths(idx_im).name;
                if strcmp(methods{idx_method},'SBNSR')
                    temp_SR=regexp(name_HR, '_', 'split');
                    name_SR='';
                    for i=1:(length(temp_SR)-2)
                        if i==1
                            name_SR=strcat(name_SR, char(temp_SR{i}));
                        else
                            name_SR=strcat(name_SR,'_', char(temp_SR{i}));
                        end
                    end
                    [~,~,img_ext] = fileparts(name_HR);
                    name_SR=strcat(name_SR, img_ext);
                else
                    name_SR = strrep(name_HR, 'HR', methods{idx_method});
                end
%                 name_SR = strrep(name_HR, 'HR', methods{idx_method});
                im_HR = imread(fullfile('./HR', dataset{idx_set}, ['x', num2str(scale)], name_HR));
                im_SR = imread(fullfile('./SR', degradation, [methods{idx_method}], dataset{idx_set}, ['x', num2str(scale)], name_SR));
                [row_A,~,~] = size(im_HR);
                [row_B,~,~] = size(im_SR);
                if row_A == row_B
                    [n,m,~]=size(im_HR);
                    im_SR = im_SR(scale+1:n-scale,scale+1:m-scale,:);
                    imwrite( im_SR, fullfile('./SR', degradation, [methods{idx_method}], dataset{idx_set}, ['x', num2str(scale)], name_SR));
                else
                    fprintf('Skip: %s \n',name_SR);
                end
            end
        end
    end
end

end

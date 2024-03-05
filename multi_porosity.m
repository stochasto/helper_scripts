%% Function to read in segmented volumes and write out porosity etc

% Input: The directory with all volumes
% Output: An excel with sample properties

%%
function multi_porosity(x_dim, y_dim, z_dim, inPath, outFile)

tic
%% Inputs and variables

a = dir(inPath);
a = a(3:end);
s = numel(a);

fname = cell(s,1);
nlmParam = cell(s,1);
certain_porosity = zeros(s,1);
uncertain_porosity = zeros(s,1);
certain_clay = zeros(s,1);
uncertain_clay = zeros(s,1);
total_porosity_noclay = zeros(s,1);
total_porosity_withclay = zeros(s,1);
%% Calculation of porosity

for i = 1:1:s

    fname{i} = a(i).name;
    temp = strsplit(fname{i},'_');
    nlmParam{i} = temp{4};
    fid = fopen(strcat(inPath,'/',fname{i}),'r');
    I = fread(fid,x_dim*y_dim*z_dim);
    fclose(fid);
    n_voxels = x_dim*y_dim*z_dim;

    certain_pore_voxels     = 0;
    uncertain_pore_voxels   = 0;
    certain_clay_voxels     = 0;
    uncertain_clay_voxels   = 0;
    rock_voxels             = 0;
    
    for j = 1:n_voxels
        if I(j)==0        
            certain_pore_voxels = certain_pore_voxels + 1;
        elseif I(j)==1
            uncertain_pore_voxels = uncertain_pore_voxels + 1;
        elseif I(j)==2
            certain_clay_voxels = certain_clay_voxels + 1;
        elseif I(j)==3
            uncertain_clay_voxels = uncertain_clay_voxels + 1;
        else
            rock_voxels = rock_voxels + 1;
        end
    end
    
    certain_porosity(i) = certain_pore_voxels/n_voxels;
    uncertain_porosity(i) = uncertain_pore_voxels/n_voxels;
    certain_clay(i) = certain_clay_voxels/n_voxels;
    uncertain_clay(i) = uncertain_clay_voxels/n_voxels;
    total_porosity_noclay(i) = (certain_pore_voxels+uncertain_pore_voxels)/n_voxels;
    total_porosity_withclay(i) = (certain_pore_voxels+uncertain_pore_voxels+0.3*certain_clay_voxels)/n_voxels;
    
end

%% Output to excel file

T = table(fname,nlmParam,certain_porosity,uncertain_porosity,certain_clay,uncertain_clay,total_porosity_noclay,total_porosity_withclay);
writetable(T,outFile);

toc;

%%


% fprintf('The certain porosity is : %f \n', certain_pore_voxels/n_voxels);
% fprintf('The uncertain porosity is : %f \n', uncertain_pore_voxels/n_voxels);
% fprintf('The certain clay is : %f \n', certain_clay_voxels/n_voxels);
% fprintf('The uncertain clay is : %f \n', uncertain_clay_voxels/n_voxels);
% fprintf('Total porosity excl. clay (certain+uncertain) is : %f \n', (certain_pore_voxels+uncertain_pore_voxels)/n_voxels);
% fprintf('Total porosity incl. clay (certain+uncertain+0.3*clay) is : %f \n', (certain_pore_voxels+uncertain_pore_voxels+0.3*certain_clay_voxels)/n_voxels);
%% Functions to automate segmentation. 
%  Algo: First, take out a reference center slice and choose seed regions
%  for rock pore and clay. These must be rectangular regions spread across
%  the image in different phases. For example, we could choose three
%  regions for rock in three different rock areas, five regions for pores
%  in five different pore areas, etc. The top left and bottom right corners
%  of these regions must be fed into an excel 'seed_regions.xlsx', in the
%  corresponding tabs. Write the x and y image coordinates for the top left
%  vertex in the first two columns and the x,y coordinates of the bottom
%  right vertex in the third and fourth columns.

%  INPUT: Volumes to be segmented,their dimensions should be known. 
%  The files are named in this format: cuda_rha02_AN_0.5_2um_16bu_512x512x512.raw
%  The 0.5 in the middle is the nlm smoothing parameter. This is extracted
%  to know which volume we are segmenting. Extract slice will be called to get their center slices. 
%  The excel is read to get the regions and the corresponding grey values
%  are obtained. 
%
%  Parameters:
%  inFolder -> folder with input volumes whose thresholds are required
%  regionFile -> excel sheet with region limits, should be in inFolder
%  outFile -> output text file with seeds
%  x,y -> dimensions of input volume, needed to extract slice of interest
%  znum -> slice number to extract, for example 255 for a 512 cubed, to get
%  the center slice of 256.
%
%  OUTPUT: A text file with file names and seeds. The first column is the
%  file name, second is the nlm filter value, next three are pore, clay and rock seeds for method 1
%  (absolute values) and the next three are seeds for method 2 (averages).

%%
function multiThresh(inFolder,regionFile,outFile,x,y,znum)
%%

% Read region limits

regionLims = cell(3,1);

regionFilePath = strcat(inFolder,'/',regionFile);

regionLims{1} = readmatrix(regionFilePath,'Sheet','pore');
regionLims{2} = readmatrix(regionFilePath,'Sheet','clay');
regionLims{3} = readmatrix(regionFilePath,'Sheet','rock');

%%

% Start loop

% Read input files

flist = dir(inFolder);

flist = flist(3:end-1); % omit seed_regions file
%flist = flist(5);

s = numel(flist);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% final output, first three elements are method 1, 
% next 3 are method 2. Order is pore, clay, rock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
seeds = zeros(s,6); 
nlmParam = cell(s,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:1:s
    flist(i).name
    [A I] = extract_slice(x,y,znum,flist(i).name,'uint16');
    seeds(i,:) = findSeeds(I,regionLims);

    temp = strsplit(flist(i).name,'_');
    nlmParam{i} = temp{4};
end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen(outFile,'w+');
outFmt = '%s %s %4d %4d %4d %4d %4d %4d\n';

for i = 1:1:s
    fprintf(fid,outFmt,flist(i).name,nlmParam{i},seeds(i,1),seeds(i,2),seeds(i,3),seeds(i,4),seeds(i,5),seeds(i,6));
end

fclose(fid);
    





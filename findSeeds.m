%% Function to read regions from an excel and find seeds by both averaging method and absolute vals
%%
function seeds = findSeeds(iM,regionLims)
%%
seeds = zeros(6,1);
%seed2 = zeros(3,1);


%% Loop through phases. 1 is pore, 2 is clay, 3 is rock
for i = 1:1:3
    regList = regionLims{i}; 
    s = size(regList);
    numRegs = s(1);
    tempSeeds = zeros(numRegs,2);
    
    % Loop through individual regions
    for j = 1:1:numRegs
        regArea = iM(regList(j,2):regList(j,4),regList(j,1):regList(j,3));
        
        switch i
            case 1 % pore
                tempSeeds(j,1) = max(regArea(:));
            case 2 % clay
                tempSeeds(j,1) = min(regArea(:));
            case 3 % rock
                tempSeeds(j,1) = median(regArea(:));
        end
        tempSeeds(j,2) = mean(regArea(:)); % averaging for method 2
    end
    tempSeeds
    switch i
        case 1
            seeds(i) = max(tempSeeds(:,1)); % max of all regions for pore
            seeds(i + 3) = mean(tempSeeds(:,2)); % average of all regions
        case 2
            seeds(i) = min(tempSeeds(:,1)); % min of all regions for clay
            seeds(i + 3) = mean(tempSeeds(:,2)); % average of all regions
        case 3
            seeds(i) = median(tempSeeds(:,1)); % median of all regions for rock
            seeds(i + 3) = mean(tempSeeds(:,2)); % average of all regions
    end
end

% %% Loop through regions
% 
% regPore = regionLims; 
% 
% sPore = size(regPore);
% 
% nPore = sPore(1);
% 
% tempPore = zeros(nPore,2);
% 
% for i = 1:1:nPore
%     poreArea = iM(regPore(i,2):regPore(i,4),regPore(i,1):regPore(i,3));
%     tempPore(i,1) = max(poreArea(:));
%     tempPore(i,2) = mean(poreArea(:));
% end
% 
% % seeds(1) and 4 are the pore seeds with methods 1 and 2 respectively
% seeds(1) = min(tempPore(:,1));
% seeds(4) = mean(tempPore(:,2));


                
    
    

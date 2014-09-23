function [results] = sort_psychophysics(varargin)
    results = struct;
    names = varargin;
%     namesShort = {'disp', 'tf', 'sf'};
    ogdir = pwd;
    strResponse = input('Enter Initials: ', 's'); 
    dir = [ogdir, '/data/', strResponse];
%     dir = ['/Users/phil/Documents/Research Projects/Temporal Disparity Gradient/Vertical 2AFC/data/crossed/pedestal equal to duration'];
    cd(dir);
    files = what;
    cd(ogdir)
    run = 0; %this is here so that the "run" structure is not confused witht he Matlab run command
    
    sigmaValues = [];
    dummy = [];
    
%%
% sigma = 2.^[-1 -.5:.1:.5 1]; %cues consistent sigma used to compare the mistmatched sigmaL and sigmaD
% sigmaD = 2.^[1 2 3 4]; %sigma for luminance edge
% sigmaL = 2.^[-.5 .5]; %sigma for disparity edge
% 
% 
% maxLuminance = [1/128];
% maxLuminance = [1/16];
% 
% disparity = 8 * .3;
% [conditions temp] = makeStimulusConditions('render', 'disparity', disparity, 'sigmaL', sigmaL, 'sigmaD', sigmaD, 'sigmaC', sigma, 'maxLuminance', maxLuminance);
% 
% 
% 
%         conditions.sigmaL        = 2.^(log2(conditions.sigmaL) + log2(conditions.sigmaD));        
%         conditions.sigmaC        = 2.^(log2(conditions.sigmaC) + log2(conditions.sigmaL));
% %         conditions.sigmaL(conditions.sigmaD == 2.^.5) = 2.^(log2(conditions.sigmaL(conditions.sigmaD == 2^.5))-1);
% 
% 
% 
% %switch sigmaD and sigmaL within makeStimulusConditions to get all 4
% %permutations away from the "fixed" value (2^(1,2,3, or 4))
%     [conditions2 response] = makeStimulusConditions('render', 'disparity', disparity, 'sigmaL', sigmaD, 'sigmaD', sigmaL, 'sigmaC', sigma, 'maxLuminance', maxLuminance);
%             conditions2.sigmaD        = 2.^(log2(conditions2.sigmaD) + log2(conditions2.sigmaL));
%             conditions2.sigmaC        = 2.^(log2(conditions2.sigmaC) + log2(conditions2.sigmaL));
% 
%     
%     conditions.disparity = [conditions.disparity,conditions2.disparity];
%     conditions.sigmaC = [conditions.sigmaC, conditions2.sigmaC];
%     conditions.sigmaL = [conditions.sigmaL, conditions2.sigmaL];
%     conditions.sigmaD = [conditions.sigmaD, conditions2.sigmaD];
%     conditions.maxLuminance = [conditions.maxLuminance, conditions2.maxLuminance];
%     conditions.signalSign = [conditions.signalSign, conditions2.signalSign];
%     conditions.nTrials = conditions.nTrials + conditions2.nTrials;
%     conditions.index = [conditions.index, conditions2.index+conditions.index(end)];
% 
% % get rid of rounding errors, e.g. 
% conditions.sigmaL        = 2.^(round(log2(conditions.sigmaL)*10000)/10000);
% conditions.sigmaD        = 2.^(round(log2(conditions.sigmaD)*10000)/10000);
% conditions.sigmaC        = 2.^(round(log2(conditions.sigmaC)*10000)/10000);
        %%    
    
    
    for f = 1:length(files.mat)
        f
        load(strcat(files.path, '/', files.mat{f}));


        
%         sigma = unique([sigma; run.sigmaL, run.sigmaD, run.maxLuminance], 'rows');
%         disparity = unique([disparity, temp.disparity]);
% %         sigmaC = unique([sigmaC, temp.sigmaC]);
% %         sigmaD = unique([sigmaD, temp.sigmaD]);
% %         sigmaL = unique([sigmaL, temp.sigmaL]);
% %         unique(log2(run.sigmaL))
        for abc = 1:numel(varargin)
            dummy = [dummy; getfield(run, names{abc})];
            values{abc} = getfield(run, names{abc});
            values{abc} = unique(values{abc});
        end
        dummy = (unique(dummy', 'rows')');
        sigmaValues = [sigmaValues, dummy];
        sigmaValues = (unique(sigmaValues', 'rows')');
        dummy = [];
%         for ind = 1:size(sigma,2)
%             [conditions temp] = makeStimulusConditions('analysis', names, sigma(:,ind));
        for ind = 1:size(sigmaValues, 2)
            for zzz = 1:size(values,2)
                values{zzz} = sigmaValues(zzz,ind);
            end
            [conditionsTemp temp] = makeStimulusConditions('analysis', names, values);
            for hij = 1:numel(names)
                %             sigma = [sigma; getfield(run, names{efg})];
                if ind == 1
                    conditions = conditionsTemp;
                else
                    conditions = setfield(conditions, names{hij},...
                        [getfield(conditions, names{hij}), getfield(conditionsTemp, names{hij})]);
                end
                %             values{efg} = unique(values{efg});
            end
        end
        

        clear temp;

        for xyz = 1 :numel(getfield(conditions, names{1}))
            uniqueCond = [];
            for efg = 1:numel(names)
                condname{efg}   = names{efg};
                condval{efg}    = getfield(conditions, condname{efg});
                condval{efg}    = condval{efg}(xyz);
                
                condstr{efg}    = num2str(round(condval{efg}*100)/100);
                condstr{efg}    = strrep(condstr{efg}, '.', '_');
                condstr{efg}    = strrep(condstr{efg}, '-', 'n');
              
 
                uniqueCond  = [uniqueCond, condname{efg}, condstr{efg}, '_'];
%                 uniqueCond = [uniqueCond, namesShort{efg}, condstr{efg}, '_'];
            end
            uniqueCond = uniqueCond(1:end-1);
            
            if ~isfield(results, uniqueCond)
                temp    = cell2struct(condval, condname, 2);
                temp.results = [];
                temp.signal = [];
                results = setfield(results, uniqueCond, temp);
                clear temp
            end
            temp                = getfield(results, uniqueCond);
            [newvalues, signal] = getValues(run, response, condname, condval);
                temp.results    = [temp.results, newvalues];
                temp.signal     = [temp.signal, signal];
                results         = setfield(results, uniqueCond, temp);

            clear temp
        end 
    end
end


function [response signal] = getValues(input, response, names, values)
    first = getfield(input, names{1});

    ind = find(first == values{1});
    for abc = 2:numel(names)
        first = getfield(input,names{abc});
        ind = intersect(ind, find(first == values{abc}));
    end
    if isfield(response, 'disparity')
        response = response.disparity(ind);
    else
        response = response.key(ind);
    end
    signal   = input.signalSign(ind);
end
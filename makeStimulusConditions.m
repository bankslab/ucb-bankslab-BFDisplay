function [runvals response] = makeStimulusConditions(inputtype, varargin)
   
    runvals               = struct();
    runvals.nRepeat       = 5;
    runvals.nyquist       = 1.5;
    
    switch inputtype
        case 'analysis'
            runvals.nRepeat = 1;
            names   = varargin{1};
            values  = varargin{2};
            varargin = cell(1, numel(names)*2);
            for abc = 1:numel(names)
                varargin{abc*2-1}   = names{abc};
                varargin{abc*2}     = values{abc};
            end
            clear names values
    end
    

    if mod(numel(varargin), 2) == 1
        disp('Number of stimulus conditions and stimulus values are not equal')
        return
    end


    totalConditions = numel(varargin)/2;
    for abc = 2:2:numel(varargin)
        runvals = setfield(runvals, varargin{abc-1}, []);
    end
    runvals.signalSign = [];


    KbName('UnifyKeyNames');
    stereoMode = 4;


    clear conditionsçk
    clone = varargin{2};
    for abc = 1:numel(clone)
        conditions{abc} = clone(abc);
    end
    clone = [];
    for abc = 4:2:numel(varargin)
        clone{abc/2-1} = varargin{abc};
    end
    
    while numel(clone) > 0
        for xyz = 1:numel(conditions)
            for efg = clone{1}
                conditions{end+1} = [conditions{xyz}, efg];
            end
        end
        clone(1) = [];
    end

    conditions(cellfun('length', conditions) ~= totalConditions) = [];

    for abc = 1 : numel(conditions)
        for efg = 1:2:numel(varargin)
            z = [getfield(runvals, varargin{ceil(efg)}), conditions{abc}(ceil(efg/2))];
            runvals = setfield(runvals, varargin{efg}, z);
        end
    end

    for efg = 1:2:numel(varargin)
        runvals = setfield(runvals, varargin{efg}, repmat(getfield(runvals, varargin{ceil(efg)}), [1 runvals.nRepeat]));
    end

    runvals.nTrials     = numel(conditions)*runvals.nRepeat;
    runvals.signalSign  = sign(randn([1 runvals.nTrials]));
    runvals.signalSign(runvals.signalSign == 0) = -1;
    runvals.index       = 1:runvals.nTrials;
    
    response.key = zeros(size(runvals.signalSign));
end
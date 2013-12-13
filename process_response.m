
while(stop_flag==0)
    Screen('SelectStereoDrawBuffer',windowPtr,0);
    Screen('FillRect',windowPtr,[0 0 0]);
    Screen('SelectStereoDrawBuffer',windowPtr,1);
    Screen('FillRect',windowPtr,[0 0 0]);
    Screen('Flip',windowPtr);
    presentAgain=0;
    [a b c d]=KbCheck(-1);
    if a==1
        iKeyIndex=find(c);
        strInputName=KbName(iKeyIndex(1));
        if strcmp(strInputName,'UpArrow')
            scellThisRound{s_i}=processResponse(scellThisRound{s_i}, 0);
            f_print_response = 0;
            break;
        elseif strcmp(strInputName,'DownArrow')
            scellThisRound{s_i}=processResponse(scellThisRound{s_i}, 1);
            f_print_response = 1;
            break;
        elseif strcmp(strInputName,'ESCAPE')||strcmp(strInputName,'esc')
            stop_flag=1;
            break;
        end
    end
end

if get(scellThisRound{s_i},'MCS')==1 % MCS
    if get(scellThisRound{s_i},'complete')==1
        clear temp;
        temp=[];
        for ii=1:length(scellThisRound)
            if ii==s_i
                scellCompleted{end+1}=scellThisRound{ii};
            else
                temp{end+1}=scellThisRound{ii};
            end
        end
        clear scellThisRound;
        scellThisRound=temp;
    else % move scell to next round anyway
        clear temp;
        temp=[];
        for ii=1:length(scellThisRound)
            if ii==s_i
                scellNextRound{end+1}=scellThisRound{ii};
            else
                temp{end+1}=scellThisRound{ii};
            end
        end
        clear scellThisRound;
        scellThisRound=temp;
    end
end

if isempty(scellThisRound)
    if isempty(scellNextRound)
        stop_flag=1; % end of the experiment
    else
        scellThisRound=scellNextRound;
        scellNextRound=[];
    end
end
s_i=ceil(rand(1)*length(scellThisRound));

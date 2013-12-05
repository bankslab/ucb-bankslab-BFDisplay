
if isempty(get(scellThisRound{s_i},'MCS')) % staircasing
    reversalsBeforeResponse=get(scellThisRound{s_i},'currentReversals'); % remember # reversals
end

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
        if strcmp(strInputName,'LeftArrow')
            scellThisRound{s_i}=processResponse(scellThisRound{s_i}, 0);
            break;
        elseif strcmp(strInputName,'RightArrow')
            scellThisRound{s_i}=processResponse(scellThisRound{s_i}, 1);
            break;
        elseif strcmp(strInputName,'ESCAPE')||strcmp(strInputName,'esc')
            stop_flag=1;
            break;
        end
    end
end


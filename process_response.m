
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

function [] = analyze_fatigue_temporal_change()

%% Draw graph for temporal change of fatigue

[filenames, pathname]=uigetfile('*.txt', 'Select all the experimental output files' ,'MultiSelect', 'on');
whatisthis=whos('filenames');
if strcmp(whatisthis.class, 'cell')
    number_of_files=length(filenames);
else
    number_of_files=1;
end

for index=1:number_of_files
    if strcmp(whatisthis.class, 'cell')
        textfilename= [pathname filenames{index}];
    else
        textfilename= [pathname filenames];
    end

    [t_current_condition, t_reported_time, t_degree_fatigue] = ...
        textread(textfilename,'%d%d%d');

    if exist('v_condition', 'var')
        v_condition=[v_condition; t_current_condition];
        v_reported_time=[v_reported_time; t_reported_time];
        v_degree_fatigue=[v_degree_fatigue; t_degree_fatigue];
    else
        v_condition=t_current_condition;
        v_reported_time=t_reported_time;
        v_degree_fatigue=t_degree_fatigue;
    end
    
end

%%
% Arrange experimental data for given number of conditions and frequencies.
% WARNING! This code is extremely inefficient in terms of both calculation
% time and memory usage.
% Basic assumption for this code is that the size of vectors is extremely
% small.
condition=unique(v_condition);
num_conditions=length(condition); % number of conditions
t_reported_time=-1*ones(length(v_condition),num_conditions); % -1 is default value.
t_degree_fatigue=-1*ones(length(v_condition),num_conditions);
end_index=zeros(num_conditions,1); % indicates where valid information for given condition ends.

%%
for ii=1:num_conditions
    t_index=0;
    for jj=1:length(v_condition)
        if v_condition(jj)==ii
            t_index=t_index+1;
            t_reported_time(t_index,ii)=v_reported_time(jj);
            t_degree_fatigue(t_index,ii)=v_degree_fatigue(jj);
        end
    end
    end_index(ii)=t_index;
end

%% Draw graph
plot(t_reported_time(1:end_index(1),1),t_degree_fatigue(1:end_index(1),1),'b:',...
    t_reported_time(1:end_index(2),2),t_degree_fatigue(1:end_index(2),2),'b-',...
    t_reported_time(1:end_index(3),3),t_degree_fatigue(1:end_index(3),3),'r:',...
    t_reported_time(1:end_index(4),4),t_degree_fatigue(1:end_index(4),4),'r-',...
    t_reported_time(1:end_index(5),5),t_degree_fatigue(1:end_index(5),5),'g:',...
    t_reported_time(1:end_index(6),6),t_degree_fatigue(1:end_index(6),6),'g-')
legend('0.1D, Uncrossed',...
    '0.1D, Crossed',...
    '1.3D, Uncrossed',...
    '1.3D, Crossed',...
    '2.5D, Uncrossed',...
    '2.5D, Crossed',...
    'Location','NorthEastOutSide');
function [] = analyze_fatigue_assess()

%%

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

    [t_poundsign, t_current_condition, t_rds_grating_cpd, t_rpt_orientation, t_response, t_answer, t_phase1_verg_dist,...
        t_phase1_accom_dist, t_phase2_verg_dist, t_phase2_accom_dist] = ...
        textread(textfilename,'%s%d%f%f%d%d%f%f%f%f');

    if exist('v_condition', 'var')
        v_condition=[v_condition; t_current_condition];
        v_freq=[v_freq; t_rds_grating_cpd];
        v_orientation=[v_orientation; t_rpt_orientation];
        v_response=[v_response; t_response];
        v_answer=[v_answer; t_answer];
        v_phase1_verg_dist=[v_phase1_verg_dist; t_phase1_verg_dist];
        v_phase1_accom_dist=[v_phase1_accom_dist; t_phase1_accom_dist];
        v_phase2_verg_dist=[v_phase2_verg_dist; t_phase2_verg_dist];
        v_phase2_accom_dist=[v_phase2_accom_dist; t_phase2_accom_dist];
    else
        v_condition=t_current_condition;
        v_freq=t_rds_grating_cpd;
        v_orientation=t_rpt_orientation;
        v_response=t_response;
        v_answer=t_answer;
        v_phase1_verg_dist=t_phase1_verg_dist;
        v_phase1_accom_dist=t_phase1_accom_dist;
        v_phase2_verg_dist=t_phase2_verg_dist;
        v_phase2_accom_dist=t_phase2_accom_dist;
    end
    
end

%%
% Arrange experimental data for given number of conditions and frequencies.
condition=unique(v_condition);
num_conditions=length(condition); % number of conditions
freq=unique(v_freq);
num_freqs=length(freq); % number of conditions

num_trialspercorrfreq=10; % should not be smaller than 'trialspercorrfreq' in test parameter file.
num_datatypes=7;
% number of all data types
data=zeros(num_conditions,num_freqs,num_datatypes,num_trialspercorrfreq);
num_existingdata=zeros(num_conditions,num_freqs,num_datatypes); % number of actual trials per specific combination of condition and frequency.

% Below are indices of all data types.
% discomfort, orientation, response, answer, phase1_verg_dist,
% phase1_accom_dist, phase2_verg_dist, phase2_accom_dist
i_data_orientation=1;
i_data_response=2;
i_data_answer=3;
i_data_phase1_verg_dist=4;
i_data_phase1_accom_dist=5;
i_data_phase2_verg_dist=6;
i_data_phase2_accom_dist=7;

for ii=1:length(v_condition)
    i_condition=find(condition==v_condition(ii));
    i_freq=find(freq==v_freq(ii));
    
%     % Record discomfort
%     if v_discomfort(ii)>0
%         num_existingdata(i_condition,i_freq,i_data_discomfort)=num_existingdata(i_condition,i_freq,i_data_discomfort)+1;
%         i_data=num_existingdata(i_condition,i_freq,i_data_discomfort);
%         data(i_condition,i_freq,i_data_discomfort,i_data)=v_discomfort(ii);
%     end
    
    % Record response: don't need 'if.'
    num_existingdata(i_condition,i_freq,i_data_response)=num_existingdata(i_condition,i_freq,i_data_response)+1;
    i_data=num_existingdata(i_condition,i_freq,i_data_response);
    data(i_condition,i_freq,i_data_response,i_data)=v_response(ii);
    
end

%%
% calculate mean and error
mean_data=zeros(num_conditions,num_freqs,num_datatypes);
error_data=zeros(num_conditions,num_freqs,num_datatypes);

for i_condition=1:length(condition)
    for i_freq=1:length(freq)
%         t_v_discomfort=squeeze(data(i_condition,i_freq,i_data_discomfort,1:num_existingdata(i_condition,i_freq,i_data_discomfort)));
%         mean_data(i_condition,i_freq,i_data_discomfort)=mean(t_v_discomfort);
%         error_data(i_condition,i_freq,i_data_discomfort)=std(t_v_discomfort);
        t_v_response=squeeze(data(i_condition,i_freq,i_data_response,1:num_existingdata(i_condition,i_freq,i_data_response)));
        mean_data(i_condition,i_freq,i_data_response)=mean(t_v_response);
        error_data(i_condition,i_freq,i_data_response)=std(t_v_response);
    end
end

% mean discomfort and response per conditions
% mean_discomfort_per_condition=zeros(length(condition),1);
mean_response_per_condition=zeros(length(condition),1);
for ii=1:length(condition)
%     mean_discomfort_per_condition(ii)=mean(mean_data(ii,:,i_data_discomfort));
    mean_response_per_condition(ii)=mean(mean_data(ii,:,i_data_response));
end

%%
% draw graphs

% Line property according to the conditions
line_property={'g--' 'b--' 'r-' 'c--' 'm--' 'k-'};

% Figure 1: graphs about discomfort
% figure(1);
% set(1,'Position',[100 100 800 700]);
% subplot(2,1,1);
% hold on;
% for ii=1:length(condition)
%     errorbar(freq,squeeze(mean_data(ii,:,i_data_discomfort)),squeeze(error_data(ii,:,i_data_discomfort)),line_property{ii});
% end
% LEGEND('0D-0.6D INCON','0.6D-1.2D INCON','0D-0.6D CON','2.5D-3.1D INCON','3.1D-3.7D INCON','2.5D-3.1D CON');
% set(gca,'FontSize',12);
% set(gca,'YTick',0:1:10);
% set(gca,'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10'});
% axis([0.5,4.5,0,10]);
% xlabel({'Corrugation frequencies (cycles/deg)'});
% ylabel({'Discomfort level'});
% 
% temp_h=subplot(2,1,2);
% x=1:6;
% plot(x,mean_discomfort_per_condition);
% set(gca,'FontSize',12);
% set(gca,'YTick',0:1:10);
% set(gca,'YTickLabel',{'0','1','2','3','4','5','6','7','8','9','10'});
% axis([0.5,6.5,0,10]);
% xlabel({'';'Conditions'});
% ylabel({'Discomfort level'});
% 
% xtl = {{'0D-0.6D';'INCON'}, {'0.6D-1.2D';'INCON'}, {'0D-0.6D';'CON'}, {'2.5D-3.1D';'INCON'}, {'3.1D-3.7D';'INCON'}, {'2.5D-3.1D';'CON'}};
% h = my_xticklabels(gca,1:6,xtl);

% Figure 1: graph of response
figure(1);
set(1,'Position',[100 100 800 700]);
subplot(2,1,1);
hold on;
for ii=1:length(condition)
    plot(freq,squeeze(mean_data(ii,:,i_data_response)),line_property{ii});
    %errorbar(freq,squeeze(mean_data(ii,:,i_data_response)),squeeze(error_data(ii,:,i_data_response)),line_property{ii});
end
LEGEND('0D-1.2D INCON','1.2D-2.4D INCON','0D-1.2D CON','2.5D-3.7D INCON','3.7D-4.9D INCON','2.5D-3.7D CON');
set(gca,'FontSize',12);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'});
axis([0.8,2.6,0,1]);
xlabel({'Corrugation frequencies (cycles/deg)'});
ylabel({'Response ratio'});

temp_h=subplot(2,1,2);
x=1:6;
plot(x,mean_response_per_condition);
set(gca,'FontSize',12);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'});
axis([0.5,6.5,0,1]);
xlabel({'';'Conditions'});
ylabel({'Response ratio'});

xtl = {{'0D-1.2D';'INCON'}, {'1.2D-2.4D';'INCON'}, {'0D-1.2D';'CON'}, {'2.5D-3.7D';'INCON'}, {'3.7D-4.9D';'INCON'}, {'2.5D-3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);

%%
% Analyze the text file containing the questionaire answer.

[filenames, pathname]=uigetfile('*.txt', 'Select all the questionaire answer files' ,'MultiSelect', 'on');
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

    [t_qcondition,t_eyetiredness,t_visionclearness,t_necksoreness,t_eyestrain,t_headache] = ...
        textread(textfilename,'%d%d%d%d%d%d');

    if exist('v_qcondition', 'var')
        v_qcondition=[v_qcondition; t_qcondition];
        v_eyetiredness=[v_eyetiredness; t_eyetiredness];
        v_visionclearness=[v_visionclearness; t_visionclearness];
        v_necksoreness=[v_necksoreness; t_necksoreness];
        v_eyestrain=[v_eyestrain; t_eyestrain];
        v_headache=[v_headache; t_headache];
    else
        v_qcondition=t_qcondition;
        v_eyetiredness=t_eyetiredness;
        v_visionclearness=t_visionclearness;
        v_necksoreness=t_necksoreness;
        v_eyestrain=t_eyestrain;
        v_headache=t_headache;
    end
    
end

%% Arrange data
num_question_data_types=5;
i_qdata_eyetiredness=1;
i_qdata_visionclearness=2;
i_qdata_necksoreness=3;
i_qdata_eyestrain=4;
i_qdata_headache=5;
qdata=zeros(num_conditions,num_question_data_types);

for ii=1:num_conditions
    qdata(v_qcondition(ii),i_qdata_eyetiredness)=v_eyetiredness(ii);
    qdata(v_qcondition(ii),i_qdata_visionclearness)=v_visionclearness(ii);
    qdata(v_qcondition(ii),i_qdata_necksoreness)=v_necksoreness(ii);
    qdata(v_qcondition(ii),i_qdata_eyestrain)=v_eyestrain(ii);
    qdata(v_qcondition(ii),i_qdata_headache)=v_headache(ii);
end
%% Draw graphs of questionaire answer data.

% Figure 2: graph of average data
figure(3);
set(3,'Position',[100 100 1200 700]);

subplot(2,3,1); % response ratio
x=1:6;
plot(x,mean_response_per_condition);
set(gca,'FontSize',10);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'});
axis([0.5,6.5,0,1]);
xlabel({'';'';'Conditions'});
ylabel({'Response ratio'});
xtl = {{'0D-';'1.2D';'INCON'}, {'1.2D-';'2.4D';'INCON'}, {'0D-';'1.2D';'CON'}, {'2.5D-';'3.7D';'INCON'}, {'3.7D-';'4.9D';'INCON'}, {'2.5D-';'3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);

subplot(2,3,2); % eye tiredness
x=1:6;
plot(x,squeeze(qdata(:,i_qdata_eyetiredness)));
set(gca,'FontSize',10);
set(gca,'YTick',0:1:4);
set(gca,'YTickLabel',{'0','1','2','3','4'});
axis([0.5,6.5,0,4]);
xlabel({'';'';'Conditions'});
ylabel({'Eye tiredness'});
xtl = {{'0D-';'1.2D';'INCON'}, {'1.2D-';'2.4D';'INCON'}, {'0D-';'1.2D';'CON'}, {'2.5D-';'3.7D';'INCON'}, {'3.7D-';'4.9D';'INCON'}, {'2.5D-';'3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);

subplot(2,3,3); % vision clearness
x=1:6;
plot(x,squeeze(qdata(:,i_qdata_visionclearness)));
set(gca,'FontSize',10);
set(gca,'YTick',0:1:4);
set(gca,'YTickLabel',{'0','1','2','3','4'});
axis([0.5,6.5,0,4]);
xlabel({'';'';'Conditions'});
ylabel({'Vision blurriness'});
xtl = {{'0D-';'1.2D';'INCON'}, {'1.2D-';'2.4D';'INCON'}, {'0D-';'1.2D';'CON'}, {'2.5D-';'3.7D';'INCON'}, {'3.7D-';'4.9D';'INCON'}, {'2.5D-';'3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);

subplot(2,3,4); % neck and back soreness
x=1:6;
plot(x,squeeze(qdata(:,i_qdata_necksoreness)));
set(gca,'FontSize',10);
set(gca,'YTick',0:1:4);
set(gca,'YTickLabel',{'0','1','2','3','4'});
axis([0.5,6.5,0,4]);
xlabel({'';'';'Conditions'});
ylabel({'Neck and back soreness'});
xtl = {{'0D-';'1.2D';'INCON'}, {'1.2D-';'2.4D';'INCON'}, {'0D-';'1.2D';'CON'}, {'2.5D-';'3.7D';'INCON'}, {'3.7D-';'4.9D';'INCON'}, {'2.5D-';'3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);

subplot(2,3,5); % eye strain
x=1:6;
plot(x,squeeze(qdata(:,i_qdata_eyestrain)));
set(gca,'FontSize',10);
set(gca,'YTick',0:1:4);
set(gca,'YTickLabel',{'0','1','2','3','4'});
axis([0.5,6.5,0,4]);
xlabel({'';'';'Conditions'});
ylabel({'Eye strain'});
xtl = {{'0D-';'1.2D';'INCON'}, {'1.2D-';'2.4D';'INCON'}, {'0D-';'1.2D';'CON'}, {'2.5D-';'3.7D';'INCON'}, {'3.7D-';'4.9D';'INCON'}, {'2.5D-';'3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);

subplot(2,3,6); % headache
x=1:6;
plot(x,squeeze(qdata(:,i_qdata_headache)));
set(gca,'FontSize',10);
set(gca,'YTick',0:1:4);
set(gca,'YTickLabel',{'0','1','2','3','4'});
axis([0.5,6.5,0,4]);
xlabel({'';'';'Conditions'});
ylabel({'Headache'});
xtl = {{'0D-';'1.2D';'INCON'}, {'1.2D-';'2.4D';'INCON'}, {'0D-';'1.2D';'CON'}, {'2.5D-';'3.7D';'INCON'}, {'3.7D-';'4.9D';'INCON'}, {'2.5D-';'3.7D';'CON'}};
h = my_xticklabels(gca,1:6,xtl);



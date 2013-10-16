if ~exist('record_data','var')
    error('load a data file first!')
end

numCorrect=zeros(1,6);
numTrials=zeros(1,6);
for ii=1:6
    numCorrect(ii)=sum(record_data.response(find(record_data.condition==ii)));
    numTrials(ii)=length(find(record_data.condition==ii));
end

numPerformance=numCorrect./numTrials

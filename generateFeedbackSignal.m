Fs=8192;
soundDuration=0.1;

frequency=960;
soundwavePeriod=1/frequency;
SN=round(soundDuration*Fs);
y1=sin(2*pi*(1:SN)/Fs/soundwavePeriod);

frequency=480;
soundwavePeriod=1/frequency;
SN=round(soundDuration*Fs);
y2=sin(2*pi*(1:SN)/Fs/soundwavePeriod);

frequency=720;
soundwavePeriod=1/frequency;
SN=round(soundDuration*Fs);
y3=sin(2*pi*(1:SN)/Fs/soundwavePeriod);

% if exist('soundWrong','var')
%     clear soundWrong;
%     clear soundCorrect;
%     clear soundPresentation;
% end

disp('generating sounds');
% for t_i=1:ceil(param.session.duration/param.stim.interval)
for t_i=1:1000
    soundWrong{t_i}=audioplayer(y1,Fs);
    soundCorrect{t_i}=audioplayer([y2 y3],Fs);
%     soundPresentation{t_i}=audioplayer(y4,Fs);
end
disp('sound generation ended');
w_i=1;
c_i=1;
%Raw data collected by David Hoffman
%7/24/2008
%Monitors set to 180Hz 800x600
%Contrast=0.7
%Brightness=100%
%colortemp=6500K

clear all
close all
RawdataL=[...
    0   0.34;...
    20  1.23;...
    40  2.99;...
    60  5.78;...
    80  9.78;...
    100 14.9;...
    128 24.4;...
    160 38.4;...
    180 48.9;...
    200 61.1;...
    220 74.4;...
    240 89.5;...
    255 94.0]

RawdataR=[...
    0   0.27;...
    25  1.47;...
    50  4.08;...
    75  8.42;...
    100 14.6;...
    128 24.2;...
    150 38.6;...
    175 46.6;...
    200 62.2;...
    220 76.5;...
    240 90.6;...
    255 93.1]


figure(2)
subplot(2,2,1)
plot(RawdataL(:,1), RawdataL(:,2), 'o')
subplot(2,2,2)
plot(RawdataR(:,1), RawdataR(:,2), 'o')


subplot(2,2,3)
plot(log10(RawdataL(:,1)), log10(RawdataL(:,2)), 'o')
subplot(2,2,4)
plot(log10(RawdataR(:,1)), log10(RawdataR(:,2)), 'o')

%Measure the slopes of the log log plot of this raw data
%Note that I exclude some of the end points for a better overall fit
%Left Monitor, 1.9864-2.787
%Right monitor y=1.9874x-2.7847

RGBnum=[0:1:255];
gamma_curve_L= 10^-2.787*RGBnum.^1.9864;
subplot(2,2,1)
hold on
plot(RGBnum, gamma_curve_L, 'r-')


gamma_curve_R= 10^-2.7874*RGBnum.^1.9874;
subplot(2,2,2)
hold on
plot(RGBnum, gamma_curve_R, 'r-')



equiluminancestepsL= [.34:(94-.34)/256:93.9];
IntensitysignalL= (equiluminancestepsL./(10^-2.7872)).^(1/1.9864);
lookupvaluesL=ceil(IntensitysignalL);

%for i=1:256
    inversegammaL= 10^-2.7872*RGBnum(lookupvaluesL(:)).^1.9864;
    subplot(2,2,1)
    plot(RGBnum, inversegammaL, 'g-')
    
    
    
    equiluminancestepsR= [.34:(94-.34)/256:93.9];
IntensitysignalR= (equiluminancestepsR./(10^-2.7874)).^(1/1.9874);
lookupvaluesR=ceil(IntensitysignalR);


    inversegammaR= 10^-2.7874*RGBnum(lookupvaluesR(:)).^1.9874;
    subplot(2,2,2)
    plot(lookupvaluesR, 'g-')


BF_CLUT_L=repmat(lookupvaluesL',1,3);
BF_CLUT_R=repmat(lookupvaluesR',1,3);

save( 'BF_CLUTlookuptables.mat', 'BF_CLUT*')

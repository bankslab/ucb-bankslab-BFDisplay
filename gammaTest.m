[win wrect]=Screen('OpenWindow',0,1,[],[],[],4);

gammaRed = 2.2;%2.32345;%2.324;%2.37;
gammaGreen = 2.2;%2.22135;%2.223;%2.22;%2.14;
gammaBlue = 2.2;%2.277;%2.324;%2.29;
rgb=1:255;
gr = rgb.^(1/gammaRed);
gr = gr/max(gr);
gg = rgb.^(1/gammaGreen);
gg = gg/max(gg);
gb = rgb.^(1/gammaBlue);
gb = gb/max(gb);

glt(:,1) = gr;
glt(:,2) = gg;
glt(:,3) = gb; 


%load('piecewiseLookUpTable.mat');
%glt = newLookUpTable;

%load('matlab_lookup_table.mat');
%glt = newLookUpTable;

load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
% load('BF_params/BF_correctedLinearGamma.mat');
indices = 0:1/255:1;
% correctedGammaLarge{1} = zeros(1024,3);
% correctedGammaLarge{2} = zeros(1024,3);
%{
for dispNo = 1:2
    for i = 1:1024
        lowerIndex = find(indices <= (i-1)/(1023),1,'last');
        upperIndex = find(indices >= (i-1)/(1023),1,'first');
        alpha = (i-1)/(1023)-indices(upperIndex);
        beta = indices(lowerIndex) - (i-1)/(1023);
        if alpha == beta
            correctedGammaLarge{dispNo}(i,:) = ...
                correctedGammaNew{dispNo}(lowerIndex,:);
        else
            correctedGammaLarge{dispNo}(i,:) = ...
                (alpha*correctedGammaNew{dispNo}(lowerIndex,:)+...
                beta*correctedGammaNew{dispNo}(upperIndex,:))/(alpha+beta);
            
        end
    end
end
%}
%origGamma=Screen('LoadNormalizedGammaTable', win, correctedGammaNew{2});
% Screen('SelectStereoDrawBuffer',win,0);
% origGamma=Screen('LoadNormalizedGammaTable', win, correctedGamma{1});
% Screen('SelectStereoDrawBuffer',win,1);
% origGamma=Screen('LoadNormalizedGammaTable', win, correctedGamma{2});
origGamma=Screen('LoadNormalizedGammaTable', win, correctedGamma{2});

%load('gammalookuptable.mat');
%load('newGammaLUT.mat');
% load('BF_params/BF_correctedLinearGamma.mat');
%origGamma=Screen('LoadNormalizedGammaTable', win, correctedGamma{2});
% origGamma=Screen('LoadNormalizedGammaTable', win, gammaLookupTable);

% These textures are not used at all
hdr = 0;
%{
if hdr
    img1 = 255*double(hdrread('BF_texture_files/gamma/gamma1.hdr'));
    img2 = 255*double(hdrread('BF_texture_files/gamma/gamma2.hdr'));
    img3 = 255*double(hdrread('BF_texture_files/gamma/gamma3.hdr'));
    img4 = 255*double(hdrread('BF_texture_files/gamma/gamma4.hdr'));
else
    img1 = imread('BF_texture_files/gamma/gamma1.png');
    img2 = imread('BF_texture_files/gamma/gamma2.png');
    img3 = imread('BF_texture_files/gamma/gamma3.png');
    img4 = imread('BF_texture_files/gamma/gamma4.png');
end

tex(1) = Screen('MakeTexture',win,img1(:,:,1));
tex(2) = Screen('MakeTexture',win,img2(:,:,1));
tex(3) = Screen('MakeTexture',win,img3(:,:,1));
tex(4) = Screen('MakeTexture',win,img4(:,:,1));
%}
step = 25;
lums = 0:step:floor(255);
lumsr = lums;
lumsg = lums;
lumsb = lums;
len = length(lums);

layer = 1;

stop_flag=0;
while (stop_flag==0)
    for ii=0:1
        Screen('SelectStereoDrawBuffer',win,ii);
%         Screen('LoadNormalizedGammaTable', win, correctedGamma{ii+1});
        Screen('FillRect',win,[0 0 0], [0 0 800 600]);

        if layer == 1
            for i = 1:len
                Screen('FillRect',win,[lumsr(i) lumsg(i) lumsb(i)], [((i-1)*800/len) 200 ((i)*800/len) 400]);
                Screen('FillRect',win,[lumsr(i)/2 lumsg(i)/2 lumsb(i)/2], [((i-1)*800/len) 0 ((i)*800/len) 200]);
                Screen('FillRect',win,[lumsr(i)/4 lumsg(i)/4 lumsb(i)/4], [((i-1)*800/len) 400 ((i)*800/len) 600]);

            end
        end
        if layer == 2
            for i = 1:length(lums)
                Screen('FillRect',win,[lumsr(i)/2 lumsg(i)/2 lumsb(i)/2], [((i-1)*800/len) 0 ((i)*800/len) 200]);
                Screen('FillRect',win,[lumsr(i)/4 lumsg(i)/4 lumsb(i)/4], [((i-1)*800/len) 400 ((i)*800/len) 600]);
            end
        end
        if layer > 2
            for i = 1:length(lums)
                Screen('FillRect',win,[lumsr(i)/4 lumsg(i)/4 lumsb(i)/4], [((i-1)*800/len) 400 ((i)*800/len) 600]);
            end
        end

        % White square for switchable lens
        if layer==3
            Screen('FillRect',win,[255 255 255],[0 500 100 600]);
        else
            Screen('FillRect',win,[0 0 0],[0 500 100 600]);
        end

        %Screen('DrawTexture',win,tex(layer))
        if ii==1
            Screen('Flip',win,[],[],1);
        end

        %KbCheck for exit and gamma adjustment
        [a b c d]=KbCheck(-1);
        if a==1
            inputstr=KbName(c);
            if strcmp(inputstr,'ESCAPE') || strcmp(inputstr,'esc')
                % Abort if 'esc' is pressed.
                stop_flag=1;
                break;
            end

            if strcmp(inputstr,'RightArrow') 
                gammaRed = gammaRed + 0.0005;
                gammaGreen = gammaGreen + 0.0005;
                gammaBlue = gammaBlue + 0.0005;
                gr = rgb.^(1/gammaRed);
                gr = gr/max(gr);
                gg = rgb.^(1/gammaGreen);
                gg = gg/max(gg);
                gb = rgb.^(1/gammaBlue);
                gb = gb/max(gb);

                glt(:,1) = gr;
                glt(:,2) = gg;
                glt(:,3) = gb;
                origGamma=Screen('LoadNormalizedGammaTable', win, glt);
            end

            if strcmp(inputstr,'LeftArrow')
                gammaRed = gammaRed - 0.0005;
                gammaGreen = gammaGreen - 0.0005;
                gammaBlue = gammaBlue - 0.0005;
                gr = rgb.^(1/gammaRed);
                gr = gr/max(gr);
                gg = rgb.^(1/gammaGreen);
                gg = gg/max(gg);
                gb = rgb.^(1/gammaBlue);
                gb = gb/max(gb);

                glt(:,1) = gr;
                glt(:,2) = gg;
                glt(:,3) = gb;
    %             glt(:,1) = 0.5*(1+sin(2*pi*(1:255)/32));
    %             glt(:,2) = 0.5*(1+sin(2*pi*((1:255)-10)/32));
    %             glt(:,3) = 0.5*(1+sin(2*pi*((1:255)-20)/32));

                origGamma=Screen('LoadNormalizedGammaTable', win, glt);
            end
        end

    end
    layer = mod(layer,4)+1;
end
Screen('CloseAll');
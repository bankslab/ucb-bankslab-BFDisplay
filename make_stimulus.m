%The stimulus made is a RDS background of 0 disparity. Within this
%background there are two rectangular strips above and below a fixation
%cross. One strip has constant disparity through the presentation time and
%the other has a dynamic disparity. Both strips are generated to be
%centered on the fixation cross and shifted up or down depending on
%trial.signalSign.

function [leftImage rightImage] = make_stimulus(type, stimulus_dim, monitor_settings, trial, frame_num, orientation, nonius)
% shape is the dynamic plane
% pedestal is the static plane to compare the dynamic plane to
    stimulus_dim(1) = stimulus_dim(1)/2;
    noniusLine = nonius.l; %nonius.l/2

%     within = stimulus_dim(1) + 60;
    within = stimulus_dim(1);
    within = stimulus_dim(1);
    monitor_settings.y_pix = monitor_settings.y_pix;
% for f = 1:trial.frames
    %%
    %%%%%%%%%%%%%% CREATE SIGNAL
    right.x = []; right.y = []; left.x = []; left.y = [];
% static plane does nothing right now    
    for f = frame_num;
%         if f == 0
            extendfac = .65;
            rX      = double(rand(1, round(trial.nDots*extendfac))) * monitor_settings.x_pix*extendfac - monitor_settings.x_pix*extendfac/2; %generate more pixels than x_pixels because disparities shift dots off screen (1/4 screen buffer each way)
            rY      = double(rand(1, round(trial.nDots*extendfac))) * monitor_settings.y_pix - monitor_settings.y_pix/2;                      
            
%             [rX rX2 shift] = calculateshift(type, rX, rY, trial, f, stimulus_dim, noniusLine, monitor_settings, extendfac);

            time = (frame_num) * 1 / monitor_settings.Hz *trial.direction;

            switch type
                case 'signal'
                    trianglewave = sawtooth(double(trial.fixedTF * 2*pi * time - 2*pi*trial.fixedSF * rY * monitor_settings.arcmin_per_pix/ 60)+trial.randphase1, .5);
                    shift = trianglewave *trial.disparity*monitor_settings.pix_per_arcmin;
                case 'noise'
                    trianglewave = sawtooth(double(trial.tf * 2*pi * time - 2*pi*trial.sf * rY * monitor_settings.arcmin_per_pix/ 60)+trial.randphase2, .5);
                    shift = trianglewave * trial.adjustment*monitor_settings.pix_per_arcmin;
            end
            rX2 = rX - shift/2;            
            rX = rX + shift/2;

%             rX = mod(rX + monitor_settings.x_pix/2 * extendfac, monitor_settings.x_pix*extendfac) - monitor_settings.x_pix/2*extendfac;
%             rX2 = mod(rX2 + monitor_settings.x_pix/2 * extendfac, monitor_settings.x_pix*extendfac) - monitor_settings.x_pix/2*extendfac;


        
        left = crop(rX, rY, trial, stimulus_dim, noniusLine, type);
        right  = crop(rX2, rY, trial, stimulus_dim, noniusLine, type);
        
        
        leftImage = double([left.x; left.y]);
        rightImage = double([right.x; right.y]);
    end
end


function [rX rX2 shift] = calculateshift(type, rX, rY, trialInfo, frame_num, stimulus_dim, noniusLine, monitor_settings, extendfac)

%make the static and dynamic bars which will be combined with the 0 disparity background    
            time = (frame_num) * 1 / monitor_settings.Hz *trialInfo.direction;
            switch type
                case 'signal'
                    trianglewave = sawtooth(double(trialInfo.fixedTF * 2*pi * time - 2*pi*trialInfo.fixedSF * rY * monitor_settings.arcmin_per_pix/ 60)+trialInfo.randphase, .5);
                    shift = trianglewave *trialInfo.disparity;
                case 'noise'
                    trianglewave = sawtooth(double(trialInfo.tf * 2*pi * time - 2*pi*trialInfo.sf * rY * monitor_settings.arcmin_per_pix/ 60)+trialInfo.randphase2, .5);
                    shift = trianglewave * trialInfo.adjustment;                    
            end
                rX2 = rX;
end            


function [output] = crop(rX, rY, trialInfo, stimulus_dim, noniusLine, sigOrNoise)
    output.x = rX;
    output.y = rY;

    %Set the x-dimensions for the stimulus and pedestal box
    
            uRight = find( abs(output.x) < stimulus_dim(1) - noniusLine/2);
            %     uRight = find( output.rightX > -stimulus_dim(1) & output.rightX < stimulus_dim(1));


            output.x = output.x(uRight);% + monitor_settings.x_pix/2 + ((monitor_settings.x_pix/4)  * trial.signalSign) ;
            output.y = output.y(uRight) ;

            switch sigOrNoise
                case 'signal'
                    output.x = output.x + trialInfo.signalSign*(noniusLine/2 + stimulus_dim(1));
                case 'noise'
                    output.x = output.x - trialInfo.signalSign*(noniusLine/2 + stimulus_dim(1));
            end
end


function [which_bin, bin_edges] = binning(rY, min, max, bins)
    bin_edges = linspace(min, max, bins+1);
    [h,which_bin] = histc(rY, bin_edges);
end

 %make a background of 0 disparity dots with no dots in region where
 %stimulus will be placed 
%     
%     back_X      = single(rand(1, trial.nDots)) * monitor_settings.x_pix - monitor_settings.x_pix/2;
%     back_Y      = single(rand(1, trial.nDots)) * monitor_settings.y_pix -  monitor_settings.y_pix/2;
%     %Excludes the patch region from a background of dots
%     temp_X = back_X(back_X > -stimulus_dim(1) & back_X < stimulus_dim(1));
%     temp_Y = back_Y(back_X > -stimulus_dim(1) & back_X < stimulus_dim(1) );
%     
%     temp_X = temp_X(temp_Y < -stimulus_dim(2) - noniusLine | temp_Y > - noniusLine);
%     temp_Y = temp_Y(temp_Y < -stimulus_dim(2) - noniusLine | temp_Y > - noniusLine);    
%     temp_X = temp_X(temp_Y < noniusLine | temp_Y > stimulus_dim(2) + noniusLine);
%     temp_Y = temp_Y(temp_Y < noniusLine | temp_Y > stimulus_dim(2) + noniusLine);
%     back_X = back_X(back_X < -stimulus_dim(1) & back_X > -within | back_X < within & back_X > stimulus_dim(1));
%     back_Y = back_Y(back_X < -stimulus_dim(2) & back_X > -within | back_X < within & back_X > stimulus_dim(2));
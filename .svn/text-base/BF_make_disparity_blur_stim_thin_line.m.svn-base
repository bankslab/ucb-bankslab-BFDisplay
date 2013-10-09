function BF_make_disparity_blur_stim(distance, pedestal, eccentricity, db_stim_type, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye)
    global GL

    rand('seed',random_seed);
    % Calculate new fixation distance to move stimuli within display's native frusta
    distance_shifted = ShiftDiopters(distance,diopter_offset);
    
    % Calculate new reference-stimuli distance within display's native frusta
    pedestal_distance.x = ShiftDiopters(pedestal,diopter_offset)*sind(eccentricity/60);
    pedestal_distance.z = ShiftDiopters(pedestal,diopter_offset)*cosd(eccentricity/60);

    
    vertical_shift_deg = 0;    % In arcmin
    horizontal_shift_deg = 15;
    % Scale sizes     
    
    disparity_dot_FWHM_base = 60;                                                            % Guassian dot FWHM in arcmin (circle width = 4x this)
    gauss_stim_multiplier = 4;
    
    % Trying out random stimulus sizes:
    stimulus_size_adj = 0;              % In percentage      
    
    
    pink_noise_circle_diam_base = 80;                                                        % Pink-noise circle patch diameter in arcmin
    
    test_distance.x = ShiftDiopters((pedestal+depth_step),diopter_offset)*sind(eccentricity/60);
    test_distance.z = ShiftDiopters((pedestal+depth_step),diopter_offset)*cosd(eccentricity/60);
    
    fixation_cross_diam_deg = 30;                                                 % Fixation-cross diameter in arcmin
    
    nonius_length = 60;      % Length of nonius lines in arcmin.
    nonius_width = 0.001;       % Width   "  " 
    
    horizontal_direction = (rand > 0.5);
    
    % Nonius stimulus:
    if (db_stim_type == 3)  
        nonius_distance.z = ShiftDiopters(depth_step,diopter_offset);
    end
    
    
%     display(['Pedestal: ' num2str(pedestal)]);
%     display(['Shifted Pedestal: ' num2str(ShiftDiopters(pedestal,diopter_offset)*cos(eccentricity/60*pi/180))]);
%     display(['Test: ' num2str(pedestal+depth_step)]);
%     display(['Shifted Test: ' num2str(ShiftDiopters((pedestal+depth_step),diopter_offset)*cos(eccentricity/60*pi/180))]);
% %     



    % STIMULUS (REFERENCE)
    glPushMatrix();   
        % Reference
        if db_stim_type < 1
            glTranslatef(pedestal_distance.x,0,-pedestal_distance.z);
            % Disparity stimulus (small dot)
            % Scale size of stimulus to account for distance
            disparity_dot_FWHM_deg = disparity_dot_FWHM_base*(1 + stimulus_size_adj*rand);     
            if stimulus_order
                % Reference is above fixation
                vertical_offset = tand(disparity_dot_FWHM_deg*gauss_stim_multiplier/2/60 + fixation_cross_diam_deg/2/60 + vertical_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
%                 vertical_offset = tand(vertical_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
            else
                % Reference is below fixation
                vertical_offset = -tand(disparity_dot_FWHM_deg*gauss_stim_multiplier/2/60 + fixation_cross_diam_deg/2/60 + vertical_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
%                 vertical_offset = -tand(vertical_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
            end
            
            % Calculate new distances to move test stimuli within display's native frusta
            % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%             jitter = ShiftDiopters((pedestal),diopter_offset)*tand(.25); 
%             x_jitter = jitter*(rand-0.5);    
%             x_jitter = (1-2*horizontal_direction) * tand(1);
%             glTranslatef(x_jitter,vertical_offset,0);

            horizontal_offset = (1-2*horizontal_direction)*tand(disparity_dot_FWHM_deg*gauss_stim_multiplier/2/60*0 + horizontal_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
            glTranslatef(horizontal_offset,vertical_offset,0);

            disparity_dot_FWHM = tand(disparity_dot_FWHM_deg/60/2)*ShiftDiopters((pedestal),diopter_offset)*2;
            glPushMatrix();
%                 glScalef(disparity_dot_FWHM/2*1.25*gauss_stim_multiplier, disparity_dot_FWHM/2*1.25*gauss_stim_multiplier, 1);      % The 1.25 is because the texture has bounds of [-1.25 1.25], but the bind-to-square algorithm assums [-1 1]
                glScalef(disparity_dot_FWHM/10, disparity_dot_FWHM/2*gauss_stim_multiplier, 1);     
                BF_bind_texture_to_square(texname_static,2);
            glPopMatrix();
        elseif db_stim_type < 3
            glTranslatef(pedestal_distance.x,0,-pedestal_distance.z);
            % Pink noise stimulus (circular patch of 1/f noise)            
            % Scale size of stimulus to account for distance
            % To prevent the observer from comparing the sizes of the stimuli, randomly adjust their sizes
            pink_size_adj = 1.05 - 0.1*rand;            
            pink_noise_circle_diam_deg = pink_noise_circle_diam_base*(1 + stimulus_size_adj*rand);

            if stimulus_order
                % Reference is above fixation
%                 vertical_offset = tand(vertical_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
                vertical_offset = (tand((pink_noise_circle_diam_deg + vertical_shift_deg)/60)*ShiftDiopters((pedestal),diopter_offset))*0.5;
            else
                % Reference is below fixation
%                 vertical_offset = -tand(vertical_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
                vertical_offset = -(tand((pink_noise_circle_diam_deg + vertical_shift_deg)/60)*ShiftDiopters((pedestal),diopter_offset))*0.5;
            end
            
            % If it's the monocular condition, center the stimulus
            if db_stim_type == 1
                theta = atand(distance_shifted/(IPD/2));
                center_shift = ShiftDiopters(pedestal,diopter_offset)/tand(theta) - IPD/2;
                % Determine amount of additional jitter for test stimulus (to avoid reducing the task to a vernier comparison)
                jitter = 0.01*ShiftDiopters(pedestal,diopter_offset/tand(theta) - IPD/2);   
                x_jitter = jitter*(rand-0.5);  
                horizontal_offset = 0;
            else
                % Calculate new distances to move test stimuli within display's native frusta
                % Determine amount of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%                 jitter = ShiftDiopters(pedestal,diopter_offset)*tand(0.5); 
%                 x_jitter = jitter*(rand-0.5);    
                horizontal_offset = (1-2*horizontal_direction)*tand(pink_noise_circle_diam_deg/2/60 + horizontal_shift_deg/60)*ShiftDiopters((pedestal),diopter_offset);
                center_shift = 0;
                x_jitter = 0;                
            end
            
            pink_noise_circle_diam = tand(pink_noise_circle_diam_deg/60/2)*ShiftDiopters((pedestal),diopter_offset)*2;            
            glTranslatef(x_jitter+center_shift+horizontal_offset,vertical_offset,0);
            glPushMatrix();
                glScalef(pink_noise_circle_diam, pink_noise_circle_diam, 1);
                BF_bind_texture_to_circle(texname_static,17,1,rand*0.5-0.25,rand*0.5-0.25);
            glPopMatrix();  
        else
            % Nonius line
            vertical_offset = tand(disparity_dot_FWHM_deg/60/2*1.25+nonius_length/60/2)*nonius_distance.z;
            nonius_facelength = 2*tand(nonius_length/60/2)*nonius_distance.z;
            % Reference is always below fixation for the vernier task
            if (whichEye == 1)
                glTranslatef(0,-vertical_offset,-nonius_distance.z);
                glPushMatrix();
                   glScalef(nonius_width,nonius_facelength/2, 1);
                   BF_bind_texture_to_square(texname_static,2);
                glPopMatrix();                    
            end                       
        end
    glPopMatrix();
        
    % STIMULUS (TEST)
    glPushMatrix();
        if db_stim_type < 1
            glTranslatef(test_distance.x,0,-test_distance.z);
            % Disparity stimulus (small dot)              
            % Scale size of stimulus to account for distance
            disparity_dot_FWHM_deg = disparity_dot_FWHM_base*(1 + stimulus_size_adj*rand);    
            if stimulus_order
                % Reference is above fixation
                vertical_offset = -tand(disparity_dot_FWHM_deg*gauss_stim_multiplier/2/60 + fixation_cross_diam_deg/2/60 + vertical_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
%                 vertical_offset = -tand(vertical_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);            
            else
                % Reference is below fixation
                vertical_offset = tand(disparity_dot_FWHM_deg*gauss_stim_multiplier/2/60 + fixation_cross_diam_deg/2/60 + vertical_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
%                 vertical_offset = tand(vertical_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);            
            end
            % Calculate new distances to move test stimuli within display's native frusta
            % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%             jitter = ShiftDiopters(pedestal+depth_step,diopter_offset)*tand(0.25); 
%             x_jitter = jitter*(rand-0.5);   
%             x_jitter = (-1+2*horizontal_direction) * tand(1);
%             glTranslatef(x_jitter,vertical_offset,0);
            horizontal_offset = (-1+2*horizontal_direction)*tand(disparity_dot_FWHM_deg*gauss_stim_multiplier/2/60*0 + horizontal_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
            glTranslatef(horizontal_offset,vertical_offset,0);

            disparity_dot_FWHM = tand(disparity_dot_FWHM_deg/60/2)*ShiftDiopters((pedestal+depth_step),diopter_offset)*2;            
            glPushMatrix();
%                 glScalef(disparity_dot_FWHM/2*1.25*gauss_stim_multiplier, disparity_dot_FWHM/2*1.25*gauss_stim_multiplier, 1);      % The 1.25 is because the texture has bounds of [-1.25 1.25], but the bind-to-square algorithm assums [-1 1]
                glScalef(disparity_dot_FWHM/10, disparity_dot_FWHM/2*gauss_stim_multiplier, 1);     
                BF_bind_texture_to_square(texname_static,2);
            glPopMatrix();  
        elseif db_stim_type < 3
            glTranslatef(test_distance.x,0,-test_distance.z);            
            % Pink noise stimulus (circular patch of 1/f noise)
            % Scale size of stimulus to account for distance           
            % To prevent the observer from comparing the sizes of the stimuli, randomly adjust their sizes
            pink_size_adj = 1.05 - 0.1*rand;
            pink_noise_circle_diam_deg = pink_noise_circle_diam_base * (1 + stimulus_size_adj*rand);
    
            if stimulus_order
                % Reference is above fixation
                vertical_offset = -(tand((pink_noise_circle_diam_deg + vertical_shift_deg)/60)*ShiftDiopters((pedestal+depth_step),diopter_offset))*0.5;
%                 vertical_offset = -tand(vertical_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
            else
                % Reference is below fixation
                vertical_offset = (tand((pink_noise_circle_diam_deg + vertical_shift_deg)/60)*ShiftDiopters((pedestal+depth_step),diopter_offset))*0.5;
%                 vertical_offset = tand(vertical_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
            end
            % If it's the monocular condition, center the stimulus
            if db_stim_type == 1
                theta = atand(distance_shifted/(IPD/2));
                center_shift = ShiftDiopters(pedestal+depth_step,diopter_offset)/tand(theta) - IPD/2;
                % Determine amount of additional jitter for test stimulus (to avoid reducing the task to a vernier comparison)
                jitter = 0.01*ShiftDiopters(pedestal+depth_step,diopter_offset/tand(theta) - IPD/2);   
                x_jitter = jitter*(rand-0.5); 
                horizontal_offset = 0;
            else
                % Calculate new distances to move test stimuli within display's native frusta
                % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%                 jitter = ShiftDiopters((pedestal+depth_step),diopter_offset)*tand(1); 
%                 x_jitter = jitter*(rand-0.5); 
                horizontal_offset = (-1+2*horizontal_direction)*tand(pink_noise_circle_diam_deg/2/60 + horizontal_shift_deg/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
                center_shift = 0;
                x_jitter = 0;                
            end
            
            pink_noise_circle_diam = tand(pink_noise_circle_diam_deg/60/2)*ShiftDiopters((pedestal),diopter_offset)*2;
            glTranslatef(x_jitter+horizontal_offset+center_shift,vertical_offset,0);
            glPushMatrix();                 
                glScalef(pink_noise_circle_diam, pink_noise_circle_diam, 1);
                BF_bind_texture_to_circle(texname_static,17,1,rand*0.5-0.25,rand*0.5-0.25);
            glPopMatrix();
        else
            % Nonius line
            vertical_offset = tand(disparity_dot_FWHM_deg/60/2*1.25+nonius_length/60/2)*nonius_distance.z;
            nonius_facelength = 2*tand(nonius_length/60/2)*nonius_distance.z;
            % Test is always above fixation for the vernier task
            if (whichEye == 0)
                glTranslatef(0,vertical_offset,-nonius_distance.z);
                glPushMatrix();
                   glScalef(nonius_width,nonius_facelength/2, 1);
                   BF_bind_texture_to_square(texname_static,2);
                glPopMatrix();                    
            end
        end
    glPopMatrix();

return

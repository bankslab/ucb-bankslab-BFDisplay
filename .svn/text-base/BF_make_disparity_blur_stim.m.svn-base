function BF_make_disparity_blur_stim(distance, pedestal, eccentricity, db_stim_type, mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye)
    global GL
    
    rand('seed',random_seed);
    % Calculate new fixation distance to move stimuli within display's native frusta
%     distance_shifted = ShiftDiopters(distance,diopter_offset);
    distance_shifted = distance;
    
    % Calculate new reference-stimulus distance within display's native frusta
    pedestal_distance.x = ShiftDiopters(pedestal,diopter_offset)*sind(eccentricity/60);
    pedestal_distance.z = ShiftDiopters(pedestal,diopter_offset)*cosd(eccentricity/60);
    
    % Test-stimulus distance
    test_distance.x = ShiftDiopters((pedestal+depth_step),diopter_offset)*sind(eccentricity/60);
    test_distance.z = ShiftDiopters((pedestal+depth_step),diopter_offset)*cosd(eccentricity/60);
    
    vertical_shift_min = 30;            % In arcmin (distance between top of fixation cross and bottom of top stimulus)
    horizontal_shift_min = 60;          % Maximum horizontal offset between test and references (arcmin)
    
    line_length_base = 135;             % Length of line stimulus (min)
    line_width_base =  2.5;               % Width " "
            
    pink_noise_circle_diam_base = 90;   % Pink-noise circle patch diameter in arcmin
       
    fixation_cross_diam_min = 30;       % Fixation-cross diameter in arcmin
    
    horizontal_direction = (rand > 0.5);
    
    numdots = 45;                       % Detertmines density of random dots
    dotradius_arcmin = 2;
%      
%     % Nonius stimulus:
%     nonius_length = 60;         % Length of nonius lines in arcmin.
%     nonius_width = 0.001;       % Width   "
%     if (db_stim_type == 3)  
%         nonius_distance.z = ShiftDiopters(depth_step,diopter_offset);
%     end
%     
%     display(['Pedestal: ' num2str(pedestal)]);
%     display(['Shifted Pedestal: ' num2str(ShiftDiopters(pedestal,diopter_offset)*cos(eccentricity/60*pi/180))]);
%     display(['Test: ' num2str(pedestal+depth_step)]);
%     display(['Shifted Test: ' num2str(ShiftDiopters((pedestal+depth_step),diopter_offset)*cos(eccentricity/60*pi/180))]);
% 
% 
% pedestal
% stimulus_order

    % Fixation cross
    fixation_cross_diam_lin = tand(fixation_cross_diam_min/60/2)*distance_shifted*2;
    glPushMatrix();
        glTranslatef(0, 0, -distance_shifted);
        glScalef(fixation_cross_diam_lin/2, fixation_cross_diam_lin/2, 1);
        BF_bind_texture_to_square(texname_static,18);
    glPopMatrix();  

    % STIMULUS (REFERENCE)
    glPushMatrix();   
        % Reference
        if db_stim_type == 0
            glTranslatef(pedestal_distance.x,0,-pedestal_distance.z);            
            % Line stimulus            
            if stimulus_order
                % Reference is above fixation
                vertical_offset = tand(line_length_base/2/60 + fixation_cross_diam_min/2/60 + vertical_shift_min/60)*ShiftDiopters((pedestal),diopter_offset);
            else
                % Reference is below fixation
                vertical_offset = -tand(line_length_base/2/60 + fixation_cross_diam_min/2/60 + vertical_shift_min/60)*ShiftDiopters((pedestal),diopter_offset);
            end
            
            % Calculate new distances to move test stimuli within display's native frusta
            % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%             horizontal_offset = (1-2*horizontal_direction)*tand(horizontal_shift_min/2/60)*ShiftDiopters((pedestal),diopter_offset);
            jitter = ShiftDiopters((pedestal),diopter_offset)*tand(horizontal_shift_min/60); 
            horizontal_offset = jitter*(rand-0.5); 
            
            if mono
               % Monocular condition
               % Move the stimulus so that with zero jittering, it would be aligned with the fixation stimulus
                theta = atand(distance_shifted/(IPD/2));
                horizontal_offset = horizontal_offset + ShiftDiopters(pedestal,diopter_offset)/tand(theta) - IPD/2;                
            end
            
            % Move the stimulus into position
            glTranslatef(horizontal_offset,vertical_offset,0);

            % Find the scaling factors needed to correctly size the stimulus
            line_length_lin = tand(line_length_base/60/2)*ShiftDiopters((pedestal),diopter_offset)*2;
            line_width_lin = tand(4*line_width_base/60/2)*ShiftDiopters((pedestal),diopter_offset)*2;   % 4x because only 25% of the width of the texture is nonzero
            
            glPushMatrix();
                glScalef(line_width_lin/2, line_length_lin/2, 1);     
                BF_bind_texture_to_square(texname_static,23);
            glPopMatrix();
            
        elseif db_stim_type ==1        
            if stimulus_order
                % Reference is above fixation
                vertical_offset = (tand((pink_noise_circle_diam_base + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal),diopter_offset));
            else
                % Reference is below fixation
                vertical_offset = -(tand((pink_noise_circle_diam_base + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal),diopter_offset));
            end
                        
            % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%             horizontal_offset = (1-2*horizontal_direction)*tand(horizontal_shift_min/60)*ShiftDiopters((pedestal),diopter_offset);
            jitter = ShiftDiopters((pedestal),diopter_offset)*tand(horizontal_shift_min/60); 
            horizontal_offset = jitter*(rand-0.5);   

            if mono == 1
               % Monocular condition
               % Move the stimulus so that with zero jittering, it would be aligned with the fixation stimulus
                theta = atand(distance_shifted/(IPD/2));
                horizontal_offset = horizontal_offset + ShiftDiopters(pedestal,diopter_offset)/tand(theta) - IPD/2;                
            end
            
%             % Move the stimulus into position
%             glTranslatef(horizontal_offset,vertical_offset,0);     
%             
%             % Find the scaling factors needed to correctly size the stimulus            
%             pink_noise_circle_diam = tand(pink_noise_circle_diam_base/60/2)*ShiftDiopters((pedestal),diopter_offset)*2;            
%             glPushMatrix();
%                 glScalef(pink_noise_circle_diam, pink_noise_circle_diam, 1);
%                 BF_bind_texture_to_circle(texname_static,17,1,rand*0.5-0.25,rand*0.5-0.25);
%             glPopMatrix();  
%             
            
            %BF_make_rds_grating(distance, numdots, grating_orientation, cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcmin, texname_static)

            % Move the stimulus into position
            glTranslatef(pedestal_distance.x + horizontal_offset,vertical_offset,0);
            BF_make_rds_grating_hard_edge(pedestal_distance.z, numdots, 90, 1.35, pink_noise_circle_diam_base/60, 0, IPD, dotradius_arcmin, texname_static);
            
%         else
%             % Nonius line
%             vertical_offset = tand(line_length_min/60/2*1.25+nonius_length/60/2)*nonius_distance.z;
%             nonius_facelength = 2*tand(nonius_length/60/2)*nonius_distance.z;
%             % Reference is always below fixation for the vernier task
%             if (whichEye == 1)
%                 glTranslatef(0,-vertical_offset,-nonius_distance.z);
%                 glPushMatrix();
%                    glScalef(nonius_width,nonius_facelength/2, 1);
%                    BF_bind_texture_to_square(texname_static,2);
%                 glPopMatrix();                    
%             end                       
        end
    glPopMatrix();
        
    % STIMULUS (TEST)
    glPushMatrix();
        if db_stim_type == 0
            glTranslatef(test_distance.x,0,-test_distance.z);            
            % Line stimulus            
            if stimulus_order
                % Reference is above fixation
                vertical_offset = -tand(line_length_base/2/60 + fixation_cross_diam_min/2/60 + vertical_shift_min/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
            else
                % Reference is below fixation
                vertical_offset = tand(line_length_base/2/60 + fixation_cross_diam_min/2/60 + vertical_shift_min/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
            end
            
                % Calculate new distances to move test stimuli within display's native frusta
                % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%                 horizontal_offset = (-1+2*horizontal_direction)*tand(horizontal_shift_min/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
                jitter = ShiftDiopters((pedestal+depth_step),diopter_offset)*tand(horizontal_shift_min/60); 
                horizontal_offset = jitter*(rand-0.5);    
            if mono
               % Monocular condition
               % Move the stimulus so that with zero jittering, it would be aligned with the fixation stimulus
                theta = atand(distance_shifted/(IPD/2));
                horizontal_offset = horizontal_offset + ShiftDiopters(pedestal+depth_step,diopter_offset)/tand(theta) - IPD/2;                
            end
            % Move the stimulus into position
            glTranslatef(horizontal_offset,vertical_offset,0);

            % Find the scaling factors needed to correctly size the line
            line_length_lin = tand(line_length_base/60/2)*ShiftDiopters((pedestal+depth_step),diopter_offset)*2;
            line_width_lin = tand(4*line_width_base/60/2)*ShiftDiopters((pedestal+depth_step),diopter_offset)*2;   % 4x because only 25% of the width of the texture is nonzero
            
            glPushMatrix();
                glScalef(line_width_lin/2, line_length_lin/2, 1);     
                BF_bind_texture_to_square(texname_static,23);
            glPopMatrix();            
        elseif db_stim_type == 1
            % Pink noise stimulus (circular patch of 1/f noise)                          
            if stimulus_order
                % Reference is above fixation
                vertical_offset = -(tand((pink_noise_circle_diam_base + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal+depth_step),diopter_offset));
            else
                % Reference is below fixation
                vertical_offset = (tand((pink_noise_circle_diam_base + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal+depth_step),diopter_offset));
            end
                        
            % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
%             horizontal_offset = (-1+2*horizontal_direction)*tand(horizontal_shift_min/60)*ShiftDiopters((pedestal+depth_step),diopter_offset);
            jitter = ShiftDiopters((pedestal+depth_step),diopter_offset)*tand(horizontal_shift_min/60); 
            horizontal_offset = jitter*(rand-0.5);    
            if mono == 1
               % Monocular condition
               % Move the stimulus so that with zero jittering, it would be aligned with the fixation stimulus
                theta = atand(distance_shifted/(IPD/2));
                horizontal_offset = horizontal_offset + ShiftDiopters((pedestal+depth_step),diopter_offset)/tand(theta) - IPD/2;                
            end
            
%             % Move the stimulus into position
%             glTranslatef(horizontal_offset,vertical_offset,0);     
%             
%             % Find the scaling factors needed to correctly size the stimulus            
%             pink_noise_circle_diam = tand(pink_noise_circle_diam_base/60/2)*ShiftDiopters((pedestal+depth_step),diopter_offset)*2;            
% 
%             glPushMatrix();
%                 glScalef(pink_noise_circle_diam, pink_noise_circle_diam, 1);
%                 BF_bind_texture_to_circle(texname_static,17,1,rand*0.5-0.25,rand*0.5-0.25);
%             glPopMatrix();       
            

            % Move the stimulus into position
            glTranslatef(test_distance.x + horizontal_offset,vertical_offset,0);
            BF_make_rds_grating_hard_edge(test_distance.z, numdots, 90, 1.35, pink_noise_circle_diam_base/60, 0, IPD, dotradius_arcmin, texname_static);
                        
          
%         else
%             % Nonius line
%             vertical_offset = tand(line_length_min/60/2*1.25+nonius_length/60/2)*nonius_distance.z;
%             nonius_facelength = 2*tand(nonius_length/60/2)*nonius_distance.z;
%             % Test is always above fixation for the vernier task
%             if (whichEye == 0)
%                 glTranslatef(0,vertical_offset,-nonius_distance.z);
%                 glPushMatrix();
%                    glScalef(nonius_width,nonius_facelength/2, 1);
%                    BF_bind_texture_to_square(texname_static,2);
%                 glPopMatrix();                    
%             end
        end
    glPopMatrix();

return

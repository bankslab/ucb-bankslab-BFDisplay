function BF_make_disparity_blur_occ_stim(distance, pedestal, eccentricity, db_stim_type, mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye)
    global GL
    
    % Is the occluder in the center or surrounding the stimulus?
    center_occ = 0;
    
    rand('seed',random_seed);
    % Calculate new fixation distance to move stimuli within display's native frusta
    distance_shifted            = distance;
    
    % Calculate new reference-stimulus distance within display's native frusta
    pedestal_distance.x         = ShiftDiopters(pedestal,diopter_offset)*sind(eccentricity/60);
    pedestal_distance.z         = ShiftDiopters(pedestal,diopter_offset)*cosd(eccentricity/60);
    
    % Test-stimulus distance
    test_distance.x             = ShiftDiopters((pedestal+depth_step),diopter_offset)*sind(eccentricity/60);
    test_distance.z             = ShiftDiopters((pedestal+depth_step),diopter_offset)*cosd(eccentricity/60);
    
%     % Used for center occluder:     
%     vertical_shift_min          = 60;           % In arcmin (distance between middles of patches)
%     horizontal_shift_min        = 60;           % Maximum horizontal offset between test and references (arcmin)
%     
%     line_length_base            = 135;          % Length of line stimulus (min)
%     line_width_base             = 2.5;          % Width " "
%             
%     pink_noise_circle_diam_base = 88;           % Pink-noise circle patch diameter in arcmin
%     fixation_cross_diam_min     = 30;           % Fixation-cross diameter in arcmin
%     fixation_patch_width_min    = 390;          % Width of fixation surface in arcmin
%     fixation_patch_height_min   = 45;           % Height of fixation surface in arcmin

    
    % Used for surround occluders:
    vertical_shift_min          = 55;           % In arcmin (distance between top of fixation cross and bottom of top stimulus)
    horizontal_shift_min        = 60;           % Maximum horizontal offset between test and references (arcmin)
    
    line_length_base            = 135;          % Length of line stimulus (min)
    line_width_base             = 2.5;          % Width " "
            
%     pink_noise_circle_diam_base = 120;          % Pink-noise circle patch diameter in arcmin
    pink_noise_patch_height     = 120;
    
    % Randomize the size of the patch    
    
    pink_noise_patch_width      = 640;     
    
    fixation_cross_diam_min     = 45;           % Fixation-cross diameter in arcmin
    fixation_patch_width_min    = 480;          % Width of fixation surface in arcmin
    
    window_width_min            = 400;
    window_height_min           = 240;
    
    window_frame_thickness_min  = 90;
    
    
    
    
%     fixation_patch_height_min   = 45;         % Height of fixation surface in arcmin
    
    
    % Used for both types of occluder:
    horizontal_direction        = (rand > 0.5);
    numdots                     = 90;          % Detertmines density of random dots
    dotradius_arcmin            = 5;

% 5
% pedestal
% stimulus_order

% STIMULUS (REFERENCE)
    glPushMatrix();   
        if stimulus_order
            % Reference is above fixation
            if center_occ
                vertical_offset = (tand((vertical_shift_min)/2/60)*ShiftDiopters((pedestal),diopter_offset));
            else
                vertical_offset = (tand((pink_noise_patch_height + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal),diopter_offset));
            end
        else
            % Reference is below fixation
            if center_occ
                vertical_offset = -(tand((vertical_shift_min)/2/60)*ShiftDiopters((pedestal),diopter_offset));
            else
                vertical_offset = -(tand((pink_noise_patch_height + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal),diopter_offset));
            end
        end

        % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
        jitter              = 0;%ShiftDiopters((pedestal),diopter_offset)*tand(horizontal_shift_min/60); 
        horizontal_offset   = jitter*(rand-0.5);   

        if mono == 1
           % Monocular condition
           % Move the stimulus so that with zero jittering, it would be aligned with the fixation stimulus
            theta               = -atand((IPD/2)/distance_shifted);
            horizontal_offset   = -(pedestal_distance.z-distance_shifted)*tand(theta);                
        end

        % Move the stimulus into position
        glTranslatef(pedestal_distance.x + horizontal_offset,vertical_offset,0);
        
        
        BF_make_rds_rectangle(pedestal_distance.z, numdots, 1.35, pink_noise_patch_width/60, pink_noise_patch_height/60, IPD, dotradius_arcmin, texname_static);                   
    glPopMatrix();
        
    % STIMULUS (TEST)
    glPushMatrix();
        % Pink noise stimulus (circular patch of 1/f noise)                          
        if stimulus_order
            % Reference is above fixation
            if center_occ
                vertical_offset = -(tand((vertical_shift_min)/2/60)*ShiftDiopters((pedestal+depth_step),diopter_offset));
            else
                vertical_offset = -(tand((pink_noise_patch_height + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal+depth_step),diopter_offset));
            end          
        else
            % Reference is below fixation
            if center_occ            
                vertical_offset = (tand((vertical_shift_min)/2/60)*ShiftDiopters((pedestal+depth_step),diopter_offset));
            else
                vertical_offset = (tand((pink_noise_patch_height + vertical_shift_min + fixation_cross_diam_min)/2/60)*ShiftDiopters((pedestal+depth_step),diopter_offset));
            end
        end

        % Determine about of jitter for test stimulus (to avoid reducing the task to a vernier comparison)
        jitter              = 0; %ShiftDiopters((pedestal+depth_step),diopter_offset)*tand(horizontal_shift_min/60); 
        horizontal_offset   = jitter*(rand-0.5);    
        if mono == 1
           % Monocular condition
           % Move the stimulus so that with zero jittering, it would be aligned with the fixation stimulus
            theta               = -atand((IPD/2)/distance_shifted);
            horizontal_offset   = - (test_distance.z-distance_shifted)*tand(theta);               
        end

        % Move the stimulus into position
        glTranslatef(test_distance.x + horizontal_offset,vertical_offset,0);
        
        BF_make_rds_rectangle(test_distance.z, numdots, 1.35, pink_noise_patch_width/60, pink_noise_patch_height/60, IPD, dotradius_arcmin, texname_static);
%         BF_make_rds_rectangle(test_distance.z, numdots, 90, 1.35, pink_noise_circle_diam_base/60, 0, IPD, dotradius_arcmin, texname_static);
       glPopMatrix();
       
    % Fixation objects
    
    glPushMatrix();
        glTranslatef(0, 0, -distance_shifted+0.0001);
       
        if center_occ
            % Draw fixation patch in the center
            glPushMatrix();
                n=[0 0 4];
                fixation_patch_width_lin = tand(fixation_patch_width_min/60/2)*distance_shifted*2;
                fixation_patch_height_lin = tand(fixation_patch_height_min/60/2)*distance_shifted*2;
                glScalef(fixation_patch_width_lin/2, fixation_patch_height_lin/2, 1);
                glBegin(GL.POLYGON);
                    % Assign n as normal vector for this polygons surface normal:
                    glColor3f(0,0,0);
                    glNormal3dv(n);
                    glVertex3dv([-1 -1 0]);
                    glVertex3dv([1 -1 0]);
                    glVertex3dv([1 1 0]);
                    glVertex3dv([-1 1 0]);
                glEnd;
                glLineWidth(3);            
                glBegin(GL.LINES);
                    % Assign n as normal vector for this polygons surface normal:
                    glColor3f(1,1,1);
                    glVertex3dv([-1 -1 0]);
                    glVertex3dv([1 -1 0]);
                    glVertex3dv([1 -1 0]);                
                    glVertex3dv([1 1 0]);
                    glVertex3dv([1 1 0]);              
                    glVertex3dv([-1 1 0]);
                    glVertex3dv([-1 1 0]);   
                    glVertex3dv([-1 -1 0]);                
                glEnd;
            glPopMatrix();
        else
            glPushMatrix();
                n=[0 0 4];

                window_width_lin            = tand(window_width_min/60/2)*distance_shifted*2;
                window_height_lin           = tand(window_height_min/60/2)*distance_shifted*2;
                window_frame_thickness_lin  = tand(window_frame_thickness_min/60/2)*distance_shifted*2;

    %             %%%%%%%%%%%%%%%%%%%
    %             %%%%%%%%%%%%%%%%%%%
    %             %% SOLID FRAME
    %             
    %             % Top edge
    %             glPushMatrix();
    %                 glTranslatef(0,window_height_lin/2 + window_frame_thickness_lin/2,0);
    %                 glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glColor3f(1,1,1);
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1 -1 0]);
    %                     glVertex3dv([1 -1 0]);
    %                     glVertex3dv([1 1 0]);
    %                     glVertex3dv([-1 1 0]);
    %                 glEnd;
    %             glPopMatrix();
    % 
    %             % Bottom edge
    %             glPushMatrix();
    %                 glTranslatef(0,-window_height_lin/2 - window_frame_thickness_lin/2,0);
    %                 glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1 -1 0]);
    %                     glVertex3dv([1 -1 0]);
    %                     glVertex3dv([1 1 0]);
    %                     glVertex3dv([-1 1 0]);
    %                 glEnd;
    %                 glLineWidth(3);            
    %             glPopMatrix();  
    % 
    %             % Left edge
    %             glPushMatrix();
    %                 glTranslatef(-window_width_lin/2 - window_frame_thickness_lin/2,0,0);
    %                 glScalef(window_frame_thickness_lin/2,window_height_lin/2 + window_frame_thickness_lin, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1 -1 0]);
    %                     glVertex3dv([1 -1 0]);
    %                     glVertex3dv([1 1 0]);
    %                     glVertex3dv([-1 1 0]);
    %                 glEnd;
    %             glPopMatrix(); 
    %             
    %             % Add black rectangle to block any portion of stimulus that
    %             % peaks out 
    %             glPushMatrix();
    %                 glTranslatef(-window_width_lin/2 - window_frame_thickness_lin*1.5,0,0.001);
    %                 glScalef(window_frame_thickness_lin/2,window_height_lin/2 + window_frame_thickness_lin, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glColor3f(0.001,0.001,0.001);
    %                     glNormal3dv(n);
    %                     glVertex3dv([-6 -1 0]);
    %                     glVertex3dv([1.05 -1 0]);
    %                     glVertex3dv([1.05 1 0]);
    %                     glVertex3dv([-6 1 0]);
    %                 glEnd;
    %             glPopMatrix(); 
    % 
    %             % Right edge
    %             glPushMatrix();
    %                 glTranslatef(window_width_lin/2 + window_frame_thickness_lin/2,0,0);
    %                 glScalef(window_frame_thickness_lin/2, window_height_lin/2 + window_frame_thickness_lin, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glColor3f(1,1,1);
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1 -1 0]);
    %                     glVertex3dv([1 -1 0]);
    %                     glVertex3dv([1 1 0]);
    %                     glVertex3dv([-1 1 0]);
    %                 glEnd;
    %             glPopMatrix();       
    %             glPushMatrix();
    %                 glTranslatef(window_width_lin/2 + window_frame_thickness_lin*1.5,0,0.001);
    %                 glScalef(window_frame_thickness_lin/2, window_height_lin/2 + window_frame_thickness_lin, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glColor3f(0.001,0.001,0.001);
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1.05 -1 0]);
    %                     glVertex3dv([6 -1 0]);
    %                     glVertex3dv([6 1 0]);
    %                     glVertex3dv([-1.05 1 0]);
    %                 glEnd;
    %             glPopMatrix();  
    %                         
    %             glPushMatrix();
    %                 glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
    %                 glBegin(GL.POLYGON);
    %                     glColor3f(1,1,1);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1 -1 0]);
    %                     glVertex3dv([1 -1 0]);
    %                     glVertex3dv([1 1 0]);
    %                     glVertex3dv([-1. 1 0]);
    %                 glEnd;
    %             glPopMatrix();       
    % % % %                
    % % % %                 % Note that these edges shouldn't require an occluded
    % % % %                 % recangle.  The lines are just to help the appearance of
    % % % %                 % an occluder
    % % % %                 glPushMatrix();
    % % % %                     glLineWidth(3);            
    % % % %                     glBegin(GL.LINES);
    % % % %                         % Assign n as normal vector for this polygons surface normal:
    % % % %                         glColor3f(1,1,1);
    % % % %                         glVertex3dv([-fixation_patch_width_lin/2 -fixation_patch_height_lin/2 0]);
    % % % %                         glVertex3dv([-fixation_patch_width_lin/2 fixation_patch_height_lin/2 0]);
    % % % %                         glVertex3dv([fixation_patch_width_lin/2 -fixation_patch_height_lin/2 0]);
    % % % %                         glVertex3dv([fixation_patch_width_lin/2 fixation_patch_height_lin/2 0]);
    % % % %                     glEnd;
    % % % %                 glPopMatrix();       


                %%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%
                %% WIREFRAME

                %% Blocking 
                % Top edge
                glColor3f(0.001,0.001,0.001);
                glPushMatrix();
                    glTranslatef(0,window_height_lin/2 + window_frame_thickness_lin/2,0);
                    glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-1 -1 0]);
                        glVertex3dv([1 -1 0]);
                        glVertex3dv([1 1 0]);
                        glVertex3dv([-1 1 0]);
                    glEnd;
                glPopMatrix();

                % Bottom edge
                glPushMatrix();
                    glTranslatef(0,-window_height_lin/2 - window_frame_thickness_lin/2,0);
                    glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-1 -1 0]);
                        glVertex3dv([1 -1 0]);
                        glVertex3dv([1 1 0]);
                        glVertex3dv([-1 1 0]);
                    glEnd;
                    glLineWidth(3);            
                glPopMatrix();  

                % Left edge
                glPushMatrix();
                    glTranslatef(-window_width_lin/2 - window_frame_thickness_lin/2,0,0);
                    glScalef(window_frame_thickness_lin/2,window_height_lin/2 + window_frame_thickness_lin, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-1 -1 0]);
                        glVertex3dv([1 -1 0]);
                        glVertex3dv([1 1 0]);
                        glVertex3dv([-1 1 0]);
                    glEnd;
                glPopMatrix(); 

                % Add black rectangle to block any portion of stimulus that
                % peaks out 
                glPushMatrix();
                    glTranslatef(-window_width_lin/2 - window_frame_thickness_lin*1.5,0,0.001);
                    glScalef(window_frame_thickness_lin/2,window_height_lin/2 + window_frame_thickness_lin, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-6 -1 0]);
                        glVertex3dv([1.05 -1 0]);
                        glVertex3dv([1.05 1 0]);
                        glVertex3dv([-6 1 0]);
                    glEnd;
                glPopMatrix(); 

                % Right edge
                glPushMatrix();
                    glTranslatef(window_width_lin/2 + window_frame_thickness_lin/2,0,0);
                    glScalef(window_frame_thickness_lin/2, window_height_lin/2 + window_frame_thickness_lin, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-1 -1 0]);
                        glVertex3dv([1 -1 0]);
                        glVertex3dv([1 1 0]);
                        glVertex3dv([-1 1 0]);
                    glEnd;
                glPopMatrix();       
                glPushMatrix();
                    glTranslatef(window_width_lin/2 + window_frame_thickness_lin*1.5,0,0.001);
                    glScalef(window_frame_thickness_lin/2, window_height_lin/2 + window_frame_thickness_lin, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-1.05 -1 0]);
                        glVertex3dv([6 -1 0]);
                        glVertex3dv([6 1 0]);
                        glVertex3dv([-1.05 1 0]);
                    glEnd;
                glPopMatrix();  

                glPushMatrix();
                    glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
                    glBegin(GL.POLYGON);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-1 -1 0]);
                        glVertex3dv([1 -1 0]);
                        glVertex3dv([1 1 0]);
                        glVertex3dv([-1. 1 0]);
                    glEnd;
                glPopMatrix();       

                % Lines

                glColor3f(1.0,1.0,1.0);
                glTranslatef(0,0,0.0001);
                glLineWidth(8);

                % Central top  
                glPushMatrix();
                    glBegin(GL.LINES);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-window_width_lin/2 window_height_lin/2 0]);
                        glVertex3dv([window_width_lin/2 window_height_lin/2 0]);
                        glVertex3dv([window_width_lin/2 window_height_lin/2*1.06 0]);
                        glVertex3dv([window_width_lin/2 window_frame_thickness_lin/2*0.84 0]);
                        glVertex3dv([window_width_lin/2 window_frame_thickness_lin/2 0]);
                        glVertex3dv([-window_width_lin/2 window_frame_thickness_lin/2 0]);
                        glVertex3dv([-window_width_lin/2 window_frame_thickness_lin/2*0.85 0]);
                        glVertex3dv([-window_width_lin/2 window_height_lin/2*1.06 0]);
                    glEnd;
                glPopMatrix();

                % Central bottom  
                glPushMatrix();
                    glBegin(GL.LINES);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-window_width_lin/2 -window_height_lin/2 0]);
                        glVertex3dv([window_width_lin/2 -window_height_lin/2 0]);
                        glVertex3dv([window_width_lin/2 -window_height_lin/2*1.06 0]);
                        glVertex3dv([window_width_lin/2 -window_frame_thickness_lin/2*0.84 0]);
                        glVertex3dv([window_width_lin/2 -window_frame_thickness_lin/2 0]);
                        glVertex3dv([-window_width_lin/2 -window_frame_thickness_lin/2 0]);
                        glVertex3dv([-window_width_lin/2 -window_frame_thickness_lin/2*0.85 0]);
                        glVertex3dv([-window_width_lin/2 -window_height_lin/2*1.06 0]);
                    glEnd;
                glPopMatrix();      

                % Outer frame 
                glLineWidth(5);
                glPushMatrix();
                    glBegin(GL.LINES);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-window_width_lin/2-window_frame_thickness_lin -window_height_lin/2-window_frame_thickness_lin 0]);
                        glVertex3dv([window_width_lin/2+window_frame_thickness_lin -window_height_lin/2-window_frame_thickness_lin 0]);
                        glVertex3dv([window_width_lin/2+window_frame_thickness_lin window_height_lin/2+window_frame_thickness_lin 0]);
                        glVertex3dv([-window_width_lin/2-window_frame_thickness_lin window_height_lin/2+window_frame_thickness_lin 0]);
                    glEnd;
                    glLineWidth(10);
                    glBegin(GL.LINES);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([window_width_lin/2+window_frame_thickness_lin -window_height_lin/2-window_frame_thickness_lin 0]);
                        glVertex3dv([window_width_lin/2+window_frame_thickness_lin window_height_lin/2+window_frame_thickness_lin 0]);
                        glVertex3dv([-window_width_lin/2-window_frame_thickness_lin window_height_lin/2+window_frame_thickness_lin 0]);
                        glVertex3dv([-window_width_lin/2-window_frame_thickness_lin -window_height_lin/2-window_frame_thickness_lin 0]);
                    glEnd;
                glPopMatrix();               

                
    %             % Bottom edge
    %             glPushMatrix();
    %                 glTranslatef(0,-window_height_lin/2 - window_frame_thickness_lin/2,0);
    %                 glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
    %                 glBegin(GL.POLYGON);
    %                     % Assign n as normal vector for this polygons surface normal:
    %                     glNormal3dv(n);
    %                     glVertex3dv([-1 -1 0]);
    %                     glVertex3dv([1 -1 0]);
    %                     glVertex3dv([1 1 0]);
    %                     glVertex3dv([-1 1 0]);
    %                 glEnd;
    %                 glLineWidth(3);            
    %             glPopMatrix();  
    %            

            glPopMatrix();
        end
        
        % Draw fixation cross
        glTranslatef(0, 0, 0.001);
        fixation_cross_diam_lin = tand(fixation_cross_diam_min/60/2)*distance_shifted*2;
        glScalef(fixation_cross_diam_lin/2, fixation_cross_diam_lin/2, 1);
        BF_bind_texture_to_square(texname_static,18);
    glPopMatrix();  

    

return

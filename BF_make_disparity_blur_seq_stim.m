function BF_make_disparity_blur_seq_stim(distance, pedestal, eccentricity, db_stim_type, mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye,current_stim)
    global GL
    
    % Is the occluder in the center or surrounding the stimulus?
    center_occ = 0;
    
    rand('seed',random_seed);
    % Calculate new fixation distance to move stimuli within display's native frusta
    distance_shifted            = distance;
    
    % Calculate new reference-stimulus distance within display's native frusta
    pedestal_distance.z         = ShiftDiopters(pedestal,diopter_offset)*cosd(eccentricity/60);
    
    % Test-stimulus distance
    test_distance.x             = ShiftDiopters((pedestal+depth_step),diopter_offset)*sind(eccentricity/60);
    test_distance.z             = ShiftDiopters((pedestal+depth_step),diopter_offset)*cosd(eccentricity/60);
    
    pink_noise_patch_height     = 300;    
    pink_noise_patch_width      = 640;         
    
    fixation_cross_diam_min     = 30;           % Fixation-cross diameter in arcmin
    fixation_patch_width_min    = 480;          % Width of fixation surface in arcmin
    
    window_width_min            = 400;
    window_height_min           = 240;
    
    window_frame_thickness_min  = 120;
    
    
%     fixation_patch_height_min   = 45;         % Height of fixation surface in arcmin
    
    
    % Used for both types of occluder:
    horizontal_direction        = (rand > 0.5);
    numdots                     = 300;          % Detertmines density of random dots
    dotradius_arcmin            = 5;

    
% Stimulus order of 1 means the reference is shows first

if (((stimulus_order == 1) && (current_stim == 1)) || ((stimulus_order == 0) && (current_stim == 2)))
% STIMULUS (REFERENCE)
    glPushMatrix();   

        if mono == 1
           % Monocular condition
           % Move the stimulus to be aligned with the fixation stimulus
            theta               = -atand((IPD/2)/distance_shifted);
            horizontal_offset   = -(pedestal_distance.z-distance_shifted)*tand(theta);                
        else
            horizontal_offset  = 0;
        end

        % Move the stimulus into position
        glTranslatef(horizontal_offset,0,0);
        
        BF_make_rds_rectangle(pedestal_distance.z, numdots, 1.35, pink_noise_patch_width/60, pink_noise_patch_height/60, IPD, dotradius_arcmin, texname_static);                   
    glPopMatrix();
        
else
    % STIMULUS (TEST)
    glPushMatrix();
        % Pink noise stimulus (circular patch of 1/f noise)

        if mono == 1
           % Monocular condition
           % Move the stimulus to be aligned with the fixation stimulus
            theta               = -atand((IPD/2)/distance_shifted);
            horizontal_offset   = - (test_distance.z-distance_shifted)*tand(theta);               
        else
            horizontal_offset  = 0;
        end

        % Move the stimulus into position
        glTranslatef(horizontal_offset,0,0);
        
        BF_make_rds_rectangle(test_distance.z, numdots, 1.35, pink_noise_patch_width/60, pink_noise_patch_height/60, IPD, dotradius_arcmin, texname_static);
       glPopMatrix();
end
    % Fixation objects
    
    glPushMatrix();
        glTranslatef(0, 0, -distance_shifted);
       
        glPushMatrix();
            n=[0 0 4];

            window_width_lin            = tand(window_width_min/60/2)*distance_shifted*2;
            window_height_lin           = tand(window_height_min/60/2)*distance_shifted*2;
            window_frame_thickness_lin  = tand(window_frame_thickness_min/60/2)*distance_shifted*2;
            fixation_cross_diam_lin     = tand(fixation_cross_diam_min/60/2)*distance_shifted*2;


            % Top edge
            glPushMatrix();
                glTranslatef(0,window_height_lin/2 + window_frame_thickness_lin/2,0);
                glScalef(window_width_lin/2, window_frame_thickness_lin/2, 1);
                glBegin(GL.POLYGON);
                    % Assign n as normal vector for this polygons surface normal:
                    glColor3f(1,1,1);
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
                    glColor3f(1,1,1);
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
                    glColor3f(1,1,1);
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
                    glColor3f(0.001,0.001,0.001);
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
                    glColor3f(1,1,1);
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
                    glColor3f(0.001,0.001,0.001);
                    glNormal3dv(n);
                    glVertex3dv([-1.05 -1 0]);
                    glVertex3dv([6 -1 0]);
                    glVertex3dv([6 1 0]);
                    glVertex3dv([-1.05 1 0]);
                glEnd;
            glPopMatrix();       
            glColor3f(1,1,1);

            % Patch behind fixation cross
            glPushMatrix();
                glScalef(fixation_cross_diam_lin,fixation_cross_diam_lin, 1);
                glBegin(GL.POLYGON);
                    % Assign n as normal vector for this polygons surface normal:
                    glNormal3dv(n);
                    glVertex3dv([-1 -1 0]);
                    glVertex3dv([1 -1 0]);
                    glVertex3dv([1 1 0]);
                    glVertex3dv([-1. 1 0]);
                glEnd;
            glPopMatrix();                     
        glPopMatrix();

        % Draw fixation cross
        glTranslatef(0, 0, 0.001);
        glScalef(fixation_cross_diam_lin/2, fixation_cross_diam_lin/2, 1);
        BF_bind_texture_to_square(texname_static,18);
    glPopMatrix();  

    

return

%Render the Scene
% function [] = BFRenderScene(whichEye, theta, rotatev, windowPtr, depthtex_id, depthtex_handle, depthplane)
% 
%     global GL;
%     global IPD;
    %%Render an eye
        % Light properties
    glDisable(GL.LIGHTING);

    % Material properties
    materialAmb     = [1 1 1 1];
    materialDiff    = [1 1 1 1];
    materialSpec    = [1.0 0.2 0.0 1];
    materialShin    = 50.0;

    % Sphere colors
    matSphereAmb    = builtin('single',materialAmb);
    matSphereDiff   = builtin('single',materialDiff);

    % Cube colors
    matCubeAmb      = builtin('single',[1 1 1 1]);
    matCubeDiff     = builtin('single',[1 1 1.0 1]);
    
    if strcmp(experiment_type, 'hinge')
        glDisable(GL.DEPTH_TEST);
        glPushMatrix();
        glTranslatef(0, 0, -imageplanedist(depthplane));
        vertFOV = 23.3;
		horizFOV = 32.6;
        glScalef(tan((horizFOV/2)*pi/180), tan((vertFOV/2)*pi/180), 1);
        %glScalef(0.1,0.1, 1);
        BF_bind_texture_to_square(texname_static, depthplane+whichEye*4);
        glPopMatrix();
    end
 
    if strcmp(experiment_type, 'alignmode') && trial_mode==0
        if depthplane==alignplane % This means that we are in the size calibration.
            if depthplane==alignplane
                dir=-1;
                horiztextureindex=3;
                verttextureindex=2;
            else
                dir=1;
                horiztextureindex=7;
                verttextureindex=6;
            end
            vernierdim=.015*imageplanedist(depthplane)/imageplanedist(4);
            vernierwidth=.001*imageplanedist(depthplane)/imageplanedist(4);


            if align_param==1
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));

                    glPushMatrix();
                    glTranslatef(vernierdim*dir,0, 0);
                    glScalef(vernierdim,vernierwidth,.0001);
                    BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed horizontal rectangle
                    glPopMatrix();
                glPopMatrix();
            elseif align_param==2
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));
                        glPushMatrix();
                            glTranslatef(0,-vernierdim*dir, 0);
                            glScalef(vernierwidth, vernierdim,.0001);
                            BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                        glPopMatrix();
                glPopMatrix();
                
            elseif align_param==3
                glPushMatrix();
                glRotatef(6, 0,1,0)
                glTranslatef(0, 0, -imageplanedist(depthplane));
                glTranslatef(0,-vernierdim*dir, 0);
                glScalef(vernierwidth, vernierdim,.0001);
                BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                glPopMatrix();
            elseif align_param==0 %show all the lines
                %dir= whichEye*2-1;
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));
                    glPushMatrix();
                    glTranslatef(vernierdim*dir,0, 0);
                    glScalef(vernierdim,vernierwidth,.0001);
                    BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed horizontal rectangle
                    glPopMatrix();
                glPopMatrix();
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));
                        glPushMatrix();
                            glTranslatef(0,-vernierdim*dir, 0);
                            glScalef(vernierwidth, vernierdim,.0001);
                            BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                        glPopMatrix();
                glPopMatrix();
                glPushMatrix();
                glRotatef(5, 0,1,0)
                glTranslatef(0, 0, -imageplanedist(depthplane));
                glTranslatef(0,-vernierdim*dir, 0);
                glScalef(vernierwidth, vernierdim,.0001);
                BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                glPopMatrix();
                glPushMatrix();
                glRotatef(5, 1,0,0)
                glTranslatef(0, 0, -imageplanedist(depthplane));
                glTranslatef(vernierdim*dir, 0,0);
                glScalef(vernierdim,vernierwidth, .0001);
                BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed vertical rectangle
                glPopMatrix();
            end



                
        end
    end   

    if strcmp(experiment_type, 'alignmode') && trial_mode==1
        if ((depthplane==alignplane) || (depthplane==alignplane-1))
            if depthplane==alignplane
                dir=-1;
                horiztextureindex=3;
                verttextureindex=2;
            else
                dir=1;
                horiztextureindex=7;
                verttextureindex=6;
            end
            vernierdim=.015*imageplanedist(depthplane)/imageplanedist(4);
            vernierwidth=.001*imageplanedist(depthplane)/imageplanedist(4);


            if align_param==1
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));

                    glPushMatrix();
                    glTranslatef(vernierdim*dir,0, 0);
                    glScalef(vernierdim,vernierwidth,.0001);
                    BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed horizontal rectangle
                    glPopMatrix();
                glPopMatrix();
            elseif align_param==2
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));
                        glPushMatrix();
                            glTranslatef(0,-vernierdim*dir, 0);
                            glScalef(vernierwidth, vernierdim,.0001);
                            BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                        glPopMatrix();
                glPopMatrix();
                
            elseif align_param==3
                glPushMatrix();
                glRotatef(6, 0,1,0)
                glTranslatef(0, 0, -imageplanedist(depthplane));
                glTranslatef(0,-vernierdim*dir, 0);
                glScalef(vernierwidth, vernierdim,.0001);
                BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                glPopMatrix();
            elseif align_param==0 %show all the lines
                %dir= whichEye*2-1;
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));
                    glPushMatrix();
                    glTranslatef(vernierdim*dir,0, 0);
                    glScalef(vernierdim,vernierwidth,.0001);
                    BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed horizontal rectangle
                    glPopMatrix();
                glPopMatrix();
                glPushMatrix();
                %These are the center vernier lines
                    glTranslatef(0, 0, -imageplanedist(depthplane));
                        glPushMatrix();
                            glTranslatef(0,-vernierdim*dir, 0);
                            glScalef(vernierwidth, vernierdim,.0001);
                            BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                        glPopMatrix();
                glPopMatrix();
                glPushMatrix();
                glRotatef(8, 0,1,0)
                glTranslatef(0, 0, -imageplanedist(depthplane));
                glTranslatef(0,-vernierdim*dir, 0);
                glScalef(vernierwidth, vernierdim,.0001);
                BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                glPopMatrix();
                glPushMatrix();
                glRotatef(8, 1,0,0)
                glTranslatef(0, 0, -imageplanedist(depthplane));
                glTranslatef(vernierdim*dir, 0,0);
                glScalef(vernierdim,vernierwidth, .0001);
                BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed vertical rectangle
                glPopMatrix();
            end



                
        end
	end   

    
	if strcmp(stim_type, 'demomode')
        
      
		glEnable(GL.DEPTH_TEST);


		glPushMatrix();
		glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT, matCubeAmb);
		glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE, matCubeDiff);


		% groundplane

		glPushMatrix();
		glTranslatef(.02, -.04, -imageplanedist(4));
		glScalef(.2, 1.2, .3);
		glRotatef(-90,1,0, 0);
		BF_bind_texture_to_square(texname_static,12);
		glPopMatrix();    

		facesize=0.025;
		% glutSolidCube( size )

		glPushMatrix();
		glTranslatef(.035, -0.015, -imageplanedist(4));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();           
		% glutSolidCube( size )

		glPushMatrix();
		glTranslatef(-.00, -.015, -imageplanedist(3));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();  

		% glutSolidCube( size )

		glPushMatrix();
		glTranslatef(-.05, -.015, -imageplanedist(2));
% 		glTranslatef(-.0, -.0, -imageplanedist(2));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();  

		% glutSolidCube( size )
		if use3planeonly~=1
			glPushMatrix();
			glTranslatef(-.15, -.015, -imageplanedist(1));
			glScalef(facesize, facesize, 1);
			BF_bind_texture_to_square(texname_static,13);
			glPopMatrix();              
		end



		glPopMatrix();
            
           
% % % % %                 code for calling a textured surface that is exectured
% % % % %                 bound and cleared in runtime
% % %                 
% % %                 glPushMatrix();
% % %                 glTranslatef(0,.06, -.4);
% % %                 glScalef(.18,.05,.05);
% % %                 glRotatef(0, 0, 0, 1);
% % %                 BF_texture_plane;
% % %                 glPopMatrix();
% % % 
% % %                 glPushMatrix();
% % %                 glTranslatef(0,.06, -.4);
% % %                 glScalef(.05,.05,.05);
% % %                 glRotatef(0, 0, 0, 1);
% % %                 BF_bind_texture_to_square(texname_static,1);% Precomputed Luminance grating
% % %                 glPopMatrix();                
                             
                
                
                
                
%                 %code for calling a RDS stimulus (sine grating)
%                 glPushMatrix();
%                 %glTranslatef(0,-.06, -.4);
%                 %glRotatef(90, 0, 1, 0)
%                 %BF_make_rds_grating
%                 glCallList(RDS_list_index);
%                 glPopMatrix();
                
                
	end
	if strcmp(stim_type, 'demomode2')
		glEnable(GL.DEPTH_TEST);


		glPushMatrix();
		glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT, matCubeAmb);
		glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE, matCubeDiff);


		% groundplane

		glPushMatrix();
		glTranslatef(.02, -.04, -imageplanedist(4));
		glScalef(.2, 1.2, .3);
		glRotatef(-90,1,0, 0);
		BF_bind_texture_to_square(texname_static,12);
		glPopMatrix();    

		facesize=0.025;
		% glutSolidCube( size )

		glPushMatrix();
		glTranslatef(.035, -0.015, -imageplanedist(4));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();           
		% glutSolidCube( size )

		glPushMatrix();
		glTranslatef(-.00, -.015, -imageplanedist(3));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();  

		% glutSolidCube( size )

		glPushMatrix();
		glTranslatef(-.05, -.015, -imageplanedist(2));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();  

		% glutSolidCube( size )
		glPushMatrix();
		glTranslatef(-.15, -.015, -imageplanedist(1));
		glScalef(facesize, facesize, 1);
		BF_bind_texture_to_square(texname_static,13);
		glPopMatrix();              

		glPopMatrix();
            
           
% % % % %                 code for calling a textured surface that is exectured
% % % % %                 bound and cleared in runtime
% % %                 
% % %                 glPushMatrix();
% % %                 glTranslatef(0,.06, -.4);
% % %                 glScalef(.18,.05,.05);
% % %                 glRotatef(0, 0, 0, 1);
% % %                 BF_texture_plane;
% % %                 glPopMatrix();
% % % 
% % %                 glPushMatrix();
% % %                 glTranslatef(0,.06, -.4);
% % %                 glScalef(.05,.05,.05);
% % %                 glRotatef(0, 0, 0, 1);
% % %                 BF_bind_texture_to_square(texname_static,1);% Precomputed Luminance grating
% % %                 glPopMatrix();                
                             
                
                
                
                
%                 %code for calling a RDS stimulus (sine grating)
%                 glPushMatrix();
%                 %glTranslatef(0,-.06, -.4);
%                 %glRotatef(90, 0, 1, 0)
%                 %BF_make_rds_grating
%                 glCallList(RDS_list_index);
%                 glPopMatrix();
	end
	
	if strcmp(stim_type, 'specularity');
        glEnable(GL.DEPTH_TEST);
%         glEnable(GL.LIGHTING);
%         glEnable(GL.LIGHT0);
%         glLightfv(GL.LIGHT0,GL.POSITION,[ 1 2 3 0 ]);
        glDisable(GL.LIGHTING);
        glColor3f(1,1,1);

        glEnable(surfaceGLTextureTarget);
        glBindTexture(surfaceGLTextureTarget, surfaceGLTexture);
        glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
        glTexParameteri(surfaceGLTextureTarget, GL.TEXTURE_WRAP_S, GL.REPEAT);
        glTexParameteri(surfaceGLTextureTarget, GL.TEXTURE_WRAP_T, GL.REPEAT);
        glTexParameteri(surfaceGLTextureTarget, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
        glTexParameteri(surfaceGLTextureTarget, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
        glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT, matCubeAmb);
        glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE, matCubeDiff);

        glPushMatrix();
        glTranslatef(0, 0, -imageplanedist(2));
%             glScalef(1,1,0.5);
        sphereObject=gluNewQuadric;
%         glEnable(leftSurfaceTextureTarget);
%         glBindTexture(leftSurfaceTextureTarget,leftSurfaceTexture);
%         glEnable(GL.TEXTURE_2D);
%         glBindTexture(GL.TEXTURE_2D,texname_static(13));
        gluQuadricTexture(sphereObject,GL.TRUE);
        glRotatef(-90, 1,0,0);
        gluSphere(sphereObject,sphereRadius,100,100);
%         glutSolidSphere(0.02,100,100);
        surfaceScaling=(surfaceScaleIndex-1)/10;
        glScalef(1,1,surfaceScaling);
        glPopMatrix();

        glEnable(GL.BLEND);
        glBlendFunc(GL.SRC_ALPHA,GL.ONE_MINUS_SRC_ALPHA);
%         glEnable(GL.DEPTH_TEST);
%         glEnable(GL.LIGHTING);
%         glEnable(GL.LIGHT0);
%         glLightfv(GL.LIGHT0,GL.POSITION,[ 1 2 3 0 ]);
%         glDisable(GL.LIGHTING);
%             glClearColor(0,0,0,0.5);

        glEnable(reflectionGLTextureTarget);
%             glBindTexture(GL.TEXTURE_2D, leftSurfaceGLTexture);
        glBindTexture(reflectionGLTextureTarget, reflectionGLTexture);
        glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
        glTexParameteri(reflectionGLTextureTarget, GL.TEXTURE_WRAP_S, GL.REPEAT);
        glTexParameteri(reflectionGLTextureTarget, GL.TEXTURE_WRAP_T, GL.REPEAT);
        glTexParameteri(reflectionGLTextureTarget, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
        glTexParameteri(reflectionGLTextureTarget, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
        glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT, matCubeAmb);
        glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE, matCubeDiff);

        glPushMatrix();
        glTranslatef(0, 0, -imageplanedist(2)+0.0001);
%             glScalef(1,1,0.5);
        sphereObject=gluNewQuadric;
%         glEnable(leftSurfaceTextureTarget);
%         glBindTexture(leftSurfaceTextureTarget,leftSurfaceTexture);
%         glEnable(GL.TEXTURE_2D);
%         glBindTexture(GL.TEXTURE_2D,texname_static(13));
        gluQuadricTexture(sphereObject,GL.TRUE);
        glRotatef(-90, 1,0,0);
        gluSphere(sphereObject,sphereRadius,100,100);
%         glutSolidSphere(0.02,100,100);
        reflectionScaling=(reflectionScaleIndex-1)/10;
        glScalef(1,1,reflectionScaling);
        glPopMatrix();
        glDisable(GL.BLEND);

    end
    
	if strcmp(stim_type, 'disparity_blur_stim');      
		glPushMatrix();
			BF_make_disparity_blur_stim(vergdist, pedestal, eccentricity, db_stim_type,mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye);
		glPopMatrix();   
	end

	if strcmp(stim_type, 'disparity_blur_occlusion_stim');      
		glPushMatrix();
			BF_make_disparity_blur_occ_stim(vergdist, pedestal, eccentricity, db_stim_type,mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye);
		glPopMatrix();   
	end

	if strcmp(stim_type, 'disparity_blur_sequential_stim');      
		glPushMatrix();
		if (current_stim == 1)
			BF_make_disparity_blur_seq_stim(vergdist, pedestal, eccentricity, db_stim_type,mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed,whichEye,current_stim);
		else
			BF_make_disparity_blur_seq_stim(vergdist, pedestal, eccentricity, db_stim_type,mono, depth_step, IPD, texname_static,stimulus_order,diopter_offset,random_seed_two,whichEye,current_stim);
		end
		glPopMatrix();   
	end
        
     
	if strcmp(stim_type, 'fuse_stim')      
		%code for calling a RDS stimulus (sine grating)
		glPushMatrix();
		%glTranslatef(0,-.06, -.4);
		%glRotatef(90, 0, 1, 0)
		%BF_make_rds_grating
		glCallList(RDS_list_index);
		glPopMatrix();   
	end

	if strcmp(stim_type, 'rds_mask')      
		%code for calling a RDS stimulus (sine grating)
		glPushMatrix();
		%glTranslatef(0,-.06, -.4);
		%glRotatef(90, 0, 1, 0)
		%BF_make_rds_grating
		glCallList(RDSmask_list_index);
		glPopMatrix();       
	end      
      
      if strcmp(stim_type, 'fixation_cross')
%           disp('Rendering Fixation Cross')
%           vergdist*1000
        glPushMatrix();
            if (strcmp(experiment_type, 'disparity_blur')) 
%                 glTranslatef(0, 0, -ShiftDiopters(vergdist,diopter_offset));

             % Used for surround occluders:
                distance_shifted            = vergdist;
             	vertical_shift_min          = 55;           % In arcmin (distance between top of fixation cross and bottom of top stimulus)
                pink_noise_patch_height     = 120;
                pink_noise_patch_width      = 640;

                fixation_cross_diam_min     = 30;           % Fixation-cross diameter in arcmin
                fixation_patch_width_min    = 480;          % Width of fixation surface in arcmin
                glPushMatrix();
                    glTranslatef(0, 0, -vergdist);
                    n=[0 0 4];
                    fixation_patch_width_lin = tand(fixation_patch_width_min/60/2)*distance_shifted*2;
                    fixation_patch_height_lin = (tand((pink_noise_patch_height + vertical_shift_min + fixation_cross_diam_min)/2/60))*distance_shifted*2;
                    % Top edge
                    glPushMatrix();
                        glTranslatef(0,fixation_patch_height_lin*3/4,0);
                        glScalef(fixation_patch_width_lin/2, fixation_patch_height_lin/4, 1);
                        glBegin(GL.POLYGON);
                            % Assign n as normal vector for this polygons surface normal:
                            glColor3f(1,1,1);
                            glNormal3dv(n);
                            glVertex3dv([-1 -1 0]);
                            glVertex3dv([1 -1 0]);
                            glVertex3dv([1 1 0]);
                            glVertex3dv([-1 1 0]);
                        glEnd;
    %                     glLineWidth(3);            
    %                     glBegin(GL.LINES);
    %                         glColor3f(1,1,1);             
    %                         glVertex3dv([1 -1 0]);              
    %                         glVertex3dv([-1 -1 0]);
    %                     glEnd;
                    glPopMatrix();

                    % Bottom edge
                    glPushMatrix();
                        glTranslatef(0,-fixation_patch_height_lin*3/4,0);
                        glScalef(fixation_patch_width_lin/2, fixation_patch_height_lin/4, 1);
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
    %                     glBegin(GL.LINES);
    %                         % Assign n as normal vector for this polygons surface normal:
    %                         glColor3f(1,1,1);
    %                         glVertex3dv([1 1 0]);              
    %                         glVertex3dv([-1 1 0]);             
    %                     glEnd;
                    glPopMatrix();  

                    % Left edge
                    glPushMatrix();
                        glTranslatef(-fixation_patch_width_lin/2,0,0);
                        glScalef(fixation_patch_height_lin/4, fixation_patch_height_lin, 1);
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
                        glTranslatef(-(fixation_patch_width_lin/2+fixation_patch_height_lin/2),0,0.001);
                        glScalef(fixation_patch_height_lin/4, fixation_patch_height_lin, 1);
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
                        glTranslatef(fixation_patch_width_lin/2,0,0);
                        glScalef(fixation_patch_height_lin/4, fixation_patch_height_lin, 1);
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
                        glTranslatef(fixation_patch_width_lin/2+fixation_patch_height_lin/2,0,0.001);
                        glScalef(fixation_patch_height_lin/4, fixation_patch_height_lin, 1);
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
                    glPushMatrix();
                        glScalef(fixation_patch_width_lin, tand(fixation_cross_diam_min/2/60)*distance_shifted*2.5, 1);
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

                glTranslatef(0, 0, -vergdist);
                glTranslatef(0, 0, 0.001);
                glScalef(facesize, facesize, 1);
                BF_bind_texture_to_square(texname_static,18);
            elseif (strcmp(experiment_type, 'disparity_blur_sequential')  || strcmp(experiment_type, 'disparity_blur_occlusion'))
               distance_shifted            = vergdist;

                pink_noise_patch_height     = 300;    
                pink_noise_patch_width      = 640;         

                fixation_cross_diam_min     = 45;           % Fixation-cross diameter in arcmin
                fixation_patch_width_min    = 480;          % Width of fixation surface in arcmin

                window_width_min            = 400;
                window_height_min           = 240;

                window_frame_thickness_min  = 90;               
               
               glPushMatrix();
                    glTranslatef(0, 0, -distance_shifted+0.0001);

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
                glPushMatrix();
                    glLineWidth(5);
                    glBegin(GL.LINES);
                        % Assign n as normal vector for this polygons surface normal:
                        glNormal3dv(n);
                        glVertex3dv([-window_width_lin/2-window_frame_thickness_lin -window_height_lin/2-window_frame_thickness_lin 0]);
                        glVertex3dv([window_width_lin/2+window_frame_thickness_lin -window_height_lin/2-window_frame_thickness_lin 0]);
                        glVertex3dv([window_width_lin/2+window_frame_thickness_lin window_height_lin/2+window_frame_thickness_lin 0]);
                        glVertex3dv([-window_width_lin/2-window_frame_thickness_lin window_height_lin/2+window_frame_thickness_lin 0]);
                    glEnd;
                    glLineWidth(20);
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

                glTranslatef(0, 0, -vergdist);
                glTranslatef(0, 0, 0.001);
                glScalef(facesize, facesize, 1);
                BF_bind_texture_to_square(texname_static,18);
                
            else
                
                glTranslatef(0, 0, -vergdist);
                glScalef(facesize, facesize, 1);
                BF_bind_texture_to_square(texname_static,4);
            end
        glPopMatrix();  
      end
      
      if strcmp(stim_type, 'fixation_dot')
%           disp('Rendering Fixation Cross')
%           vergdist*1000
        glPushMatrix();
            if strcmp(experiment_type, 'disparity_blur')  
                glTranslatef(0, 0, -ShiftDiopters(vergdist,diopter_offset));
                glScalef(facesize*1.25, facesize*1.25, 1);      % The 1.25 is because the texture has bounds of [-1.25 1.25], but the bind-to-square algorithm assums [-1 1]
                BF_bind_texture_to_square(texname_static,16);
            else
                glTranslatef(0, 0, -vergdist);
                glScalef(facesize*1.25, facesize*1.25, 1);
                BF_bind_texture_to_square(texname_static,16);
            end
        glPopMatrix();  
      end      
      
      if strcmp(stim_type, 'maltese_cross')
%           disp('Rendering Fixation Cross')
%           vergdist*1000
        glPushMatrix();
            if strcmp(experiment_type, 'disparity_blur')  
                glTranslatef(0, 0, -ShiftDiopters(vergdist,diopter_offset));
                glScalef(facesize, facesize, 1);
                BF_make_maltese_cross(1,0.25,1)
            else
                glTranslatef(0, 0, -vergdist);
                glScalef(facesize, facesize, 1);
                BF_make_maltese_cross(1,0.25,1)
            end
        glPopMatrix();  
      end
      
      if strcmp(stim_type, 'pixel_grating')
%           disp('Rendering Fixation Cross')
%           vergdist*1000
        glPushMatrix();
            if strcmp(experiment_type, 'disparity_blur')  
                glTranslatef(0, 0, -ShiftDiopters(vergdist,diopter_offset));
                glScalef(facesize*1.5, facesize*1.5, 1);
                BF_make_pixel_grating(1,3)
%                 display(['Fixation shifted to ' num2str(-ShiftDiopters(vergdist,diopter_offset))]);
            else
                glTranslatef(0, 0, -vergdist);
                glScalef(facesize, facesize, 1);
                BF_make_pixel_grating(1,5)
            end
        glPopMatrix();  
      end      
      
      
      if strcmp(stim_type, 'vergence_check')
          glPushMatrix();
                facesize=target_sizezzz;
                glTranslatef(0, 0, -FarMidDist);
                glScalef(facesize, facesize, 1);
                BF_bind_texture_to_square(texname_static,18);
                glPopMatrix();
          glPushMatrix();
                facesize=target_sizezzz*NearDist/FarMidDist;
                glTranslatef(0, 0, -NearDist);
                glScalef(facesize, facesize, 1);
                BF_bind_texture_to_square(texname_static,18);
          glPopMatrix();                
      end
      
       
      if strcmp(stim_type, 'alignment_test')
          
          facesize=.02*MidpointMidMidDist/MidpointMidMidDist;  %These ratios are to get rid of size perspective
          xshift=.04*MidpointMidMidDist/MidpointMidMidDist; 
        glPushMatrix();
            glTranslatef(xshift, 0, -MidpointMidMidDist);
            glScalef(facesize, facesize, 1);
%             if strcmp(experiment_type, 'disparity_blur')  
%                 BF_bind_texture_to_square(texname_static,18);
%             else
                BF_bind_texture_to_square(texname_static,19);
%             end
        glPopMatrix();  
        facesize=.02*MidpointMidNearDist/MidpointMidMidDist;
        xshift=.04*MidpointMidNearDist/MidpointMidMidDist;
        glPushMatrix();
            glTranslatef(-xshift, 0, -MidpointMidNearDist);
            glScalef(facesize, facesize, 1);
%             if strcmp(experiment_type, 'disparity_blur')  
%                 BF_bind_texture_to_square(texname_static,18);
%             else
                BF_bind_texture_to_square(texname_static,19);
%             end
        glPopMatrix();          
        
        
      end
      
      
      
       if strcmp(stim_type, 'iodrects')
        glPushMatrix();
        glTranslatef(IPD/2, 0, -vergdist);
        glScalef(facesize, facesize, 1);
        BF_bind_texture_to_square(texname_static,4);
        glPopMatrix();  
       
        glPushMatrix();
        glTranslatef(-IPD/2, 0, -vergdist);
        glScalef(facesize, facesize, 1);
        BF_bind_texture_to_square(texname_static,4);
        glPopMatrix();            
          
          
      end          
          
          
      if strcmp(stim_type, 'rds_compare')      
                         %code for calling a RDS stimulus (sine grating)
                glPushMatrix();
                %glTranslatef(0,-.06, -.4);
                %glRotatef(90, 0, 1, 0)
                %BF_make_rds_grating
                glCallList(RDS_list_index);
                glPopMatrix(); 
                
      end

            
    
%             %I am not sure if this code is essential
%                 glDisable(GL.DEPTH_TEST);
%                 glDisable(GL.LIGHTING);
%                 glDisable(GL.COLOR_MATERIAL);
% 
%                 %Call DepthMatte(Disable)
%                 glDisable(GL.TEXTURE_1D);
%                 glDisable(GL.TEXTURE_GEN_S);
%                 glDisable(GL.TEXTURE_GEN_T);
%                 glDisable(GL.TEXTURE_GEN_R);
%                 glDisable(GL.TEXTURE_GEN_Q);
% 
%         %BFRebuildTextureMatrix('texture');        
%             %End of code of ambiguous value
%             

            
   % glMatrixMode(GL.PROJECTION);
    if strcmp(stim_type, 'aca_measure')

        if whichEye==1
            facesize=0.1;  % in units of meters
            % glutSolidCube( size )

            glPushMatrix();
            glTranslatef(0, 0, -aca_plane);
            glScalef(rulersize, rulersize/5, 1);
            BF_bind_texture_to_square(texname_static,15);
            glPopMatrix();      
        else
            % glutSolidCube( size )

            glPushMatrix();
            glTranslatef(line_pos, linesize, -aca_plane);
            glScalef(linesize/5, linesize, 1);
            BF_bind_texture_to_square(texname_static,2);
            glPopMatrix();
        end
    end
    if strcmp(stim_type, 'single_vision_zone_measure')

        disparate_pos=acc_plane*(IPD/2)*disparity;
        stim_angle=1.3; % intended angular size of the ruler
        stim_size=2*acc_plane*(512/402)*tand(stim_angle/2);
        if whichEye==0 % left eye
            glPushMatrix();
            glTranslatef(disparate_pos, 0, -acc_plane);
            glScalef(stim_size, stim_size, 1);
            BF_bind_texture_to_square(texname_static,13);
            glPopMatrix();
        else
            glPushMatrix();
            glTranslatef(-disparate_pos, 0, -acc_plane);
            glScalef(stim_size, stim_size, 1);
            BF_bind_texture_to_square(texname_static,13);
            glPopMatrix();   
        end
    end

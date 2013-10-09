%Render the Scene
% function [] = BFRenderScene(whichEye, theta, rotatev, windowPtr, depthtex_id, depthtex_handle, depthplane)
% 
%     global GL;
%     global IPD;
    %%Render an eye
        % Light properties



    
    % Setup perspective projection component
    
            glDisable(GL.TEXTURE_2D);
            glEnable(GL.LIGHTING);
            glEnable(GL.LIGHT0);
    

        % set up the projection
     %glMatrixMode(GL.MODELVIEW);
     %glLoadIdentity();
    
   
        %rebuild the texture matrix
        %BFRebuildTextureMatrix('projection');
    
     
   
        % Clear out the backbuffer: This also cleans the depth-buffer for
        % proper occlusion handling:
        % moglcore('glClear', mor(GL.COLOR_BUFFER_BIT,GL.DEPTH_BUFFER_BIT));
%         if strcmp(experiment_type, 'disparity_blur')  && whichEye==0
%                 %don't do the clear on the second viewport, and the images
%                 %will stack up
%                 %glClear();
%                 glClear(GL.DEPTH_BUFFER_BIT)
%                 glLoadIdentity;
%                 
%                 % to get back to normal operation always clear
%                 display('WARNING:   MAJOR HACK in ViewPORT SPECIFIC CALLS for ROBIN PILOT EXPERIMENT')
%                 
%         else
            glClear();
%         end   
        BFStereoProjection; %(whichEye, depthplane);
       
    

        %rebuild the texture matrix a second time
        %BFRebuildTextureMatrix('projection');
    
    
     glMatrixMode(GL.MODELVIEW);
     glLoadIdentity();
            
            
            
             
            
                 glActiveTexture(GL.TEXTURE0);
                 glMatrixMode(GL.TEXTURE);
                 glLoadIdentity();
                 glMatrixMode(GL.MODELVIEW);
            
                 glActiveTexture(GL.TEXTURE1);
                 
                 glBindTexture(GL.TEXTURE_1D, depthtex_id(depthtex_handle));
            
                 
            vecx=[1 0 0 0];
            vecy=[0 1 0 0];
            vecz=[0 0 1 0];
            vecw=[0 0 0 1];
            
            glActiveTexture(GL.TEXTURE1);
                glMatrixMode(GL.MODELVIEW);
                glPushMatrix();
                glLoadIdentity();
                glTexGeni(GL.S, GL.TEXTURE_GEN_MODE, GL.EYE_LINEAR);
                glTexGeni(GL.T, GL.TEXTURE_GEN_MODE, GL.EYE_LINEAR);
                glTexGeni(GL.R, GL.TEXTURE_GEN_MODE, GL.EYE_LINEAR);
                glTexGeni(GL.Q, GL.TEXTURE_GEN_MODE, GL.EYE_LINEAR);
                glTexGenfv(GL.S, GL.EYE_PLANE, vecx);
                glTexGenfv(GL.T, GL.EYE_PLANE, vecy);
                glTexGenfv(GL.Q, GL.EYE_PLANE, vecw);
                glPopMatrix();
                
                
                
            glTexGenfv(GL.R, GL.EYE_PLANE, vecz);
            
            
            
            
            
            glEnable(GL.TEXTURE_1D);
            
            glBindTexture(GL.TEXTURE_1D, depthtex_id(depthtex_handle));
            glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
            glDisable(GL.TEXTURE_2D);
            glEnable(GL.TEXTURE_GEN_S);
            glEnable(GL.TEXTURE_GEN_T);
            glEnable(GL.TEXTURE_GEN_R);
            glEnable(GL.TEXTURE_GEN_Q);
            
            
        %rebuild the texture matrix a second time
        rebuildmode='projection'; 
        BFRebuildTextureMatrix; %('projection');                 
                        
                 
            glMatrixMode(GL.MODELVIEW);     
            
   
       %Set up key fram
  
            %moglcore('glDisable',GL.TEXTURE_2D);
            %glDisable(GL.LIGHTING);
            %moglcore('glDisable',GL.LIGHT0);         
            
            
% % if depthplane==3 % && activelensmode  %I remove the active lens mode thing, because it always should be in active lens mode when the lens system is on
% %                 glColor3f(1, 1.0, 1.0);
% % 
% %             frameflagsize=.025;
% % 
% % 
% %     %Before doing eye translation insert box on frame key
% %   %happens to be the near distance frame
% %   
% %     if whichEye
% %         glPushMatrix();
% %         
% %         glRotatef(-horizFOV/2, 0,1,0)
% %         glRotatef(-vertFOV/2, 1,0,0) 
% %         glTranslatef(0,0, -(imageplanedist(depthplane)-depthoffset)/cos(horizFOV/2*3.1415/180)/cos(vertFOV/2*3.1415/180));
% %         glRotatef(-horizFOV/2, 0,1,0)
% %         glRotatef(vertFOV/2, 1,0,0)         
% % %         glScalef(1,1,.0001);
% % %         glutSolidCube(frameflagsize*imageplanedist(depthplane));
% %         glScalef(frameflagsize, frameflagsize*1.5, 1);
% %         BF_solid_square;
% % 
% %         glPopMatrix();         
% %     else
% %         glPushMatrix();
% %         
% %         glRotatef(horizFOV/2, 0,1,0)
% %         glRotatef(-vertFOV/2, 1,0,0) 
% %         glTranslatef(0,0, -imageplanedist(depthplane)/cos(horizFOV/2*3.1415/180)/cos(vertFOV/2*3.1415/180));
% %         glRotatef(horizFOV/2, 0,1,0)
% %         glRotatef(vertFOV/2, 1,0,0)         
% % %         glScalef(1,1,.0001);
% % %         glutSolidCube(frameflagsize*imageplanedist(depthplane));
% % 
% %         glScalef(frameflagsize, frameflagsize*1.5, 1);
% %         BF_solid_square;
% % 
% %         glPopMatrix(); 
% %     end
% % end
            
            glEnable(GL.LIGHTING);
            glEnable(GL.LIGHT0);      
            
            
            
            
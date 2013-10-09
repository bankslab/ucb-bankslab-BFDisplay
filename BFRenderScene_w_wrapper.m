%Render the Scene
% function [] = BFRenderScene(whichEye, theta, rotatev, windowPtr, depthtex_id, depthtex_handle, depthplane)
% 
%     global GL;
%     global IPD;
    %%Render an eye
        % Light properties


    % Material properties
%     materialAmb     = [1 1 1 1];
%     materialDiff    = [1 1 1 1];
%     materialSpec    = [1.0 0.2 0.0 1];
%     materialShin    = 50.0;
% 
%     % Sphere colors
%     matSphereAmb    = builtin('single',materialAmb);
%     matSphereDiff   = builtin('single',materialDiff);
% 
%     % Cube colors
%     matCubeAmb      = builtin('single',[1 1 1 1]);
%     matCubeDiff     = builtin('single',[1 1 1.0 1]);
%     
% 

 
    if (performalignment==1)
              
        if (depthplane==alignplane) || (depthplane==alignplane-1)
            if depthplane==alignplane
                dir=-1;
                horiztextureindex=3;
                verttextureindex=6;
            else
                dir=1;
                horiztextureindex=7;
                verttextureindex=2;
            end
            vernierdim=.015*imageplanedist(depthplane)/imageplanedist(4);
            vernierwidth=.001*imageplanedist(depthplane)/imageplanedist(4); 
            
                    glPushMatrix();         
                            %These are the center vernier lines
                            glTranslatef(0, 0, -imageplanedist(depthplane));
                            
                                glPushMatrix(); 
                                    glTranslatef(vernierdim*dir,0, 0);
                                    glScalef(vernierdim,vernierwidth,.0001);
                                    BF_bind_texture_to_square(texname_static,horiztextureindex);% Precomputed horizontal rectangle
                                glPopMatrix();
                                glPushMatrix(); 
                                    glTranslatef(0,-vernierdim*dir, 0);
                                    glScalef(vernierwidth, vernierdim,.0001);
                                    BF_bind_texture_to_square(texname_static,verttextureindex);% Precomputed vertical rectangle
                                glPopMatrix();  
                   glPopMatrix();             
                      
                   
                   %These are the offset lines for magnification
                   glPushMatrix();
                        glRotatef(8, 1,0,0)
                        glTranslatef(0, 0, -imageplanedist(depthplane));
                        glTranslatef(vernierdim*dir,0, 0);
                        glScalef(vernierdim,vernierwidth,.0001);
                        BF_bind_texture_to_square(texname_static, 2);% Precomputed horizontal rectangle
                   glPopMatrix();
                                
                                
                   glPushMatrix();
                        glRotatef(8, 0,1,0)
                        glTranslatef(0, 0, -imageplanedist(depthplane));
                        glTranslatef(0,vernierdim*dir, 0);
                        glScalef(vernierwidth, vernierdim,.0001);
                        BF_bind_texture_to_square(texname_static, 3);% Precomputed vertical rectangle
                    glPopMatrix();                        

                
        end
        
        
    else
%             glEnable(GL.DEPTH_TEST);
%             glPushMatrix();
%                 glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT, matSphereAmb);
%                 glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE, matSphereDiff);
% 
%                     % glutSolidSphere( radius, slices, stacks )
%                     glPushMatrix();
%                     glTranslatef(-.06,-.04,-.346);
%                     glutSolidSphere(0.007, 8, 8);
%                     glPopMatrix();
% 
%                     % glutSolidSphere( radius, slices, stacks )
%                     glPushMatrix();
%                     glTranslatef(0,-.04,-.46);
%                     glutSolidSphere(0.01, 8, 8);
%                     glPopMatrix();            
% 
%                      % glutSolidSphere( radius, slices, stacks )
%                     glPushMatrix();
%                     glTranslatef(.1,-.04,-.65);
%                     glutSolidSphere(0.015, 8, 8);
%                     glPopMatrix();           
% 
%             glPopMatrix();
%             
%             
%             glPushMatrix();
%                 glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT, matCubeAmb);
%                 glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE, matCubeDiff);
%                     % glutSolidCube( size )
%                     cubeSize    = .01;
%                     glPushMatrix();
%                     glTranslatef(0.08, 0.00, -imageplanedist(1));
%                     glutSolidCube(cubeSize);
%                     glPopMatrix();           
% 
%                     % glutSolidCube( size )
%                     glPushMatrix();
%                     glTranslatef(.03, .00, -imageplanedist(2));
%                     glutSolidCube(cubeSize);
%                     glPopMatrix();  
% 
%                     % glutSolidCube( size )
%                     glPushMatrix();
%                     glTranslatef(0, -.00, -imageplanedist(3));
%                     glutSolidCube(cubeSize);
%                     glPopMatrix();  
% 
%                     % glutSolidCube( size )
%                     glPushMatrix();
%                     glTranslatef(-.02, -.00, -imageplanedist(4));
%                     glutSolidCube(cubeSize);
%                     glPopMatrix();              
%     
%             glPopMatrix();
            
            
                %code for calling a textured surface that is exectured
                %bound and cleared in runtime
                %
%                 glPushMatrix();
%                 glTranslatef(0,.06, -.4);
%                 glScalef(.18,.05,.05);
%                 glRotatef(0, 0, 0, 1);
%                 BF_texture_plane;
%                 glPopMatrix();
% 
%                 glPushMatrix();
%                 glTranslatef(0,.06, -.4);
%                 glScalef(.05,.05,.05);
%                 glRotatef(0, 0, 0, 1);
%                 BF_bind_texture_to_square(texname_static,1);% Precomputed Luminance grating
%                 glPopMatrix();                
%                              
%                 
                
                
                
%                 %code for calling a RDS stimulus (sine grating)
%                 glPushMatrix();
%                 glTranslatef(0,-.06, -.4);
%                 %glRotatef(90, 0, 1, 0)
%                 %BF_make_rds_grating
%                 glCallList(RDS_list_index);
%                 glPopMatrix();
                
                
                glTranslatef(0.03,.030, -kinetic_dist);
                glutWireSphere(0.04, 25, 25);

                glTranslatef(-0.06,-.06, +(kinetic_dist)-(.8+1.2-kinetic_dist));
                glutWireSphere(0.05, 20, 20);
                
                
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

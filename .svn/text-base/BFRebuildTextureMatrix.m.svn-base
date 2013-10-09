% function BFRebuildTextureMatrix(rebuildmode)
% global nearClip;
% global farClip;
% global GL;


%code snippet from RebuildTextureMatrix(depth.c)

rtos=[0,0,0,0,  0,0,0,0, -1,0,0,0,  0,0,0,1];
%rtos=[0,0,0,0,  0,0,0,0, 0,0,0,0,  0,0,0,0];


        if (strcmp('projection', rebuildmode))

            glActiveTexture(GL.TEXTURE1);
            glMatrixMode(GL.TEXTURE);
            glLoadMatrixf(rtos);

            %Perform scaling and translationto normalize depth values to
            %frustum
%            glScalef(1,1,1 /(farClip-nearClip));
%            glTranslatef(0,0,farClip);

           
           if focus_cue_multiplier~=1

               glScalef(1,1,1/(farClip-nearClip));
               glTranslatef(0,0, nearClip-depthoffset);
               
                   glTranslatef(0,0,-vergdist);
                   glScalef(1,1, focus_cue_multiplier);
                   glTranslatef(0,0, vergdist);
                   
               %glTranslatef(0,0, -vergdist-depthoffset);
               %glScalef(1,1,focus_cue_multiplier);
               %glTranslatef(0,0,(vergdist+depthoffset)/focus_cue_multiplier);
               
           else
           glScalef(1,1,1/(farClip-nearClip));
           glTranslatef(0,0, nearClip-depthoffset);
           
           end
           
            %load all the matrix projection operations from the command list

        elseif (strcmp('texture', rebuildmode))
            glActiveTexture(GL.TEXTURE1);
            glMatrixMode(GL.TEXTURE);
            glLoadIdentity();
            %Load all the texture matrix operations

        end

glMatrixMode(GL.MODELVIEW);
glActiveTexture(GL.TEXTURE0);



            
%end of critical code from RebuildTextureMatrix
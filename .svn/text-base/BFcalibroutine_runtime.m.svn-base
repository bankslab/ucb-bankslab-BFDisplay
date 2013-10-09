%This is the routine that is done in run time to spatially distort the
%onscreen image so that straight lines project as straight
%This will correct prismatic effects from the glass and CRT nonlinearities

%Presently, there is no dynamic correction for the lens system
%Hopefully it will not be needed

%Chris Burns implemented a step by step calibration in
%SpatialCalibExample.m

%This code uses david's vectorization procedure
%Initial load time calculations done in BFloattimecalib.m

    
    
            % Read what's currently rendered in the back-buffer into
            % texture memory. 
            
   moglcore('glReadBuffer', GL.BACK); 
    
    
    Screen('BeginOpenGL', windowPtr);
    

    
            % Setup texture parameters
            moglcore('glTexEnvf', GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);   %GL.MODULATE was originally GL.REPLACCE
            moglcore('glTexParameteri',GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP);
            moglcore('glTexParameteri',GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP);
            moglcore('glTexParameteri',GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
            moglcore('glTexParameteri',GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
            
            %moglcore('glDisable', GL.TEXTURE_1D);
            moglcore('glEnable', GL.TEXTURE_2D);

            % Copy the rendered image into texture memory
            % Do not include the Alpha channel unless you need to.
            moglcore('glCopyTexImage2D', GL.TEXTURE_2D, 0, GL.RGB, 0, 0, texWidth, texHeight, 0);



            %     glBindTexture(GL.TEXTURE_2D);
            % Setup an orthographic projection that covers the entire
            % screen in pixel space.
            
            moglcore('glMatrixMode',GL.PROJECTION);
            moglcore('glLoadIdentity');

            % glOrtho(left, right, bottom, top, near, far)
            moglcore('glOrtho',0, windowWidth, 0, windowHeight, nearClip, farClip);
            %glOrtho(0, windowWidth, 0, windowHeight, nearClip, farClip);

            moglcore('glMatrixMode',GL.MODELVIEW);
            moglcore('glLoadIdentity');

            % Clear the buffer, we already copied it's contents into
            % texture memory, clear it to prepare for final drawing.


            %This Clear is important as the previous scene will peak around
            %the edges.  However, it is slow so we'll eliminate it for now
            %glClear;

            % Enable vertex arrays and texture coordinate arrays
            moglcore('glColor3f',1.0, 1.0, 1.0);  %This is important or it only draws what the last color state was

      %moglcore('glPushMatrix');
            moglcore('glTranslatef', 0, 0, -imageplanedist(depthplane));


            %moglcore('glEnable', GL.TEXTURE_2D);

            
            if whichEye==0
                
                moglcore('glEnableClientState',GL.VERTEX_ARRAY);
                moglcore('glVertexPointer', 3, GL.DOUBLE, 0, xyzcalibposL);
                moglcore('glEnableClientState', GL.TEXTURE_COORD_ARRAY);
                moglcore('glTexCoordPointer', 2, GL.DOUBLE, 0, xytexcoordsL);

                moglcore('glDrawArrays',GL.QUADS, 0, length(xyzcalibposL)/3 );
                
                
            elseif whichEye==1
                
                                
                moglcore('glEnableClientState', GL.VERTEX_ARRAY);
                moglcore('glVertexPointer',3, GL.DOUBLE, 0, xyzcalibposR);
                moglcore('glEnableClientState',GL.TEXTURE_COORD_ARRAY);
                moglcore('glTexCoordPointer', 2, GL.DOUBLE, 0, xytexcoordsR);

                moglcore('glDrawArrays', GL.QUADS, 0, length(xyzcalibposR)/3 );
                
            end
            
            




      %moglcore('glPopMatrix');

            %glDisable(GL.TEXTURE_2D);


            %glFlush;

            % Reenable lighting since it's used in the scene rendering.
            %glEnable(GL.LIGHTING);
                          
                
    % Finish OpenGL rendering into PTB window and check for OpenGL errors.
    Screen('EndOpenGL', windowPtr);
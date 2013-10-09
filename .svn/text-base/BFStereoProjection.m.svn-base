% function [] = BFStereoProjection( WhichEye, depthplane)
% 
% 
%    
%     
%     global nearClip;
%     global farClip;
%     global vertFOV;
%     global horizFOV;
%     global degvertoffset;
%     global deghorizoffset;
%     global vertFOVoffset;
%     global horizFOVoffset;
%     %global IPD;
%     global GL;

    
    glMatrixMode(GL.PROJECTION);
    glLoadIdentity();
	
	if (projection_type==0)
		%glFrustum(leftw,  rightw,  bottomw,  topw, clip_near,  clip_far);
		left=nearClip*tan((-horizFOV/2+deghorizoffset(depthplane+whichEye*4)-horizFOVoffset(depthplane+whichEye*4))*pi/180);
		right=nearClip*tan((+horizFOV/2+deghorizoffset(depthplane+whichEye*4)+horizFOVoffset(depthplane+whichEye*4))*pi/180);
		top=nearClip*tan((+vertFOV/2+degvertoffset(depthplane+whichEye*4)+vertFOVoffset(depthplane+whichEye*4))*pi/180);
		bottom=nearClip*tan((-vertFOV/2+degvertoffset(depthplane+whichEye*4)-vertFOVoffset(depthplane+whichEye*4))*pi/180);
		if strcmp(experiment_type,'demomode2')
			left=left+x_off*nearClip/imageplanedist(depthplane);
			right=right+x_off*nearClip/imageplanedist(depthplane);
			top=top+y_off*nearClip/imageplanedist(depthplane);
			bottom=bottom+y_off*nearClip/imageplanedist(depthplane);
		end
        glFrustum(left, right, bottom, top, nearClip, farClip);
    elseif (projection_type==1)
         %glFrustum(leftw,  rightw,  bottomw,  topw, clip_near,  clip_far);
		left=tan((-horizFOV/2+deghorizoffset(depthplane+whichEye*4)-horizFOVoffset(depthplane+whichEye*4))*pi/180);
		right=tan((+horizFOV/2+deghorizoffset(depthplane+whichEye*4)+horizFOVoffset(depthplane+whichEye*4))*pi/180);
		top=tan((+vertFOV/2+degvertoffset(depthplane+whichEye*4)+vertFOVoffset(depthplane+whichEye*4))*pi/180);
		bottom=tan((-vertFOV/2+degvertoffset(depthplane+whichEye*4)-vertFOVoffset(depthplane+whichEye*4))*pi/180);

        glOrtho(left, right, bottom, top, nearClip, farClip);
    else
        sca
        disp('You did not call a valid projection mode');
    end
        
        
        
	if strcmp(experiment_type,'demomode2')
		%glLookAt(eyex, eyey, eyez, atx, aty, atz, upx, upy, upz)
		gluLookAt(-IPD/2+whichEye*IPD+x_off, y_off,0, -IPD/2+whichEye*IPD, 0, -imageplanedist(depthplane), 0, 1, 0)
	else
		%glLookAt(eyex, eyey, eyez, atx, aty, atz, upx, upy, upz)
		gluLookAt(-IPD/2+whichEye*IPD, 0,0, -IPD/2+whichEye*IPD, 0, -1, 0, 1, 0)
		%displace the eyes but keep them in parallel gaze
	end
    

    
    

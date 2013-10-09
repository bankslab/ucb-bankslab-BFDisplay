function BF_make_maltese_cross(width_overall, arm_size,lines_on)
global GL;
% Creates a Maltese cross in OpenGL
% Assume the OpenGL environment has already been initialized

width_arm = width_overall * arm_size;

glBegin(GL.POLYGON);
    glVertex3f(0,0,0);
    % Bottom arm
    glVertex3f(-width_arm/2,-width_overall/2,0);
    glVertex3f(width_arm/2,-width_overall/2,0);  
    glVertex3f(0,0,0);
    % Rigth arm
    glVertex3f(width_overall/2,-width_arm/2,0);
    glVertex3f(width_overall/2,width_arm/2,0); 
    glVertex3f(0,0,0);
    % Top arm
    glVertex3f(width_arm/2,width_overall/2,0);
    glVertex3f(-width_arm/2,width_overall/2,0); 
    glVertex3f(0,0,0);
    % Left arm
    glVertex3f(-width_overall/2,width_arm/2,0);
    glVertex3f(-width_overall/2,-width_arm/2,0); 
    glVertex3f(0,0,0);
glEnd;

% If the polygon sides are too small to be painted as pixels, the cross can be outlined.
if lines_on
    %glLineWidth(1.0);
    %Draw lines to make sure no pixels are missed near the center
    glBegin(GL.LINES)
        glVertex3f(-width_arm/2,width_overall/2,0);
        glVertex3f(width_arm/2,width_overall/2,0); 
        
        glVertex3f(width_arm/2,width_overall/2,0); 
        glVertex3f(-width_arm/2,-width_overall/2,0);
    
        glVertex3f(-width_arm/2,-width_overall/2,0);
        glVertex3f(width_arm/2,-width_overall/2,0); 
        
        glVertex3f(width_arm/2,-width_overall/2,0); 
        glVertex3f(-width_arm/2,width_overall/2,0);
    glEnd();
    
    glBegin(GL.LINES)
        glVertex3f(width_overall/2,width_arm/2,0);
        glVertex3f(width_overall/2,-width_arm/2,0); 
        
        glVertex3f(width_overall/2,-width_arm/2,0); 
        glVertex3f(-width_overall/2,width_arm/2,0);
        
        glVertex3f(-width_overall/2,width_arm/2,0);
        glVertex3f(-width_overall/2,-width_arm/2,0); 
        
        glVertex3f(-width_overall/2,-width_arm/2,0);
        glVertex3f(width_overall/2,width_arm/2,0);    
    glEnd();
end
        
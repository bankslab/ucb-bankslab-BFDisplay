%This routine will compute any stimulus parameters and compile lists
%It will retrieve any needed parameters from the staircases
%Also, opportunity to recompute the projection matrices to produce
%vergence-accommodation cue conflicts


Screen('BeginOpenGL', windowPtr);

glDisable(GL.DEPTH_TEST);
if ~exist('genlist_start')
    genlist_start=glGenLists(17);  %Returns integer of first set of free display lists
end
genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices
static_scene_disp_list1=[0 1 2 3 4 5 6 7]+genlist_start+8;
wrap_texture_on_square=16+genlist_start;

for depthplane= 4: -1: 1
    depthtex_handle = depthplane;
    for whichEye=0:1
        glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
        BF_viewport_specific_GL_commands;
        glEndList();
        
        glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
        BFRenderScene_static;
        glEndList();
    end
end
Screen('EndOpenGL', windowPtr);

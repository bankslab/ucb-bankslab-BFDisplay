%This file is the prototype for the staircase method of measuring visual
%fatigue. 'Time to fuse' experiment is adopted due to similarity. Here four
%cases of staircase are measured, cues-consistent & cues-inconsistent # of
%staircases could be increased in later version according to the
%experimental configuration.

dumpworkspace=1;  %dump all variables to mat file for future reference.  

experiment_type='fatigue_dip0p1D'; % Experiment for measuring visual fatigue, staircase method
stim_type='single_vision_zone_measure';   %fuse_stim will show a sinusoidal depth random dot stereogram
%experiment_type='demomode';

trial_mode=1;   %Enter the presentation, and respond flavor of the program
show_verg_ref_dist=0;  %This is only useful for debugging.  It will print out the distances to screen

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time
renderviews= [0 1];  %0 is the left eye, 1 is the right eye
acc_plane=MidNearDist; % accommodation plane is MidNearDist plane.
disparity=0;

%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

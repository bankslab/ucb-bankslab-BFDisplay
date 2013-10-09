%This file is the prototype for the staircase method of measuring blur- and disparity-based detection thresholds


experiment_type='demomode';       % Experiment for measuring visual fatigue, staircase method
stim_type= 'disparity_blur_stim';
trial_mode=0;                           % Enter the presentation and respond flavor of the program
show_verg_ref_dist=0;

dynamic_mode=0;                         % 1 for time varying stimulus, 0 for a static stimulus
static_mode=1;                          % 1 to present a static scene, this will be precomputed in load time

                
renderviews= [0 1];                 % 0 is the left eye, 1 is the right eye
       
depth_step = .12;                  % Retrieve disparity (aka depth interval) (m)
db_stim_type = 1;                   % Retrieve stimulus type (0 = disp. only, 1 = blur only, 2 = both)
pedestal = 0.275;                    % Retrieve pedestal (m) (choose 0.37 or 0.30)
eccentricity = 0;                   % Retrieve eccentricity (arcmin)
stimulus_order = 1;                 % Retrieve whether the reference is above or below fixation
focus_cue_multiplier = 1;
mono = 0;
monocular = 2;
diopter_offset = 1/FarMidDist - 2.5;
vergdist =  ShiftDiopters(0.275,diopter_offset);         %(0.37 or 0.30)
random_seed = 5;

% depthoffset = FarMidDist - vergdist
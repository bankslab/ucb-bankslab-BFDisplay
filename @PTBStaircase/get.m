% Mostly written by Björn Vlaskamp.  Modified by Robin held
function [uit s] = get(s,varargin)
% SET Set asset properties and return the updated object
propertyArgIn = varargin;
while length(propertyArgIn) >= 1,
   prop = propertyArgIn{1};
   propertyArgIn = propertyArgIn(2:end);
   switch prop
       case 'complete',
           uit = s.complete;
       case 'condition_num'
           uit = s. condition_num;
       case 'stimDistance',
           uit = s.stimDistance;
       case 'currentValue',
           if isempty(s.currentValue)
                disp('*********************************************')
                disp('You have not initialized this staircase')
                disp('Make sure that you have run the initializeStaircase routine')
                disp('*********************************************')
                 uit =NaN;
           else
               uit = s.currentValue;
           end
       case 'altVariable'
           uit = s.altVariable;
       case 'values'
           uit = s.values;
       case 'reversalflag'
           uit = s.reversalflag;
	   case 'elevationAngle'
		   uit = s.elevationAngle;
	   case 'rotationFrequency'
		   uit = s.rotationFrequency;
        case 'phase1_duration'
            uit = s.phase1_duration ;
       case 'phase1_duration_rpt';
           uit = s.phase1_duration_rpt;
        case 'phase1_stim'
            uit = s.phase1_stim;
        case 'phase1_verg_dist'
            uit = s.phase1_verg_dist;
        case 'phase1_accom_dist'
            uit = s.phase1_accom_dist;
        case 'phase1_focusmult'
            uit = s.phase1_focusmult;
        case 'phase2_duration'
            uit = s.phase2_duration ;       
        case 'phase2_stim'
            uit = s.phase2_stim;
        case 'phase2_verg_dist'
            uit = s.phase2_verg_dist;
        case 'phase2_accom_dist'
            uit = s.phase2_accom_dist;
        case 'phase2_blend_on'
            uit = s.phase2_focusmult;
        case 'phase3_duration'
            uit = s.phase3_duration ;                 
        case 'align_parameter'
            uit = s.align_parameter;
        case 'align_plane'
            uit = s.align_plane;      
        case 'rds_grating_angularsize'
            uit = s.rds_grating_angularsize;
        case 'rds_grating_numdots'
            uit = s.rds_grating_numdots;
        case 'rds_grating_orientation'
            uit = s.rds_grating_orientation;
        case 'rds_grating_cpd'
            uit = s.rds_grating_cpd;
        case 'rds_grating_disparity'
            uit = s.rds_grating_disparity;
        case 'eccentricity'
            uit = s.eccentricity;            
        case 'pedestal'
            uit = s.pedestal;
        case 'fixation_distance'
            uit = s.fixation_distance;            
        case 'blur_disparity_stim'
            uit = s.blur_disparity_stim;  
        case 'stim_order'
            uit = s.stim_order;
        case 'straightrun'
            uit = s.straightrun;
        case 'monocular'
            uit = s.monocular; 
        case 'initialValue'
            uit = s.initialValue; 
        case 'stepSize'
            uit = s.stepSize;  
        case 'training'
            uit = s.training;
        case 'MCS'
            uit = s.MCS;    
        case 'MCS_num_stimuli'
            uit = s.MCS_num_stimuli;    
        case 'MCS_stimuli'
            uit = s.MCS_stimuli;    
        case 'MCS_num_responses'
            uit = s.MCS_num_responses; 
        case 'MCS_max_responses'
            uit = s.MCS_max_responses;
        case 'algorithm'
            uit = s.algorithm;
        case 'angle_noise'
            uit = s.angle_noise;
        case 'initialized'
            uit = s.initialized;
        case 'front_plane'
            uit = s.front_plane;
        case 'tex_side'
            uit = s.tex_side;
        case 'responses'
            uit = s.responses;
   otherwise
      error('Property does not exist')
   end
end

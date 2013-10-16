% Mostly written by Bjorn Vlaskamp
function a = mystaircaseset(a,varargin)
property_argin = varargin;
while length(property_argin) >= 2,
    prop = property_argin{1};
    val = property_argin{2};
    property_argin = property_argin(3:end);
    switch prop
    case 'initialValue'
            a.initialValue = val;
        case 'condition_num'
            a.condition_num = val;
        case 'stepSize';
            a.stepSize = val;
        case 'tGuessSd'
           a.tGuessSd = val; 
        case 'maxReversals'
           a.maxReversals = val; 
        case 'maximumtrials'
            a.maximumtrials = val;
        case 'currentReversals'
           a.currentReversals = val; 
        case 'lastDirection'
           a.lastDirection = val;   
        case 'stimDistance'
           a.stimDistance = val;   
        case 'complete'
           a.complete = val;  
        case 'responses'
           a.responses = val;  
        case 'values'
            a.values = val;
        case 'stepLimit'
            a.stepLimit = val;
        case 'maxValue'
            a.maxValue = val; 
        case 'minValue'
            a.minValue = val; 
        case 'altVariable'
            a.altVariable = val;  
        case 'numUp'
            a.numUp = val;
        case 'numDown'
            a.numDown = val; 
        case 'initialValue_random_range'
            a.initialValue_random_range =val;
		case 'elevationAngle'
			a.elevationAngle=val;
		case 'rotationFrequency'
			a.rotationFrequency=val;
        case 'phase1_duration'
            a.phase1_duration =val;
        case 'phase1_duration_rpt'
            a.phase1_duration_rpt =val;
        case 'phase1_stim'
            a.phase1_stim=val;
        case 'phase1_verg_dist'
            a.phase1_verg_dist=val;
        case 'phase1_accom_dist'
            a.phase1_accom_dist=val;
        case 'phase1_focusmult'
            a.phase1_focusmult= val;
        case 'phase2_duration'
            a.phase2_duration =val;
        case 'phase2_stim'
            a.phase2_stim=val;
        case 'phase2_verg_dist'
            a.phase2_verg_dist=val;
        case 'phase2_accom_dist'
            a.phase2_accom_dist=val;
        case 'phase2_focusmult'
            a.phase2_focusmult= val;
        case 'phase3_duration'
            a.phase3_duration =val;            
        case 'align_parameter'
            a.align_parameter=val;
        case 'align_plane'
            a.align_plane=val;
        case 'rds_grating_angularsize'
            a.rds_grating_angularsize=val;
        case 'rds_grating_numdots'
            a.rds_grating_numdots=val;
        case 'rds_grating_orientation'
            a.rds_grating_orientation=val;
        case 'rds_grating_cpd'
            a.rds_grating_cpd=val;
        case 'rds_grating_disparity'
            a.rds_grating_disparity=val;
        case 'eccentricity'
            a.eccentricity=val;            
        case 'pedestal'
            a.pedestal=val; 
        case 'dixation_distance'
            a.dixation_distance=val;               
        case 'blur_disparity_stim'
            a.blur_disparity_stim=val; 
        case 'stim_order'
            a.stim_order=val;
        case 'straightrun'
            a.straightrun=val;
        case 'monocular'
            a.monocular=val;    
        case 'training'
            a.training=val;        
        case 'MCS'
            a.MCS=val;    
        case 'MCS_num_stimuli'
            a.MCS_num_stimuli=val;    
        case 'MCS_stimuli'
            a.MCS_stimuli=val;    
        case 'MCS_num_responses'
            a.MCS_num_responses=val; 
        case 'MCS_max_responses'
            a.MCS_max_responses=val;
        case 'algorithm'
            a.algorithm=val;
        case 'hinge_distance'
            a.hinge_dist=val;
        case 'focus_distance'
            a.focus_dist=val;
        case 'angle_noise'
            a.angle_noise=val;
        case 'initialized'
            a.initialized = val;
        otherwise
        if ischar(prop),
            error(['Property ' prop ' does not exist in this class!'])
        else
            disp('Property: ')
            disp(prop)
            error('Property does not exist in this class!')
        end
    end
end

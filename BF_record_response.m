if strcmp(experiment_type, 'alignmode')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%s\n', '#', int32(current_sc), (get(scell{current_sc}, 'currentValue')), int32(get(scell{current_sc}, 'align_plane')), int32(get(scell{current_sc}, 'align_parameter')),response,  strInputName);
    
elseif strcmp(experiment_type, 'timetofuse')
    fprintf(file_1, '%c\t%d\t%d\t%d\t%f\t%d\t%d\t%s\t%f\t%f\n', '#',  trial_counter, int32(current_sc), int32(get(scell{current_sc}, 'condition_num')), (get(scell{current_sc}, 'currentValue')), rpt_orientation, response, strInputName, (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_staircase')
    fprintf(file_1, '%c\t%d\t%d\t%d\t%f\t%d\t%d\t%s\t%f\t%f\t%f\t%f\n', '#',  trial_counter, int32(current_sc), int32(get(scell{current_sc}, 'condition_num')), (get(scell{current_sc}, 'currentValue')), rpt_orientation, response, strInputName, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_fixduration')
    fprintf(file_1, '%c\t%d\t%d\t%d\t%f\t%d\t%d\t%s\t%f\t%f\t%f\t%f\n', '#',  trial_counter, int32(current_sc), int32(get(scell{current_sc}, 'condition_num')), (get(scell{current_sc}, 'currentValue')), rpt_orientation, response, strInputName, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_assess1')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition, (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_assess2')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition+howmanyconditions, (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_assess3')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition+(2*howmanyconditions), (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_assess_sym0p1D')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition, (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_assess_sym1p3D')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition+howmanyconditions, (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_assess_sym2p5D')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition+(2*howmanyconditions), (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
elseif strcmp(experiment_type, 'fatigue_time_pilot_03')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\n', '#',  current_condition, (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, vergence_dist, accommodation_dist);
elseif strcmp(experiment_type, 'fatigue_time') || strcmp(experiment_type, 'fatigue_time_3')||strcmp(experiment_type,'fatigue_time_4')...
        ||strcmp(experiment_type,'fatigue_time_5')
    fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\n', '#',  current_condition,current_corrfreq, rpt_orientation, answer, response, vergdist, depthoffset+vergdist);
	if ~exist('record_data','var')
		record_data.subject=subject_initials;
		record_data.condition_order=condition_order;
		record_data.condition=current_condition;
		record_data.corrfreq=current_corrfreq;
		record_data.orientation=rpt_orientation;
		record_data.response=response;
		record_data.answer=answer;
		record_data.vergdist=vergdist;
		record_data.accdist=depthoffset+vergdist;
	else
		record_data.condition=[record_data.condition; current_condition];
		record_data.corrfreq=[record_data.corrfreq; current_corrfreq];
		record_data.orientation=[record_data.orientation; rpt_orientation];
		record_data.response=[record_data.response; response];
		record_data.answer=[record_data.answer; answer];
		record_data.vergdist=[record_data.vergdist; vergdist];
		record_data.accdist=[record_data.accdist; depthoffset+vergdist];
	end
elseif strcmp(experiment_type, 'fatigue_dip0p1D')
    fprintf(file_1, '%f\n', disparity);
    0.1+disparity
elseif strcmp(experiment_type, 'fatigue_dip1p3D')
    fprintf(file_1, '%f\n', disparity);
    1.3+disparity
elseif strcmp(experiment_type, 'fatigue_dip2p5D')
    fprintf(file_1, '%f\n', disparity);
    2.5+disparity
elseif strcmp(experiment_type, 'exp_aca')
    if exp_aca_phase==1
        fprintf(file_1, '%c\t%d\t%f\t%f\n', 'b', current_condition, acc_stim, acc_conv);
    elseif exp_aca_phase==2
        fprintf(file_1, '%c\t%d\t%f\t%d\t%d\t%d\t%f\t%f\t%f\t%f\n', '#',  current_condition, (get(scell{current_sc},'rds_grating_cpd')), rpt_orientation, response, answer, (get(scell{current_sc}, 'phase1_verg_dist')), (get(scell{current_sc}, 'phase1_accom_dist')), (get(scell{current_sc}, 'phase2_verg_dist')), (get(scell{current_sc}, 'phase2_accom_dist')));
    elseif exp_aca_phase==3
        fprintf(file_1, '%c\t%d\t%f\t%f\n', 'a', current_condition, acc_stim, acc_conv);
    end
elseif strcmp(experiment_type, 'cyl_structure')
    
    f_cue_diopters=1/(get(scell{current_sc}, 'phase1_verg_dist')-cyl_radius*focus_cue_multiplier)-1/(get(scell{current_sc}, 'phase1_verg_dist')+cyl_radius*focus_cue_multiplier);  %This line will calculate the dioptric difference for the focus cues 1/ (distance- radius(multiplier)) - 1/ (distance +radius(multiplier)
    
    fprintf(file_1, '%c\t%d\t%d\t%d\t%f\t%f\t%d\t%s\t%d\t%s\t%f\n', '#',  trial_counter, int32(current_sc), int32(get(scell{current_sc}, 'condition_num')), cyl_radius, (get(scell{current_sc}, 'currentValue')), rpt_orientation, veridical_rotation, response, strInputName, f_cue_diopters);
elseif (strcmp(experiment_type, 'disparity_blur') || strcmp(experiment_type, 'disparity_blur_occlusion') || strcmp(experiment_type, 'disparity_blur_sequential'))
    fprintf(file_1, '%c\t%d\t%d\t%d\t%f\t%d\t%d\t%d\t%d\t%s\n', '#',    trial_counter, int32(current_sc), int32(get(scell{current_sc}, 'condition_num')), (get(scell{current_sc}, 'currentValue')), (get(scell{current_sc}, 'eccentricity')), (get(scell{current_sc}, 'pedestal')), (get(scell{current_sc}, 'blur_disparity_stim')), response, strInputName);
end



%'%c\t %d\t %d\t %d\t %f\t %d\t %d\t %s\t %f\t %f\n', '#',  
%cd trial_counter
%d int32(current_sc)
%d int32(get(scell{current_sc}, 'condition_num'))
%f (get(scell{current_sc}, 'currentValue')), 
%d rpt_orientation, 
%d response, 
%s strInputName,
%f (get(scell{current_sc}, 'phase2_verg_dist'))
%f (get(scell{current_sc}, 'phase2_accom_dist')));


% '%c\t %d\t %d\t %d\t %f\t %d\t %d\t %d\t %d\t %s\n', '#',  
%cd trial_counter
%d int32(current_sc)
%d int32(get(scell{current_sc}, 'condition_num'))
%f (get(scell{current_sc}, 'currentValue')), 
%d (get(scell{current_sc}, 'eccentricity')), 
%d (get(scell{current_sc}, 'pedestal')), 
%d (get(scell{current_sc}, 'blur_disparity_stim')), 
%d response, 
%s strInputName,

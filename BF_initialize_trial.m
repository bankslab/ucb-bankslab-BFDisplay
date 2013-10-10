%This routine will compute any stimulus parameters and compile lists
%It will retrieve any needed parameters from the staircases
%Also, opportunity to recompute the projection matrices to produce
%vergence-accommodation cue conflicts


  Screen('BeginOpenGL', windowPtr);
  
  	% Specific Experiment Code
if strcmp(experiment_type, 'hing')
    glDisable(GL.DEPTH_TEST);
    genlist_start=glGenLists(17);  %Returns integer of first set of free display lists
    genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices
    static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;
    wrap_texture_on_square=16+genlist_start;
    
    for depthplane= 4: -1: 1
        depthtex_handle = depthplane;
        for whichEye=0:1
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
            
            glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end
end

if strcmp(stim_type,'aca_measure')

    genlist_start=glGenLists(16);  %Returns integer of first set of free display lists
    genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
    static_scene_disp_list1=[0 1 2 3 4 5 6 7]+genlist_start+8;

    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=0:1
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();

            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();

        end
    end
  
elseif strcmp(stim_type,'single_vision_zone_measure')

    genlist_start=glGenLists(16);  %Returns integer of first set of free display lists
    genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
    static_scene_disp_list1=[0 1 2 3 4 5 6 7]+genlist_start+8;

    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=0:1
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();

            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();

        end
    end
  
elseif strcmp(experiment_type, 'alignmode')

%     glDeleteLists(genlist_projection1(1), 8);
    %glDeleteLists(genlist_projection2(1), 8);
%     glDeleteLists(static_scene_disp_list1(1), 8);
    %glDeleteLists(static_scene_disp_list2(1), 8);


    alignplane= get(scell{current_sc}, 'align_plane');
    align_param= get(scell{current_sc}, 'align_parameter');


    if align_param==1
        degvertoffset(alignplane+renderviews*4)=get(scell{current_sc}, 'currentValue');
    elseif align_param==2
        deghorizoffset(alignplane+renderviews*4)=get(scell{current_sc}, 'currentValue');
    elseif align_param==3
            vertFOVoffset(alignplane+renderviews*4)=  -get(scell{current_sc}, 'currentValue')*vertFOV/horizFOV;
            horizFOVoffset(alignplane+renderviews*4)= -get(scell{current_sc}, 'currentValue');
    end
   
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

    if ~exist('static_scene_disp_list1', 'var')
        static_scene_disp_list1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end

    
elseif strcmp(experiment_type, 'timetofuse')
    

        stim_type=get(scell{current_sc}, 'phase1_stim');
        facesize=.01;
        vergdist=get(scell{current_sc}, 'phase1_verg_dist');
        depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
        focus_cue_multiplier=0;  
        
        
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

    
    if ~exist('static_scene_disp_list1', 'var')
        static_scene_disp_list1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end


        stim_type=get(scell{current_sc}, 'phase2_stim');
        vergdist=get(scell{current_sc}, 'phase2_verg_dist');
        depthoffset=get(scell{current_sc}, 'phase2_accom_dist')-get(scell{current_sc}, 'phase2_verg_dist');
        rpt_orientation= round(rand(1))*2-1;
    
        if ~exist('RDS_list', 'var')
            RDS_list_index=glGenLists(1);
        end
        glNewList(RDS_list_index, GL.COMPILE)
            %BF_make_rds_grating(distance, numdots, grating_orientation,
            %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)

            BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots'),...
                90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
                get(scell{current_sc}, 'rds_grating_cpd'), ...
                get(scell{current_sc}, 'rds_grating_angularsize'),...
                get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
        glEndList();
    
    
    if ~exist('genlist_projection2', 'var')
        genlist_projection2=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection2(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

    if ~exist('static_scene_disp_list2', 'var')
        static_scene_disp_list2=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list2(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end

%put up the RDS stimulus mask
%it has the same properties as the stimulus but random depth  (actually,
%just a very high cpd corrugation
        if ~exist('RDSmask_list_index', 'var')
            RDSmask_list_index=glGenLists(1);
        end
        glNewList(RDSmask_list_index, GL.COMPILE)
            %BF_make_rds_grating(distance, numdots, grating_orientation,
            %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)

            BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots')*4,...
                0, ...
                60, ...
                get(scell{current_sc}, 'rds_grating_angularsize')*2,...
                0.001, IPD, 1.0, texname_static);
        glEndList();
        stim_type='rds_mask';
    
    if ~exist('static_scene_disp_list3', 'var')
        static_scene_disp_list3=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list3(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    
    end
elseif (strcmp(experiment_type, 'fatigue_staircase') || strcmp(experiment_type, 'fatigue_fixduration'))
    

        stim_type=get(scell{current_sc}, 'phase1_stim');
        facesize=.01;
        vergdist=get(scell{current_sc}, 'phase1_verg_dist');
        depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
        focus_cue_multiplier=0;  
        
        
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

    
    if ~exist('static_scene_disp_list1', 'var')
        static_scene_disp_list1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end

    % Create RDS_list, genlist_projection2_3intervals,
    % static_scene_disp_list2_3intervals, for initialization of phase2.
    if ~exist('RDS_list', 'var')
        RDS_list=[0 1 2]+glGenLists(3);
    end
    % For 3 interval oddity test, we need 3 projection sets for phase 2:
    % genlist_projection2_3intervals has 24 elements.
    if ~exist('genlist_projection2_3intervals', 'var')
        genlist_projection2_3intervals=[0:23]+glGenLists(24);
    end
    % For 3 interval oddity test, we need 3 image sets for phase 2:
    % static_scene_disp_list2_3intervals has 24 elements.
    if ~exist('static_scene_disp_list2_3intervals', 'var')
        static_scene_disp_list2_3intervals=[0:23]+glGenLists(24);
    end
  
    phase2_odd_index=floor(3*rand); % To decide which rds image in phase2 would be odd.
    %phase2_odd_index=1; % To decide which rds image in phase2 would be odd.
    rpt_orientation= round(rand(1))*2-1;

    for phase2_index=0:2;
        % assign scell values to stim_type, vergdist, depthoffset.
        % use phase2 parameters for the second interval.
        % use phase1 parameters for the first and third intervals,
        if phase2_index==1
            stim_type=get(scell{current_sc}, 'phase2_stim');
            vergdist=get(scell{current_sc}, 'phase2_verg_dist');
            depthoffset=get(scell{current_sc}, 'phase2_accom_dist')-get(scell{current_sc}, 'phase2_verg_dist');
        else
            stim_type=get(scell{current_sc}, 'phase1_stim');
            vergdist=get(scell{current_sc}, 'phase1_verg_dist');
            depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
        end
        
        % producing RDS images
        RDS_list_index = RDS_list(phase2_index+1);
        orientation=rpt_orientation; % This variable is to make orientation difference in odd image
        if phase2_index==phase2_odd_index; % in this case, change the angle of the orientation
            orientation=-rpt_orientation; % makes orientation difference of +-20degree.
        end
        glNewList(RDS_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)
        BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots'),...
            90+orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
            get(scell{current_sc}, 'rds_grating_cpd'), ...
            get(scell{current_sc}, 'rds_grating_angularsize'),...
            get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
        glEndList();

        % producing genlist_projection2_3intervals
        for depthplane= 4: -1: 1
            depthtex_handle=depthplane ;
            for whichEye=renderviews
                glNewList(genlist_projection2_3intervals(phase2_index*8+whichEye*4+depthplane), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
        end
        
        % producing static_scene_disp_list2_3intervals
        for depthplane= 4: -1: 1
            depthtex_handle=depthplane ;
            for whichEye=renderviews
                glNewList(static_scene_disp_list2_3intervals(phase2_index*8+whichEye*4+depthplane), GL.COMPILE);
                BFRenderScene_static;
                glEndList();
            end
        end
    end
    
    %put up the RDS stimulus mask
    %it has the same properties as the stimulus but random depth  (actually,
    %just a very high cpd corrugation
    if ~exist('RDSmask_list_index', 'var')
        RDSmask_list_index=glGenLists(1);
    end
    glNewList(RDSmask_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)

        BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots')*4,...
            0, ...
            60, ...
            get(scell{current_sc}, 'rds_grating_angularsize')*2,...
            0.001, IPD, 1.0, texname_static);
    glEndList();
    stim_type='rds_mask';

    if ~exist('static_scene_disp_list3', 'var')
        static_scene_disp_list3=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list3(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    
    end

    
elseif strcmp(experiment_type, 'fatigue_assess1')||strcmp(experiment_type, 'fatigue_assess2')||strcmp(experiment_type, 'fatigue_assess3')...
        ||strcmp(experiment_type, 'fatigue_assess_sym0p1D')||strcmp(experiment_type, 'fatigue_assess_sym1p3D')||strcmp(experiment_type, 'fatigue_assess_sym2p5D')...
        ||strcmp(experiment_type, 'fatigue_assess_sym_training')
    
    stim_type=get(scell{current_sc}, 'phase1_stim');
    facesize=.01;
    vergdist=get(scell{current_sc}, 'phase1_verg_dist');
    depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
    focus_cue_multiplier=0;  
        
        
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

    
    if ~exist('static_scene_disp_list1', 'var')
        static_scene_disp_list1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end

    % Create RDS_list, genlist_projection2_3intervals,
    % static_scene_disp_list2_3intervals, for initialization of phase2.
    if ~exist('RDS_list', 'var')
        RDS_list=[0 1 2]+glGenLists(3);
    end
    % For 3 interval oddity test, we need 3 projection sets for phase 2:
    % genlist_projection2_3intervals has 24 elements.
    if ~exist('genlist_projection2_3intervals', 'var')
        genlist_projection2_3intervals=[0:23]+glGenLists(24);
    end
    % For 3 interval oddity test, we need 3 image sets for phase 2:
    % static_scene_disp_list2_3intervals has 24 elements.
    if ~exist('static_scene_disp_list2_3intervals', 'var')
        static_scene_disp_list2_3intervals=[0:23]+glGenLists(24);
    end
  
    phase2_odd_phase=floor(2*rand); % To decide which perspective would the odd phase have.
    phase2_odd_index=floor(3*rand); % To decide which rds image in phase2 would have odd orientation.
    %phase2_odd_index=1; % To decide which rds image in phase2 would be odd.
    rpt_orientation= round(rand(1))*2-1;

    for phase2_index=0:2;
        % assign scell values to stim_type, vergdist, depthoffset.
        % use phase2 parameters for the second interval.
        % use phase1 parameters for the first and third intervals,
        if phase2_index==1
            if phase2_odd_phase==0
                stim_type=get(scell{current_sc}, 'phase1_stim');
                vergdist=get(scell{current_sc}, 'phase1_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
            else
                stim_type=get(scell{current_sc}, 'phase2_stim');
                vergdist=get(scell{current_sc}, 'phase2_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase2_accom_dist')-get(scell{current_sc}, 'phase2_verg_dist');
            end
        else
            if phase2_odd_phase==0
                stim_type=get(scell{current_sc}, 'phase2_stim');
                vergdist=get(scell{current_sc}, 'phase2_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase2_accom_dist')-get(scell{current_sc}, 'phase2_verg_dist');
            else
                stim_type=get(scell{current_sc}, 'phase1_stim');
                vergdist=get(scell{current_sc}, 'phase1_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
            end
        end
        
        % producing RDS images
        RDS_list_index = RDS_list(phase2_index+1);
        orientation=rpt_orientation; % This variable is to make orientation difference in odd image
        if phase2_index==phase2_odd_index; % in this case, change the angle of the orientation
            orientation=-rpt_orientation; % makes orientation difference of +-20degree.
        end
        glNewList(RDS_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)
        BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots'),...
            90+orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
            get(scell{current_sc}, 'rds_grating_cpd'), ...
            get(scell{current_sc}, 'rds_grating_angularsize'),...
            get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
        glEndList();

        % producing genlist_projection2_3intervals
        for depthplane= 4: -1: 1
            depthtex_handle=depthplane ;
            for whichEye=renderviews
                glNewList(genlist_projection2_3intervals(phase2_index*8+whichEye*4+depthplane), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
        end
        
        % producing static_scene_disp_list2_3intervals
        for depthplane= 4: -1: 1
            depthtex_handle=depthplane ;
            for whichEye=renderviews
                glNewList(static_scene_disp_list2_3intervals(phase2_index*8+whichEye*4+depthplane), GL.COMPILE);
                BFRenderScene_static;
                glEndList();
            end
        end
    end
    
    %put up the RDS stimulus mask
    %it has the same properties as the stimulus but random depth  (actually,
    %just a very high cpd corrugation
    if ~exist('RDSmask_list_index', 'var')
        RDSmask_list_index=glGenLists(1);
    end
    glNewList(RDSmask_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)

        BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots')*4,...
            0, ...
            60, ...
            get(scell{current_sc}, 'rds_grating_angularsize')*2,...
            0.001, IPD, 1.0, texname_static);
    glEndList();
    stim_type='rds_mask';

    if ~exist('static_scene_disp_list3', 'var')
        static_scene_disp_list3=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list3(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    
    end

elseif strcmp(experiment_type, 'fatigue_time_pilot_03')
	focus_cue_multiplier=focus_cue(current_condition);
	vergdist=1/vergence_offset;

	if ~exist('genlist_projection', 'var')
		genlist_start=glGenLists(8);
		genlist_projection=[0 1 2 3 4 5 6 7]+genlist_start;
	end
	for depthplane= 4: -1: 1
		depthtex_handle=depthplane ;
		for whichEye=renderviews
			glNewList(genlist_projection(whichEye*4+depthplane), GL.COMPILE);
			BF_viewport_specific_GL_commands;
			glEndList();
		end
	end
    
	if ~exist('RDS_list', 'var')
		RDS_list_index=glGenLists(1);
	end
	if exist('rpt_orientation', 'var') % when it is called during the experiment
		% producing RDS images
		glNewList(RDS_list_index, GL.COMPILE)
		%BF_make_rds_grating(distance, numdots, grating_orientation,
		%cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)
		BF_make_rds_grating(1/vergence_offset,...
			get(scell{current_sc}, 'rds_grating_numdots'),...
			90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
			current_corrfreq, ...
			get(scell{current_sc}, 'rds_grating_angularsize'),...
			get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
		glEndList();
	end

elseif strcmp(experiment_type, 'fatigue_time') || strcmp(experiment_type,'fatigue_time_3') || strcmp(experiment_type,'fatigue_time_4')
    
	facesize=.01;
    rpt_orientation= 1-2*round(rand(1));

	if mod(current_condition,2)==1 % control session
		if conflict_length(ceil(current_condition/2))==-1
			vergdist=imageplanedist(4);
			conf_det=mod(trial_index,2);
			if conf_det==0
				depthoffset=0;
			elseif conf_det==1
				depthoffset=imageplanedist(2)-imageplanedist(4);
			end
		elseif conflict_length(ceil(current_condition/2))==0 % random vergence value
            ver_det=floor(2*rand(1)+1);
            if ver_det==1
                vergdist=imageplanedist(4); % larger vergence
                conf_det=floor(2*rand(1));
                if conf_det==0
                    depthoffset=0;
                elseif conf_det==1
                    depthoffset=imageplanedist(2)-imageplanedist(4);
                end
            elseif ver_det==2
                vergdist=imageplanedist(2); % smaller vergence
                depthoffset=0;
            end
        elseif mod(trial_index-1,2*conflict_length(ceil(current_condition/2)))>=conflict_length(ceil(current_condition/2)) % go to high ver & acc
            vergdist=imageplanedist(4);
            depthoffset=0;
        else % stay at default ver & acc
            vergdist=imageplanedist(2);
            depthoffset=0;
		end
	elseif mod(current_condition,2)==0 % conflict session
		if conflict_length(ceil(current_condition/2))==-1
			vergdist=imageplanedist(4);
			conf_det=mod(trial_index,2);
			if conf_det==0
				depthoffset=0;
			elseif conf_det==1
				depthoffset=imageplanedist(2)-imageplanedist(4);
			end
		elseif conflict_length(ceil(current_condition/2))==0 % random vergence value
            ver_det=floor(2*rand(1)+1);
            if ver_det==1
                vergdist=imageplanedist(4); % larger vergence
                conf_det=floor(2*rand(1));
                if conf_det==0
                    depthoffset=0;
                elseif conf_det==1
                    depthoffset=imageplanedist(2)-imageplanedist(4);
                end
            elseif ver_det==2
                vergdist=imageplanedist(2); % smaller vergence
                depthoffset=0;
            end
        elseif mod(trial_index-1,2*conflict_length(ceil(current_condition/2)))>=conflict_length(ceil(current_condition/2)) % give conflict
            vergdist=imageplanedist(4);
            depthoffset=imageplanedist(2)-imageplanedist(4);
        else % stay at default ver & acc
            vergdist=imageplanedist(2);
            depthoffset=0;
		end
	end
    focus_cue_multiplier=0;  
        
	if ~exist('RDS_list', 'var')
		RDS_list_index=glGenLists(1);
	end
	% producing RDS images
	glNewList(RDS_list_index, GL.COMPILE)
	if strcmp(experiment_type,'fatigue_time_3')||strcmp(experiment_type,'fatigue_time_4')
		BF_make_rds_grating(vergdist,...
			get(scell{current_sc}, 'rds_grating_numdots'),...
			90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
			current_corrfreq, ...
			get(scell{current_sc}, 'rds_grating_angularsize'),...
			get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
	else
		BF_make_rds_grating_on_gray(vergdist,...
			get(scell{current_sc}, 'rds_grating_numdots'),...
			90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
			current_corrfreq, ...
			get(scell{current_sc}, 'rds_grating_angularsize'),...
			get(scell{current_sc}, 'rds_grating_disparity'), IPD, 4, texname_static);
	end
%     BF_make_rds_grating(vergdist,...
%         get(scell{current_sc}, 'rds_grating_numdots'),...
%         90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
%         current_corrfreq, ...
%         get(scell{current_sc}, 'rds_grating_angularsize'),...
%         get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
	glEndList();

    if ~exist('genlist_projection2', 'var')
        genlist_projection2=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
	for depthplane= 4: -1: 1
		depthtex_handle=depthplane ;
		for whichEye=renderviews
			glNewList(genlist_projection2(whichEye*4+depthplane), GL.COMPILE);
			BF_viewport_specific_GL_commands;
			glEndList();
		end
	end

    if ~exist('static_scene_disp_list2', 'var')
        static_scene_disp_list2=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
	for depthplane= 4: -1: 1
		depthtex_handle=depthplane ;
		for whichEye=renderviews
			glNewList(static_scene_disp_list2(whichEye*4+depthplane), GL.COMPILE);
			BFRenderScene_static;
			glEndList();
		end
	end
    
elseif strcmp(experiment_type, 'fatigue_time_5')
    
	facesize=.01;
    rpt_orientation= 1-2*round(rand(1));

	if ~exist('RDS_list', 'var')
		RDS_list_index=glGenLists(1);
	end
	% producing RDS images
	glNewList(RDS_list_index, GL.COMPILE)
    BF_make_rds_grating(imageplanedist(2),...
        get(scell{current_sc}, 'rds_grating_numdots'),...
        90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
        current_corrfreq, ...
        get(scell{current_sc}, 'rds_grating_angularsize'),...
        get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
	glEndList();

elseif strcmp(experiment_type, 'focusVaryingStereo')
	facesize=.01;
    rpt_orientation= 1-2*round(rand(1));
    
    % load texture for the moving box
    if ~exist('boxTexture','var')
        boxTexture=glGenTextures(1);
        glBindTexture(GL.TEXTURE_2D,boxTexture);
        % Setup texture wrapping behaviour:
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
        % Setup filtering for the textures:
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
        % Choose texture application function: It shall modulate the light
        % reflection properties of the the cubes face:
        glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

        tx=permute(imread('FocusVaryingStereoDisplay/boxTextureForFocusVaryingStereo.bmp'), [3 2 1]);
        glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
    end

    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8); % control session projection
        genlist_projection2=[0 1 2 3 4 5 6 7]+glGenLists(8); % conflict session projection
        for depthplane= 4: -1: 1
            if depthplane==1
                depthtex_handle=6; % don't display anything on farthest plane
            else
                depthtex_handle=depthplane;
            end
            for whichEye=renderviews
                glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
            if depthplane==2 % genlist_projection2 displays only farmimd plane
                depthtex_handle=7;
            else
                depthtex_handle=6;
            end
            for whichEye=renderviews
                glNewList(genlist_projection2(depthplane+whichEye*4), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
        end
        texturedBox_list=glGenLists(1);
        glNewList(texturedBox_list,GL.COMPILE);
        glEnable(GL.TEXTURE_2D);
        glBindTexture(GL.TEXTURE_2D,boxTexture);
        glBegin(GL.POLYGON);
        glNormal3dv([0 0 1]);
        cubeSize=0.1;
        glTexCoord2dv([ 1 0 ]);
        glVertex3dv(cubeSize/2*[1 1 0]);
        glTexCoord2dv([ 0 0 ]);
        glVertex3dv(cubeSize/2*[-1 1 0]);
        glTexCoord2dv([ 0 1 ]);
        glVertex3dv(cubeSize/2*[-1 -1 0]);
        glTexCoord2dv([ 1 1 ]);
        glVertex3dv(cubeSize/2*[1 -1 0]);
        glEnd;
        glDisable(GL.TEXTURE_2D);
        glEndList();
    end

% 	if ~exist('RDS_list', 'var')
% 		RDS_list_index=glGenLists(1);
% 	end
% 	% producing RDS images
% 	glNewList(RDS_list_index, GL.COMPILE)
%     BF_make_rds_grating(imageplanedist(2),...
%         get(scell{current_sc}, 'rds_grating_numdots'),...
%         90+rpt_orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
%         current_corrfreq, ...
%         get(scell{current_sc}, 'rds_grating_angularsize'),...
%         get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
% 	glEndList();
    
elseif strcmp(experiment_type, 'specularity_flat')
    if exist('genlist_projection1','var')
        BF_build_textures_for_specularity_flat_project;
        for textureIndex=0:(numReflectionImageInOneSet-1)
            for depthIndex=1:4
                for eyeIndex=0:1
                    % generate scene display genlist here..
                    glNewList(static_scene_disp_list(depthIndex+4*eyeIndex+8*textureIndex), GL.COMPILE);
                    if depthIndex ~= 1
                        glPushMatrix();
                        if eyeIndex==0
                            specularityTranslateX=-IPD*(imageplanedist(2)-imageplanedist(depthIndex))/(2*imageplanedist(2));
                        else
                            specularityTranslateX=IPD*(imageplanedist(2)-imageplanedist(depthIndex))/(2*imageplanedist(2));
                        end
                        specularityScale=textureImageSize*imageplanedist(depthIndex)/imageplanedist(2);
                        glTranslatef(specularityTranslateX, 0.0, -imageplanedist(depthIndex));
                        glScalef(specularityScale,specularityScale,1);
                        glEnable(GL.TEXTURE_2D);
                        n=[0 0 1];
                        if eyeIndex==0
                            glBindTexture(GL.TEXTURE_2D,leftTexture(3*textureIndex+depthIndex-1));
                        else
                            glBindTexture(GL.TEXTURE_2D,rightTexture(3*textureIndex+depthIndex-1));
                        end
                        glBegin(GL.POLYGON);
                        glNormal3dv(n);
                        glTexCoord2dv([ 1 0 ]);
                        glVertex3dv([1 1 0]);
                        glTexCoord2dv([ 0 0 ]);
                        glVertex3dv([-1 1 0]);
                        glTexCoord2dv([ 0 1 ]);
                        glVertex3dv([-1 -1 0]);
                        glTexCoord2dv([ 1 1 ]);
                        glVertex3dv([1 -1 0]);
                        glEnd;
                        glPopMatrix();
                    end
                    glEndList();
                end
            end
        end
    end    
elseif strcmp(experiment_type, 'exp_aca')
    
    stim_type=get(scell{current_sc}, 'phase1_stim');
    facesize=.01;
    vergdist=get(scell{current_sc}, 'phase1_verg_dist');
    depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
    focus_cue_multiplier=0;  
        
        
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

    
    if ~exist('static_scene_disp_list1', 'var')
        static_scene_disp_list1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list1(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    end

    % Create RDS_list, genlist_projection2_3intervals,
    % static_scene_disp_list2_3intervals, for initialization of phase2.
    if ~exist('RDS_list', 'var')
        RDS_list=[0 1 2]+glGenLists(3);
    end
    % For 3 interval oddity test, we need 3 projection sets for phase 2:
    % genlist_projection2_3intervals has 24 elements.
    if ~exist('genlist_projection2_3intervals', 'var')
        genlist_projection2_3intervals=[0:23]+glGenLists(24);
    end
    % For 3 interval oddity test, we need 3 image sets for phase 2:
    % static_scene_disp_list2_3intervals has 24 elements.
    if ~exist('static_scene_disp_list2_3intervals', 'var')
        static_scene_disp_list2_3intervals=[0:23]+glGenLists(24);
    end
  
    phase2_odd_phase=floor(2*rand); % To decide which perspective would the odd phase have.
    phase2_odd_index=floor(3*rand); % To decide which rds image in phase2 would have odd orientation.
    %phase2_odd_index=1; % To decide which rds image in phase2 would be odd.
    rpt_orientation= round(rand(1))*2-1;

    for phase2_index=0:2;
        % assign scell values to stim_type, vergdist, depthoffset.
        % use phase2 parameters for the second interval.
        % use phase1 parameters for the first and third intervals,
        if phase2_index==1
            if phase2_odd_phase==0
                stim_type=get(scell{current_sc}, 'phase1_stim');
                vergdist=get(scell{current_sc}, 'phase1_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
            else
                stim_type=get(scell{current_sc}, 'phase2_stim');
                vergdist=get(scell{current_sc}, 'phase2_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase2_accom_dist')-get(scell{current_sc}, 'phase2_verg_dist');
            end
        else
            if phase2_odd_phase==0
                stim_type=get(scell{current_sc}, 'phase2_stim');
                vergdist=get(scell{current_sc}, 'phase2_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase2_accom_dist')-get(scell{current_sc}, 'phase2_verg_dist');
            else
                stim_type=get(scell{current_sc}, 'phase1_stim');
                vergdist=get(scell{current_sc}, 'phase1_verg_dist');
                depthoffset=get(scell{current_sc}, 'phase1_accom_dist')-get(scell{current_sc}, 'phase1_verg_dist');
            end
        end
        
        % producing RDS images
        RDS_list_index = RDS_list(phase2_index+1);
        orientation=rpt_orientation; % This variable is to make orientation difference in odd image
        if phase2_index==phase2_odd_index; % in this case, change the angle of the orientation
            orientation=-rpt_orientation; % makes orientation difference of +-20degree.
        end
        glNewList(RDS_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)
        BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots'),...
            90+orientation*get(scell{current_sc}, 'rds_grating_orientation'), ...
            get(scell{current_sc}, 'rds_grating_cpd'), ...
            get(scell{current_sc}, 'rds_grating_angularsize'),...
            get(scell{current_sc}, 'rds_grating_disparity'), IPD, 1.5, texname_static);
        glEndList();

        % producing genlist_projection2_3intervals
        for depthplane= 4: -1: 1
            depthtex_handle=depthplane ;
            for whichEye=renderviews
                glNewList(genlist_projection2_3intervals(phase2_index*8+whichEye*4+depthplane), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
        end
        
        % producing static_scene_disp_list2_3intervals
        for depthplane= 4: -1: 1
            depthtex_handle=depthplane ;
            for whichEye=renderviews
                glNewList(static_scene_disp_list2_3intervals(phase2_index*8+whichEye*4+depthplane), GL.COMPILE);
                BFRenderScene_static;
                glEndList();
            end
        end
    end
    
    %put up the RDS stimulus mask
    %it has the same properties as the stimulus but random depth  (actually,
    %just a very high cpd corrugation
    if ~exist('RDSmask_list_index', 'var')
        RDSmask_list_index=glGenLists(1);
    end
    glNewList(RDSmask_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcsec, texname_static)

        BF_make_rds_grating(vergdist, get(scell{current_sc}, 'rds_grating_numdots')*4,...
            0, ...
            60, ...
            get(scell{current_sc}, 'rds_grating_angularsize')*2,...
            0.001, IPD, 1.0, texname_static);
    glEndList();
    stim_type='rds_mask';

    if ~exist('static_scene_disp_list3', 'var')
        static_scene_disp_list3=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
        
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(static_scene_disp_list3(depthplane+whichEye*4), GL.COMPILE);
            BFRenderScene_static;
            glEndList();
        end
    
	end
	

elseif strcmp(experiment_type, 'cyl_structure')

    
   focus_cue_multiplier=10^get(scell{current_sc}, 'currentValue');  %eventually add in the other important stuff here
   
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end

            if ~exist('genlist_projection1', 'var')
                        CYLDOTS_list_index=glGenLists(1);
            end
        glNewList(CYLDOTS_list_index, GL.COMPILE)
        %BF Make cylinder dots (number of dots, cyl radius, cyl height, dotradius
        BF_make_cylinder_dots(get(scell{current_sc}, 'rds_grating_numdots'), cyl_radius, cyl_height, dotradius);  
        glEndList();
    
    
elseif strcmp(experiment_type, 'disparity_blur')     
    
%     vergdist = get(scell{current_sc},'stimDistance');
    stimulus_order = (rand > 0.5);
    scell{current_sc} = set(scell{current_sc},'stim_order',stimulus_order);             % 0 = Pedestal below fixation. 1 = Pedestal above fixation.
    focus_cue_multiplier = get(scell{current_sc},'phase1_focusmult');                   % 0 = no accomodation stimulus, 1 = accommodation and vergence
    db_stim_type = get(scell{current_sc}, 'blur_disparity_stim');                       % Retrieve stimulus type (0 = thin line, 1 = pink-noise disk)  
    mono = get(scell{current_sc}, 'monocular');                                         % Retrieve viewing condition (0 = binocular, 1 = monocular)
    training = get(scell{current_sc}, 'training');                                      % Retrieve training state (0 = off, 1 = on)
    depth_step = get(scell{current_sc}, 'currentValue');                 % Retrieve disparity (aka depth interval) (m)
    pedestal = get(scell{current_sc}, 'pedestal');                       % Retrieve pedestal (m)
    eccentricity = get(scell{current_sc}, 'eccentricity');               % Retrieve eccentricity (arcmin)    
    random_seed = round(10000*rand);
    vergdist = ShiftDiopters(get(scell{current_sc},'stimDistance'),diopter_offset);    
    
    % Ensure that the step size is the right direction (away from the pedestal)
    if ~((db_stim_type == 1) && mono)
        % But only if it's not the blur-only condition
        step_size_magnitude = abs(get(scell{current_sc},'stepSize'));
        set(scell{current_sc},'stepSize',step_size_magnitude*sign(depth_step));
    end
    
    
%     depthoffset
%     vergdist
    
    % Mandatory projection
    if ~exist('genlist_projection1', 'var')
        genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end
    
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews
            glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
            BF_viewport_specific_GL_commands;
            glEndList();
        end
    end
    
    % Fixation 
    if ~exist('fixation_projection', 'var')
        fixation_projection=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end

    % Stimulus
    if ~exist('stimulus_projection', 'var')
        stimulus_projection=[0 1 2 3 4 5 6 7]+glGenLists(8);
    end

%     stimulus_order = get(scell{current_sc}, 'stim_order');             % Retrieve whether the reference is above or below fixation   
    for depthplane= 4: -1: 1
        depthtex_handle=depthplane ;
        for whichEye=renderviews

            stim_type = 'fixation_cross';
            fixation_cross_diam_deg = 30;                                           % Fixation-cross diameter in arcmin
            fixation_cross_diam = tand(fixation_cross_diam_deg/2/60)*vergdist*2;    % " in meters
            facesize = fixation_cross_diam/2;
            glNewList(fixation_projection(depthplane+whichEye*4), GL.COMPILE);
                BFRenderScene_static;
            glEndList();
            stim_type = 'disparity_blur_stim';
            % If this is the monocular condition, only show the stimulus to the left eye
            if ((mono == 0) || (mono >= 1 && whichEye == 1))
                glNewList(stimulus_projection(depthplane+whichEye*4), GL.COMPILE);
                    BFRenderScene_static;
                glEndList();  
            end
        end
    end
    
    elseif strcmp(experiment_type, 'disparity_blur_occlusion')     
    
    %     vergdist = get(scell{current_sc},'stimDistance');
        stimulus_order          = (rand > 0.5);
        scell{current_sc}       = set(scell{current_sc},'stim_order',stimulus_order);     	% 0 = Pedestal below fixation. 1 = Pedestal above fixation.
        focus_cue_multiplier    = get(scell{current_sc},'phase1_focusmult');               	% 0 = no accomodation stimulus, 1 = accommodation and vergence
        db_stim_type            = get(scell{current_sc}, 'blur_disparity_stim');           	% Retrieve stimulus type (0 = thin line, 1 = pink-noise disk)  
        mono                    = get(scell{current_sc}, 'monocular');                    	% Retrieve viewing condition (0 = binocular, 1 = monocular)
        training                = get(scell{current_sc}, 'training');                   	% Retrieve training state (0 = off, 1 = on)
        depth_step              = get(scell{current_sc}, 'currentValue');                   % Retrieve disparity (aka depth interval) (m)
        pedestal                = get(scell{current_sc}, 'pedestal');                       % Retrieve pedestal (m)
        eccentricity            = get(scell{current_sc}, 'eccentricity');                   % Retrieve eccentricity (arcmin)    
        random_seed             = round(10000*rand);
        vergdist                = ShiftDiopters(get(scell{current_sc},'stimDistance'),diopter_offset);    

        % Ensure that the step size is the right direction (away from the pedestal)
        if ~((db_stim_type == 1) && mono)
            % But only if it's not the blur-only condition
            step_size_magnitude = abs(get(scell{current_sc},'stepSize'));
            set(scell{current_sc},'stepSize',step_size_magnitude*sign(depth_step));
        end

        % Mandatory projection
        if ~exist('genlist_projection1', 'var')
            genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end

        for depthplane= 4: -1: 1
            depthtex_handle = depthplane ;
            for whichEye = renderviews
                glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
        end

        % Fixation 
        if ~exist('fixation_projection', 'var')
            fixation_projection=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end

        % Stimulus
        if ~exist('stimulus_projection', 'var')
            stimulus_projection=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end

    %     stimulus_order = get(scell{current_sc}, 'stim_order');             % Retrieve whether the reference is above or below fixation   
        for depthplane= 4: -1: 1
            depthtex_handle = depthplane ;
            for whichEye = renderviews

                stim_type               = 'fixation_cross';
                fixation_cross_diam_deg = 45;                                               % Fixation-cross diameter in arcmin
                fixation_cross_diam     = tand(fixation_cross_diam_deg/2/60)*vergdist*2;    % " in meters
                facesize                = fixation_cross_diam/2;
                glNewList(fixation_projection(depthplane+whichEye*4), GL.COMPILE);
                    BFRenderScene_static;
                glEndList();
                stim_type = 'disparity_blur_occlusion_stim';
                % If this is the monocular condition, only show the stimulus to the left eye
                if ((mono == 0) || (mono >= 1 && whichEye == 0))
                    glNewList(stimulus_projection(depthplane+whichEye*4), GL.COMPILE);
                        BFRenderScene_static;
                    glEndList();  
                end
            end
        end
 elseif strcmp(experiment_type, 'disparity_blur_sequential')     
    
    %     vergdist = get(scell{current_sc},'stimDistance');
        stimulus_order          = (rand > 0.5);
        scell{current_sc}       = set(scell{current_sc},'stim_order',stimulus_order);     	% 0 = Pedestal below fixation. 1 = Pedestal above fixation.
        focus_cue_multiplier    = get(scell{current_sc},'phase1_focusmult');               	% 0 = no accomodation stimulus, 1 = accommodation and vergence
        db_stim_type            = get(scell{current_sc}, 'blur_disparity_stim');           	% Retrieve stimulus type (0 = thin line, 1 = pink-noise disk)  
        mono                    = get(scell{current_sc}, 'monocular');                    	% Retrieve viewing condition (0 = binocular, 1 = monocular)
        training                = get(scell{current_sc}, 'training');                   	% Retrieve training state (0 = off, 1 = on)
        depth_step              = get(scell{current_sc}, 'currentValue');                   % Retrieve disparity (aka depth interval) (m)
        pedestal                = get(scell{current_sc}, 'pedestal');                       % Retrieve pedestal (m)
        eccentricity            = get(scell{current_sc}, 'eccentricity');                   % Retrieve eccentricity (arcmin)    
        random_seed             = round(10000*rand);
        random_seed_two         = round(10000*rand);
        vergdist                = ShiftDiopters(get(scell{current_sc},'stimDistance'),diopter_offset);    

        % Ensure that the step size is the right direction (away from the pedestal)
        if ~((db_stim_type == 1) && mono)
            % But only if it's not the blur-only condition
            step_size_magnitude = abs(get(scell{current_sc},'stepSize'));
            set(scell{current_sc},'stepSize',step_size_magnitude*sign(depth_step));
        end

        % Mandatory projection
        if ~exist('genlist_projection1', 'var')
            genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end

        for depthplane= 4: -1: 1
            depthtex_handle = depthplane ;
            for whichEye = renderviews
                glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                BF_viewport_specific_GL_commands;
                glEndList();
            end
        end

        % Fixation 
        if ~exist('fixation_projection', 'var')
            fixation_projection=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end

        % Stimulus one
        if ~exist('stimulus_projection_one', 'var')
            stimulus_projection_one=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end
        
        % Stimulus two
        if ~exist('stimulus_projection_two', 'var')
            stimulus_projection_two=[0 1 2 3 4 5 6 7]+glGenLists(8);
        end        

    %     stimulus_order = get(scell{current_sc}, 'stim_order');             % Retrieve whether the reference is above or below fixation   
        for depthplane= 4: -1: 1
            depthtex_handle = depthplane ;
            for whichEye = renderviews

                stim_type               = 'fixation_cross';
                fixation_cross_diam_deg = 30;                                               % Fixation-cross diameter in arcmin
                fixation_cross_diam     = tand(fixation_cross_diam_deg/2/60)*vergdist*2;    % " in meters
                facesize                = fixation_cross_diam/2;
                glNewList(fixation_projection(depthplane+whichEye*4), GL.COMPILE);
                    BFRenderScene_static;
                glEndList();
                stim_type = 'disparity_blur_sequential_stim';
                % If this is the monocular condition, only show the stimulus to the left eye
                if ((mono == 0) || (mono >= 1 && whichEye == 0))
                    current_stim = 1;
                    glNewList(stimulus_projection_one(depthplane+whichEye*4), GL.COMPILE);
                        BFRenderScene_static;
                    glEndList();  
                    
                    current_stim  = 2;
                    glNewList(stimulus_projection_two(depthplane+whichEye*4), GL.COMPILE);
                        BFRenderScene_static;
                    glEndList();                      
                end
            end
        end        
    
end

  

Screen('EndOpenGL', windowPtr);

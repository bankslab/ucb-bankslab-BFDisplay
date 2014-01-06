
if strcmp(experiment_type, 'comparison')
    tic
    while toc < param.stim_duration
        depthplane = depthplane + 1;
        if depthplane > 4
            depthplane = 1;
        end
        depthtex_handle = depthplane;
        for whichEye = renderviews
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            if whichEye == 0
                glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
                if static_mode  %optional mode for staic imagery
                    glCallList(static_scene_disp_list1(depthplane+whichEye*4));
                end
            else
                glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
                if static_mode  %optional mode for staic imagery
                    glCallList(static_scene_disp_list1(depthplane+whichEye*4));
                end
            end
            Screen('EndOpenGL', windowPtr);
            
            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255  255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            else
                if whichEye==1
                    Screen('FillRect', windowPtr, [0 0 0], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [0 0 0], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end
        end
%         Screen('DrawText',windowPtr,num2str(stop_flag),[],[],[255 255 255]);
        Screen('Flip', windowPtr, [], 2, 1);
    end
end

if strcmp(stim_type,'aca_measure')
    presentation_time_ruler=2; % presentation time of ruler
    presentation_time_line=0.2; % presentation time of line
    tic;
    depthplane=2;
    while toc<presentation_time_ruler
        depthplane=depthplane+1;
        if depthplane>4
            depthplane=1;
        end
        depthtex_handle=depthplane;
        for whichEye=renderviews
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            if whichEye==0
                if toc>(presentation_time_ruler/2) && toc<(presentation_time_ruler/2+presentation_time_line)
                    glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
                    if static_mode  %optional mode for staic imagery
                        glCallList(static_scene_disp_list1(depthplane+whichEye*4));
                    end
                end
            else
                glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
                if static_mode  %optional mode for staic imagery
                    glCallList(static_scene_disp_list1(depthplane+whichEye*4));
                end
            end
            Screen('EndOpenGL', windowPtr);
            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
%                     Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.5, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
%                     Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.5 , winRect(4)]);
                end
            else
                % Since the left image does not display
                % anything when toc<2 or toc>2.2, it is
                % necessary to draw a black square to
                % prevent a white square from remaining at
                % the corner of the left monitor all the
                % time.
                if whichEye==0
                    if toc>(presentation_time_ruler/2) && toc<(presentation_time_ruler/2+presentation_time_line)
                        Screen('FillRect', windowPtr, [0 0 0], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [0 0 0], [0, 0, winRect(3) , winRect(4)]);
                    end
                end
            end
        end
        Screen('Flip', windowPtr, [], 2, 1);
    end

elseif strcmp(stim_type,'single_vision_zone_measure')
    displaymessage=1;
    depthplane=2;
    while(displaymessage==1)

        depthplane=depthplane+1;
        if depthplane>4
            depthplane=1;
        end
        depthtex_handle=depthplane;
        for whichEye=renderviews
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
            end
            Screen('EndOpenGL', windowPtr);
            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            else
            end
        end
        Screen('Flip', windowPtr, [], 2, 1);
    
        [strInputName2, x, y] = BFWaitForInput(0.000001);

%         for whichEye=[0 1]
%             Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
%             glClear();
%         end
%         Screen('Flip', windowPtr, [], 2, 1);

        if strcmp(strInputName2, 'UpArrow')
            disparity=disparity-0.1;
            return;
        elseif strcmp(strInputName2, 'DownArrow')
            disparity=disparity+0.1;
            return;
        elseif strcmp(strInputName2, 'ESCAPE')
            stop_flag=1;
            return;
        elseif strcmp(strInputName2, 'Return')
            record_flag=1;
            return;
        end

    end

elseif strcmp(experiment_type, 'alignmode')
    
    presentation_time= get(scell{current_sc}, 'phase1_duration');
    tic
    depthplane=2;
    tempResponse=0;
%     while toc<presentation_time
    while (1)

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup

            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
            end

                Screen('EndOpenGL', windowPtr);
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end
            
        end

        Screen('Flip', windowPtr, [], 2, 1);
        
        if cameraCalibration==1 && toc>1.5 && mod(toc,1/10)<1/120
            [a b c d]=KbCheck(-1);
            if a==1
                kbstring=KbName(c);
                if strcmp(kbstring,'UpArrow') || strcmp(kbstring,'RightArrow')
                    tempResponse=1;
                    break;
                elseif strcmp(kbstring,'DownArrow') || strcmp(kbstring,'LeftArrow')
                    tempResponse=2;
                    break;
                end
            end
        elseif cameraCalibration==0 && toc>presentation_time
            break;
        end


    end



elseif strcmp(experiment_type, 'timetofuse')
    
    %Start of fixation interval
    presentation_time= get(scell{current_sc}, 'phase1_duration')+(2*rand(1)-1)*get(scell{current_sc}, 'phase1_duration_rpt');
    tic
    depthplane=2;
    while toc<presentation_time

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup

            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
            end

                Screen('EndOpenGL', windowPtr);
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

        end
        Screen('Flip', windowPtr, [], 2, 1);


    end
    
%     %Start of stimulus interval
    presentation_time= get(scell{current_sc}, 'currentValue');
    tic
    depthplane=2;

    
    while toc<presentation_time

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection2(depthplane+whichEye*4));    %mandatory projection setup

            glCallList(RDS_list_index);

                Screen('EndOpenGL', windowPtr);
                
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

        end
        
             if show_verg_ref_dist  % print out the lens specified depth
                    
                    Screen('TextSize',windowPtr, 50);
                    
                   Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]); 
                   Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]); 
                   pause(.5)
             end
                
        Screen('Flip', windowPtr, [], 2, 1);
        

    end    
    
    
    %mask is displayed at end
    presentation_time= .5;  %Mask shown for .5 seconds
    tic
    
    while toc<presentation_time

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection2(depthplane+whichEye*4));    %mandatory projection setup

            glCallList(RDSmask_list_index);

                Screen('EndOpenGL', windowPtr);
            
        

                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end
       end
        Screen('Flip', windowPtr, [], 2, 1);


    end   
    

elseif strcmp(experiment_type, 'structure')
    
    tic
    while toc<pause_time
         depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;   
        
        
        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear();
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end
            
        end

        Screen('Flip', windowPtr, [], 2, 1);
        
    end
    
    
    presentation_time= get(scell{current_sc}, 'phase1_duration');
    tic
    depthplane=2;
    rpt_orientation=2*round(rand(1,1))-1;
    if rpt_orientation==1
        veridical_rotation='right';
    else
        veridical_rotation='left';
    end
    
    
    while toc<presentation_time
        cyl_rotation=toc*360/cyl_rotation_period*rpt_orientation;
        
        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
     
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup

                BFRenderScene_dynamic


                Screen('EndOpenGL', windowPtr);
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end
            
        end

        Screen('Flip', windowPtr, [], 2, 1);


    end

elseif strcmp(experiment_type, 'fatigue_staircase')
    
    %Start of fixation interval
    presentation_time= get(scell{current_sc}, 'phase1_duration')+(2*rand(1)-1)*get(scell{current_sc}, 'phase1_duration_rpt');
    tic
    depthplane=2;
    while toc<presentation_time

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup

            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
            end

                Screen('EndOpenGL', windowPtr);
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

        end
        Screen('Flip', windowPtr, [], 2, 1);


    end
%     %Start of stimulus interval
    presentation_time= get(scell{current_sc}, 'currentValue');
    
    for phase2_index=0:2; % show image sets composed of 3 intervals.
        tic
        depthplane=2;
        RDS_list_index=RDS_list(phase2_index+1);

    
        while toc<presentation_time

            depthplane=depthplane+1;
            if depthplane>4
                depthplane=1;
            end
            depthtex_handle=depthplane;

            for whichEye=renderviews

                Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
                Screen('BeginOpenGL', windowPtr);

                glCallList(genlist_projection2_3intervals(phase2_index*8+whichEye*4+depthplane));    %mandatory projection setup
                glCallList(RDS_list_index);

                Screen('EndOpenGL', windowPtr);
                
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

            end
        
            if show_verg_ref_dist  % print out the lens specified depth
                Screen('TextSize',windowPtr, 50);
                Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]); 
                Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]); 
                pause(.5)
            end
            Screen('Flip', windowPtr, [], 2, 1);
        

        end    
    end
    
    %Mask is not needed for the three interval oddity task
    
    %mask is displayed at end,
%     presentation_time= .5;  %Mask shown for .5 seconds
%     tic
%     
%     while toc<presentation_time
% 
%         depthplane=depthplane+1;
%         if depthplane>4
% 
%             depthplane=1;
%         end
%         depthtex_handle=depthplane;
% 
%         for whichEye=renderviews
% 
%             Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
%             Screen('BeginOpenGL', windowPtr);
% 
% 
%             glCallList(genlist_projection2(depthplane+whichEye*4));    %mandatory projection setup
% 
%             glCallList(RDSmask_list_index);
% 
%                 Screen('EndOpenGL', windowPtr);
%             
%         
% 
%                 if depthplane==3
%                     if whichEye==1
%                         Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
%                     else
%                         Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
%                     end
%                 end
%        end
%         Screen('Flip', windowPtr, [], 2, 1);
% 
% 
%     end   
    

elseif strcmp(experiment_type, 'fatigue_fixduration') % made only to fix duration of phase 2 stimulus.
    
    %Start of fixation interval
    presentation_time= get(scell{current_sc}, 'phase1_duration')+(2*rand(1)-1)*get(scell{current_sc}, 'phase1_duration_rpt');
    tic
    depthplane=2;
    while toc<presentation_time

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup

            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
            end

                Screen('EndOpenGL', windowPtr);
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

        end
        Screen('Flip', windowPtr, [], 2, 1);


    end
    
%     %Start of stimulus interval
    presentation_time= get(scell{current_sc}, 'phase2_duration')
    get(scell{current_sc}, 'phase2_duration')
    for phase2_index=0:2; % show image sets composed of 3 RDSs.
        tic
        depthplane=2;
        RDS_list_index=RDS_list(phase2_index+1);

    
        while toc<presentation_time

            depthplane=depthplane+1;
            if depthplane>4
                depthplane=1;
            end
            depthtex_handle=depthplane;

            for whichEye=renderviews

                Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
                Screen('BeginOpenGL', windowPtr);

                glCallList(genlist_projection2_3intervals(phase2_index*8+depthplane+whichEye*4));    %mandatory projection setup

                glCallList(RDS_list_index);

                Screen('EndOpenGL', windowPtr);
                
                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

            end
        
            if show_verg_ref_dist  % print out the lens specified depth
                Screen('TextSize',windowPtr, 50);
                Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]); 
                Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]); 
                pause(.5)
            end
            Screen('Flip', windowPtr, [], 2, 1);
        

        end    
    end
    
    
    
    %mask is displayed at end
    presentation_time= .5;  %Mask shown for .5 seconds
    tic
    
    while toc<presentation_time

        depthplane=depthplane+1;
        if depthplane>4

            depthplane=1;
        end
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);


            glCallList(genlist_projection2_3intervals(depthplane+whichEye*4));    %mandatory projection setup

            glCallList(RDSmask_list_index);

                Screen('EndOpenGL', windowPtr);
            
        

                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end
       end
        Screen('Flip', windowPtr, [], 2, 1);


    end   
    

elseif strcmp(experiment_type, 'fatigue_assess1')||strcmp(experiment_type, 'fatigue_assess2')||strcmp(experiment_type, 'fatigue_assess3')...
        ||strcmp(experiment_type, 'fatigue_assess_sym0p1D')||strcmp(experiment_type, 'fatigue_assess_sym1p3D')||strcmp(experiment_type, 'fatigue_assess_sym2p5D')...
        ||strcmp(experiment_type, 'fatigue_assess_sym_training')
    %Start of stimulus interval
    for phase2_index=0:2; % show image sets composed of 3 RDSs.
        start_time=GetSecs;
        depthplane=2;
        RDS_list_index=RDS_list(phase2_index+1);
        stimulus_duration=get(scell{current_sc}, 'phase2_duration');

        while GetSecs-start_time<stimulus_duration

            depthplane=depthplane+1;
            if depthplane>4
                depthplane=1;
            end
            depthtex_handle=depthplane;

            for whichEye=renderviews

                Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
                Screen('BeginOpenGL', windowPtr);

                glCallList(genlist_projection2_3intervals(phase2_index*8+depthplane+whichEye*4));    %mandatory projection setup

                glCallList(RDS_list_index);

                Screen('EndOpenGL', windowPtr);

                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

            end

            if show_verg_ref_dist  % print out the lens specified depth
                Screen('TextSize',windowPtr, 50);
                Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]);
                Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]);
                pause(.5)
            end
            Screen('Flip', windowPtr, [], 2, 1);

        end
    end

elseif strcmp(experiment_type, 'fatigue_time_pilot_03')
	
	current_condition
	start_time=GetSecs;
	depthplane=2;
	stimulus_duration=stimulus_duration_offset+rand(1);

	while GetSecs-start_time<stimulus_duration
		depthplane=depthplane+1;
		if depthplane>4
			depthplane=1;
		end

		for whichEye=renderviews

            relative_vergence=relative_vergence_amp(current_condition)*...
                (0.5-0.5*sin(2*pi*mod(toc*temporal_freq(current_condition),1)));
            vergence_dist=1/(vergence_offset+relative_vergence);
			if focus_cue_multiplier==0
				accommodation_dist=1/vergence_offset;
			elseif focus_cue_multiplier==1
				accommodation_dist=vergence_dist;
			end
% 			relative_accommodation=relative_accommodation_amp(current_condition)*...
%                 (0.5-0.5*sin(2*pi*mod(toc*temporal_freq(current_condition),1)));
% 			accdist=1/(accommodation_offset+relative_accommodation);
%  			depthoffset=accdist-vergdist;

			Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);

			glCallList(genlist_projection(depthplane+whichEye*4));    %mandatory projection setup
			BFRenderScene_dynamic;

            Screen('EndOpenGL', windowPtr);
			if depthplane==3
				if whichEye==1
					Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
				else
					Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
				end
			end

		end

		Screen('Flip', windowPtr, [], 2, 1);

	end
	
elseif strcmp(experiment_type, 'fatigue_time') || strcmp(experiment_type,'fatigue_time_3') || strcmp(experiment_type,'fatigue_time_4')
    %Start of stimulus interval
	start_time=GetSecs;
	depthplane=2;
	stimulus_duration=get(scell{current_sc}, 'phase2_duration');
%     stim_screenshot=0;
%     if ~exist('picIndex','var')
%         picIndex=1;
%     end

	while GetSecs-start_time<stimulus_duration
		depthplane=depthplane+1;
		if depthplane>4
			depthplane=1;
		end
		depthtex_handle=depthplane;

		for whichEye=renderviews

			Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
			Screen('BeginOpenGL', windowPtr);

			glCallList(genlist_projection2(depthplane+whichEye*4));    %mandatory projection setup

			glCallList(RDS_list_index);

			Screen('EndOpenGL', windowPtr);

			if depthplane==3
				if whichEye==1
					Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
				else
					Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
				end
			else
				if whichEye==1
					Screen('FillRect', windowPtr, [0 0 0], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
				else
					Screen('FillRect', windowPtr, [0 0 0], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
				end
			end

		end

		if show_verg_ref_dist  % print out the lens specified depth
			Screen('TextSize',windowPtr, 50);
			Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]);
			Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]);
			pause(.5)
		end
		Screen('Flip', windowPtr, [], 2, 1);
%         if depthplane==2 && stim_screenshot==0
%             sshot=Screen('GetImage',windowPtr);
%             imagefilename=['capture_' num2str(picIndex) '.bmp'];
%             imwrite(sshot,imagefilename);
%             stim_screenshot=1;
%             picIndex=picIndex+1;
%         end

    end
    
elseif strcmp(experiment_type, 'focusVaryingStereo')

    if trial_counter>trials_per_block
        blockIndex=2;
    else
        blockIndex=1;
    end
    % run the stimuli
    stereoFrameNum=stereoFrameNum+1;
    trialNum=trial_counter-(blockIndex-1)*length(firstFrameInTrial);
    
    if length(firstFrameInTrial)>trialNum
        trialEnd=firstFrameInTrial(trialNum+1)+(blockIndex-1)*stereoFrameRate*experimentDuration;
    else % given trial is the last one
        trialEnd=stereoFrameRate*experimentDuration*blockIndex;
    end
    currentStim.relativeDisparity=0; % for data recording
    currentStim.vergdist=0;
    while stereoFrameNum<trialEnd
        
        % determine which condition it is
        vergdist=1/(0.6988+dio(2)+pathGenerated(stereoFrameNum)-0.1);
        % NOTE: 0.6988 is a dioptric distance offset of BF display setting
        if strcmp(block{blockIndex}.condition,'cues-consistent') % control session
            accdist=vergdist;
        elseif strcmp(block{blockIndex}.condition,'cues-inconsistent') % conflict session
            accdist=1/dio(2);
        end
        depthoffset=accdist-vergdist;
        debugging{blockIndex}.vergdist(stereoFrameNum)=vergdist;
        debugging{blockIndex}.accdist(stereoFrameNum)=accdist;
        focus_cue_multiplier=0;  

        depthplane=depthplane+1;
        if depthplane>4
            depthplane=1;
            stereoFrameNum=stereoFrameNum+1;
        end
 
        for whichEye=renderviews
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
%             glEnable(GL.LIGHTING);
%             glEnable(GL.LIGHT0);
            glEnable(GL.DEPTH_TEST);
            if strcmp(block{blockIndex}.condition,'cues-consistent') % control session
                glCallList(genlist_projection1(depthplane+whichEye*4));
            elseif strcmp(block{blockIndex}.condition,'cues-inconsistent') % conflict session
                glCallList(genlist_projection2(depthplane+whichEye*4));
            end
            glPushMatrix();
                % draw box here
                glTranslatef(0,0,-vergdist);
                glCallList(texturedBox_list);
            glPopMatrix();
            if stimRelativeDisparity(stereoFrameNum)~=0
                if currentStim.relativeDisparity==0
                    currentStim.relativeDisparity=stimRelativeDisparity(stereoFrameNum);
                    currentStim.vergdist=vergdist;
                end
                cyclopianSeparation=0.04;
                arcmin=vergdist*tand(2/60); % match arcmin
                pillarHeight=0.02; pillarWidth=0.002;
                sphereRadius=0.01;
                glPushMatrix();
                    glTranslatef(0,0,-vergdist+eps);
                    glPushMatrix();
                        glTranslatef(-cyclopianSeparation/2,0,0); % left pillar
                        if whichEye==0 % left monitor
                            glTranslatef((stimRelativeDisparity(stereoFrameNum)+3)*arcmin/4,0,0);
                        else % right monitor
                            glTranslatef((-stimRelativeDisparity(stereoFrameNum)+3)*arcmin/4,0,0);
                        end
                        glTranslatef(0,0,0.0001);
                        % draw pillar
                        glScalef(pillarWidth,pillarHeight,0.00001);
                        glutSolidCube(1);
%                         glScalef(sphereRadius,sphereRadius,0.00001);
%                         glutSolidSphere(1,16,2);
                    glPopMatrix();
                    glPushMatrix();
                        glTranslatef(cyclopianSeparation/2,0,0); % right pillar
                        if whichEye==0 % left monitor
                            glTranslatef((-stimRelativeDisparity(stereoFrameNum)-3)*arcmin/4,0,0);
                        else % right monitor
                            glTranslatef((stimRelativeDisparity(stereoFrameNum)-3)*arcmin/4,0,0);
                        end
                        glTranslatef(0,0,0.0001);
                        % draw pillar
                        glScalef(pillarWidth,pillarHeight,0.00001);
                        glutSolidCube(1);
%                         glScalef(sphereRadius,sphereRadius,0.00001);
%                         glutSolidSphere(1,32,2);
                    glPopMatrix();
                glPopMatrix();
            end
            Screen('EndOpenGL', windowPtr);
            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end
        end
 
        Screen('Flip', windowPtr, [], 2, 1);
        thePresent=toc; 
    end
    
elseif strcmp(experiment_type, 'fatigue_time_5')
    
    % run the stimuli
    start_time=toc;
    depthplane=2;
    thePresent=toc;
    if ~exist('previousFrame','var')
        previousFrame=0;
    end
 
    while thePresent-start_time<stimulus_duration
        dIndex=dIndex+1;
        
        % determine which condition it is
        if mod(current_condition,2)==1 % control session
            relative_vergence=relative_vergence_amp(current_condition)*...
                (0.5-0.5*cos(2*pi*mod(thePresent*temporal_freq(current_condition),1)));
            vergdist=1/(vergence_offset+relative_vergence);
            relative_accommodation=relative_accommodation_amp(current_condition)*...
                (0.5-0.5*cos(2*pi*mod(thePresent*temporal_freq(current_condition),1)));
            accdist=1/(accommodation_offset+relative_accommodation);
            depthoffset=accdist-vergdist;
        elseif mod(current_condition,2)==0 % conflict session
            relative_vergence=relative_vergence_amp(current_condition)*...
                (0.5-0.5*cos(2*pi*mod(thePresent*temporal_freq(current_condition),1)));
            vergdist=1/(vergence_offset+relative_vergence);
            relative_accommodation=relative_accommodation_amp(current_condition)*...
                (0.5-0.5*cos(2*pi*mod(thePresent*temporal_freq(current_condition),1)));
            accdist=1/(accommodation_offset+relative_accommodation);
            depthoffset=accdist-vergdist;
        end
        debugging{condition_index}.vergdist(dIndex)=vergdist;
        debugging{condition_index}.accdist(dIndex)=accdist;
        focus_cue_multiplier=0;  

        depthplane=depthplane+1;
        if depthplane>4
            depthplane=1;
        end
 
        for whichEye=renderviews
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            if mod(current_condition,2)==1
                glCallList(genlist_projection1(depthplane+whichEye*4));
            elseif mod(current_condition,2)==0
                glCallList(genlist_projection2(depthplane+whichEye*4));
            end
            glPushMatrix();
            glScalef(vergdist/imageplanedist(2),vergdist/imageplanedist(2),vergdist/imageplanedist(2));
            glCallList(RDS_list_index);
            glTranslatef(0,0,imageplanedist(2));
            glPopMatrix();
            Screen('EndOpenGL', windowPtr);
            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end
        end
 
        Screen('Flip', windowPtr, [], 2, 1);
        thePresent=toc; 
        if previousFrame==0
            previousFrame=thePresent;
        elseif previousFrame>0
            if ~exist('frameTimePlot')
                frameTimePlot=[];
            end
            frameTimePlot=[frameTimePlot thePresent-previousFrame];
            previousFrame=thePresent;
        end
    end
    previousFrame=0;
    
elseif strcmp(experiment_type, 'exp_aca')
    %Start of stimulus interval
    for phase2_index=0:2; % show image sets composed of 3 RDSs.
        start_time=GetSecs;
        depthplane=2;
        RDS_list_index=RDS_list(phase2_index+1);
        stimulus_duration=get(scell{current_sc}, 'phase2_duration');

        while GetSecs-start_time<stimulus_duration

            depthplane=depthplane+1;
            if depthplane>4
                depthplane=1;
            end
            depthtex_handle=depthplane;

            for whichEye=renderviews

                Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
                Screen('BeginOpenGL', windowPtr);

                glCallList(genlist_projection2_3intervals(phase2_index*8+depthplane+whichEye*4));    %mandatory projection setup

                glCallList(RDS_list_index);

                Screen('EndOpenGL', windowPtr);

                if depthplane==3
                    if whichEye==1
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                    else
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                    end
                end

            end

            if show_verg_ref_dist  % print out the lens specified depth
                Screen('TextSize',windowPtr, 50);
                Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]);
                Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]);
                pause(.5)
            end
            Screen('Flip', windowPtr, [], 2, 1);

        end
    end
    
elseif strcmp(experiment_type,'specularity_flat')
    depthplane=1;
    lastInputAt=0;
    surfaceScaleIndex=10;
    reflectionScaleIndex=10;
    while (1)
        depthplane=depthplane+1;
        if depthplane>4
            depthplane=1;
        end
 
        for whichEye=renderviews
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            glCallList(genlist_projection1(depthplane+whichEye*4));
            glCallList(static_scene_disp_list(depthplane+4*whichEye+8*(reflectionScaleIndex-1)));
            Screen('EndOpenGL', windowPtr);
            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end
        end
        Screen('Flip', windowPtr, [], 2, 1);
        [a b c d]=KbCheck(-1);
        if (a==1) && (GetSecs-lastInputAt)>0.2
            reflectionScaleIndex
            iKeyIndex=find(c);
            strInputName=KbName(iKeyIndex);
            switch strInputName
                case {'RightArrow'}
                    surfaceScaleIndex=surfaceScaleIndex+1;
                    if surfaceScaleIndex>10
                        surfaceScaleIndex=10;
                    end
                    lastInputAt=GetSecs;
                case {'LeftArrow'}
                    surfaceScaleIndex=surfaceScaleIndex-1;
                    if surfaceScaleIndex<10
                        surfaceScaleIndex=10;
                    end
                    lastInputAt=GetSecs;
                case {'UpArrow'}
                    reflectionScaleIndex=reflectionScaleIndex+1;
                    if reflectionScaleIndex>19
                        reflectionScaleIndex=19;
                    end
                    lastInputAt=GetSecs;
                case {'DownArrow'}
                    reflectionScaleIndex=reflectionScaleIndex-1;
                    if reflectionScaleIndex<1
                        reflectionScaleIndex=1;
                    end
                    lastInputAt=GetSecs;
                case {'RETURN','return','Return'}
                    break;
                case {'escape','esc','ESCAPE'}
                    stop_flag=1;
                    break;
            end
        end
    end
    
elseif strcmp(experiment_type, 'disparity_blur')
    fix_duration =  get(scell{current_sc}, 'phase1_duration');
    stimulus_duration = get(scell{current_sc}, 'phase2_duration') + fix_duration; 
    tic;
    depthplane=2;    
    
    if (get(scell{current_sc}, 'straightrun') == 1)
        depth_step
    end
    
    
    while toc < stimulus_duration
        depthplane=depthplane+1;
        if depthplane>4
            depthplane=1;
        end
%         depthplane = 2;                 % Used for non-bf-lens haploscope
        depthtex_handle=depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            
            
            
            %begin diplopia addition
%             if whichEye==0
%                 glCallList(genlist_projection1(depthplane+1*4));    %mandatory projection setup
%                 if (toc < fix_duration)  
%                     % Show fixation cross             
%                     glCallList(fixation_projection(depthplane+1*4));         % Fixation
%                 else              
% 
%                     glCallList(stimulus_projection(depthplane+1*4));       	% Stimulus
%                 end
%             end
%                         glLoadIdentity;
%             glDisable(GL.DEPTH_TEST);
            %end diplopia addition

            
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if (toc < fix_duration)
                % Show fixation cross             
                glCallList(fixation_projection(depthplane+whichEye*4));         % Fixation
            else              
                % Show stimulus
                glCallList(stimulus_projection(depthplane+whichEye*4));       	% Stimulus
            end
            Screen('EndOpenGL', windowPtr);

            if depthplane==3
                if whichEye==1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end

        end
        Screen('Flip', windowPtr, [], 2, 1);   %The fourth parameter of this is 0, which means it will clear the frame buffer after a flip, I nomrally like to keep it at 2 which leaves it underfined
    end
    
elseif strcmp(experiment_type, 'disparity_blur_occlusion')
    fix_duration        =  get(scell{current_sc}, 'phase1_duration');
    stimulus_duration   = get(scell{current_sc}, 'phase2_duration') + fix_duration; 
    tic;
    depthplane          = 2;    
    
    if (get(scell{current_sc}, 'straightrun') == 1)
        depth_step
    end
    
    
    while toc < stimulus_duration
        
        depthplane = depthplane+1;
        if depthplane > 4
            depthplane  = 1;
        end

        depthtex_handle = depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if (toc < fix_duration)
                % Show fixation cross             
                glCallList(fixation_projection(depthplane+whichEye*4));         % Fixation
            else              
                % Show stimulus
                glCallList(stimulus_projection(depthplane+whichEye*4));       	% Stimulus
            end
            Screen('EndOpenGL', windowPtr);

            if depthplane == 3
                if whichEye == 1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end

        end
        Screen('Flip', windowPtr, [], 2, 1);   %The fourth parameter of this is 0, which means it will clear the frame buffer after a flip, I nomrally like to keep it at 2 which leaves it underfined
    end
elseif strcmp(experiment_type, 'disparity_blur_sequential')
    fix_duration            =  get(scell{current_sc}, 'phase1_duration');
    inter_stimulus_duration = get(scell{current_sc}, 'phase3_duration');
    one_stimulus_duration   = get(scell{current_sc}, 'phase2_duration');
    total_stimulus_duration = one_stimulus_duration*2 + fix_duration + inter_stimulus_duration; 
    tic;
    depthplane          = 2;    
    
    if (get(scell{current_sc}, 'straightrun') == 1)
        depth_step
    end
    
    
    while toc < total_stimulus_duration
        
        depthplane = depthplane+1;
        if depthplane > 4
            depthplane  = 1;
        end

        depthtex_handle = depthplane;

        for whichEye=renderviews

            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            Screen('BeginOpenGL', windowPtr);
            
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if (toc < fix_duration)
                % Show fixation cross             
                glCallList(fixation_projection(depthplane+whichEye*4));         % Fixation
            elseif (toc < fix_duration + one_stimulus_duration)            
                % Show first stimulus
                glCallList(stimulus_projection_one(depthplane+whichEye*4));       	% Stimulus
            elseif (toc < fix_duration + one_stimulus_duration + inter_stimulus_duration)
                % Show fixation cross             
                glCallList(fixation_projection(depthplane+whichEye*4));         % Fixation
            else
                % Show second stimulus
                glCallList(stimulus_projection_two(depthplane+whichEye*4));       	% Stimulus
            end
            Screen('EndOpenGL', windowPtr);

            if depthplane == 3
                if whichEye == 1
                    Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                else
                    Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                end
            end

        end
        Screen('Flip', windowPtr, [], 2, 1);   %The fourth parameter of this is 0, which means it will clear the frame buffer after a flip, I nomrally like to keep it at 2 which leaves it underfined
    end
    
         
end

onset=Screen('Flip', windowPtr, [], []);

if ~strcmp(experiment_type,'comparison')
    BF_respond_react
end

onset=Screen('Flip', windowPtr, [], 2, 1);

if strcmp(experiment_type, 'fatigue_assess1')||strcmp(experiment_type, 'fatigue_assess2')||strcmp(experiment_type, 'fatigue_assess3')||strcmp(experiment_type, 'disparity_blur')...
        ||strcmp(experiment_type, 'disparity_blur_occlusion')||strcmp(experiment_type,'disparity_blur_sequential')||strcmp(experiment_type, 'fatigue_assess_sym0p1D')||strcmp(experiment_type, 'fatigue_assess_sym1p3D')...
        ||strcmp(experiment_type, 'fatigue_assess_sym2p5D')||strcmp(experiment_type, 'fatigue_assess_sym_training')||strcmp(experiment_type, 'fatigue_time')...
		||strcmp(experiment_type, 'fatigue_time_pilot_03')||strcmp(experiment_type,'fatigue_time_3')||strcmp(experiment_type,'fatigue_time_4')
	% discomfort=0; % if the value remains 0, then it means the subject did not answer.
    answer=0;
    response=0;
    question_start=GetSecs;
end

if strcmp(experiment_type, 'exp_aca')
    % discomfort=0; % if the value remains 0, then it means the subject did not answer.
    answer=0;
    response=0;
    question_start=GetSecs;
end

while(1==1)
        if strcmp(experiment_type,'specularity_flat')
            break;
        end
        fSec=0.000001;
    % Get key press
        [strInputName, x, y] = BFWaitForInput(fSec);
            if strcmp(strInputName, 'ESCAPE')  %Escape program
                if strcmp(experiment_type, 'fatigue_assess1')||strcmp(experiment_type, 'fatigue_assess2')||strcmp(experiment_type, 'fatigue_assess3')...
                        ||strcmp(experiment_type,'exp_aca')||strcmp(experiment_type,'disparity_blur')||strcmp(experiment_type,'disparity_blur_occlusion')||strcmp(experiment_type,'disparity_blur_sequential')...
                        ||strcmp(experiment_type, 'fatigue_assess_sym0p1D')||strcmp(experiment_type, 'fatigue_assess_sym1p3D')||strcmp(experiment_type, 'fatigue_assess_sym2p5D')...
                        ||strcmp(experiment_type, 'fatigue_assess_sym_training')||strcmp(experiment_type, 'fatigue_time') || strcmp(experiment_type,'fatigue_time_3')...
						||strcmp(experiment_type, 'fatigue_time_pilot_03')||strcmp(experiment_type,'fatigue_time_4') || strcmp(experiment_type,'fatigue_time_5')...
                        ||strcmp(experiment_type, 'focusVaryingStereo')
                    display('should escape');
                    stop_flag=1;
                end
                break;
            end

        if strcmp(stim_type,'aca_measure')
            if strcmp(strInputName,'0')
                acc_response=0;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'1')
                acc_response=1;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'2')
                acc_response=2;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'3')
                acc_response=3;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'4')
                acc_response=4;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'5')
                acc_response=5;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'6')
                acc_response=6;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'7')
                acc_response=7;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'8')
                acc_response=8;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'9')
                acc_response=9;
                BF_calculate_acc_conv;
                break;
            elseif strcmp(strInputName,'.')
                acc_response=10;
                BF_calculate_acc_conv;
                break;
            end
%         elseif strcmp(experiment_type,'specularity_flat_mono')
%             if strcmp(strInputName,'RightArrow')
%                 iodIndex=iodIndex+1;
%                 if iodIndex>21
%                     iodIndex=21;
%                 end
%             elseif strcmp(strInputName,'LeftArrow')
%                 iodIndex=iodIndex-1;
%                 if iodIndex<1
%                     iodIndex=1;
%                 end
%             end
            
        elseif strcmp(experiment_type, 'alignmode')
            if cameraCalibration==0 % for human subjects
                if strcmp(strInputName, 'UpArrow') || strcmp(strInputName, 'RightArrow')
                    response=1;
                    break;
                elseif strcmp(strInputName, 'DownArrow') || strcmp(strInputName, 'LeftArrow')
                    response=2;
                    break;
                % Was the esc key pressed?
                end
            elseif cameraCalibration==1 % for camera calibration
                response=tempResponse;
                break;
            end


        elseif strcmp(experiment_type, 'timetofuse')
            
            if (strcmp(strInputName, 'RightArrow')  && (rpt_orientation==-1)) || (rpt_orientation==1 && strcmp(strInputName, 'LeftArrow'))
                response=1;
                % After changing the control machine,
                % two pitches do not come without a pause between them.
                % For an example, execute 'soundTest.m'
                % I guess it's an OS issue.
                % Anyway, let's make only one pitch.
                % low for right answer, high for wrong answer.
% 				sound(0.5*sin(2*pi*[0:1/44100:.1]*1000),44000);
				sound(0.5*sin(2*pi*[0:1/44100:.1]*600),44000);
                 break;
            elseif (strcmp(strInputName, 'RightArrow')  && (rpt_orientation==1)) || (rpt_orientation==-1 && strcmp(strInputName, 'LeftArrow'))
                response=2;
				sound(0.5*sin(2*pi*[0:1/44100:.15]*1000),44000);
                 break;
            elseif strcmp(strInputName, 'DownArrow')
                response=0;
                break;
%             elseif strcmp(strInputName, 'p')
%                 response=2;
%                 break;                
%             elseif strcmp(strInputName, 'o')
%                 response=1;
%                 break;
            end
            
        elseif (strcmp(experiment_type, 'fatigue_staircase') || strcmp(experiment_type, 'fatigue_fixduration'))
            % Here only two cases are considered,
            % 2: answer is correct
            % 1: answer is not correct
            if ((strcmp(strInputName, '1') ||strcmp(strInputName, '1!'))  && (phase2_odd_index==0)) ||... % When the answer is correct
                    ((strcmp(strInputName, '2') || strcmp(strInputName, '2@'))  && (phase2_odd_index==1)) ||...
                    ((strcmp(strInputName, '3') || strcmp(strInputName, '3#'))  && (phase2_odd_index==2))
                response=2; % decrease CurrentValue
				sound(0.5*sin(2*pi*[0:1/44100:.1]*1000),44000);
				sound(0.5*sin(2*pi*[0:1/44100:.1]*600),44000);
                 break;
            elseif strcmp(strInputName,'1') || strcmp(strInputName,'2') ||...
                    strcmp(strInputName,'3')  || strcmp(strInputName, '1!') ||...
                    strcmp(strInputName, '2@') || strcmp(strInputName, '3#')% When the answer is not correct
                response=1; % increase CurrentValue
				sound(0.5*sin(2*pi*[0:1/44100:.15]*1000),44000);
                 break;
            end
            
        elseif strcmp(experiment_type, 'fatigue_assess1')||strcmp(experiment_type, 'fatigue_assess2')||strcmp(experiment_type, 'fatigue_assess3')...
                ||strcmp(experiment_type, 'fatigue_assess_sym0p1D')||strcmp(experiment_type, 'fatigue_assess_sym1p3D')||strcmp(experiment_type, 'fatigue_assess_sym2p5D')...
                ||strcmp(experiment_type, 'fatigue_assess_sym_training')
            % Here only two cases are considered,
            % 2: answer is correct
            % 1: answer is not correct
            if (GetSecs-question_start > oddity_question_duration)
                break;    
            else
                if ((strcmp(strInputName, '1') ||strcmp(strInputName, '1!'))  && (phase2_odd_index==0)) ||... % When the answer is correct
                        ((strcmp(strInputName, '2') || strcmp(strInputName, '2@'))  && (phase2_odd_index==1)) ||...
                        ((strcmp(strInputName, '3') || strcmp(strInputName, '3#'))  && (phase2_odd_index==2))
                    response=1; % Answer is correct
                    if strcmp(strInputName, '1') || strcmp(strInputName, '1!')
                        answer=1;
                    elseif strcmp(strInputName, '2') || strcmp(strInputName, '2@')
                        answer=2;
                    elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                        answer=3;
                    end
                    sound(0.5*sin(2*pi*[0:1/44100:.1]*1000),44000);
                elseif strcmp(strInputName,'1') || strcmp(strInputName,'2') ||...
                        strcmp(strInputName,'3')  || strcmp(strInputName, '1!') ||...
                        strcmp(strInputName, '2@') || strcmp(strInputName, '3#')% When the answer is not correct
                    response=0; % Answer is not correct
                    if strcmp(strInputName, '1') || strcmp(strInputName, '1!')
                        answer=1;
                    elseif strcmp(strInputName, '2') || strcmp(strInputName, '2@')
                        answer=2;
                    elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                        answer=3;
                    end
                    sound(0.5*sin(2*pi*[0:1/44100:.1]*600),44000);
                end
            end

        elseif strcmp(experiment_type, 'fatigue_time_pilot_03')
            % Here only two cases are considered,
            % 2: answer is correct
            % 1: answer is not correct
			if ((strcmp(strInputName, '1')  && (rpt_orientation==1)) ||... % When the answer is correct
					(strcmp(strInputName, '')  && (rpt_orientation==0)))
				response=1; % Answer is correct
				if strcmp(strInputName, '1')
					answer=1;
				elseif strcmp(strInputName, '')
					answer=2;
				end
				sound(0.5*sin(2*pi*[0:1/44100:.1]*1000),44000); % Correct
			elseif strcmp(strInputName,'1') ||... % when the answer is wrong
					strcmp(strInputName, '')
				response=0; % Answer is not correct
				if strcmp(strInputName, '1')
					answer=1;
				elseif strcmp(strInputName, '')
					answer=2;
				end
				sound(0.5*sin(2*pi*[0:1/44100:.1]*600),44000); % Wrong
			elseif strcmp(strInputName,'1!')
				current_condition=1;
			elseif strcmp(strInputName,'2@')
				current_condition=2;
			elseif strcmp(strInputName,'3#')
				current_condition=3;
			elseif strcmp(strInputName,'4$')
				current_condition=4;
			end
			break;

        elseif strcmp(experiment_type, 'fatigue_time') || strcmp(experiment_type,'fatigue_time_3') || strcmp(experiment_type,'fatigue_time_4') ...
                || strcmp(experiment_type, 'fatigue_time_5')
            % Here only two cases are considered,
            % 2: answer is correct
            % 1: answer is not correct
			if ((strcmp(strInputName, 'LeftArrow')  && (rpt_orientation==-1)) ||... % When the answer is correct
					(strcmp(strInputName, 'RightArrow')  && (rpt_orientation==1)))
				response=1; % Answer is correct
				if strcmp(strInputName, 'LeftArrow')
					answer=-1;
				elseif strcmp(strInputName, 'RightArrow')
					answer=1;
				end
% 				sound(0.5*sin(2*pi*[0:1/44100:.1]*1000),44000); % Correct
% 				sound(0.5*sin(2*pi*[0:1/44100:.1]*700),44000);
%                 play(soundCorrect{c_i});
%                 c_i=c_i+1;
				% Accumulate into 'record'
                Beeper(880,0.4,0.1);
			elseif strcmp(strInputName,'LeftArrow') || strcmp(strInputName,'RightArrow') || strcmp(strInputName,'') % when the answer is wrong
				response=0; % Answer is not correct
				if strcmp(strInputName, 'LeftArrow')
					answer=-1;
				elseif strcmp(strInputName, 'RightArrow')
					answer=1;
				end
% 				sound(0.5*sin(2*pi*[0:1/44100:.1]*700),44000); % Wrong
				% Accumulate into 'record'
%                 play(soundWrong{w_i});
%                 w_i=w_i+1;
                Beeper(660,0.4,0.1);
			end
			break;

        elseif strcmp(experiment_type, 'exp_aca')
            % Here only two cases are considered,
            % 2: answer is correct
            % 1: answer is not correct
            if (GetSecs-question_start > oddity_question_duration)
                break;    
            else
                if ((strcmp(strInputName, '1') ||strcmp(strInputName, '1!'))  && (phase2_odd_index==0)) ||... % When the answer is correct
                        ((strcmp(strInputName, '2') || strcmp(strInputName, '2@'))  && (phase2_odd_index==1)) ||...
                        ((strcmp(strInputName, '3') || strcmp(strInputName, '3#'))  && (phase2_odd_index==2))
                    response=1; % Answer is correct
                    if strcmp(strInputName, '1') || strcmp(strInputName, '1!')
                        answer=1;
                    elseif strcmp(strInputName, '2') || strcmp(strInputName, '2@')
                        answer=2;
                    elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                        answer=3;
                    end
                    sound(0.5*sin(2*pi*[0:1/44100:.1]*1000),44000);
                elseif strcmp(strInputName,'1') || strcmp(strInputName,'2') ||...
                        strcmp(strInputName,'3')  || strcmp(strInputName, '1!') ||...
                        strcmp(strInputName, '2@') || strcmp(strInputName, '3#')% When the answer is not correct
                    response=0; % Answer is not correct
                    if strcmp(strInputName, '1') || strcmp(strInputName, '1!')
                        answer=1;
                    elseif strcmp(strInputName, '2') || strcmp(strInputName, '2@')
                        answer=2;
                    elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                        answer=3;
                    end
                    sound(0.5*sin(2*pi*[0:1/44100:.1]*600),44000);
                end
            end
            
        elseif strcmp(experiment_type, 'cyl_structure')
            
            if (strcmp(strInputName, 'RightArrow')  && rpt_orientation==-1) || (rpt_orientation==1 && strcmp(strInputName, 'LeftArrow'))
                response=1;

                 break;
            elseif (strcmp(strInputName, 'RightArrow')  && rpt_orientation==1) || (rpt_orientation==-1 && strcmp(strInputName, 'LeftArrow'))
                response=2;

                 break;
            elseif strcmp(strInputName, 'DownArrow')
                response=0;

                break;
%             elseif strcmp(strInputName, 'p')
%                 response=2;
%                 break;                
%             elseif strcmp(strInputName, 'o')
%                 response=1;
%                 break;
            end
            
        elseif strcmp(experiment_type,'focusVaryingStereo')
            if currentStim.relativeDisparity~=0
                block{blockIndex}.vergdist(end+1)=currentStim.vergdist;
                block{blockIndex}.relativeDisparity(end+1)=currentStim.relativeDisparity;
                if strcmp(strInputName,'LeftArrow')
                    block{blockIndex}.response(end+1)=1;
                elseif strcmp(strInputName,'RightArrow')
                    block{blockIndex}.response(end+1)=-1;
                else
                    block{blockIndex}.response(end+1)=0;
                end
                if sign(block{blockIndex}.response(end))==sign(currentStim.relativeDisparity)
                    block{blockIndex}.performance(end+1)=1;
                    Beeper(880,0.4,0.1);
                elseif block{blockIndex}.response(end)==0
                    block{blockIndex}.performance(end+1)=0;
                    Beeper(660,0.4,0.1);
                else
                    block{blockIndex}.performance(end+1)=-1;
                    Beeper(660,0.4,0.1);
                end
            end
            break;
            
                      
        elseif  (strcmp(experiment_type, 'disparity_blur')||strcmp(experiment_type,'disparity_blur_occlusion'))
              depthplane=depthplane+1;
              if depthplane>4
                  depthplane=1;
              end
%             depthplane = 2;                 % Used for non-bf-lens haploscope
            depthtex_handle=depthplane;  

            for whichEye=renderviews 
                
                Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
                Screen('BeginOpenGL', windowPtr);
                glClear;
                
                % Show fixation cross   
                glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup                
                glCallList(fixation_projection(depthplane+whichEye*4));         % Fixation
                
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

            % Get stimulus presentation layout
            depth_step = get(scell{current_sc}, 'currentValue');        % Negative:  reference farther away than pedestal

            if (db_stim_type < 3)
                
                if (strcmp(strInputName, 'UpArrow') && ((mono == 1) && (vergdist == ShiftDiopters(0.37,diopter_offset))))
                    strInputName = 'DownArrow';
                elseif (strcmp(strInputName, 'DownArrow') && ((mono == 1) && (vergdist == ShiftDiopters(0.37,diopter_offset))))
                    strInputName = 'UpArrow';
                end                                            
            
                % Pedestal on top
                if ((strcmp(strInputName, 'UpArrow') && (depth_step < 0) && stimulus_order) || (strcmp(strInputName, 'DownArrow') && (depth_step > 0) && stimulus_order))
                    % Correct (pedestal is on top and far or on top and close)             
                    response = 2;
                    display('Response:  Correct');
                    if training                    
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*1000),44000);
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*2000),44000);                    
                    end
                    break;
                elseif ((strcmp(strInputName, 'UpArrow') && (depth_step > 0) && (stimulus_order == 0)) || (strcmp(strInputName, 'DownArrow') && (depth_step < 0) && (stimulus_order == 0)))
                    % Correct (pedestal is on top and far or on top and close)             
                    response = 2;
                    display('Response:  Correct');
                    if training                        
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*1000),44000);
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*2000),44000);
                    end
                    break;                   
                elseif (strcmp(strInputName, 'UpArrow') || strcmp(strInputName, 'DownArrow'))
                    % Correct (pedestal is on top and far or on top and close)             
                    response = 1;
                    display('Response:  Incorrect');
                    if training                        
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*1000),44000);
        				sound(0.5*sin(2*pi*[0:1/44100:.05]*600),44000);       
                    end
                    break;
                elseif strcmp(strInputName, '0')
                    % Skip
                    response = 0;
                    display('Response:  Skip');
                    break;
                end 
            else
                % Nonius task              
                if (strcmp(strInputName, 'LeftArrow'))
                    % Upper line is seen to the left of the lower one
                    % This means the response is "correct." That is, the separation must be decreased, even if it becomes negative
                    response = 1;
                    display('Response:  Top to the left');
                    break;
                elseif (strcmp(strInputName, 'RightArrow'))
                    % Increase the separation
                    response = 2;
                    display('Response:  Top to the right'); 
                    break;
                elseif strcmp(strInputName, '0') 
                    % Skip
                    response = 0;
                    display('Response:  Skip');
                    break;
                end
            end
            
            if (get(scell{current_sc}, 'MCS'))
                % Method of constant stimuli
                % Modify response so it reflects whether the test looked farther away than the reference
                % 2 = test farther away. 1 = test closer.
                if (depth_step < 0 && response ~= 0)
                    response = 3 - response;
                end
            end
                    
        elseif  (strcmp(experiment_type,'disparity_blur_sequential'))
              depthplane=depthplane+1;
              if depthplane>4
                  depthplane=1;
              end
%             depthplane = 2;                 % Used for non-bf-lens haploscope
            depthtex_handle=depthplane;  

            for whichEye=renderviews 
                
                Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
                Screen('BeginOpenGL', windowPtr);
                glClear;
                
                % Show fixation cross   
                glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup                
                glCallList(fixation_projection(depthplane+whichEye*4));         % Fixation
                
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

            % Get stimulus presentation layout
            depth_step = get(scell{current_sc}, 'currentValue');        % Negative:  reference farther away than pedestal

            if (db_stim_type < 3)
                
                if (strcmp(strInputName, '1') && ((mono == 1) && (vergdist == ShiftDiopters(0.37,diopter_offset))))
                    strInputName = '2';
                elseif (strcmp(strInputName, '2') && ((mono == 1) && (vergdist == ShiftDiopters(0.37,diopter_offset))))
                    strInputName = '1';
                end                                            
            
                % Pedestal on top
                if ((strcmp(strInputName, '1') && (depth_step < 0) && stimulus_order) || (strcmp(strInputName, '2') && (depth_step > 0) && stimulus_order))
                    % Correct (pedestal is on top and far or on top and close)             
                    response = 2;
                    display('Response:  Correct');
                    if training                    
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*1000),44000);
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*2000),44000);                    
                    end
                    break;
                elseif ((strcmp(strInputName, '1') && (depth_step > 0) && (stimulus_order == 0)) || (strcmp(strInputName, '2') && (depth_step < 0) && (stimulus_order == 0)))
                    % Correct (pedestal is on top and far or on top and close)             
                    response = 2;
                    display('Response:  Correct');
                    if training                        
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*1000),44000);
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*2000),44000);
                    end
                    break;                   
                elseif (strcmp(strInputName, '1') || strcmp(strInputName, '2'))
                    % Correct (pedestal is on top and far or on top and close)             
                    response = 1;
                    display('Response:  Incorrect');
                    if training                        
                        sound(0.5*sin(2*pi*[0:1/44100:.05]*1000),44000);
        				sound(0.5*sin(2*pi*[0:1/44100:.05]*600),44000);       
                    end
                    break;
                elseif strcmp(strInputName, '0')
                    % Skip
                    response = 0;
                    display('Response:  Skip');
                    break;
                end 
            else
                % Nonius task              
                if (strcmp(strInputName, 'LeftArrow'))
                    % Upper line is seen to the left of the lower one
                    % This means the response is "correct." That is, the separation must be decreased, even if it becomes negative
                    response = 1;
                    display('Response:  Top to the left');
                    break;
                elseif (strcmp(strInputName, 'RightArrow'))
                    % Increase the separation
                    response = 2;
                    display('Response:  Top to the right'); 
                    break;
                elseif strcmp(strInputName, '0') 
                    % Skip
                    response = 0;
                    display('Response:  Skip');
                    break;
                end
            end                 
                
        else                    
            sound(0.5*sin(2*pi*[0:1/44100:.05]*300),44000);
        end                     
end

% if (get(scell{current_sc}, 'MCS') && response ~= 0)
%     % Method of constant stimuli
%     % Modify response so it reflects whether the test looked farther away than the reference
%     % 2 = test farther away. 1 = test closer.
%     if (depth_step < 0)
%         response = 3 - response;
%     end
% end 

BF_record_response;
% below are experiments not using staircase cells.
if ~strcmp(experiment_type, 'fatigue_time_pilot_03')&&~strcmp(experiment_type, 'fatigue_time')&&~strcmp(experiment_type,'fatigue_time_3')...
        &&~strcmp(experiment_type,'fatigue_time_4')&&~strcmp(experiment_type,'fatigue_time_5')&&~strcmp(experiment_type,'specularity_flat') ...
        &&~strcmp(experiment_type,'focusVaryingStereo')
	scell{current_sc} = processResponse(scell{current_sc},response);
end

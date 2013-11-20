%This script will display a message to the user

for whichEye=[0 1]
    Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
    glClear();
end
Screen('Flip', windowPtr, [], 2, 1);

if strcmp(message,'fatiguequestion')
    fatigue_question_start=GetSecs;
end

displaymessage=1;
depthplane=0;
while(displaymessage==1)

    depthplane=depthplane+1;
    if depthplane>4

        depthplane=1;
    end
    depthtex_handle=depthplane;  
                
    for whichEye=0

        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        glClear;
        if depthplane==3
            if whichEye==1
                Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
            else
                Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
            end
        end

        if strcmp(experiment_type,'fatigue_assess_sym0p1D') || strcmp(experiment_type,'fatigue_assess_sym1p3D') || strcmp(experiment_type,'fatigue_assess_sym2p5D')...
                ||strcmp(experiment_type,'fatigue_assess_sym_training')
            messageplane=3; % MidNear plane
        elseif strcmp(experiment_type,'fatigue_assess1') || strcmp(experiment_type,'fatigue_assess2') || strcmp(experiment_type,'fatigue_assess3') || strcmp(experiment_type,'fatigue_time_4')
            messageplane=2; % Farmid plane
%         elseif strcmp(experiment_type,'fatigue_dip0p1D')||strcmp(experiment_type,'fatigue_dip1p3D')||strcmp(experiment_type,'fatigue_dip2p5D')
%             messageplane=acc_plane;
        else
            messageplane=1; % Farthest plane
        end
        if depthplane==messageplane
            if strcmp(message, 'endofblock')
                Screen('TextSize',windowPtr, 25);
                Screen('DrawText', windowPtr, ['Take a break'], 300, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['Press enter to continue'], 200, 300, [255, 255, 255, 255]);  
                Screen('DrawText', windowPtr, ['Press escape to stop'], 200, 300, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, [num2str(trial_counter/350) 'blocks completed'], 200, 350, [255, 255, 255, 255]);
                Screen('Flip', windowPtr, [], 2, 1);
                WaitSecs(2);
            elseif strcmp(message, 'takeabreak')
                Screen('TextSize',windowPtr, 25);
                Screen('DrawText', windowPtr, ['Take a break'], 300, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['Press any key to continue'], 200, 300, [255, 255, 255, 255]);  
                Screen('DrawText', windowPtr, ['trial' num2str(trial_counter)], 200, 350, [255, 255, 255, 255]);  
            elseif strcmp(message, 'readytobegin')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Ready to begin?'], 300, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['Push mouse out of the way.'], 250, 275, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['Press any key to continue'], 200, 350, [255, 255, 255, 255]);
            elseif strcmp(message, 'experimentcomplete')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Experiment Complete'], 300, 200, [255, 255, 255, 255]); 
            elseif strcmp(message, 'turnlensoff')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['!!!!!Turn off lens NOW !!!!!'], 200, 200, [255, 255, 255, 255]);
            elseif strcmp(message, 'turnlenson')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Turn lens on now'], 300, 200, [255, 255, 255, 255]);    
			elseif strcmp(message, 'wrongbasedistance')
                Screen('TextSize',windowPtr, 25);
                Screen('DrawText', windowPtr, ['Check calibration file:'], 300, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['Wrong base distance'], 200, 300, [255, 255, 255, 255]);  
                Screen('DrawText', windowPtr, ['correct distance is ' correctBaseDistance], 200, 350, [255, 255, 255, 255]);  
            elseif strcmp(message, 'fatiguequestion')
                Screen('TextSize',windowPtr, 30);
                Screen('DrawText', windowPtr, ['How tired are your eyes?'], 210, 220, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['---------------------------------'], 200, 250, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['1       -       5'], 290, 300, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['(very fresh)      (very tired)'], 180, 350, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['You rated:'], 300, 400, [255, 255, 255, 255]); 
                if degree_fatigue~=-1
                    Screen('DrawText',windowPtr,[num2str(degree_fatigue)],470,400,[255,255,255,255]);
                end
                if GetSecs-fatigue_question_start>fatigue_question_duration
                    displaymessage=0;
                end
            elseif strcmp(message, 'breakuntilnextassessment')
                Screen('TextSize',windowPtr, 35);
                if toc>break_duration
                    Screen('DrawText', windowPtr, ['Press any key'], 300, 200, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['to start'], 350, 275, [255, 255, 255, 255]);
                else
                    remaining_time=ceil(break_duration-toc);
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    Screen('DrawText', windowPtr, ['BREAK'], 300, 200, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['remaining time is'], 350, 275, [255, 255, 255, 255]); 
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    if remaining_second<10
                        str_time=[num2str(remaining_minute) ':0' num2str(remaining_second)];
                    else
                        str_time=[num2str(remaining_minute) ':' num2str(remaining_second)];
                    end
                    Screen('DrawText', windowPtr, [str_time], 400, 350, [255, 255, 255, 255]);
                end
            elseif strcmp(message, 'persessionQ')
                Screen('TextSize',windowPtr, 35);
                break_duration=break_duration_persession;
                if toc>break_duration
                    Screen('DrawText', windowPtr, ['Press any key'], 300, 200, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['to start'], 350, 275, [255, 255, 255, 255]);
                else
                    remaining_time=ceil(break_duration-toc);
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    persessionQ_text=['(Condition ' num2str(ceil(finished_conditions/2)) ' Session ' num2str(2-mod(finished_conditions,2)) ')'];
                    Screen('DrawText', windowPtr, persessionQ_text, 300, 200, [255, 255, 255, 255]);
                    Screen('DrawText', windowPtr, ['Per session Q'], 300, 125, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['remaining time is'], 350, 275, [255, 255, 255, 255]); 
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    if remaining_second<10
                        str_time=[num2str(remaining_minute) ':0' num2str(remaining_second)];
                    else
                        str_time=[num2str(remaining_minute) ':' num2str(remaining_second)];
                    end
                    Screen('DrawText', windowPtr, [str_time], 400, 350, [255, 255, 255, 255]);
                end
            elseif strcmp(message, 'persessionQcomparisonQ')
                Screen('TextSize',windowPtr, 35);
                break_duration=break_duration_comparison;
                if toc>break_duration_comparison
                    Screen('DrawText', windowPtr, ['Press any key'], 300, 200, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['to start'], 350, 275, [255, 255, 255, 255]);
                else
                    remaining_time=ceil(break_duration-toc);
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    persessionQ_text=['(Condition ' num2str(ceil(finished_conditions/2)) ' Session ' num2str(2-mod(finished_conditions,2)) ')'];
                    Screen('DrawText', windowPtr, persessionQ_text, 300, 200, [255, 255, 255, 255]);
                    Screen('DrawText', windowPtr, ['Per session & comparison Q'], 200, 125, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['remaining time is'], 350, 275, [255, 255, 255, 255]); 
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    if remaining_second<10
                        str_time=[num2str(remaining_minute) ':0' num2str(remaining_second)];
                    else
                        str_time=[num2str(remaining_minute) ':' num2str(remaining_second)];
                    end
                    Screen('DrawText', windowPtr, [str_time], 400, 350, [255, 255, 255, 255]);
                end
            elseif strcmp(message, 'break_fatigue_time')
                Screen('TextSize',windowPtr, 35);
%                 break_duration=break_duration_comparison;
                if toc>break_duration
                    Screen('DrawText', windowPtr, ['Press enter'], 300, 200, [255, 255, 255, 255]); 
                    Screen('DrawText', windowPtr, ['to start'], 350, 275, [255, 255, 255, 255]);
                else
                    remaining_time=ceil(break_duration-toc);
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    Qinfo=['(Day ' num2str(ceil(finished_conditions/2)) ' Session ' num2str(2-mod(finished_conditions,2)) ')'];
                    Screen('DrawText', windowPtr, Qinfo, 300, 200, [255, 255, 255, 255]);
                    Screen('DrawText', windowPtr, ['remaining time is'], 350, 275, [255, 255, 255, 255]); 
                    remaining_minute=floor(remaining_time/60);
                    remaining_second=remaining_time-60*remaining_minute;
                    if remaining_second<10
                        str_time=[num2str(remaining_minute) ':0' num2str(remaining_second)];
                    else
                        str_time=[num2str(remaining_minute) ':' num2str(remaining_second)];
                    end
                    Screen('DrawText', windowPtr, [str_time], 400, 350, [255, 255, 255, 255]);
                end
            elseif strcmp(message, 'pressentertocontinue')
                Screen('TextSize',windowPtr, 35);
				Screen('DrawText', windowPtr, ['Please read questionnaire,'], 130, 200, [255, 255, 255, 255]); 
				Screen('DrawText', windowPtr, ['and remember what you feel.'], 110, 275, [255, 255, 255, 255]); 
				Screen('DrawText', windowPtr, ['Press enter to continue'], 150, 350, [255, 255, 255, 255]);
            elseif strcmp(message, 'marktheansweranddiscomfort')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Mark your answer and discomfort.'], 100, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['Answer:'], 400, 275, [255, 255, 255, 255]); 
                if (answer~=0)
                    Screen('DrawText', windowPtr, [num2str(answer)], 600, 275, [255, 255, 255, 255]); 
                end
                Screen('DrawText', windowPtr, ['Discomfort:'], 400, 350, [255, 255, 255, 255]); 
                if (discomfort~=0)
                    Screen('DrawText', windowPtr, [num2str(discomfort)], 600, 350, [255, 255, 255, 255]); 
                end
                if GetSecs-fatigue_question_start>fatigue_question_duration
                    displaymessage=0;
                end
            elseif strcmp(message, 'positivediplopia')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Move the target'], 200, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['as close to you as possible,'], 150, 250, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['while the target remains'], 200, 300, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['in focus.'], 300, 350, [255, 255, 255, 255]); 
            elseif strcmp(message, 'negativediplopia')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Move the target'], 200, 200, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['as far from you as possible,'], 150, 250, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['while the target remains'], 200, 300, [255, 255, 255, 255]); 
                Screen('DrawText', windowPtr, ['in focus.'], 300, 350, [255, 255, 255, 255]); 
            elseif strcmp(message, 'wrongdirection')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Wrong direction!'], 100, 200, [255, 255, 255, 255]); 
            else
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Invalid Message'], 300, 200, [255, 255, 255, 255]);                     
            end     
        end
    end
    onset=Screen('Flip', windowPtr, [], 2, 1);
    
    
    [strInputName2, x, y] = BFWaitForInput(0.000001);

    for whichEye=[0 1]
        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        glClear();
    end
    Screen('Flip', windowPtr, [], 2, 1);
    
    if strcmp(message, 'endofblock') && strcmp(strInputName2, 'Return') == 1
        displaymessage=0;
        break;
    elseif strcmp(message, 'endofblock') && strcmp(strInputName2, 'ESCAPE') == 1
        displaymessage=0;
        stop_flag=1;
        for whichEye=[0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
    end
                

    if strcmp(strInputName2, '')==0 && strcmp(message, 'turnlensoff')~=1 && strcmp(message, 'breakuntilnextassessment')~=1 && strcmp(message, 'marktheansweranddiscomfort')~=1 ...
        && strcmp(message, 'fatiguequestion')~=1 && strcmp(message, 'pressentertocontinue')~=1 && strcmp(message, 'persessionQ')~=1 && strcmp(message, 'persessionQcomparisonQ')~=1 ...
		&& strcmp(message, 'break_fatigue_time')~=1
        displaymessage=0;
        for whichEye=[0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
                        
        break;
        
    elseif strcmp(strInputName2, 'q')==1 && strcmp(message, 'turnlensoff')
        displaymessage=0;
        
        
        break;
	elseif strcmp(message, 'pressentertocontinue') && strcmp(strInputName2, 'Return')
		displaymessage=0;
		break;
    elseif strcmp(message, 'fatiguequestion') && strcmp(strInputName2, '1')
        degree_fatigue=1;
    elseif strcmp(message, 'fatiguequestion') && strcmp(strInputName2, '2')
        degree_fatigue=2;
    elseif strcmp(message, 'fatiguequestion') && strcmp(strInputName2, '3')
        degree_fatigue=3;
    elseif strcmp(message, 'fatiguequestion') && strcmp(strInputName2, '4')
        degree_fatigue=4;
    elseif strcmp(message, 'fatiguequestion') && strcmp(strInputName2, '5')
        degree_fatigue=5;
    elseif strcmp(strInputName2, 'ESCAPE') && strcmp(message, 'breakuntilnextassessment')
        displaymessage=0;
        stop_flag=1;
        for whichEye=[0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
    elseif strcmp(strInputName2, 'ESCAPE') && strcmp(message, 'persessionQ')
        displaymessage=0;
        stop_flag=1;
        for whichEye=[0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
    elseif strcmp(strInputName2, 'ESCAPE') && strcmp(message, 'persessionQcomparisonQ')
        displaymessage=0;
        stop_flag=1;
        for whichEye=[0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
        
    elseif strcmp(strInputName2, 'ESCAPE') && strcmp(message, 'break_fatigue_time')
        displaymessage=0;
        stop_flag=1;
        for whichEye=[0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
        
    elseif strcmp(strInputName2,'')==0 && strcmp(message, 'breakuntilnextassessment') && toc>break_duration
        displaymessage=0;
    elseif strcmp(strInputName2,'')==0 && strcmp(message, 'persessionQ') && toc>break_duration
        displaymessage=0;
    elseif strcmp(strInputName2,'')==0 && strcmp(message, 'persessionQcomparisonQ') && toc>break_duration
        displaymessage=0;
	elseif strcmp(strInputName2, 'Return') && strcmp(message, 'break_fatigue_time') && toc>break_duration
		displaymessage=0;
    end

end

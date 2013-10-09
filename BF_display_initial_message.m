% This routine displays initial messages for the experiment on screen.

% in fatigue time study 4, check the calibration file base distance and
% notice if it doesn't match with the designed base distance
if strcmp(experiment_type,'fatigue_time_4') && finished_conditions<howmanyconditions
	if (condition_order(finished_conditions+1)==1)...
            ||(condition_order(finished_conditions+1)==2)...
            ||(condition_order(finished_conditions+1)==3)...
            ||(condition_order(finished_conditions+1)==4)
		correctBaseDistance='0p1D';
    elseif (condition_order(finished_conditions+1)==5)...
            ||(condition_order(finished_conditions+1)==6)
		correctBaseDistance='1p3D';
    elseif (condition_order(finished_conditions+1)==7)...
            ||(condition_order(finished_conditions+1)==8)
        correctBaseDistance='0p1D';
	end
	calibrationFileLength=length(observer_initials);
	calibrationFileBaseDistance=observer_initials((calibrationFileLength-3):calibrationFileLength);
	if ~strcmp(correctBaseDistance,calibrationFileBaseDistance)
		stop_flag=1;
		message='wrongbasedistance';
		BF_disp_message;
	else
		message='turnlenson';
		BF_disp_message

		message='readytobegin';
		BF_disp_message
	end
else
	message='turnlenson';
	BF_disp_message

	message='readytobegin';
	BF_disp_message
end

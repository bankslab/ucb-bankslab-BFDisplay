
            if strcmp(strInputName, 'ESCAPE')

                %ListenChar(0);
                break;
            end
            
            
            if strcmp(experiment_type,'demomode') 
                
                    %perform a calibration
                if strcmp(strInputName, 'c')
                    %toggle calibration
                        spatialundistort= (spatialundistort==0);


                    % Spatial undistortion is done inside the per-view image
                    % processing chains of the imaging pipeline. Simplest way
                    % of en-/disabling this op is to enable/disable the chains:
                    if spatialundistort
                        Screen('HookFunction', windowPtr, 'Enable', 'StereoLeftCompositingBlit');
                        Screen('HookFunction', windowPtr, 'Enable', 'StereoRightCompositingBlit');
                    else
                        Screen('HookFunction', windowPtr, 'Disable', 'StereoLeftCompositingBlit');
                        Screen('HookFunction', windowPtr, 'Disable', 'StereoRightCompositingBlit');
                    end


                elseif strcmp(strInputName, 'a')
                        activelensmode=(activelensmode==0);
                        depthtex_handle=1;
                        depthplane=1;

                elseif strcmp(strInputName, 'f')
                    focus_cue_multiplier=double(focus_cue_multiplier==0);
                    recompute_projection_list=1;
%                 elseif strcmp(strInputName, 'f')
%                     if focus_cue_multiplier==1
%                         focus_cue_multiplier=0;
%                     else
%                         focus_cue_multiplier=1;
%                     end

                end
                
                if activelensmode==0
                    if strcmp(strInputName, '1') || strcmp(strInputName, '1!')
                        depthtex_handle=1;
                        depthplane=1;
                    elseif strcmp(strInputName, '2') || strcmp(strInputName, '2@')
                        depthtex_handle=2;
                        depthplane=2;
                    elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                        depthtex_handle=3;
                        depthplane=3;
                    elseif strcmp(strInputName, '4') || strcmp(strInputName, '4$')
                        depthtex_handle=4;
                        depthplane=4;
                    end
                else
                   if strcmp(strInputName, '1') || strcmp(strInputName, '1!')
                        vergdist=imageplanedist(1)
                    elseif strcmp(strInputName, '2') || strcmp(strInputName, '2@')
                        vergdist=imageplanedist(2)
                    elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                        vergdist=imageplanedist(3)
                    elseif strcmp(strInputName, '4') || strcmp(strInputName, '4$')
                        vergdist=imageplanedist(4)
                   end      
                    recompute_static_scene_list=1;
                end
            elseif strcmp(experiment_type,'specularity')
                if strcmp(strInputName,'RightArrow')
                    surfaceScaleIndex=surfaceScaleIndex+1;
                    recompute_static_scene_list=1;
                    if surfaceScaleIndex>21
                        surfaceScaleIndex=21;
                    end
                elseif strcmp(strInputName,'LeftArrow')
                    surfaceScaleIndex=surfaceScaleIndex-1;
                    recompute_static_scene_list=1;
                    if surfaceScaleIndex<1
                        surfaceScaleIndex=1;
                    end
                elseif strcmp(strInputName,'UpArrow')
                    reflectionScaleIndex=reflectionScaleIndex-1;
                    recompute_static_scene_list=1;
                    if reflectionScaleIndex>21
                        reflectionScaleIndex=21;
                    end
                elseif strcmp(strInputName,'DownArrow')
                    reflectionScaleIndex=reflectionScaleIndex-1;
                    recompute_static_scene_list=1;
                    if reflectionScaleIndex<1
                        reflectionScaleIndex=1;
                    end
                end
            elseif strcmp(experiment_type,'specularity_flat_mono')
                if strcmp(strInputName,'RightArrow')
%                     surfaceScaleIndex=surfaceScaleIndex+1;
%                     recompute_static_scene_list=1;
%                     if surfaceScaleIndex>19
%                         surfaceScaleIndex=19;
%                     end
                elseif strcmp(strInputName,'LeftArrow')
%                     surfaceScaleIndex=surfaceScaleIndex-1;
%                     recompute_static_scene_list=1;
%                     if surfaceScaleIndex<1
%                         surfaceScaleIndex=1;
%                     end
                elseif strcmp(strInputName,'UpArrow')
                    reflectionScaleIndex=reflectionScaleIndex+1;
                    recompute_static_scene_list=1;
                    if reflectionScaleIndex>19
                        reflectionScaleIndex=19;
                    end
                elseif strcmp(strInputName,'DownArrow')
                    reflectionScaleIndex=reflectionScaleIndex-1;
                    recompute_static_scene_list=1;
                    if reflectionScaleIndex<1
                        reflectionScaleIndex=1;
                    end
                end
            elseif strcmp(experiment_type, 'alignmode')  ||  strcmp(experiment_type, 'iodrectmode')
             
                recompute_projection_list=1;
                
                if strcmp(strInputName, '2')  || strcmp(strInputName, '2@')
                    alignplane=2;
                    recompute_static_scene_list=1;
                elseif strcmp(strInputName, '3') || strcmp(strInputName, '3#')
                    alignplane=3;
                    recompute_static_scene_list=1;
                elseif strcmp(strInputName, '4')  || strcmp(strInputName, '4$')
                    alignplane=4;
                    recompute_static_scene_list=1;
                elseif strcmp(strInputName, 'x')
                    alignplane=1;
                    recompute_static_scene_list=1;
                elseif strcmp(strInputName, 'e')
                    adjustEye=(0==adjustEye)+0;   
                    recompute_projection_list=1;
                elseif strcmp(strInputName, 'm')
                    alignmag=(0==alignmag)+0;  
                    recompute_projection_list=1;
                elseif strcmp(strInputName, 'UpArrow')
                    
                    if alignmag
                    
                            
                            vertFOVoffset(alignplane+4*adjustEye)=vertFOVoffset(alignplane+4*adjustEye)-align_adjust;

                    else
                        degvertoffset(alignplane+4*adjustEye)=degvertoffset(alignplane+4*adjustEye)-align_adjust;
                    end    
                    recompute_projection_list=1;
                elseif strcmp(strInputName, 'DownArrow')

                    if alignmag
                            vertFOVoffset(alignplane+4*adjustEye)=vertFOVoffset(alignplane+4*adjustEye)+align_adjust;
                        
                    else
                        degvertoffset(alignplane+4*adjustEye)=degvertoffset(alignplane+4*adjustEye)+align_adjust;
                    end                      
                    recompute_projection_list=1;
                elseif strcmp(strInputName, 'RightArrow')
                    if alignmag

                            horizFOVoffset(alignplane+4*adjustEye)=horizFOVoffset(alignplane+4*adjustEye)+align_adjust;

                    else
                        deghorizoffset(alignplane+4*adjustEye)=deghorizoffset(alignplane+4*adjustEye)+align_adjust;
                    end                      
                    recompute_projection_list=1;
                elseif strcmp(strInputName, 'LeftArrow')
                    if alignmag


                            horizFOVoffset(alignplane+4*adjustEye)=horizFOVoffset(alignplane+4*adjustEye)-align_adjust;

                    else
                        deghorizoffset(alignplane+4*adjustEye)=deghorizoffset(alignplane+4*adjustEye)-align_adjust;
                    end
                    recompute_projection_list=1;
                end
                
            end

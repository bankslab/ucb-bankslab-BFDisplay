function output = ConvertToDisparity(fix_dist,obj_dist,IPD,min)

% Find angle formed by object
obj_angle = 2*atand(IPD/2./obj_dist);

% Find fixation angle
fix_angle= 2*atand(IPD/2./fix_dist);

disparity = obj_angle - fix_angle;

% Output in minutes?
if min
    output = disparity*60;
else
    output = disparity;
end

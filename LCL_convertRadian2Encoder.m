function [configEncoder] = LCL_convertRadian2Encoder(configRadian)
    % this function converts radian values from rigidBodyTree 

    nbJoints = length(configRadian);
    configEncoder = zeros(nbJoints,1);

    % Set Radian Position to be upright LCL
    configRadian(2).JointPosition = configRadian(2).JointPosition - (pi/2);

    % Map values from [0:pi] to [0:2048] 
    % account for directions being different
    % set 0 radian position to 2048encoder positon
    for i = 1:nbJoints
        configEncoder(i) = round(2048 - (configRadian(i).JointPosition / pi) * 2048) ;
    end


end
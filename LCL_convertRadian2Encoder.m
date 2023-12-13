function [configEncoder] = LCL_convertRadian2Encoder(configRadian)
    nbJoints = length(configRadian);
    configEncoder = zeros(nbJoints,1);

    % Set Radian Position to be upright LCL
    configRadian(2).JointPosition = configRadian(2).JointPosition - (pi/2);


    for i = 1:nbJoints
        configEncoder(i) = round(2048 - (configRadian(i).JointPosition / pi) * 2048) ;
    end


end
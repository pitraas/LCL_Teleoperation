function [configRadian] = LCL_convertEncoder2Radian(configEncoder)
    % this function converts encoder values from LCL to radian values to...
    % use with rigidBodyTree Model

    nbJoints = length(configEncoder);
    configRadian = zeros(nbJoints,1);

    % Map values from [0:2048] to [0:pi]
    % change direction
    % set 2048encoder position to 0 rad
    for i = 1:nbJoints
        configRadian(i) = ((2048-configEncoder(i)) / 2048) * pi;
    end


    % Set Radian Position to be upright LCL
    configRadian(2) = configRadian(2) + (pi/2);
end
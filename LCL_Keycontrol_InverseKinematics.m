nbJoints = 5;
% setting limits
minLimit = [500; 1000; 300; 1000; 1500];
maxLimit = [3596; 3000; 3800; 3000; 3500];


% create an inverseKinematics Object (possibility to use MATLAB app
% to choose best suited solver)
ik = inverseKinematics('RigidBodyTree',LCL_Tree);

% specify weights for the different components of pose 
% (use a lower magnitude for orientation angles than the position components)
weights = [0.25 0.25 0.25 1 1 1];

% use home configuration as an initial guess
homeConfig = homeConfiguration(LCL_Tree);


% Move to Homepositon

% Enter a Position in Task Space TransformationMatrix


% Calculate the corresponding Transform Matrice
tform = getTransform(LCL_Tree,homeConfig,'tool','base')

% Calculate Joint Position using inverseKinematics Object
initialguess = homeConfig;
[configSoln,solnInfo] = ik("tool",tform,weights,initialguess)

% Map the solution to motor encoder values
jointPositionsEncoderMapping = zeros(1,nbJoints);
for i = 1:nbJoints
    jointPositionsEncoderMapping(i) = (configSoln(i).JointPosition / (2*pi)) * 4096;
    % Correct Position Error for SM40BL Motors
    if i >= 4
        jointPositionsEncoderMapping(i) = jointPositionsEncoderMapping(i) + 40;
    end
end

% Check Limits
for i = 1:nbJoints
    if (jointPositionsEncoderMapping(i) < minLimit(i)) || (jointPositionsEncoderMapping(i) > maxLimit(i))
        msg = ['Joint ', int2str(i), ' out of Limits!'];
        disp (msg);
    end
end


% Check if the new Configuration is near the old one

% Show new robot Configuration

% Ask if Robot should move to Poition

% Move to Position


% write the desired Pose as a Transformation Matrix
%tform = getTransform(LCL_Tree,randConfig,'tool','base');

% Calculate the joint positions using the inverseKinematics object.
% initialguess = homeConfig;
% [configSoln,solnInfo] = ik("tool",tform,weights,initialguess);
% create an inverseKinematics Object (possibility to use MATLAB app
% to choose best suited solver)
ik = inverseKinematics('RigidBodyTree',LCL_Tree)

% specify weights for the different components of pose 
% (use a lower magnitude for orientation angles than the position components)
weights = [0.25 0.25 0.25 1 1 1];

% use home configuration as an initial guess
initialguess = homeConfiguration(LCL_Tree)

% Move to Homepositon

% Enter a Position in Task Space TransformationMatrix


% Calculate the corresponding Transform Matrice

% Calculate Joint Position using inverseKinematics Object

% Check Limits

% Show new robot Configuration

% Ask if Robot should move to Poition

% Move to Position


% write the desired Pose as a Transformation Matrix
tform = getTransform(LCL_Tree,randConfig,'tool','base');

% Calculate the joint positions using the inverseKinematics object.
[configSoln,solnInfo] = ik("tool",tform,weights,initialguess);
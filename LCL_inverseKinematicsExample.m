%Example how to use inverse kinematics:

%Step 1: create an inverseKinematics Object (possibility to use MATLAB app
%       to choose best suited solver)
ik = inverseKinematics('RigidBodyTree',LCL_Tree)

%Step 2: specify weights for the different components of pose 
%        (use a lower magnitude for orientation angles than the position
%         components)
weights = [0.25 0.25 0.25 1 1 1];

%Step 3: use home configuration as an initial guess
initialguess = homeConfiguration(LCL_Tree)

%Step 4: write the desired Pose as a Transformation Matrix
tform = getTransform(LCL_Tree,randConfig,'tool','base');

%Step 5: Calculate the joint positions using the inverseKinematics object.
[configSoln,solnInfo] = ik("tool",tform,weights,initialguess);
clc

% Define variables
r = rateControl(10);
stepSize = 0.02
q; %Stepsize in cm
homePose = homeConfiguration(LCL_Tree);
ik = inverseKinematics('RigidBodyTree', LCL_Tree); % create inverseKinematics Object
weights = [0.25 0.25 0.25 1 1 1]; %specify weights for orientation / Position



% Move to initial Position 

RobMaster.writeline('move 2048 2048 2048 2048 2048 T=1000 D=0');

oldPose = homePose;

nextPose = getTransform(LCL_Tree,homePose,'Axis_5_Camera','base');

disp('Change Pose: x+: s, x-: x, y+: a, y-: y, z+: d, z-: c, quit: q');
programmRunning = 1;
while programmRunning 
    disp('Enter MoveCommand:')
    keyEntered = getkey();
    switch(keyEntered)
        case 'a'
            nextPose(2,4) = nextPose(2,4) + stepSize;
        case 'y'
            nextPose(2,4) = nextPose(2,4) - stepSize;
        case 's'
            nextPose(1,4) = nextPose(1,4) + stepSize;
        case 'x'
            nextPose(1,4) = nextPose(1,4) - stepSize;
        case 'd'
            nextPose(3,4) = nextPose(3,4) + stepSize;
        case 'c'
            nextPose(3,4) = nextPose(3,4) - stepSize;
        case 'q'
            programmRunning = 0;
    end
    
    disp(nextPose(1:3,4));
    % Calculate the joint positions using the inverseKinematics object.
    initialguess = oldPose;
    [configSolutionRadian,solnInfo] = ik("Axis_5_Camera",nextPose,weights,oldPose);
    oldPose = configSolutionRadian;

    % Show new Position of Model in figure
    show(LCL_Tree,configSolutionRadian);

    % Convert calculated Pose to Encoder values which can be sent to LCL
    configEncodervalues = LCL_convertRadian2Encoder(configSolutionRadian);
    
    % Construct Command
    SendCommand = append('move ',num2str(configEncodervalues(1)),' ',...
        num2str(configEncodervalues(2)),' ',num2str(configEncodervalues(3)),' ',...
        num2str(configEncodervalues(4)),' ',num2str(configEncodervalues(5)), ' T=1000 D=0');
    
    % Display comand
    disp(['Command: ', SendCommand]);

    % check for limits

    
    % Ask if movement should be executed
    disp('Exceute Movement? Yes: enter, No: n')
    key = getkey();
    if key == 13
        RobMaster.writeline(SendCommand);
    end
    waitfor(r);
end


clc

%% *** Define variables ***

r = rateControl(2);
stepSize = 0.02; %Stepsize in cm
homePose = homeConfiguration(LCL_Tree);
ik = inverseKinematics('RigidBodyTree', LCL_Tree); % create inverseKinematics Object
weights = [0.25 0.25 0.25 1 1 1]; %specify weights for orientation / Position
nbJoints = 5;
minLimit = [600; 1000; 200; 1900; 1000]; % robot joint min limits
maxLimit = [3495; 3200; 3700; 3800; 3000]; % robot joint max limits


%% *** Move robot to starting Position ***

%RobMaster.writeline('move 2048 2048 2048 2048 2048 T=1000 D=0'); % stretched Position
%oldEncoderValues = [2048; 2048; 2048; 2048; 2048];
RobMaster.writeline('move 2048 1661 420 3300 2048 T=1000 D=0'); % Sitting Human Position 
oldEncoderValues = [2048; 1661; 420; 3300; 2048];


%% *** set new rigidbodytree HomePose to current pose ***

RobMaster.writeline('enable');
pause(1)
currPoseEncoder = LCL_getCurrentPose(RobMaster);
currPoseRadian = LCL_convertEncoder2Radian(currPoseEncoder);
for i = 1:length(currPoseRadian)
    homePose(i).JointPosition = currPoseRadian(i);
end

oldPose = homePose; %intitialization of oldPose
nextPose = getTransform(LCL_Tree,homePose,'Axis_5_Camera','base'); % Initialize nextPose to be a Transform Matrix


%% *** Main Loop: ... ***
% Read user entry (new task space Pose),
% Calculate new joint positions
% convert joint position from rad to encoder values
% construct command message to be sent to robot
% check robot limits
% check how different the next position is from the current one
% Show new config in plot (rigidbodytree)
% -> send command to robot if limits are ok

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
            break
    end
    
    disp(nextPose(1:3,4));

    % Calculate the joint positions using the inverseKinematics object.
    initialguess = oldPose;
    [configSolutionRadian,solnInfo] = ik("Axis_5_Camera",nextPose,weights,initialguess);
    
    % Convert calculated Pose to Encoder values which can be sent to LCL
    configEncodervalues = LCL_convertRadian2Encoder(configSolutionRadian);
    
    % Construct Command Message
    SendCommand = append('move ',num2str(configEncodervalues(1)),' ',...
        num2str(configEncodervalues(2)),' ',num2str(configEncodervalues(3)),' ',...
        num2str(configEncodervalues(4)),' ',num2str(configEncodervalues(5)), ' T=300 D=0');
    
    % Display command message
    disp(['Command: ', SendCommand]);

    limitflag = 0;
    % Check Limits
    for i = 1:nbJoints
        if (configEncodervalues(i) < minLimit(i)) || (configEncodervalues(i) > maxLimit(i))
            msg = ['Joint ', int2str(i), ' out of Limits! Try different Pose.'];
            detailedmsg = [int2str(configEncodervalues(i)),' is not inside [',int2str(minLimit(i)),' ',int2str(maxLimit(i))];
            disp(msg);
            disp(detailedmsg);
            limitflag = 1;
        end
    end

    %%  check that new configuration is near the old one
    farawayPoseFlag = 0;
    for i = 1:length(configEncodervalues)
        if (abs(configEncodervalues(i) - oldEncoderValues(i)) > 500)
            farawayPoseFlag = 1;
            msg2 = 'New config to far from old one! Try different Pose.';
            disp(msg2)
        end
    end

    % Show new Position of Model in figure
    show(LCL_Tree,configSolutionRadian);

    if (limitflag == 0 && farawayPoseFlag == 0)    
        disp('Exceute Movement? Yes: enter, No: n')
        key = getkey();
        if key == 13
            RobMaster.writeline(SendCommand);
            oldEncoderValues = configEncodervalues;
            oldPose = configSolutionRadian;
        end
        if key == 'q'
            break
        end
    end
    waitfor(r);
end

RobMaster.writeline('enable');



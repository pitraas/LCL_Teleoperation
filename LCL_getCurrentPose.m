function configEncoder = getCurrentPose(robot)
    pattern  = digitsPattern;

    % read String message from robot containing config data
    robot.writeline('read');
    PoseString = robot.readline();

    % extract positions
    Pose = extract(PoseString, pattern);

    % convert strings to integers and store values in array
    configEncoder = [str2num(Pose(1)); str2num(Pose(3));...
     str2num(Pose(5)); str2num(Pose(7)); str2num(Pose(9))];
end
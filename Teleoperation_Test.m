
RobMaster.writeline('disable');
% RobMaster.writeline('readstream');
pattern = digitsPattern;
r = rateControl(0.9);
waitforbuttonpress;
close(figure(1))

while true
    RobMaster.writeline('read');
    PosMasterString = RobMaster.readline()
    PosMaster = extract(PosMasterString, pattern);
    SlaveCommand = append('move ',PosMaster(1),' ',...
        PosMaster(3),' ',PosMaster(5),' ',...
        PosMaster(7),' ',PosMaster(9))
    RobSlave.writeline(SlaveCommand);
    RobMaster.writeline('read');
    waitfor(r);
end

function configEncoder = getcurrentPose(robot)
    pattern  = digitsPattern;
    robot.writeline('read');
    PoseString = robot.readline();
    Pose = extract(PoseString, pattern);
    configEncoder = [Pose(1); Pose(2); Pose(5); Pose(7); Pose (9)];
end
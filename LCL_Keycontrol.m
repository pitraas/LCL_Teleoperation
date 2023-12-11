clear keyEntered pattern posMaster posMasterString posMasterNum
clear programmRunning r SendCommand stepSize
pattern = digitsPattern;
r = rateControl(1/20);
%Stepsize encodersteps
stepSize = 100;

% Get initial Position
RobMaster.writeline('read');



posMasterString = RobMaster.readline();
posMaster = extract(posMasterString, pattern);


robot(1).Jointposition = str2num(posMaster(1));
robot(2).Jointposition = str2num(posMaster(3));
robot(3).Jointposition = str2num(posMaster(5));
robot(4).Jointposition = str2num(posMaster(7));
robot(5).Jointposition = str2num(posMaster(9));
% waitforbuttonpress;
% close(figure(1));


programmRunning = 1;
while programmRunning 
    
    keyEntered  = getkey();
    switch(keyEntered)
        case '1'
            robot(1).Jointposition = robot(1).Jointposition + stepSize;
        case 'q'
            robot(1).Jointposition = robot(1).Jointposition - stepSize;
        case '2'
            robot(2).Jointposition = robot(2).Jointposition + stepSize;
        case 'w'
            robot(2).Jointposition = robot(2).Jointposition - stepSize;
        case '3'
            robot(3).Jointposition = robot(3).Jointposition + stepSize;
        case 'e'
            robot(3).Jointposition = robot(3).Jointposition - stepSize;
        case '4'
            robot(4).Jointposition = robot(4).Jointposition + stepSize;
        case 'r'
            robot(4).Jointposition = robot(4).Jointposition - stepSize;
        case '5'
            robot(5).Jointposition = robot(5).Jointposition + stepSize;
        case 't'
            robot(5).Jointposition = robot(5).Jointposition - stepSize;
        case 'c'
            programmRunning = 0;
    end

    % Send new Position to LCL
    SendCommand = append('move ',num2str(robot(1).Jointposition),' ',...
        num2str(robot(2).Jointposition),' ',num2str(robot(3).Jointposition),' ',...
        num2str(robot(4).Jointposition),' ',num2str(robot(5).Jointposition), ' D=0');
    disp(SendCommand);
    RobMaster.writeline(SendCommand);
    % waitfor(r);
end
clear keyEntered pattern posMaster posMasterString posMasterNum
clear programmRunning r SendCommand stepSize
pattern = digitsPattern;
r = rateControl(1/20);
stepSize = 100;

% Get iitial Position
RobMaster.writeline('read');

posMasterString = RobMaster.readline();
posMaster = extract(posMasterString, pattern);
posMasterNum(1) = str2num(posMaster(1));
posMasterNum(2) = str2num(posMaster(3));
posMasterNum(3) = str2num(posMaster(5));
posMasterNum(4) = str2num(posMaster(7));
posMasterNum(5) = str2num(posMaster(9));
% waitforbuttonpress;
% close(figure(1));

programmRunning = 1;

while programmRunning 
    
    keyEntered  = getkey();
    switch(keyEntered)
        case '1'
            posMasterNum(1) = posMasterNum(1) + stepSize;
        case 'q'
            posMasterNum(1) = posMasterNum(1) - stepSize;
        case '2'
            posMasterNum(2) = posMasterNum(2) + stepSize;
        case 'w'
            posMasterNum(2) = posMasterNum(2) - stepSize;
        case '3'
            posMasterNum(3) = posMasterNum(3) + stepSize;
        case 'e'
            posMasterNum(3) = posMasterNum(3) - stepSize;
        case '4'
            posMasterNum(4) = posMasterNum(4) + stepSize;
        case 'r'
            posMasterNum(4) = posMasterNum(4) - stepSize;
        case '5'
            posMasterNum(5) = posMasterNum(5) + stepSize;
        case 't'
            posMasterNum(5) = posMasterNum(5) - stepSize;
        case 'c'
            programmRunning = 0;
    end
  
    SendCommand = append('move ',num2str(posMasterNum(1)),' ',...
        num2str(posMasterNum(2)),' ',num2str(posMasterNum(3)),' ',...
        num2str(posMasterNum(4)),' ',num2str(posMasterNum(5)), ' D=0');
    disp(SendCommand);
    RobMaster.writeline(SendCommand);
    % waitfor(r);
end
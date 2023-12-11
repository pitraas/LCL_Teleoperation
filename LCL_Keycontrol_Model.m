


r = rateControl(10);
%Stepsize in rad
stepSize = (pi/180)*5;

% Move to initial Position 
% RobMaster.writeline('move 2048 2048 2048 2048 2048 T=2000 D=0');

InitialPosRadian = homeConfiguration(LCL_Tree);
for i = 1:6
    InitialPosRadian(i).JointPosition = pi;
end

newPosRadian = InitialPosRadian;
programmRunning = 1;
while programmRunning 
    
    keyEntered  = getkey();
    switch(keyEntered)
        case '1'
            newPosRadian(1).JointPosition = newPosRadian(1).JointPosition + stepSize;
        case 'q'
            newPosRadian(1).JointPosition = newPosRadian(1).JointPosition - stepSize;
        case '2'
            newPosRadian(2).JointPosition = newPosRadian(2).JointPosition + stepSize;
        case 'w'
            newPosRadian(2).JointPosition = newPosRadian(2).JointPosition - stepSize;
        case '3'
            newPosRadian(3).JointPosition = newPosRadian(3).JointPosition + stepSize;
        case 'e'
            newPosRadian(3).JointPosition = newPosRadian(3).JointPosition - stepSize;
        case '4'
            newPosRadian(4).JointPosition = newPosRadian(4).JointPosition + stepSize;
        case 'r'
            newPosRadian(4).JointPosition = newPosRadian(4).JointPosition - stepSize;
        case '5'
            newPosRadian(5).JointPosition = newPosRadian(5).JointPosition + stepSize;
        case 't'
            newPosRadian(5).JointPosition = newPosRadian(5).JointPosition - stepSize;
        case 'c'
            programmRunning = 0;
    end

    % Show new Position of Model in figure
    show(LCL_Tree,newPosRadian)

    newPosEncoder = LCL_convertRadian2Encoder(newPosRadian);

   



    % % % Send new Position to LCL
    % % SendCommand = append('move ',num2str(LCL(1).JointPosition),' ',...
    % %     num2str(LCL(2).JointPosition),' ',num2str(LCL(3).JointPosition),' ',...
    % %     num2str(LCL(4).JointPosition),' ',num2str(LCL(5).JointPosition), ' D=0');
    % % disp(SendCommand);
    % % RobMaster.writeline(SendCommand);
    % % % waitfor(r);
end


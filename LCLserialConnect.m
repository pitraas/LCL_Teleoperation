function [ ardu ] = LCLserialConnect( com_port )
% LCLserialConnect Initializes a serial connection with LCL robot.
% 1) Power up LCL robot
% 2) Connect LCL robot via USB with your computer
% 3) Check COM port with serialportlist function
% 4) Run this function with corresponding com port
% Read data with readline (or read) command. Write
% data with writeline command. This function additionally streams
% all serial data received from LCL robot to Command Window.
%
% Available LCL commands (Ergosurg):
% help or ? prints this help
% getservopos: start or stop reading out servo positions.
% Optionally with the amount of return values.
% EXAMPLE: tgetservopos // tgetservopos 1 //
% tgetservopos 123
% getmemsinfo: start or stop reading out mems-sensor. DiffAngle is
% the angle change since the start of the last motion
% playback. Optionally with the amount of return
% values.
% EXAMPLE: tgetmemsinfo // tgetmemsinfo 1 //
% tgetmemsinfo 123
% move: move to servo positions -30700 - +30700. Optional
% travel time T [ms] if possible. Restricted by the
% limits.
% EXAMPLE: move 2118 1816 47 -20000 T=1000
% enable/disable: enable/disable Motor torque.
% record/stop: move robot by hand and record movement. Type "stop"
% to finish recording.
% play/stop: robot does previously recorded movement once. Type
% "stop" or press any button at robot to abort.
% playlooped/stop: robot does previously recorded movement repeatedly.
% Type "stop" or press any button at robot to abort.
% updateinterval: displays the update interval. An additional value
% [10-100] changes the update interval [default: 20ms]
% CHANGE CAREFULLY: Movements can become very fast.
% EXAMPLE: updateinterval // displays current value
% EXAMPLE: updateinterval 30 // changes current value
% to 30ms
% printmemtable: shows all entries of the memory table of the servos.
% If a value is specified, only the entry of the
% corresponding address is displayed.
% EXAMPLE: printmemtable // prints complete memory-
% table
% EXAMPLE: printmemtable 28 // prints memory-table of
% address 28
% setmemtable: change an entry of the memory-table for one
% (explicte servo-number) or all (use -1) servos with
% a given value. To find the address and additional
% information use the 'printmemtable'-command or the
% servo-datasheet. The value is NOT stored permanently
% in the EEPROM and is lost after power failure or
% switching off the servo. Use the command
% 'writememtable' instead.
% EXAMPLE: setmemtable 2 28 400 // sets the
% protection-current entry (28) for servo 2 to 2580mA
% (400 * 6.25mA)
% writememtable: same as 'setmemtable' but it stores the value
% permanently to the EEPROM. So it is protected
% against
% power failure or power interruption of the servo.
% EXAMPLE: writememtable -1 21 69 // change
% permanently the P scale factor of the PID controller
% to 69 for all servos
%
% == INPUTS =============================================================
% com_port COM port, e.g. 'COM3' (Windows) or '/dev/cu.usbmodem2101'
% (Mac)
%
% == OUTPUTS ============================================================
% ardu serial port object
%
% EXAMPLE:
% serialportlist
% ardu = LCLserialConnect('COM3') % Windows
% ardu = LCLserialConnect('/dev/cu.usbmodem2101') % Mac OS
% pause(8);
% writeline(ardu,'getservopos');

% baudrate
br = 500000;

% serial port object
ardu = serialport(com_port,br,'DataBits',8,'Parity','none','StopBits',1);

% set terminator, depending on OS system
if ismac()
    configureTerminator(ardu,"CR/LF","LF");
elseif ispc()
    configureTerminator(ardu,"CR/LF");
else
    error('function not tested for your OS yet');
end
% remove old data
flush(ardu);

% set callback function
configureCallback(ardu,"terminator",@readSerialData)

% callback function for reading: print to Command Window if anything is
% received
function readSerialData(src,~)
    %convert to char array, append \n
    txt = [convertStringsToChars(readline(src)) '\n'];
    % print if any text was received
    if ~strcmp(txt,'\n')
        fprintf(txt);
    end
end

end
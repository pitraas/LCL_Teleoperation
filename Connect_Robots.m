
com_port_Master = 'COM5';
com_port_Slave = 'COM6';

RobMaster = LCLserialConnect(com_port_Master);
%pause(10);
%RobSlave = LCLserialConnect(com_port_Slave)

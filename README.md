# LCL_Teleoperation

### Connect_Robots: 
connects master and slave LCL robot to MATLAB.

### LCLserialConnect: 
MiMed function to connect Robot to MATLAB. 

### LCL_buildRigidBodyTree: 
builds rigidBody Tree of Camera Robot. Should be updated if robot hardware changes.

### LCL_convertEncoder2Radian: 
converts LCL encoder values to rad. The goal is to match rigidBodytree with real robot.

### LCL_convertRadian2Encoder: 
converts rad to LCL encoder values in a way that both rigidbodytree and LCL have the same configuration.

### LCL_getCurrentPose: 
reads current Pose of robot and stores values in Vector.

### LCL_inverseKinematicsExample: 
first Test of MATLAB inversekinematics functions.

### LCL_Keycontrol: 
control LCL robot joints with Keys.
Joint1: 1+ q-; Joint2: 2+ w-; Joint3: 3+ e-; Joint4: 4+ r-; Joint5 5+ t-

### LCL_Keycontrol_Inversekinematics: 
controls LCL robot with keys in Task space:
Y: a+ y-; X: s+ x-; Z: d+ c-

### Teleoperation_Test: 
First Test of controlling Slave robot with Master robot.

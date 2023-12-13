
% Defining length of LCL Segments
LCL.heightBase      = 0.15;
LCL.heightShoulder  = 0.07;
LCL.lengthUpperarm  = 0.30;
LCL.widthUpperarm   = 0.06;
LCL.lengthUnderarm  = 0.20;
LCL.widthUnderarm   = 0.05;
LCL.lengthAxis5     = 0.06;
LCL.widthAxis5      = 0.065;
LCL.lengthAxis6     = 0.03;
LCL.lengthTool      = 0.1;

% Defining Denavit Hartenberg Parameters for 5 Axis LCL_Camera_Robot

LCL.dhParams = [0                   0       LCL.heightBase      0;
                0                   pi/2    LCL.heightShoulder  0;
                LCL.lengthUpperarm  pi      -LCL.widthUpperarm  0;
                LCL.lengthUnderarm  0       LCL.widthUnderarm   0;
                LCL.lengthAxis5     -pi/2   -LCL.widthAxis5     0;
                0                   0       LCL.lengthTool      0];
                % 0                   pi/2    LCL.lengthAxis6     pi;
                % 0                   0       LCL.lengthTool      0];

% Creating rigid body tree (model of LCL Robot)
LCL_Tree = rigidBodyTree;

% Defining Bodies and Joints
LCL.body1 = rigidBody('baselcl');
LCL.jnt1 = rigidBodyJoint('jnt1','fixed');
LCL.body2 = rigidBody('shoulder');
LCL.jnt2 = rigidBodyJoint('jnt2','revolute');
LCL.jnt2.PositionLimits = [deg2rad(-180) deg2rad(180)];
LCL.body3 = rigidBody('upperarm');
LCL.jnt3 = rigidBodyJoint('jnt3','revolute');
LCL.jnt3.PositionLimits = [deg2rad(70) deg2rad(190)];
LCL.body4 = rigidBody('underarm');
LCL.jnt4 = rigidBodyJoint('jnt4','revolute');
LCL.jnt4.PositionLimits = [deg2rad(-160) deg2rad(160)];
LCL.body5 = rigidBody('Axis_5_Camera');
LCL.jnt5 = rigidBodyJoint('jnt5','revolute');
LCL.jnt5.PositionLimits = [deg2rad(-90) deg2rad(90)];
LCL.body6 = rigidBody('body6');
LCL.jnt6 = rigidBodyJoint('jnt6','revolute');
LCL.jnt6.PositionLimits = [deg2rad(-90) deg2rad(90)];
% LCL.body7 = rigidBody('tool');
% LCL.jnt7 = rigidBodyJoint('jnt7','revolute');

% set new homeConfiguration

LCL.jnt3.HomePosition = pi/2;
LCL.jnt4.HomePosition = 0;
LCL.jnt5.HomePosition = 0;
%LCL.jnt6.HomePosition = pi;

% % Add Viuals to Bodies
% % addVisual(body1,'box',[0.10 0.15 0.12])

% Specify body to body transformations using DH-parameters
% (theta is ignored because the angle is a DOF (for revolute joints))
setFixedTransform(LCL.jnt1,LCL.dhParams(1,:),'dh');
setFixedTransform(LCL.jnt2,LCL.dhParams(2,:),'dh');
setFixedTransform(LCL.jnt3,LCL.dhParams(3,:),'dh');
setFixedTransform(LCL.jnt4,LCL.dhParams(4,:),'dh');
setFixedTransform(LCL.jnt5,LCL.dhParams(5,:),'dh');
setFixedTransform(LCL.jnt6,LCL.dhParams(6,:),'dh');

% Adding the joints to the bodies
LCL.body1.Joint = LCL.jnt1;
LCL.body2.Joint = LCL.jnt2;
LCL.body3.Joint = LCL.jnt3;
LCL.body4.Joint = LCL.jnt4;
LCL.body5.Joint = LCL.jnt5;
LCL.body6.Joint = LCL.jnt6;
%LCL.body7.Joint = LCL.jnt7;

% attach the bodies to the rigid body tree LCL
addBody(LCL_Tree,LCL.body1,'base')
addBody(LCL_Tree,LCL.body2,'baselcl')
addBody(LCL_Tree,LCL.body3,'shoulder')
addBody(LCL_Tree,LCL.body4,'upperarm')
addBody(LCL_Tree,LCL.body5,'underarm')
addBody(LCL_Tree,LCL.body6,'Axis_5_Camera')
%addBody(LCL_Tree,LCL.body7,'body6')

show(LCL_Tree);
% interactiveLCL = interactiveRigidBodyTree(LCL,homeconfiguration);


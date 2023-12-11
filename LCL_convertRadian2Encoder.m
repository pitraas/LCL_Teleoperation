function [PosEncoder] = LCL_convertRadian2Encoder(PosRadian)
    nbJoints = 5;
    PosEncoder = PosRadian;
    for i = 1:nbJoints
        PosEncoder(i).JointPosition = (PosRadian(i).JointPosition / pi) * 4096;
    end
end
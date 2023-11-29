
% Define length of LCL Segments
lengthBase = 0.20;
lengthShoulder = 0.1;
lengthUpperArm = 0.4;
lengthUnderArm = 0.3;
lengthAxis5 = 0.05;

dhparams = [];
function A = A_z(phi)
    % Erstellt eine Drehmatrix.
    % Geht von einer Elementardrehung um die z-Achse aus
    A = [cos(phi) -sin(phi) 0;
        sin(phi) cos(phi) 0;
        0 0 1];
end

function A = A_x(phi)
    % Erstellt eine Drehmatrix.
    % Geht von einer Elementardrehung um die x-Achse aus
    A = [1 0 0;
        0 cos(phi) -sin(phi);
        0 sin(phi) cos(phi)];
end

function A = A_y(phi)
    % Erstellt eine Drehmatrix.
    % Geht von einer Elementardrehung um die y-Achse aus
    A = [cos(phi) 0 sin(phi);
        0 1 0;
        -sin(phi) 0 cos(phi)];
end


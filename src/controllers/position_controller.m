function [F, acc] = position_controller(current_state, desired_state, params, question)

% Input parameters
% 
%   current_state: The current state of the robot with the following fields:
%   current_state.pos = [x; y; z], 
%   current_state.vel = [x_dot; y_dot; z_dot],
%   current_state.rot = [phi; theta; psi], 
%   current_state.omega = [phidot; thetadot; psidot]
%   current_state.rpm = [w1; w2; w3; w4];
%
%   desired_state: The desired states are:
%   desired_state.pos = [x; y; z], 
%   desired_state.vel = [x_dot; y_dot; z_dot],
%   desired_state.rot = [phi; theta; psi], 
%   desired_state.omega = [phidot; thetadot; psidot]
%   desired_state.acc = [xdotdot; ydotdot; zdotdot];
%
%   params: Quadcopter parameters
%
%   question: Question number
%
% Output parameters
%
%   F: u1 or thrust
%
%   acc: will be stored as desired_state.acc = [xdotdot; ydotdot; zdotdot]
%
%************  POSITION CONTROLLER ************************

% Example PD gains
Kp1 = 17;
Kd1 = 6.6;

Kp2 = 17;
Kd2 = 6.6;

Kp3 = 20;
Kd3 = 9;

% Kp1 = 20;
% Kd1 = 7;
% 
% Kp2 = 20;
% Kd2 = 7;
% 
% Kp3 = 22;
% Kd3 = 11;
if question == 51
    Kp1 = 20;
    Kd1 = 8;

    Kp2 = 20;
    Kd2 = 8;

    Kp3 = 18;
    Kd3 = 9;   

elseif question == 52
    Kp1 = 20;
    Kd1 = 8;

    Kp2 = 20;
    Kd2 = 8;

    Kp3 = 10;
    Kd3 = 19;
end 
% TODO: Write code here
Kp = [Kp1; Kp2; Kp3];
Kd = [Kd1; Kd2; Kd3];

% Errors
e_pos = current_state.pos - desired_state.pos;
e_vel = current_state.vel - desired_state.vel;

% Acceleration Error
e_xyz_ddot = - Kp .* e_pos - Kd .* e_vel;

% Required Force
f = params.mass * transpose([0; 0; 1]) * ([0; 0; params.gravity] + e_xyz_ddot + desired_state.acc);

acc = e_xyz_ddot + desired_state.acc;
F = max(0, f);



end

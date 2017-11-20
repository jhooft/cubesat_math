%Given a quaternion q (both scalar and vector part), extract the axis of
%rotation. Return as UNIT vector (x,y,z). The function will accept either a
%column or row quaternion.


function qaxis=quaternion_rot_axis(q)
    vec = [q(2),q(3),q(4)];
    qaxis = vec/norm(vec,2);
    return;
end
%Given a quaternion (scalar plus vector part, row or column) extract the
%angle of rotation. Return angle in radians, and with respect to 'positive'
%rotation in a right-handed coordinate system.

function angle=quaternion_rot_angle(q)
    angle = 2 * acos(q(1));
    if angle>-2*pi && angle<2*pi
        disp('Angle of rotation is:');
    else
        disp('Possible error. Verify angle.');
    end
    
    return;
end
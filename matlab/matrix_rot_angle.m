%Given a matrix A (likely 3x3) extract the angle of rotation about its axis.
%We assume the matrix has already been verified as a rotation sequence.
%The axis of rotation is the associated eigenvector to the unit eigenvalue.
%The angle is presented relative to 'positive rotation' according to
%right-handed coordinate system.
%Return the angle in radians.


function angle = matrix_rot_angle(A)
    angle=acos((trace(A)-1)/2);
    disp('Angle of rotation is:');
    return;
end
%Given a matrix A (likely 3x3) extract the axis of rotation.
%We assume the matrix has already been verified as representing a rotation sequence.
%This allows us to assume the existence of a unit eigenvalue, then extract
%the associated eigenvector.
%Return the axis as a vector [x,y,z]^T

function rot=matrix_rot_axis(A)
    [evecs,evals]=eig(A);
    vec=0;%'eigenvector not yet identified' marker
    for i=1:3
        if evals(i,i)==1
            rot=evecs(:,i);
            vec=vec+1;
        end
    end
    if vec>1
        disp('Possible error. Multiple rotation axes identified.');
    elseif vec==0
        disp('Error. No rotation axis identified.');
    else
        disp('Axis of rotation is:');
    end
    return;
end
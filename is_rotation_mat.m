%Determine if a given matrix is actually a rotation matrix.
%We check that determinant is +1 and matrix is orthogonal
%Assume we are given a square matrix A (inputs will most likely be 3x3)
%Returns 1 if rotation matrix, 0 if not

function rotation = is_rotation_mat(A)
  rotation = 1;
  if det(A) == 1
    for i=1:3
      sum1 = 0;  
      sum2 = 0;
      for j=1:3
        sum1 = sum1 + (A(i,j))^2;  
        sum2 = sum2 + (A(j,i))^2;
      end
      if ((sqrt(sum1)~= 1)||(sqrt(sum2)~= 1)) %criterium unit vector rows and columns broken
        rotation = 0;
      end
    end %for
    
    for i=1:3   
      for j=2:3
        if (i~=j)&&(rotation==1)
          if (dot(A(i,:),A(j,:))~=0)&&(dot(A(:,i),A(:,j))~=0)%criterium all rows and columns orthogonal broken
            rotation = 0;
          end
        end 
      end 
    end
  else%if det(A) not 1
    rotation = 0;
  end
  if rotation ==1
    disp('Verified rotation matrix');
  else
    disp('Not a rotation matrix');
  end
  return;  
end

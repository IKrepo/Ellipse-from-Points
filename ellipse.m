%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               ellipse.m                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Ioannis Koureas ID:29830206 ik4n17@soton.ac.uk              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          !!! MAIN PROGRAM !!!                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% The purpose of this function is to compute the long-axis and the        %
% short-axis of an ellipse given a number of points that made up the      %
% ellipse.                                                                %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [short_axis, long_axis] = ellipse(x, y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% INPUTS:                                                                 %
%     1) x      -> experimental data for the x-coordinates (for the       %
%                  elliptical path).                                      %
%     2) y      -> experimental data for the y-coordinates (for the       %
%                  elliptical path).                                      %
%                                                                         %
% OUTPUTS:                                                                %
%     1) short_axis -> short axis of the ellipse.                         %
%     2) long_axis  -> long axis of the ellipse.                          %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The main idea is to solve the general equation for a set of points (x, y)
% that satisfy Ax^2 + Bxy +Cy^2 + Dx + Ey + F = 0

% We divide the whole equation by F for simplicity.

% At this step the function uses all values of x and y and creates an array
% for the values that correspond to x^2, xy, y^2, x and y 
X = [x.^2, x.*y, y.^2, x, y ];

% Since the points represent the actual x and y coordinates of an ellipse
% the process is quite straightforward. In case the points were an
% approximation of an ellipse then the procedure would be much more
% complicated. As a result, since we have an equation with 5 (since we
% divide by F) unkowns we need 5 equations. We can take any 5 equations
% from the array in random since all the points represent an exact slution
% for the elluipse.
X = X(1:20:100, :);

% Now we have to solve a system of the form Ax = B to find A. In this case
% B is an array of -ones (-F).
a = X\-ones(5,1);
[a,b,c,d,e] = deal(a(1), a(2), a(3), a(4), a(5));

%The matrices Mo and M are defined the same way like in the notes of prof.
% Charles F. Van Loan https://www.cs.cornell.edu/cv/OtherPdf/Ellipse.pdf
% slide 17.
Mo = [1 d/2 e/2; d/2 a b/2; e/2 b/2 c];
M = [a b/2; b/2 c];

D = eig(M);

short_axis = 2*sqrt(-det(Mo)/(det(M)*D(1))); % short_axis = 2b

long_axis  = 2*sqrt(-det(Mo)/(det(M)*D(2))); % long_axis = 2a

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   END                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
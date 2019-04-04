%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         ellipse_from_points.m                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% The purpose of this function is to compute the long-axis and the        %
% short-axis of an ellipse given a number of points that make up the      %
% ellipse.                                                                %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read the txt file that contains the x and y coordinates of the ellipse.

%Change the directory accordingly.
ellipse_data = 'C:\Users\Desktop\';

test_file = 'Ellipse.txt';
test_name = [ellipse_data test_file];

% open the txt-format data file, read-only:
my_fid    = fopen(test_name, 'r');

% the first six lines are headers; only read data below these files.
rawdata   = textscan(my_fid, '%f%f', 'HeaderLines', 6);
x    = rawdata{1};
y    = rawdata{2};

fclose(my_fid);      % all data read; close file now.
clear rawdata my_fid % these variables are not needed anymore.

figure()
plot(x, y, '--')

[short_axis, long_axis] = ellipse(x, y)


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

% The given points represent the x and y coordinates of an ellipse.
% Since we have an equation with 5 unkowns we need 5 equations.
% We can take any 5 points from the array in random since all the
% points represent an exact solution of the ellipse.
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

function [  ] = test(  )
%TEST Summary of this function goes here
%   Detailed explanation goes here

WIN_SIZE = 8;        %interarrival  distance by default

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
tr_ex = str2double( fgets( fid ) );
tr_in = str2double( fgets( fid ) );
fclose( fid );

if size > 0
    WIN_SIZE = size;
end

fprintf('sizee is: %d', size);
fprintf('tr_ex: %d', tr_ex);
fprintf('tr_in: %d', tr_in);

end


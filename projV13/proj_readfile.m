function [ ] = proj_readfile(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%block_size = 100000;
%format = '%s';

% change values here to make changes in this file
path_data_file = 'C:\Users\sourabh\Desktop\proj_data\modEIData.txt' ;
% because it is not input by user we are reading from file
user = 0;

fid = fopen( path_data_file );

%while ~feof( fid )
%    segarray = textscan( fid, format, block_size );    
%end

tline = fgets( fid );
while ischar( tline )
%while ~feof( fid )
   fprintf('\nprocessing string: \n'); 
   disp( tline );
   proj_process_str( tline, user );   %proj_process_str called with each line read from input file
   tline = fgets( fid );
end

fclose( fid );

end


function [  ] = bayes_read(  )
%BAYES_READ Summary of this function goes here
%   Detailed explanation goes here

fid = fopen( 'C:\Users\sourabh\Desktop\proj_data\bayesInput.txt' );

train = fgets( fid );
test = fgets( fid );
disp(train);
disp('test is:');
disp( test );

bayes_process_strings( train, test );

fclose( fid );


end


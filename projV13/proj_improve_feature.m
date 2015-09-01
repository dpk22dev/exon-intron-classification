function [ ] = proj_improve_feature( norm_train_data, norm_ex_tst_data, norm_in_tst_data, class_size )
%PROJ_IMPROVE_FEATURE Summary of this function goes here
%   Detailed explanation goes here
%disp( norm_train_data );
%disp( norm_in_tst_data );
%disp( norm_ex_tst_data );
%disp( class_size(1) );

WIN_SIZE = 8;        %interarrival  distance by default

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
fclose( fid );

if size > 0
    WIN_SIZE = size;
end

accuracy = 0;
index_bound = 4*WIN_SIZE;

for i=1:4*WIN_SIZE
    [ mod_norm_train_data, mod_norm_ex_tst_data, mod_norm_in_tst_data, mod_accuracy ] = proj_improve_accuracy( norm_train_data, norm_ex_tst_data, norm_in_tst_data, class_size, index_bound );
    if( mod_accuracy > accuracy )
        accuracy = mod_accuracy;
        norm_train_data = mod_norm_train_data;
        norm_in_tst_data = mod_norm_in_tst_data;
        norm_ex_tst_data = mod_norm_ex_tst_data;
        index_bound =  index_bound - 1;
    else
        fprintf('\nmaximum accuracy achieved: %f with %d features\n', accuracy, 4*WIN_SIZE - i );
        break;
    end
end

end


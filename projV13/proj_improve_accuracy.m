function [ mod_norm_train_data, mod_norm_ex_tst_data, mod_norm_in_tst_data, mod_accuracy ] = proj_improve_accuracy( norm_train_data, norm_ex_tst_data, norm_in_tst_data, class_size, INDEX_BOUND )
%PROJ_IMPROVE_ACCURACY Summary of this function goes here
%   Detailed explanation goes here

WIN_SIZE = 8;        %interarrival  distance by default
TRAINEXR = 150;     %number of exons used for training 
TRAININTR = 160;    %number of introns used for training

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
tex = str2double( fgets(fid) );
tin = str2double( fgets(fid));
fclose( fid );

if size > 0
    WIN_SIZE = size;
end

if tex > 0
    TRAINEXR = tex;
end

if tin > 0
    TRAININTR = tin;
end

%finding number of rows in exon_A.txt i.e. number of exons in input data
fid = fopen('exon_A.txt','rt');
exon_A_lines = 0;
while (fgets(fid) ~= -1),
  exon_A_lines = exon_A_lines+1;
end
fclose(fid);

fprintf('\nnumber  of exons are : %d\n', exon_A_lines );

exon_number_rows = exon_A_lines;
exon_train_number_rows = TRAINEXR; % nearly 70 per of total data
exon_test_number_rows = exon_number_rows - exon_train_number_rows;   % nearly 30 per of total data 

%%%%%%%%%%%
%finding number of introns in data

fid = fopen('intron_A.txt','rt');
intron_A_lines = 0;
while (fgets(fid) ~= -1),
  intron_A_lines = intron_A_lines+1;
end
fclose(fid);

fprintf('\nnumber  of introns are : %d\n', intron_A_lines );

intron_number_rows = intron_A_lines;
intron_train_number_rows = TRAININTR; % nearly 70 per of total data
intron_test_number_rows = intron_number_rows - intron_train_number_rows;   % nearly 30 per of total data 

%%%
accuracy = 0;
index = 0;
%modify here if required 
for i=1:INDEX_BOUND
    disp(i);
    mod_norm_train_data_tmp = [ norm_train_data(:,1:i) norm_train_data(:,i+2:INDEX_BOUND) ];
    mod_norm_ex_tst_data_tmp = [ norm_ex_tst_data(:,1:i) norm_ex_tst_data(:,i+2:INDEX_BOUND) ];
    mod_norm_in_tst_data_tmp = [ norm_in_tst_data(:,1:i) norm_in_tst_data(:,i+2:INDEX_BOUND) ];    
    
    %%%%%%%%%%%%%%% find exon_test_number_rows 
    %find accuracy  by calling proj_nn_classifier 
    ex_c=0;
    for j = 1:(exon_test_number_rows) %for testing data = total - train data for exons
        class_decision = proj_nn_classifier( mod_norm_ex_tst_data_tmp(j,:), mod_norm_train_data_tmp, [exon_train_number_rows intron_train_number_rows]);
        if( class_decision == 0 )
            ex_c = ex_c + 1;
        end
    end

    %fprintf('Total #exons(test data) %d\n', exon_test_number_rows );
    %disp('exon caught in exon test data: ');
    %ex_c
    %fprintf('#exons caught by classifier %d\n', ex_c );

    % %%%%%%%%%%%%%%% changing tr_data to normalise tr_datan %%%%%%%%%%%%

    in_c=0;
    for j = 1:(intron_test_number_rows) %for testing data = total - train data for introns
        class_decision = proj_nn_classifier( mod_norm_in_tst_data_tmp(j,:), mod_norm_train_data_tmp, [exon_train_number_rows intron_train_number_rows]); 
        if( class_decision == 1 )
            in_c = in_c + 1;
        end
    end

    %fprintf('Total #introns(test data) %d\n', intron_test_number_rows );
    %disp('intron caught in intron test data: ');
    %in_c
    %fprintf('#introns caught by classifier %d\n', in_c );

    mod_accuracy_tmp = ( ex_c +  in_c )/( exon_test_number_rows + intron_test_number_rows );
    fprintf('\naccuracy is: %f\n', mod_accuracy_tmp);
    %disp(mod_accuracy_tmp);
    %%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%% work if accuracy is higher
    if( mod_accuracy_tmp > accuracy )
        accuracy = mod_accuracy_tmp;
        index = i;
    end
end

    fprintf('\nfinally accuracy acheived: %f with index: %d\n', accuracy, index );
    %%%%%%%%%%%%%%%%%%%%%% code here for return value index+1 col is
    %%%%%%%%%%%%%%%%%%%%%% removed
    mod_norm_train_data = [ norm_train_data(:,1:index) norm_train_data(:,index+2:INDEX_BOUND) ];
    mod_norm_ex_tst_data = [ norm_ex_tst_data(:,1:index) norm_ex_tst_data(:,index+2:INDEX_BOUND) ];
    mod_norm_in_tst_data = [ norm_in_tst_data(:,1:index) norm_in_tst_data(:,index+2:INDEX_BOUND) ];
    mod_accuracy = accuracy;    
    %%%%%%%%%%%%%%%%%%%%%%
end


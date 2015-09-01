function [  ] = proj_test_classifier( user )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%  %%%%%%%%%%%%%% CAUTION %%%%%%%%%%%%%%%%
%correct the size of each file exon(224x8) intron(259x8)
% 
% load exon_A.txt
% load exon_T.txt
% load exon_C.txt
% load exon_G.txt
% load intron_a.txt
% load intron_t.txt
% load intron_c.txt
% load intron_g.txt


% CHANGE THESE VALUES ACCORDINGLY ONLY 
WINSIZE = 8;        %interarrival  distance
TRAINEXR = 150;     %number of exons used for training 
TRAININTR = 160;    %number of introns used for training

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
tex = str2double( fgets(fid) );
tin = str2double( fgets(fid) );
fclose( fid );

if size > 0
    WINSIZE = size;
end

if tex > 0
    TRAINEXR = tex;
end

if tin > 0
    TRAININTR = tin;
end
%disp( WINSIZE );



% ############## CAUTION: in case use other data files change data given below ##################
% read files rather than loading

%finding number of rows in exon_A.txt i.e. number of exons in input data
fid = fopen('exon_A.txt','rt');
exon_A_lines = 0;
while (fgets(fid) ~= -1),
  exon_A_lines = exon_A_lines+1;
end
fclose(fid);

fprintf('\nnumber  of exons are : %d\n', exon_A_lines );


exon_number_rows = exon_A_lines;
exon_row_size = exon_number_rows - 1; % to be used for dlmread function which starts counting from 0 to n-1
exon_col_size = WINSIZE;
exon_train_number_rows = TRAINEXR; % nearly 70 per of total data
exon_test_number_rows = exon_number_rows - exon_train_number_rows;   % nearly 30 per of total data 

%finding number of introns in data
fid = fopen('intron_A.txt','rt');
intron_A_lines = 0;
while (fgets(fid) ~= -1),
  intron_A_lines = intron_A_lines+1;
end
fclose(fid);

fprintf('\nnumber  of introns are : %d\n', intron_A_lines );

intron_number_rows = intron_A_lines;
intron_row_size = intron_number_rows - 1; % to be used for dlmread function which starts counting from 0 to n-1
intron_col_size = WINSIZE;
intron_train_number_rows = TRAININTR; % nearly 70 per of total data
intron_test_number_rows = intron_number_rows - intron_train_number_rows;   % nearly 30 per of total data 

% ############################# change above data in case other input file is used ##############

col_limit = exon_col_size - 1;

exon_A = dlmread('exon_A.txt',' ', [0 0 exon_row_size  col_limit] );
%size( exon_A )
exon_C = dlmread('exon_C.txt',' ', [0 0 exon_row_size  col_limit] );
%size( exon_C )
exon_G = dlmread('exon_G.txt',' ', [0 0 exon_row_size  col_limit] );
%size( exon_G )
exon_T = dlmread('exon_T.txt',' ', [0 0 exon_row_size  col_limit] );
%size( exon_T )
intron_a = dlmread('intron_a.txt',' ', [0 0 intron_row_size  col_limit] );
%size( intron_a )
intron_c = dlmread('intron_c.txt',' ', [0 0 intron_row_size  col_limit] );
%size( intron_c )
intron_g = dlmread('intron_g.txt',' ', [0 0 intron_row_size  col_limit] );
%size( intron_g )
intron_t = dlmread('intron_t.txt',' ', [0 0 intron_row_size  col_limit] );
%size( intron_t )

% ############## for exons ###############

exd=[];
for i=1:exon_number_rows
    % combine 1x8 vectors for  each base to form 1x32 vector named exdata
    exdata = [exon_A(i,:) exon_C(i,:) exon_G(i,:) exon_T(i,:)]; 
    % append exdata to exd
    exd=[exd;exdata]; 
end 
%disp('exd is: ');
%exd

%verify the size of exd vector 
%size(exd)

%############### for intron ###############
ind=[];
for i=1:intron_number_rows
    % combine 1x8 vectors for  each base to form 1x32 vector named indata
    indata = [intron_a(i,:) intron_c(i,:) intron_g(i,:) intron_t(i,:)];
    % append exdata to ind
    ind=[ind;indata];
end

%disp('ind is');
%ind
%verify the size of ind vector 
%size(ind); 

% %%%%%%%%%%%%%%%%%% check for error after here %%%%%%%%%%%%%%%%%%%%%%%%%%%
% error found : Never forget to normalise data -- corrected OK now

%training data for exon
ex_tr_data = exd( 1:exon_train_number_rows, : );
%training data for intron
in_tr_data = ind( 1:intron_train_number_rows , : );
%net training data is
tr_data = [ex_tr_data;in_tr_data];

if( user == 0 || user == 2 )
    %test data for exon
    ex_tst_data = exd( exon_train_number_rows+1:exon_number_rows, : );
    %test data for intron
    in_tst_data = ind(intron_train_number_rows+1:intron_number_rows, : );
else
    %user defined data    
    %find number of rows and col in user defined data
    
    fid = fopen('uexon_A.txt','rt');
    uexon_A_lines = 0;
    while (fgets(fid) ~= -1),
        uexon_A_lines = uexon_A_lines+1;
    end
    fclose(fid);

    exon_test_number_rows = uexon_A_lines;
    fprintf('\nnumber  of user given exons are : %d\n', uexon_A_lines );
    
    fid = fopen('uintron_A.txt','rt');
    uintron_A_lines = 0;
    while (fgets(fid) ~= -1),
        uintron_A_lines = uintron_A_lines+1;
    end
    fclose(fid);

    intron_test_number_rows = uintron_A_lines;
    fprintf('\nnumber  of user given introns are : %d\n', uintron_A_lines );
    
%    exon_test_number_rows = exon_test_number_rows - 1;
    uexon_row_size = exon_test_number_rows - 1;
%    intron_test_number_rows = intron_test_number_rows - 1;
    uintron_row_size = intron_test_number_rows - 1;
    
    uexon_A = dlmread('uexon_A.txt',' ', [0 0 uexon_row_size  col_limit] );
    %size( uexon_A )
    uexon_C = dlmread('uexon_C.txt',' ', [0 0 uexon_row_size  col_limit] );
    %size( uexon_C )
    uexon_G = dlmread('uexon_G.txt',' ', [0 0 uexon_row_size  col_limit] );
    %size( uexon_G )
    uexon_T = dlmread('uexon_T.txt',' ', [0 0 uexon_row_size  col_limit] );
    %size( uexon_T )
    uintron_a = dlmread('uintron_a.txt',' ', [0 0 uintron_row_size  col_limit] );
    %size( uintron_a )
    uintron_c = dlmread('uintron_c.txt',' ', [0 0 uintron_row_size  col_limit] );
    %size( uintron_c )
    uintron_g = dlmread('uintron_g.txt',' ', [0 0 uintron_row_size  col_limit] );
    %size( uintron_g )
    uintron_t = dlmread('uintron_t.txt',' ', [0 0 uintron_row_size  col_limit] );
    %size( uintron_t )
    
    %creating exon test data input by user
    uexd=[];
    for i=1:exon_test_number_rows
        % combine 1x8 vectors for  each base to form 1x32 vector named exdata
        uexdata = [uexon_A(i,:) uexon_C(i,:) uexon_G(i,:) uexon_T(i,:)]; 
        % append exdata to exd
        uexd=[uexd;uexdata]; 
    end
    
    %creating intron test data input by user
    uind=[];
    for i=1:intron_test_number_rows
        % combine 1x8 vectors for  each base to form 1x32 vector named indata
        uindata = [uintron_a(i,:) uintron_c(i,:) uintron_g(i,:) uintron_t(i,:)];
        % append exdata to ind
        uind=[uind;uindata];
    end
    
    %test data for exon
    ex_tst_data = uexd( 1:exon_test_number_rows, : );
    %test data for intron
    in_tst_data = uind( 1:intron_test_number_rows, : );
    
end

%unnormalised classifier we will not use it
%class_decision = nn_classifier( ex_tst_data(1,:), tr_data, [150 160])
%class_decision = nn_classifier( in_tst_data(1,:), tr_data, [150 160])

%normalise the training data
for i = 1:(exon_train_number_rows+intron_train_number_rows) %total train data for exon+intron 
    tr_datan(i,:) = tr_data(i,:)/max(tr_data(i,:));         %normalisisng train data
end
%normalise the exon test data
for i = 1:(exon_test_number_rows) %for testing data = total - train data for exons
    ex_tst_datan(i,:) = ex_tst_data(i,:)/max(ex_tst_data(i,:));
end
%normalise the intron test data
for i = 1:(intron_test_number_rows) %for testing data = total - train data for introns
    in_tst_datan(i,:) = in_tst_data(i,:)/max(in_tst_data(i,:));
end

% %%%%%%%%%  changing tr_data to normalised tr_datan %%%%%%%%%%%%%%%%
if( user == 2 ) %pass data to proj_improve_feature function
    proj_improve_feature( tr_datan, ex_tst_datan, in_tst_datan,[ exon_train_number_rows intron_train_number_rows ] )
else    
ex_c=0;
for i = 1:(exon_test_number_rows) %for testing data = total - train data for exons
    class_decision = proj_nn_classifier( ex_tst_datan(i,:), tr_datan, [exon_train_number_rows intron_train_number_rows]);
    if( class_decision == 0 )
        ex_c = ex_c + 1;
    end
end

fprintf('Total #exons(test data) %d\n', exon_test_number_rows );
%disp('exon caught in exon test data: ');
%ex_c
fprintf('#exons caught by classifier %d\n', ex_c );

% %%%%%%%%%%%%%%% changing tr_data to normalise tr_datan %%%%%%%%%%%%

in_c=0;
for i = 1:(intron_test_number_rows) %for testing data = total - train data for introns
    class_decision = proj_nn_classifier( in_tst_datan(i,:), tr_datan, [exon_train_number_rows intron_train_number_rows]); 
    if( class_decision == 1 )
        in_c = in_c + 1;
    end
end

fprintf('Total #introns(test data) %d\n', intron_test_number_rows );
%disp('intron caught in intron test data: ');
%in_c
fprintf('#introns caught by classifier %d\n', in_c );

accuracy = ( ex_c +  in_c )/( exon_test_number_rows + intron_test_number_rows );
fprintf('accuracy is: ');
disp(accuracy);

end
end


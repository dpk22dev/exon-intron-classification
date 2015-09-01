function [ ] = bayes_process_strings( train, test )
%BAYES_PROCESS_STRINGS Summary of this function goes here
%   Detailed explanation goes here
WIN_SIZE = 8;

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
fclose( fid );

if size > 0
    WIN_SIZE = size;
end
%disp( WIN_SIZE );

TRAIN_SIZE = length( train );
WIN_SIZE_MID = floor( WIN_SIZE / 2 );
WIN_LEN = WIN_SIZE - 1;

% initialisations
exon_vector = {};
intron_vector ={};
num_exons_caught = 0;
num_introns_caught = 0;
correct = 0;

for i = 1:(TRAIN_SIZE-WIN_SIZE+1)
    if( train(i+ WIN_SIZE_MID ) == 'G' || train(i+WIN_SIZE_MID) == 'A' || train(i+WIN_SIZE_MID) == 'C' || train(i+WIN_SIZE_MID) == 'T' )
        exon_vector{end+1} = upper( train( i:(i+WIN_LEN) ) );
    else
        intron_vector{end+1} = lower( train( i:(i+WIN_LEN) ) );
    end
end
% displaying exon_vector
disp('exon vector is:');
for i = 1:length(exon_vector)
    disp( exon_vector{i} );
end

% displaying intron_vector
disp( 'intron_vector is:' );
for i = 1:length(intron_vector)
    disp( intron_vector{i} );
end

%starting the trainig procedure
exon_array = zeros( 4, WIN_SIZE );      %4 is used for four bases A, C, G, T
intron_array = zeros( 4, WIN_SIZE );    %4 is used for four bases A, C, G, T

g = 1; c = 2; a = 3; t = 4;

for i = 1:length(exon_vector)
    for j = 1:WIN_SIZE 
        switch exon_vector{i}(j)
            case 'G'
                exon_array(g,j) = exon_array(g,j) + 1;
            case 'C'
                exon_array(c,j) = exon_array(c,j) + 1;
            case 'A'
                exon_array(a,j) = exon_array(a,j) + 1;
            case 'T'
                exon_array(t,j) = exon_array(t,j) + 1;
            otherwise
                disp('did not match');
        end
    end
end

for i = 1:length(intron_vector)
    for j = 1:WIN_SIZE 
        switch intron_vector{i}(j)
            case 'g'
                intron_array(g,j) = intron_array(g,j) + 1;
            case 'c'
                intron_array(c,j) = intron_array(c,j) + 1;
            case 'a'
                intron_array(a,j) = intron_array(a,j) + 1;
            case 't'
                intron_array(t,j) = intron_array(t,j) + 1;
            otherwise
                disp('did not match');
        end
    end
end

%converting to probability by dividing by length of vectors

for i = 1:4     %4 is used for four bases A, C, G, T
    for j = 1:WIN_SIZE
        exon_array(i,j) = exon_array(i,j)/length(exon_vector);
        intron_array(i,j) = intron_array(i,j)/length(intron_vector);
    end
end

%displaying intron and exon arrays
disp('displaying exon probs');
for i = 1:4    %4 is used for four bases A, C, G, T
    for j = 1:WIN_SIZE
        fprintf('%f ', exon_array(i,j) );
    end
        fprintf('\n');
end
disp('displaying intron probs');
for i = 1:4    %4 is used for four bases A, C, G, T
    for j = 1:WIN_SIZE
        fprintf( '%f ', intron_array(i,j) );
    end
        fprintf('\n');
end

%%%%%%%%%%%%%%%%%% it may be cause of error check it %%%%%%%%%%%%%%%%
prob_exon = length(exon_vector)/( length(exon_vector)+ length(intron_vector)  );
prob_intron = length(intron_vector)/( length(exon_vector)+ length(intron_vector) );

%testing test data

for i=1:length(test)/WIN_SIZE
    
    temp = lower( test(i:i+WIN_SIZE-1) );
    prob_exon_cond_s = 1;
    prob_intron_cond_s = 1;
    
    for j = 1:WIN_SIZE
        switch temp(j)
            case 'g'
                prob_exon_cond_s = prob_exon_cond_s*exon_array( 1, j );
            case 'c'
                prob_exon_cond_s = prob_exon_cond_s*exon_array( 2, j );
            case 'a'
                prob_exon_cond_s = prob_exon_cond_s*exon_array( 3, j );
            case 't'
                prob_exon_cond_s = prob_exon_cond_s*exon_array( 4, j );
            otherwise
                disp('did not match');
        end    
                
    end
    prob_exon_cond_s = prob_exon_cond_s*prob_exon;
%finding prob for intron    
    for j = 1:WIN_SIZE
        switch temp(j)
            case 'g'
                prob_intron_cond_s = prob_intron_cond_s*intron_array( 1, j );
            case 'c'
                prob_intron_cond_s = prob_intron_cond_s*intron_array( 2, j );
            case 'a'
                prob_intron_cond_s = prob_intron_cond_s*intron_array( 3, j );
            case 't'
                prob_intron_cond_s = prob_intron_cond_s*intron_array( 4, j );
            otherwise
                disp('did not match');
        end    
                
    end
    
    prob_intron_cond_s = prob_intron_cond_s*prob_intron;
    
%decide weather sequence is intron or exon    
%during comparison we have ignored the denominator part because it will
%same for both probs

    tempseq = test(i:i+WIN_LEN);
    
    if( prob_exon_cond_s > prob_intron_cond_s ) %sequence is exon
%        disp('sequence is exon');
        num_exons_caught = num_exons_caught + 1;
        
        if ( proj_test_exon( tempseq ) == 1 )
            correct = correct + 1;
        end
            
    else %sequence  is intron
        %disp('sequence is intron');
        num_introns_caught = num_introns_caught + 1;
        if ( proj_test_exon( tempseq ) == 0 )
            correct = correct + 1;
        end
    end        
    
    i = i+WIN_SIZE;
    
end

%calculate precision
[exon intron] = regexp( test, '[ACGT]*', 'match', 'split' );

%find total number of exons of WIN_SIZE present in test data
num_exon_test = 0;
for i=1:length(exon) 
    num_exon_test = num_exon_test + floor( length( exon{i} )/WIN_SIZE );
end
%find total number of introns of WIN_SIZE present in test data
num_intron_test = 0;
for i=1:length( intron ) 
    num_intron_test = num_intron_test + floor( length( intron{i} )/WIN_SIZE );
end

fprintf('\nexons: %d introns: %d total: %d\n', num_exons_caught, num_introns_caught, num_exons_caught+num_introns_caught );
fprintf('\nexon length: %d intron length: %d\n', length(exon), length(intron) );
fprintf('\nnum_exons: %d num_introns: %d\n', num_exon_test, num_intron_test );

accuracy = ( correct )/( num_exon_test + num_intron_test );
fprintf('accuracy for bayesian classification is: %f', accuracy );

end
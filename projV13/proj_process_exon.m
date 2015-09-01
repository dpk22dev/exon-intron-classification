function [  ] = proj_process_exon( str, user )
%PROJ_PROCESS_EXON Summary of this function goes here
%   Detailed explanation goes here

%########## CHANGE THE WINSIZE if you want but remember to change in all files ##########
% WINSIZE is actually max inter-arrival window size 
% winsize is by default taken 8 
 WINSIZE = 8;

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
fclose( fid );

if size > 0
    WINSIZE = size;
end
%disp( WINSIZE );
 
%initialise arrival array for each base with zeroes

fprintf('\nprocessing exon\n');
disp( str );

arrival_A = zeros( 1, WINSIZE );
prev_A = 0;

arrival_C = zeros( 1, WINSIZE );
prev_C = 0;

arrival_G = zeros( 1, WINSIZE );
prev_G = 0;

arrival_T = zeros( 1, WINSIZE );
prev_T = 0;

% consider case when str is of zero length
% otherwise empty string will be processed and will get ignored. it's OK

for i = 1:length( str )
    
switch str(i)    
    case 'A'
        %disp('A');
        temp = i - prev_A;
        if temp > 0 && temp <= WINSIZE
            arrival_A( temp ) = arrival_A( temp ) + 1;                 
        end
        prev_A = i;
        
    case 'C'
        %disp('C');
        temp = i - prev_C;
        if temp > 0 && temp <= WINSIZE
            arrival_C( temp ) = arrival_C( temp ) + 1;                 
        end
        prev_C = i;
        
    case 'G'
        %disp('G');
        temp = i - prev_G;
        if temp > 0 && temp <= WINSIZE
            arrival_G( temp ) = arrival_G( temp ) + 1;                 
        end
        prev_G = i;
        
    case 'T'
        %disp('T');
        temp = i - prev_T;
        if temp > 0 && temp <= WINSIZE
            arrival_T( temp ) = arrival_T( temp ) + 1;                 
        end
        prev_T = i;
      
%    otherwise
%        disp('process_exon: char not matched -- ignore me');
        
end

end

%############# now save arrival_A,C,G,T to file for loading for plot ##############
if( user == 0 )
    dlmwrite( 'exon_A.txt',arrival_A,'delimiter',' ','-append' );
    dlmwrite( 'exon_C.txt',arrival_C,'delimiter',' ','-append' );
    dlmwrite( 'exon_G.txt',arrival_G,'delimiter',' ','-append' );
    dlmwrite( 'exon_T.txt',arrival_T,'delimiter',' ','-append' );
else
    dlmwrite( 'uexon_A.txt',arrival_A,'delimiter',' ','-append' );
    dlmwrite( 'uexon_C.txt',arrival_C,'delimiter',' ','-append' );
    dlmwrite( 'uexon_G.txt',arrival_G,'delimiter',' ','-append' );
    dlmwrite( 'uexon_T.txt',arrival_T,'delimiter',' ','-append' );
end

end


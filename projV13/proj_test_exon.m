function [ exon ] = proj_test_exon( str )
%PROJ_TEST_EXON Summary of this function goes here
%   Detailed explanation goes here
WIN_SIZE = 8;

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
fclose( fid );

if size > 0
    WIN_SIZE = size;
end
%disp( WIN_SIZE );

count = 0;
exon = -1;

for i=1:WIN_SIZE
    switch str(i)
        case 'G' 
            count = count + 1;
        case 'C' 
            count = count + 1;   
        case 'A' 
            count = count + 1;
        case 'T' 
            count = count + 1;
    end
            
end

if( count == WIN_SIZE ) %it is an exon
    exon = 1;
end

count = 0;
for i = 1:WIN_SIZE
    switch str(i)
        case 'g' 
            count = count + 1;
        case 'c' 
            count = count + 1;   
        case 'a' 
            count = count + 1;
        case 't' 
            count = count + 1;
    end
            
end

if( count == WIN_SIZE )    %it is an intron
    exon = 0;
    
%else                      %it is to be ignored 
%    exon = -1;

end


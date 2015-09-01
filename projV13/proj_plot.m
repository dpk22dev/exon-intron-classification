function [  ] = proj_plot(  )
%PROJ_PLOT Summary of this function goes here
%   Detailed explanation goes here

%######## whatever WINSIZE is ############
% if you change WINSIZE, remember it to change in each file 
WINSIZE = 8;

fid = fopen( 'proj_sizes.txt');
size = str2double( fgets( fid ) );
fclose( fid );

if size > 0
    WINSIZE = size;
end
%disp( WINSIZE );

col_limit = WINSIZE-1;

%############ for file exon_A ###############

%counting number of lines in file exon_A
fid = fopen('exon_A.txt','rt');
exon_A_lines = 0;
while (fgets(fid) ~= -1),
  exon_A_lines = exon_A_lines+1;
end
fclose(fid);

disp( exon_A_lines );

row_limit = exon_A_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('exon_A.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('exon_A');

figure;

%############ for file exon_C ###############
%counting number of lines in file exon_C
fid = fopen('exon_C.txt','rt');
exon_C_lines = 0;
while (fgets(fid) ~= -1),
  exon_C_lines = exon_C_lines+1;
end
fclose(fid);

disp( exon_C_lines );

row_limit = exon_C_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('exon_C.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('exon_C');

figure;
%############ for file exon_G ###############
%counting number of lines in file exon_G
fid = fopen('exon_G.txt','rt');
exon_G_lines = 0;
while (fgets(fid) ~= -1),
  exon_G_lines = exon_G_lines+1;
end
fclose(fid);

disp( exon_G_lines );

row_limit = exon_G_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('exon_G.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('exon_G');

figure;
%############ for file exon_T ###############
%counting number of lines in file exon_T
fid = fopen('exon_T.txt','rt');
exon_T_lines = 0;
while (fgets(fid) ~= -1),
  exon_T_lines = exon_T_lines+1;
end
fclose(fid);

disp( exon_T_lines );

row_limit = exon_T_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('exon_T.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('exon_T');

figure;
%############ for file intron_a ###############
%counting number of lines in file intron_a
fid = fopen('intron_a.txt','rt');
intron_a_lines = 0;
while (fgets(fid) ~= -1),
  intron_a_lines = intron_a_lines+1;
end
fclose(fid);

disp( intron_a_lines );

row_limit = intron_a_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('intron_a.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('intron_a');

figure;
%############ for file intron_c ###############
%counting number of lines in file intron_c
fid = fopen('intron_c.txt','rt');
intron_c_lines = 0;
while (fgets(fid) ~= -1),
  intron_c_lines = intron_c_lines+1;
end
fclose(fid);

disp( intron_c_lines );

row_limit = intron_c_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('intron_c.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('intron_c');

figure;
%############ for file intron_g ###############
%counting number of lines in file intron_g
fid = fopen('intron_g.txt','rt');
intron_g_lines = 0;
while (fgets(fid) ~= -1),
  intron_g_lines = intron_g_lines+1;
end
fclose(fid);

disp( intron_g_lines );

row_limit = intron_g_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('intron_g.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('intron_g');

figure;
%############ for file intron_t ###############
%counting number of lines in file intron_t
fid = fopen('intron_t.txt','rt');
intron_t_lines = 0;
while (fgets(fid) ~= -1),
  intron_t_lines = intron_t_lines+1;
end
fclose(fid);

disp( intron_t_lines );

row_limit = intron_t_lines - 1;

for i = 0:row_limit
%    disp(i);
    hold;
    row = dlmread('intron_t.txt',' ', [i 0 i  col_limit] );
%    disp( row );    
    plot( row );
    hold;
end
title('intron_t');

end


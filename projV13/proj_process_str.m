function [ exon, intron  ] = proj_process_str( str, user )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% split exons and introns from gene string
[exon intron] = regexp( str, '[ACGT]*', 'match', 'split' );

%disp('exon');

for k = 1:length( exon )
% disp(k);
% disp(exon{k});
proj_process_exon( exon{k}, user ); %process all exons present in string
end


%disp('intron');
for k = 1:length( intron )
% disp(k);
% disp(intron{k});
proj_process_intron( intron{k}, user ); %process all introns present in string
end

end


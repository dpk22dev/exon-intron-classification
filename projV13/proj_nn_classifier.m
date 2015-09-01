function class_decision = proj_nn_classifier( testdata, alltrainingdata, class_size)
% alltrainingdata is constructed by keeping each data as row-vector of the
% exon and intron training data kept serially within the matrix
% alltrainingdata. Here class_size is a row-vector of values signifying
% data-size of each class
%   Detailed explanation goes here

% use class_size directly because we know that there will be only two
% classes
% class_no = length(class_size);
% for i = 1:class_no
%     cl_size(i) = class_size(i);
% end

[row,col] = size(alltrainingdata);

%finding distance between testdata and training data
for i = 1:row
    d(i) = (sum((testdata-alltrainingdata(i,:)).^2)).^0.5;
end

%finding index for minimum distance between testdata and training data
f = find(d == min(d));

%disp('index is ');
%f

% For 2 class problem
% class_size(1) is number of exons in training data
if f > class_size(1)
    class_decision = 1; % found an intron
else
    class_decision = 0; % found an exon
end

end


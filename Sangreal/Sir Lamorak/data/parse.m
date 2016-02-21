files = dir('*.jpg');

for i=1:length(files)
    filename = files(i).name;
    A = imread(filename);
    
    display(filename);
    display(determine_type(A));
    
    
end
function [ type ] = determine_type( A )
color_channel = A(1,1,:);
type = all(color_channel < 10);
end


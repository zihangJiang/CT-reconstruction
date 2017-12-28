function [ z1 ] = filternumber( x,y,z )
%FILTERNUMBER Summary of this function goes here
%   Detailed explanation goes here

if y>120
    if z<14/28
        z1=0;
    else
        z1=1;
    end
else
    if z<14/28
        z1=0;
    elseif z<28.2/28
        z1=1;
    elseif z<32/28
        z1=2;
    elseif z<35/28
        z1=3;
    elseif z<40/28
        z1=4;
    elseif z<1.5 
        z1=5;
    end
end


end


function [x,y,found] = search_colored (A, type)

found = 0;
for r=1:7
    for c=1:18
        x = 75 + (c-1)*(108-75);
        y = 78 + (r-1)*(110-78);
        colors = A(y, x, :);
        if (type) %black image N
           if (~all(colors > 10))
               found = 1;
               break
           end
        else
            %yellow image E
            if (all(colors > 10))
               found = 1;
               break
           end
        end
    end
    
    if (found)
        break
    end
end

end
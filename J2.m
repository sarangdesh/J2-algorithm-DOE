function J2d = J2()
    
global N;
term10=0;

    for i=1:N
        for j=1:N
            if i<j
                term9 = Del_ij(i,j)^2;
                sum = term9+term10;
                term10=sum;
            end
        end
    end
    
    J2d = sum;

end
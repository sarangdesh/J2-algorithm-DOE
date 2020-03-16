function LowerBound = L(r)
term2=0;
term4=0;
term6=0;
global N Lsorted Wsorted;

for k=1:r
    term1 = N*Wsorted(k)*1/Lsorted(k);
    sum1 = term1+term2;
    term2 = sum1;
    
    term3 = (Lsorted(k)-1)*(N*Wsorted(k)*1/Lsorted(k))^2;
    sum2 = term3+term4;
    term4 = sum2;
    
    term5 = Wsorted(k);
    sum3 = term5+term6;
    term6 = sum3;
end

sumsq1=sum1^2;
sumsq3=sum3^2;

LowerBound = 0.5*(sumsq1+sum2-N*sumsq3);        % Lower bound "L(n)"

end
function deltaij = Del_ij(i,j)

global col Wsorted d;
term8 = 0;

for k=1:col
        term7 = Wsorted(k)*Del(d(i,k),d(j,k));
        sum4 = term7+term8;
        term8 = sum4;
end
    deltaij = sum4;

end
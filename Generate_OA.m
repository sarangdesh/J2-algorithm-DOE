% Two-level, multi-factor experimental design algorithm
% Source: http://in.mathworks.com/matlabcentral/newsreader/view_thread/261404

function OA = Generate_OA(N)

N = 6;

n = 2^ceil(log2(N+1));
    for i = 1: n
       for j = 1: N
           level = 0;
           k = j;
           mask = n/2;
           while k>0
               if mod(k,2) & (bitand(i-1,mask)~=0)
                   level = mod(level + 1, 2);
               end
               k = floor(k/2);
               mask = mask/2;
               OA(i,j) = level + 1;
           end
       end
    end
end
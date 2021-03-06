%% GENERATION OF NEARLY-ORTHOGONAL ARRAYS USING J2 OPTIMALITY CRITERION
%
% ---------------------------------------------------------------------- %
% This piece of code generates nearly-orthogonal arrays (NOAs) for the
% purpose of experiment design. It reads user-specified values for the
% number of factors, number of levels of each factor, and number of runs to
% generate NOA of the required strength and resolution.
% This NOA can be used for designing a shortened experiment where it is not
% possible to build and perform full-factorial experiments, with large run
% sizes and large number of factors.
% 
% The program adopts the algorithm proposed by Hongquan Xu, Department of
% Statistics, UCLA, for constructing OAs and NOAs with mixed levels and
% small runs utilizing the combinatorial J2-optimality criterion.
% 
%                        Copyright (C) 2016 Cambio
% ---------------------------------------------------------------------- %


function Cambio_J2_NOA()
clc

%% USER INPUTS

temp1 = input('Total number of factors: ','s');
global n;
n = str2double(temp1);          % n is the total number of factors

MAT_factors = zeros(1,n);       % Initializing matrix of factors
MAT_levels = zeros(1,n);        % Initializing matrix of levels
MAT_weights = zeros(1,n);       % Initializing matrix of weights

for p=1:n
    MAT_factors(1,p)=p;
    
    fprintf('Number of levels for factor %d: ', p);
    temp2 = input('','s');
    MAT_levels(1,p) = str2double(temp2);
    
    fprintf('Weight for factor %d: ', p);
    temp3 = input('','s');
    MAT_weights(1,p) = str2double(temp3);
end

%% USER INPUTS (DIALOG) (To Edit: Uncomment All)

% prompt = {'Total number of factors:','Levels for each factor (comma separated): ','Weights for each factor (comma separated):'};
% dlg_title = 'Experiment Design Definition';
% num_lines = 1;
% 
% answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
% 
% str1 = regexprep(answer{1},',',' ');
% f = str2num(str1);
% MAT_factors = f;
% 
% str2 = regexprep(answer{2},',',' ');
% l = str2num(str2);
% MAT_levels = l;
% 
% str3 = regexprep(answer{3},',',' ');
% w = str2num(str3);
% MAT_weights = w;

%% CHECKING VALIDITY OF ALL INPUTS (To Edit: Uncomment All)

% for xyz=1:3
%     
%     B = isempty(answer{xyz});
%     
% while B==1
%     warndlg('Nothing was entered. Do not be lazy.');
%     answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
%     str1 = regexprep(answer{1},',',' ');
%     f = str2num(str1);
%     MAT_factors = f;
% 
%     str2 = regexprep(answer{2},',',' ');
%     l = str2num(str2);
%     MAT_levels = l;
% 
%     str3 = regexprep(answer{3},',',' ');
%     w = str2num(str3);
%     MAT_weights = w;
%     
%     B = isempty(answer{xyz});
%     if B==1
%     else
%         B=0;
%     end
% end
% end
% 
% MAT_factors
% MAT_levels
% MAT_weights
% 
% for xyz=1:3   
% bb = regexprep(answer{xyz},',',' ');        % Replace regular expression (Stores numbers separated by comma into a matrix)
% B1 = str2double(bb);               % Converted matrix
% 
% [m n]=size(B1);
% for i=1:m;
%     j=1;
%         while B1(i,j)<0||mod(B1(i,j),1)~=0
%         warndlg('Please enter positive integers only. Or you could go refer a primary mathematics textbook.');
%         answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
%         str1 = regexprep(answer{1},',',' ');
%         f = str2num(str1);
%         MAT_factors = f;
% 
%         str2 = regexprep(answer{2},',',' ');
%         l = str2num(str2);
%         MAT_levels = l;
% 
%         str3 = regexprep(answer{3},',',' ');
%         w = str2num(str3);
%         MAT_weights = w;
%         
%         end
% end
% end
% 
% 
% for xyz=2:3
% bb = regexprep(answer{xyz},',',' ');        % Replace regular expression (Stores numbers separated by comma into a matrix)
% B1 = str2double(bb);               % Converted matrix
% B2 = isinteger(B1);
% B3 = numel(B1);
% tp = str2double(answer{1});
% 
% while B3~=tp
%     warndlg({'Please enter levels corresponding to number of the factors input.','E.g. Enter five numbers corresponding to the factors if "5" was entered in the above field.'});
%     answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
%     str1 = regexprep(answer{1},',',' ');
%     f = str2num(str1);
%     MAT_factors = f;
% 
%     str2 = regexprep(answer{2},',',' ');
%     l = str2num(str2);
%     MAT_levels = l;
% 
%     str3 = regexprep(answer{3},',',' ');
%     w = str2num(str3);
%     MAT_weights = w;
%     
% end
% end


%% ARRANGING FACTORS IN DESCENDING ORDER OF LEVELS

global Fsorted Lsorted Wsorted;

[Lsorted,SortIndex] = sort(MAT_levels,'descend');
Fsorted = MAT_factors(SortIndex);
Wsorted = MAT_weights(SortIndex);

fprintf('\nFactors');
Fsorted
fprintf('\nLevels for factors (in descending order)');
Lsorted
fprintf('\nWeights for factors (corresponding)');
Wsorted

%% INPUT OF NUMBER OF RUNS VALUE

disp('Enter total number of runs equal to LCM of the number of levels, or a multiple of it.');
lcm_levels = lcms(MAT_levels);                      % Function "LCMS" (by Josh) for finding LCM of matrix elements
fprintf('LCM of number of levels = %d', lcm_levels);

temp4 = input('\nTotal number of runs: ','s');
global N;
N = str2double(temp4);

while N<max(MAT_levels)
      disp('\nInput not allowed. \nEnter total number of runs equal to LCM of the number of levels, or a multiple of it.');
      
      temp4 = input('\nTotal number of runs: ','s');
      N = str2double(temp4);
end

%% INPUT VALUES OF T1 AND T2

val1 = input('\nEnter the value of T1: ','s');
T1 = str2double(val1);

val2 = input('\nEnter the value of T2: ','s');
T2 = str2double(val2);

%% CALCULATION OF LOWER BOUND "L(n)"

Ln = L(n);
fprintf('\nLower bound L(n) = %f \n',Ln);


%% CONSTRUCTION OF INITIAL DESIGN

global d;
d = zeros(N,n);                         % Initializing design matrix "d"

% First balanced column
reps1 = N/Lsorted(1);                   % No. of reps for levels of first column
filler = 0;
temp6 = 1;

for temp5=1:N
    if temp6<=reps1
        d(temp5,1) = filler;
        temp6=temp6+1;
    else
        filler=filler+1;
        d(temp5,1)=filler;
        temp6=2;
    end
end
    
% disp(d(:,1));

% Second balanced column
filler = 0;
temp7 = 1;

for temp5=1:N
    if temp7<=Lsorted(2)
        d(temp5,2) = filler;
        filler=filler+1;
        temp7=temp7+1;
    else
        filler=0;
        d(temp5,2)=filler;
        filler=filler+1;
        temp7=2;
    end
end

% disp(d(:,2));

fprintf('\n Design matrix: current status\n');
disp(d);

%% PRE-ALGORITHM CHECK

global col;             % Number of columns to consider for the calculation of Del_ij and J2
global deltaijd;

Ln = L(2);              % Lower bound
fprintf('\nL(2) = %f \n',Ln);

col=2;                  % NOTE: Be sure to update the value of col whenever a fresh calculation of J2 is required
J2value = J2();
fprintf('\nJ2(2) = %f \n',J2value);

fprintf('\nDelta(i,j) = %f \n',deltaijd);

if J2value==Ln
    n0 = 2;
    T = T1;
else
    n0 = 0;
    T = T2;
end

fprintf('\n n0 = %f \n', n0);
fprintf('\n T = %f \n', T);


%% GENERATION OF ADDITIONAL BALANCED COLUMNS

for k=3:n
    
    % STEP A: Create new balanced column based on sequential filling (as done previously for column 2)
    
    % Here, all new columns corresponding to the specified factors are
    % created at the same time for ease of programming.
    
    filler = 0;
    counter2 = 1;

    for counter1=1:N
        if counter2<=Lsorted(k)
            d(counter1,k) = filler;
            filler=filler+1;
            counter2=counter2+1;
        else
            filler=0;
            d(counter1,k)=filler;
            filler=filler+1;
            counter2=2;
        end
    end
end

%% INTERCHANGE AND EXCHANGE ALGORITHM

% The algorithm iterates through adding columns to the design matrix after
% the second column (k=3:n), through repeating randomly generated columns T
% times (t=1:T), through minimizing the values of J2(d+) by performing
% interchange and exchange procedures.
% 
% For each kth column of the design matrix, the counter 'oo' helps to link
% the minimum value for J2 obtained, with the column that produced it. A
% matrix 'vbn' stores J2 values corresponding to the number of times it is
% calculated ('oo'), and stores the column that resulted in that J2 value
% in a separate matrix 'columndef' with the column index set to 'oo'.
% 
% At the end, the column producing the minimum J2 value is sought,
% retrieved and set as the kth column of the design matrix.


zxc = zeros(N,3);               % Initialization of matrix to store DELTA(a,b) values and obtain value of max element later
vbn = zeros(2000000,1);         % Initialization of matrix to store J2dplus values and retrieve value of column producing smallest J2dplus
columndef = zeros(2000000,1);   % Initialization of matrix to store column symbols and retrieve value of column producing smallest J2dplus

for k=3:n
    
    oo = 1;                     % Initializing counter for storing current column definition and storing J2value against this index
    J2diff=10;                  % Initializing J2diff for entering imminent while loop
    
    for t=1:T                   % STEP C: Repeat T times. T1,T2~100 (moderate values) according to recommendation of the authors
        
        % RANDOMLY GENERATE COLUMNS HERE
        
        % ---------
        
        column=[1 2;4 5];       % TEMP
        
        
        % ---------
        
        columndef(:,oo)=column(:,k);         % columndef is the matrix that stores each latest created column along the index oo
        
        while J2diff>=0.5           % Custom criterion for exiting iterative interchanging
            
            % Store current column definition corresponding to counter 'oo'
            
            %----CHANGE----%
            columndef(:,oo)=column(:,k);         % columndef is the matrix that stores each latest created column along the index oo
            
            % STEP A: Computation of J2(d+)
            col=k-1;                            % J2 value is being calculated for (k-1) columns of the current status of design matrix d
            J2value=J2();
            
            for e=1:N
                for f=1:N
                    if e<f
                        deltaijd = Del_ij(e,f);
                        deltaijc = Del(d(e,k),d(f,k));          % Since Del_ij(c) = Del(ci,cj)
                        deltadelta = deltaijd*deltaijc;         % deltadelta = Del_ij(d)*Del_ij(c)
                        term11 = deltadelta+term12;
                        term12 = term11;                        % Final sum is stored in term11 (and term12)
                    end
                end
            end
            
            
            J2dplus = J2value + 2*Wsorted(k)*term12 + 0.5*N*Wsorted(k)^2*(N/Lsorted(k)-1);
            
            % OR J2dplus could be calculated without a recursive function by calling the J2
            % function directly for col=k.
            
            % col = k;
            % J2dplus = J2();
            
            % STEP A: Optimality condition check
            
            if J2dplus==L(k)
                
                J2value=J2dplus;
                n0=k;                       % Signifies that n0 columns in the design are orthogonal
                
                % Storing J2dplus values (to retrieve highest value after T iterations are completed)
                vbn(oo,1) = J2value;
                oo=oo+1;
                
            else
                T=T2;
                
                % STEP B: Calculation of DELTA(a,b)
                                
                u=1;                        % Counter for storing DELTA(a,b) values in zxc, with columns corresponding to values of (a,b,DELTAab) respectively
                term22=0;                   % Initialization of sum of DELTAab (for safety only)
                
                for a=1:N
                    for b=1:N
                        
                        if d(a,k)~=d(b,k)
                            
                            for j=1:N
                                if j~=a && j~=b
                                    col=k-1;                % In the parent (outermost, Line 270) for loop, the current status of design matrix has k-1 columns
                                    term13 = (Del_ij(a,j)-Del_ij(b,j));
                                    
                                    Del_aj_c = Wsorted(k)*Del(d(a,k),d(j,k));     % formula of Del_ij for added column c
                                    term16 = Del_aj_c+term15;
                                    term15 = term16;                    % Final sum stored in term15 (and term16)
                                    
                                    Del_bj_c = Wsorted(k)*Del(d(b,k),d(j,k));     % formula of Del_ij for added column c
                                    term17 = Del_bj_c+term18;
                                    term18 = term17;                    % Final sum stored in term17 (and term18)
                                    
                                    term19 = (Del_aj_c)-(Del_bj_c);
                                    
                                    term20 = term13*term19;
                                    term21 = term20+term22;
                                    term22 = term21;                    % Summation for final value calculation of DELTA(a,b)
                                    
                                end
                            end
                            
                            zxc(u,1) = a;
                            zxc(u,2) = b;
                            zxc(u,3) = term22;
                            u=u+1;
                            
                        end
                    end
                end
                
                % STEP B: Searching highest DELTA(a,b) and switching symbols in the corresponding rows
                
                [highest index] = max(zxc(:,3));        % Largest DELTA(a,b) value
                % NOTE: If the maximum value occurs more than once, then max returns the index corresponding to the first occurrence.
                                
                % Storing J2dplus before switching (to retrieve highest value after T iterations are completed)
                vbn(oo,1) = J2dplus;
                
                % Switching symbols and saving new column against the proper index 'oo'
                
                columndef(:,oo+1)=columndef(:,oo);            % Copy last column to a new column
                tempvar=columndef(zxc(index,1),oo+1);
                columndef(zxc(index,1),oo+1) = columndef(zxc(index,2),oo+1);
                columndef(zxc(index,2),oo+1) = tempvar;
                
                oo=oo+1;
                
                % STEP B: Refresh value of J2(d+) using function OR reduce J2(d+) by 2*wk*DELTA(a,b)
                J2value = J2dplus-2*Wsorted(k)*zxc(index,3);
                % col = k;
                % J2value = J2();
                
                % Storing J2dplus values after switching (to retrieve highest value after T iterations are completed)
                vbn(oo,1) = J2value;
                                
                
            end
            
            J2diff = abs(J2value-J2dplus);
            
        end
        
    end

    % STEP D: Assign column with least J2value to the kth column of the design matrix d
    [minimum J2minindex] = min(vbn(:,1));
    d(:,k)=columndef(:,J2minindex);
    fprintf('\nMinimum value of J2 among all iterations = %d\n',minimum);
    
end


% Display final output, i.e. final design matrix
fprintf('\nFinal Design Matrix = \n');
d
fprintf('\nNumber of orthogonal columns (n0) = %d', n0);


%% RANDOM COLUMN GENERATION

% Define initial design matrix as randomly generated instead of zeros() to
% avoid counting conflict with the zeros already in the matrix.

column = randi([10000 12000],N,n);

for k=3:n
    
    % Enter first Lsorted(k) number of rows in the column randomly. Although not fully randomized, this method is applied to simplify count checking.
    random=randi([0 Lsorted(k)-1]);
    column(1,k)=random;
    
    for m=2:Lsorted(k)
        random=randi([0 Lsorted(k)-1]);
        
        while random~=d(m-1,k)
            column(m,k)=random;
        end
    end
            
        
        
        for f=1:Lsorted(k)
            count(f)=sum(column(:,k))==column(1,k);
            
        
        end
    
    
end
        







end

prompt = {'Total number of factors:','Levels for each factor (comma separated): ','Weights for each factor (comma separated):'};
dlg_title = 'Experiment Design Definition';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
a = answer{1};
b = answer{2};
c = answer{3};

%% CHECKING VALIDITY OF ALL INPUTS

for xyz=1:3
    
    B = isempty(answer{xyz});
    
while B==1
    warndlg('Nothing was entered. Do not be lazy.');
    answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
    a = answer{1};
    b = answer{2};
    c = answer{3};
    B = isempty(answer{xyz});
    if B==1
    else
        B=0;
    end
end
end


for xyz=1:3   
bb = regexprep(answer{xyz},',',' ');        % Replace regular expression (Stores numbers separated by comma into a matrix)
B1 = str2num(bb);               % Converted matrix
B2 = isinteger(B1);

[m n]=size(B1);
for i=1:m
    for j=1:n
        while B1(i,j)<0||mod(B1(i,j),1)~=0
        warndlg('Please enter positive integers only. Or you could go refer a primary mathematics textbook.');
        answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
        a = answer{1};
        b = answer{2};
        c = answer{3};
        end
    end
end
end


for xyz=2:3
bb = regexprep(answer{xyz},',',' ');        % Replace regular expression (Stores numbers separated by comma into a matrix)
B1 = str2num(bb);               % Converted matrix
B2 = isinteger(B1);
B3 = numel(B1);
tp = str2num(answer{1});

while B3~=tp
    warndlg({'Please enter levels corresponding to number of the factors input.','E.g. Enter five numbers corresponding to the factors if "5" was entered in the above field.'});
    answer = inputdlg(prompt,dlg_title,num_lines,{'','',''},'on');
    a = answer{1};
    b = answer{2};
    c = answer{3};
end
end



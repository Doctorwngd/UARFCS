lammda = 1;
name = 'example_new';%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(['.\', name, '.mat']);
min_k = 1;
max_k = size(trandata, 2) - 1;
trandata(18, 1) = 1;
for i=2:4
    if rem(max(trandata(:,i)),1) ~= 0 
        trandata(:,i) = (trandata(:,i)-min(trandata(:,i)))/(max(trandata(:,i))-min(trandata(:,i)));
    end
end

[B, red] = UCAFRS(trandata, lammda, min_k, max_k);
red



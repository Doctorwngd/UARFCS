function M_sim = ele_Sim(data, lammda) %return M_sim, whose every i of 3th d is the number of ith fratures.
    [row, attrinu]=size(data);

    for i=1:attrinu
        if rem(max(data(:,i)), 1) ~= 0
            data(:,i) = (data(:,i)-min(data(:,i)))/(max(data(:,i))-min(data(:,i)));
        end
    end

    %%%%%%%%%%%%%%%%Initializes the fuzzy radius %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    delta=zeros(1,attrinu);
    M_sim = zeros(row, row, attrinu);
    for j=1:attrinu
        if min(data(:,j))==0&&max(data(:,j))==1
         delta(j)=std(data(:,j),1)/lammda; % Find the fuzzy radius of the numeric attribute
        end
    end
    delta

    for i=1:attrinu %计算关于每一个属性的相似度矩阵 %1
        col=i;
        r=[];
        eval(['ssr' num2str(col) '=[];']);
        for j=1:row      
            a=data(j,col);
            x=data(:,col);       
            for m=1:j
                r(j,m)=fruar_kersim(a,x(m),delta(i));
                r(m,j)=r(j,m);
            end
        end
        M_sim(:, :, i) = r;
    end

end
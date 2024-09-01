%%Compute reduct from numerical data, categorical data and their mixtures with
%%Fuzzy rough sets without decision.
%%Dependency is employed as the heuristic rule.
%%Please refer to the following article.
%%Yuan Zhong, Chen Hongmei, Li Tianrui, Yu Zeng, Sang Binbin, and Luo Chuan. 
%%Unsupervised attribute reduction for mixed data based on fuzzy rough sets, Information Science,2021, 572:67-87.
%%Uploaded by Yuan Zhong on May 29, 2021. E-mail:yuanzhong2799@foxmail.com.
function select_feature=uar_FR(M_sim, attrinu, row, B)
%%%input:
% Data is data matrix, where rows for samples and columns for attributes without decision. 
% Numerical attributes should be normalized into [0,1]
% Fuzzy radius delta=std拢篓Data拢漏/lammda, lammda usually takes value in [0.1,1] with 0.1
%%%output:
% a reduct--- the set of selected attributes.
%%
%%%%%%%%%%%%%%search reduct with a forward greedy strategy%%%%%%%%%%%%%%%%%%%%%%%
red=[];
x=0; % x没有实际作用，仅作为启动
base=ones(row); % 得到的是一个nxn的
for j=attrinu:-1:1 % 用break来代替终止条件
    sig=[]; % 每次都会重置
    for l_1=1:length(B) % 为算法里面的B，差集，用来计算每一个B中的属性新并进R时的相似度矩阵
       r2=M_sim(:, :, B(l_1)); 
       %base为原来所有已经选入的属性下的相似度矩阵
       r1=min(r2,base); % r1：将新选择的B中的某一个属性与原来的属性共同的相似度矩阵
       for l_2=1:attrinu % 这层循环为计算上述得到的选入属性和某一个属性的并对于单个属性的下近似
           temp_SIN=zeros(row); % 用来记录下近似，为nxn的矩阵
           r_SIN=M_sim(:, :, l_2); % 每个属性下的相似度矩阵
           [r_SIN_temp,~,r_SIN_ic]=unique(r_SIN,'rows'); % 去重？
            for l_3=1:size(r_SIN_temp,1) % 该循环来计算BUc1_1集合下对cl——2的下近似
                    i_tem=find(r_SIN_ic==l_3); % 去重之后的元素在去重之前的位置
                    temp2_SIN=min(max(1-r1,repmat(r_SIN_temp(l_3,:),row,1)),[],2); % 计算出一个列向量，关于所有变量在属性集在单个属性下的下近似
                    
                    temp_SIN(i_tem,:)=repmat(temp2_SIN',length(i_tem),1); % 放入事先空置的矩阵中
            end
            importance_SIN=sum(max(temp_SIN,[],1)); % 按矩阵列选最大再加起来，计算下近似总和
            sig(l_1,l_2)=importance_SIN/row; % 行为每一个属性集，列为数据表每个属性，元素为集合对于单个属性下的正域除以元素总个数
       end
    end
    [x1,n1]=max(mean(sig,2)); % 按行算每一个属性集的平均值   
    x=[x;x1]; % 将算得的平均值最大值添加到x数组的末尾
    len=length(x); % 计算总长度
    if abs(x(len)-x(len-1))>0% 如果新算的的最大值大于之前算的属性度最大值就将该最值的属性更新B
        base1=M_sim(:, :,B(n1)); %新属性的相关性矩阵
        % 重新计算更新属性后的相关性base
        base=min(base,base1);
        red=[red,B(n1)]; % 更新选中的属性集，red是和base对应
        B=setdiff(B,B(n1)); % 在B中去掉新得到的属性
    else
        break; % 最大属性值已经不能对正域有效果就直接结束
    end
end
select_feature=red;


end

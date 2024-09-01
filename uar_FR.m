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
% Fuzzy radius delta=std£¨Data£©/lammda, lammda usually takes value in [0.1,1] with 0.1
%%%output:
% a reduct--- the set of selected attributes.
%%
%%%%%%%%%%%%%%search reduct with a forward greedy strategy%%%%%%%%%%%%%%%%%%%%%%%
red=[];
x=0; % xû��ʵ�����ã�����Ϊ����
base=ones(row); % �õ�����һ��nxn��
for j=attrinu:-1:1 % ��break��������ֹ����
    sig=[]; % ÿ�ζ�������
    for l_1=1:length(B) % Ϊ�㷨�����B�������������ÿһ��B�е������²���Rʱ�����ƶȾ���
       r2=M_sim(:, :, B(l_1)); 
       %baseΪԭ�������Ѿ�ѡ��������µ����ƶȾ���
       r1=min(r2,base); % r1������ѡ���B�е�ĳһ��������ԭ�������Թ�ͬ�����ƶȾ���
       for l_2=1:attrinu % ���ѭ��Ϊ���������õ���ѡ�����Ժ�ĳһ�����ԵĲ����ڵ������Ե��½���
           temp_SIN=zeros(row); % ������¼�½��ƣ�Ϊnxn�ľ���
           r_SIN=M_sim(:, :, l_2); % ÿ�������µ����ƶȾ���
           [r_SIN_temp,~,r_SIN_ic]=unique(r_SIN,'rows'); % ȥ�أ�
            for l_3=1:size(r_SIN_temp,1) % ��ѭ��������BUc1_1�����¶�cl����2���½���
                    i_tem=find(r_SIN_ic==l_3); % ȥ��֮���Ԫ����ȥ��֮ǰ��λ��
                    temp2_SIN=min(max(1-r1,repmat(r_SIN_temp(l_3,:),row,1)),[],2); % �����һ�����������������б��������Լ��ڵ��������µ��½���
                    
                    temp_SIN(i_tem,:)=repmat(temp2_SIN',length(i_tem),1); % �������ȿ��õľ�����
            end
            importance_SIN=sum(max(temp_SIN,[],1)); % ��������ѡ����ټ������������½����ܺ�
            sig(l_1,l_2)=importance_SIN/row; % ��Ϊÿһ�����Լ�����Ϊ���ݱ�ÿ�����ԣ�Ԫ��Ϊ���϶��ڵ��������µ��������Ԫ���ܸ���
       end
    end
    [x1,n1]=max(mean(sig,2)); % ������ÿһ�����Լ���ƽ��ֵ   
    x=[x;x1]; % ����õ�ƽ��ֵ���ֵ��ӵ�x�����ĩβ
    len=length(x); % �����ܳ���
    if abs(x(len)-x(len-1))>0% �������ĵ����ֵ����֮ǰ������Զ����ֵ�ͽ�����ֵ�����Ը���B
        base1=M_sim(:, :,B(n1)); %�����Ե�����Ծ���
        % ���¼���������Ժ�������base
        base=min(base,base1);
        red=[red,B(n1)]; % ����ѡ�е����Լ���red�Ǻ�base��Ӧ
        B=setdiff(B,B(n1)); % ��B��ȥ���µõ�������
    else
        break; % �������ֵ�Ѿ����ܶ�������Ч����ֱ�ӽ���
    end
end
select_feature=red;


end

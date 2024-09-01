function densityVector = DS(S_new, S)
    % 计算 S_new 和 S 的逐元素乘积
    multipliedMatrix = S_new .* S;
    
    % 对每一行进行求和
    rowSums = sum(multipliedMatrix, 1);
    rowS = sum(S_new, 1);
    
    % 返回 n*1 的向量
    densityVector = rowSums./rowS;
end

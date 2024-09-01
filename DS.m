function densityVector = DS(S_new, S)
    % ���� S_new �� S ����Ԫ�س˻�
    multipliedMatrix = S_new .* S;
    
    % ��ÿһ�н������
    rowSums = sum(multipliedMatrix, 1);
    rowS = sum(S_new, 1);
    
    % ���� n*1 ������
    densityVector = rowSums./rowS;
end

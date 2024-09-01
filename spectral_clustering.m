% ʹ���������ƾ��� M_feature �����׾��ಢ���ؾ������ M_clustering
function M_clustering = spectral_clustering(M_feature, k)
   
    % ����Ⱦ��� D
    
    D = diag(sum(M_feature, 2));
    
    % ����������˹���� L
    L = D - M_feature;
    
    % ���� L ������ֵ���������� D^(-1/2)*L*D^(-1/2)
    [eig_vectors, eig_values] = eig(L);

    
    % ������ֵ�������򣬲��ҳ�ǰ k ����С����ֵ��Ӧ����������
    [~, sorted_indices] = sort(diag(eig_values));
    eig_vectors_k = eig_vectors(:, sorted_indices(1:k));

    % �������������й�һ��
    Y = bsxfun(@rdivide, eig_vectors_k, sqrt(sum(eig_vectors_k.^2, 2)));

    % �� Y ���� k-means ����
    clustering = kmeans(Y, k);

    % ����������� M_clustering
    M_clustering = zeros(k, length(clustering));
    for i = 1:length(clustering)
        M_clustering(clustering(i), i) = 1;
    end
%     if k == 3
%         %         D
%         %         L
%         %         D^(-1/2)*L*D^(-1/2)
%         eig_values
%         eig_vectors_k
%     end
end

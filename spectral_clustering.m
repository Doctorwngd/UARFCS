% 使用属性相似矩阵 M_feature 进行谱聚类并返回聚类矩阵 M_clustering
function M_clustering = spectral_clustering(M_feature, k)
   
    % 计算度矩阵 D
    
    D = diag(sum(M_feature, 2));
    
    % 计算拉普拉斯矩阵 L
    L = D - M_feature;
    
    % 计算 L 的特征值和特征向量 D^(-1/2)*L*D^(-1/2)
    [eig_vectors, eig_values] = eig(L);

    
    % 对特征值进行排序，并找出前 k 个最小特征值对应的特征向量
    [~, sorted_indices] = sort(diag(eig_values));
    eig_vectors_k = eig_vectors(:, sorted_indices(1:k));

    % 对特征向量进行归一化
    Y = bsxfun(@rdivide, eig_vectors_k, sqrt(sum(eig_vectors_k.^2, 2)));

    % 对 Y 进行 k-means 聚类
    clustering = kmeans(Y, k);

    % 构建聚类矩阵 M_clustering
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

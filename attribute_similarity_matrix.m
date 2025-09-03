% 计算三维张量 M_sim 的属性间相似矩阵 M_feature
function M_feature = attribute_similarity_matrix(M_sim)
    [~, ~, num_features] = size(M_sim);
    M_feature = zeros(num_features, num_features);
    
    for i = 1:num_features
        for j = i:num_features
            M_i = squeeze(M_sim(:, :, i));
            M_j = squeeze(M_sim(:, :, j));
            sim_vec = similarity_vec(M_i, M_j);
            sim = mean(sim_vec);
            M_feature(i, j) = sim;
            M_feature(j, i) = sim; % 对角线对称
        end
    end
end
% 计算两个矩阵之间的相似度向量
function sim_vec = similarity_vec(M_i, M_j)
    min_matrix = min(M_i, M_j);
    max_matrix = max(M_i, M_j);
    sim_vec = sum(min_matrix, 2) ./ sum(max_matrix, 2);
end

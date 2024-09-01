function [B, red] = UCAFRS(trandata, lammda, min_k, max_k)

[rows, attrinu] = size(trandata(:, 1:end - 1));
M_sim = ele_Sim(trandata(:, 1:end - 1), lammda);
S = attribute_similarity_matrix(M_sim); % Compute the attribute similarity matrix based on element similarities
% S = normalize_matrix(S);
losses = zeros(max_k - min_k + 1, 1);

% For the given range of k values, perform spectral clustering and calculate the loss
for k = min_k:max_k
    C = spectral_clustering(S, k); % Perform spectral clustering and obtain the clustering results
%     C = fuzzy_cmeans(S, k);
    S_new = (C' * C) > 0; % Compute the new similarity matrix based on the clustering results
%     S_sim = normalize_symmetric_matrix    
    losses(k - min_k + 1) = norm(S_new - S, 2); % Calculate the loss as the norm of the difference between the new and original similarity matrices
end

% Identify the k value with the minimum loss and the corresponding clustering result
[~, min_loss_idx] = min(losses);
optimal_k = min_k + min_loss_idx - 1;
optimal_C = spectral_clustering(S, optimal_k);
% S_new = (optimal_C' * optimal_C) > 0;
base = ones(rows);
B = 1:attrinu;
sig = sig_M(attrinu, rows, base, M_sim, B); % Compute the significance of attributes
sig_mean = mean(sig, 2)'; % Calculate the mean significance across attributes
% ds = DS(S_new, S);
% Obtain the importance of each element within its cluster
% C_sig_mean = optimal_C .* sig_mean .* ds;
C_sig_mean = optimal_C .* sig_mean;
% Find the maximum value and the corresponding column index for each row
[max_values, max_indices] = max(C_sig_mean, [], 2);
B = max_indices';
% attrinu = length(B);
red = uar_FR(M_sim, attrinu, rows, B); % Perform final attribute reduction based on the selected attributes

end

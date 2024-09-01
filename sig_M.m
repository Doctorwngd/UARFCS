function sig = sig_M(attrinu, row, base, M_sim, B)

sig = []; % Initialize the significance matrix for each attribute set
for l_1 = 1:length(B) % Loop over the selected attributes in B to calculate their significance when added to the reduction set R
   r2 = M_sim(:, :, B(l_1)); 
   % `base` represents the similarity matrix of all attributes that have already been added to the reduction set
   r1 = min(r2, base); % Combine the similarity of the newly selected attribute with the existing attributes in the reduction set

   for l_2 = 1:attrinu % This loop calculates the lower approximation for each attribute in the current reduction set
       temp_SIN = zeros(row); % Temporary matrix to store the lower approximation values for each element (row x row)
       r_SIN = M_sim(:, :, l_2); % Similarity matrix for the current attribute
       [r_SIN_temp,~,r_SIN_ic] = unique(r_SIN,'rows'); % Remove duplicate rows from the similarity matrix
       
       for l_3 = 1:size(r_SIN_temp,1) % Loop to calculate the intersection of BUc1_1 with cl_2 under the reduction set
           i_tem = find(r_SIN_ic == l_3); % Find the original positions of the elements after removing duplicates
           temp2_SIN = min(max(1-r1, repmat(r_SIN_temp(l_3,:), row, 1)), [], 2); % Compute a column vector depending on all variables' lower approximation under the current attribute
           
           temp_SIN(i_tem,:) = repmat(temp2_SIN', length(i_tem), 1); % Store the results in the temporary matrix
       end
       
       importance_SIN = sum(max(temp_SIN, [], 1)); % Sum the maximum values from each column to get the overall lower approximation significance
       sig(l_1,l_2) = importance_SIN / row; % Store the significance score for the attribute set (row corresponds to the attribute set, column to the individual attribute)
   end
end

end

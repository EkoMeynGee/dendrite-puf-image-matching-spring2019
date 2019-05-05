load SNR_pepper_salt.mat
ratio = zeros(26,1);
for index = 1:26
    ratio(index) = numel(find(G_noise_match(index,:) == [1:30]))/30;
end
idx_set = [4, 6, 13, 15, 17, 18, 19, 21, 22 23, 39, 43, 49];

rate_df = [];
for i = 1:length(idx_set)
   idx = idx_set(i);
   str = strcat(num2str(idx), '.mat');
   load(str); 
   rate_df = [rate_df, rateTable];
end

save rate_df rate_df

figure, hold on, grid on
for i = 1:length(idx_set)
   scatter([1:10], rate_df(:,i), 50);
end

[population2,gof] = fit([1:10]',mean(rate_df,2),'poly2');
plot(population2, 'b--')
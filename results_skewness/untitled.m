idx_set = [17, 21, 34, 45, 49];

sk_df = [];
for i = 1:length(idx_set)
   idx = idx_set(i);
   str = strcat('sk', num2str(idx), 'savemat.mat');
   load(str); 
   sk_df = [sk_df, rate(1:2:end)];
end

save sk_df sk_df

figure, hold on, grid on
load deg
for i = 1:length(idx_set)
   scatter(deg(1:2:end), sk_df(:,i), 40, 'filled', 'MarkerFaceAlpha', 0.4);
   [population2,~] = fit(deg(1:2:end), sk_df(:,i),'poly2');
   plt1 = plot(population2, '--');
   plt1.Color(4) = 0.7;
end
 
[population2,gof] = fit(deg(1:2:end),mean(sk_df,2),'poly2');
plot(population2, 'k-')
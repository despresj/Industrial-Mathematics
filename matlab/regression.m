file = "https://raw.githubusercontent.com/despresj/Industrial-Mathematics/main/data/hotel.csv";
hotel = readmatrix(file);
col_select = [3, 10, 11, 12, 28];
X = hotel(:, col_select);
y = hotel(:, 2);
y = categorical(y);
[B,dev,stats] = mnrfit(X, y);
p_q = mnrval(B, X);

phat_vec = p_q(1:1000, 1);

capacity_vec = zeros(1, length(phat_vec));

for i = 1:length(phat_vec)
<<<<<<< HEAD
    probs = capacity_frac(phat_vec(i), 1000, 4)
   capacity_vec(i) = probs;
end
=======
    book = capacity_frac(phat_vec(i), 1000, 4);
   capacity_vec(i) = book;
end 
beep
capacity_vec
>>>>>>> test

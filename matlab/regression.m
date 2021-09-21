file = "https://raw.githubusercontent.com/despresj/Industrial-Mathematics/main/data/hotel.csv";
hotel = readmatrix(file);
hotel_table = readtable(file);
col_select = [3, 10, 11, 12, 28];
X = hotel(:, col_select);
y = hotel(:, 2);
y = categorical(y);
[B,dev,stats] = mnrfit(X, y);
p_q = mnrval(B, X);
phat_vec = p_q(:, 1);
phat_vec;

capacity_vec = zeros(1, length(phat_vec));

for i = 1:length(phat_vec)
   capacity_vec(i) = capacity_frac(phat_vec(i), 1000, 4);
end
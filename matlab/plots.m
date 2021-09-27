rooms = 1000;
bookings = 1500;
p = 0.64;
% plot(binopdf(1:rooms, bookings, p))

p_vec = 0:0.01:1;

y = zeros(1, length(p_vec));

for i = 1:length(p_vec)
   y(i) = capacity_frac(p_vec(i), 1000, 4);
end

plot(p_vec, y)

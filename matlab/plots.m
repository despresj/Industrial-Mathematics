rooms = 1000;
bookings = 1500;
p = 0.64;
% plot(binopdf(1:rooms, bookings, p))
<<<<<<< HEAD
% plot(binopdf(rooms+1, bookings, p))
=======
>>>>>>> test

p_vec = 0:0.01:1;

y = zeros(1, length(p_vec));

for i = 1:length(p_vec)
<<<<<<< HEAD
    y(i) = capacity_frac(p_vec(i), 1000, 1500)
=======
   y(i) = capacity_frac(p_vec(i), 1000, 4);
>>>>>>> test
end

plot(p_vec, y)

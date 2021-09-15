how_many_bookings(1000, 4, 0.64)

max = zeros(100, 1);

for rooms = 900:1000
   max(rooms) = how_many_bookings(rooms, 25, 0.64);
end

max_rooms = transpose(1:1000);
table(max_rooms, max)

losses = zeros(10, 1);
for loss = 1:10
    losses(loss) = how_many_bookings(1000, loss, 0.64);
end

loss_factor = transpose(1:10);
table(loss_factor, losses)
    
function bookings = how_many_bookings(capacity, loss, p);
    bookings = 1;
    while true
        phi = binocdf(capacity, bookings + 1, p) - loss * binocdf(capacity, bookings + 2, p, 'upper');
        rho = binocdf(capacity, bookings, p) - loss * binocdf(capacity, bookings + 1, p, 'upper');
        bookings = bookings + 1;
        if phi - rho < 0 % stop when neg
            break  % end
        end
    end
    bookings;
end


booking_optimize(1000, 0.64, 4)

function max_booking = booking_optimize(rooms, p, loss)

    E = 0;
    E_m1 = 0;
    filled_m1 = 0;
    over_m1 = 0;
    bookings = rooms;
    while E_m1+1 >= E
        
        E = sum(filled_m1) - loss * sum(over_m1);
        filled_m1 = bookings * binopdf(1:rooms, bookings, p);
        over_m1 = bookings * binopdf(rooms+1:bookings, bookings, p);
        E_m1 = sum(filled_m1) - loss * sum(over_m1);

        bookings = bookings + 1;

    end
    bookings
end
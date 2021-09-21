function frac_of_capacity = capacity_frac(p, rooms, loss)

    E = 0;
    E_m1 = 0;
    filled_m1 = 0;
    over_m1 = 0;
    bookings = rooms;
    while E_m1 >= E
        
        E = sum(filled_m1) - loss * sum(over_m1);
        filled_m1 = bookings * binopdf(1:rooms, bookings, p);
        over_m1 = bookings * binopdf(rooms+1:bookings, bookings, p);
        E_m1 = sum(filled_m1) - loss * sum(over_m1);

        bookings = bookings + 1;

    end
    frac_of_capacity = bookings;
end
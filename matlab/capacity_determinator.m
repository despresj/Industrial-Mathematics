function frac_of_capacity = capacity_determinator(p, rooms, loss)

    E = 0;
    E_m1 = 0;
    filled_m1 = 0;
    over_m1 = 0;
    bookings = rooms;
    F_bookings = 0;
    F_bookings_c = 0;
    while E_m1 >= E
        E = F_bookings * bookings - loss * F_bookings_c
        
        F_bookings = binocdf(rooms, bookings, p)
        
        F_bookings_c = 1 - F_bookings
        
        E_m1 = sum(filled_m1) - loss * sum(over_m1);
       
        bookings = bookings + 1;

    end
    frac_of_capacity = bookings
end
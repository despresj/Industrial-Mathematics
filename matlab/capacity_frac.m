function frac_of_capacity = capacity_frac(p, rooms, loss)

    [E, E_m1, Fx, P_overbook, bookings] = deal(0, 0, 0, 0, rooms);

    while E_m1 >= E
        E = bookings * Fx - loss * bookings * P_overbook;
        
        Fx = binocdf(rooms, bookings, p);
        P_overbook = 1 - Fx;
        E_m1 = bookings * Fx - loss * bookings * P_overbook;

        bookings = bookings + 1;
    end
    frac_of_capacity = bookings;
end
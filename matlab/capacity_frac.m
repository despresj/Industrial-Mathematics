function frac_of_capacity = capacity_frac(p, rooms, loss)

    [E, E_m1, Fx, P_overbook, bookings] = deal(0, 0, 0, 0, rooms);

    while E_m1 >= E
        E = bookings * Fx - loss * bookings * P_overbook;
  
        Fx = binocdf(rooms, bookings, p);
        P_overbook = 1 - Fx;
        bookings = bookings + 1;
        
        if bookings > 2e3
            bookings = bookings + 1e3;
            break
        end
        
        E_m1 = bookings * Fx - loss * bookings * P_overbook;
    end
    frac_of_capacity = bookings;
end
function frac_of_capacity = capacity_frac(p, rooms, loss)

    [E, E_m1, Fx, P_overbook, bookings] = deal(0, 0, 0, 0, rooms);
    if p > 0.3
        while E_m1 >= E
            E = bookings * Fx - loss * bookings * P_overbook;

            Fx = binocdf(rooms, bookings, p);
            P_overbook = 1 - Fx;
            bookings = bookings + 1;

            E_m1 = bookings * Fx - loss * bookings * P_overbook;
        end
    else
        bookings = bookings + 2e3;
    end
    frac_of_capacity = bookings;
end
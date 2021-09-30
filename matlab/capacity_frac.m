function frac_of_capacity = capacity_frac(p, rooms, loss)

<<<<<<< HEAD
    E = 0;
    E_m1 = 0;
    filled_m1 = 0;
    over_m1 = 0;
    bookings = rooms;

    while E_m1 >= E
        
        if bookings > 1e4
            break
        end

        E = sum(filled_m1) - loss * sum(over_m1);
        
        bookings = bookings + 1;
        
        filled_m1 = bookings * binopdf(1:rooms, bookings, p);
        over_m1 = bookings * binopdf(rooms+1:bookings, bookings, p);
        E_m1 = sum(filled_m1) - loss * (bookings - rooms) * sum(over_m1);
        
=======
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
>>>>>>> test
    end
    frac_of_capacity = bookings;
end
loss = 4;
rooms = 1000;

for booking = rooms:1:2000
    E_arrival_m1 = binoinv(0.5,booking + 1,0.62);
    E_arrival = binoinv(0.5, booking, 0.62);
    
    phi = E_arrival_m1 - E_arrival - loss * bookings * binocdf(rooms, E_arrival_m1, 0.64, "upper") + loss * bookings * binocdf(rooms, E_arrival, 0.64, "upper");
    if phi < 0
        break
    end
    
end 

booking
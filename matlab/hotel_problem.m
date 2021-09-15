Fc = 1e5;   % Fixed cost
Mc = 30;    % marginal cost
Mr = 100;   % marginal revenue
r  = 1000;  % hotel capacity
B  = 1500;  % bookings
c  = 2;     % loss constant
l  = c * Mr;     %
p  = 1 - 0.36;
format long

binocdf(r, B, p, 'upper'); % probs B > r

bookings = zeros(100, 1); 

loss = 6;
for r = 900:1000   % rooms 1:1000
    for B = r:10000 % bookings rooms < bookings through 1000
        phi = binocdf(r, B + 1, p) - loss*binocdf(r, B+2, p, 'upper');
        rho = binocdf(r, B, p) - loss*binocdf(r, B, p, 'upper');
            % P(bookings <= rooms) - 4*P(bookings > rooms)
        if phi - rho < 0 % stop when neg
            break  % end
        end 
    end
    ind = r-899;
    bookings(ind) = B; % gives us vec of n rooms
end

rooms = transpose(900:1000);
table(rooms, bookings)


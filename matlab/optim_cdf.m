 
r = 1000
p = 0.64
for bookings = r:10000
    phi = binocdf(r, B + 1, p, 'upper') + binocdf(r, B, p, 'upper')
    if phi > 0 
        break 
    end
end
B
function r = linear_taper(d, dmax)
    r = (dmax - abs(d)) / dmax;
end
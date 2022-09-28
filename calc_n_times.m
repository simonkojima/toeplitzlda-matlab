function r = calc_n_times(dim, n_channels, n_times)

if isnumeric(n_times)
    if floor(n_times) == n_times % if type(n_times) is int:
        r = n_times;
    else
        error("Unknown value for n_times")
    end
elseif strcmpi(n_times, "infer")
    if rem(dim, n_channels) ~= 0
        error("Could not infer time samples. Remainder is non-zero.")
    else
        r = dim / n_channels;
    end
else
    error("Unknown value for n_times")
end
end
function val = GuassPDF(x, mu, sigma)
    val = (1 / (sigma * sqrt(2 * pi))) * exp(-(x - mu).^2 ./ (2 * sigma^2));
end
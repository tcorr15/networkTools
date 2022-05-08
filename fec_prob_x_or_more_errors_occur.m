function fec_prob_x_or_more_errors_occur(ber, no_errors, n)
    disp("P(> R errors) = 1 - P(< R errors)");
    prob = fec_prob_x_or_less_errors_occur(ber, no_errors, n);
    fprintf("P(> %d errors) = 1 - P(< %d errors)\n", no_errors, no_errors);
    fprintf("P(> %d errors) = 1 - %d\n", no_errors, prob);
    fprintf("P(> %d errors) = %d\n", no_errors, 1-prob);
end
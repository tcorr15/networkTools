function prob = fec_prob_x_or_less_errors_occur(ber, no_errors, n)
    disp("P(< R errors) = ΣP(j errors)");
    fprintf("P(< %d errors) = P(0 errors) ", no_errors);
    for i=1:no_errors-1
        fprintf("+ P(%d errors) ", i);
    end
    fprintf("\n");
    
    prob = 0;
    for i=0:no_errors-1
        fprintf("P(%d errors) = (Pe)^j * (1-Pe)^n-j * (Ce)^n^j\n", i);
        fprintf("P(%d errors) = (%d)^%d * (1-%d)^%d * (%d!/%d!%d!)\n", i, ber, i, ber, n-i, n, i, n-i);
        fprintf("P(%d errors) = (%d)^%d * (1-%d)^%d * (%d!/%d!%d!)\n", i, ber, i, ber, n-i, n, i, n-i);
        cenj = factorial(n)/(factorial(i)*factorial(n-i));
        pej = ber^i;
        one_minus_pej_n_minus_j = (1-ber)^(n-i);
        fprintf("P(%d errors) = %d * %d * %d\n", i, pej, one_minus_pej_n_minus_j, cenj);
        prob = prob + (pej*one_minus_pej_n_minus_j*cenj);
        fprintf("P(%d errors) = %d\n", i, (pej*one_minus_pej_n_minus_j*cenj));
    end

    fprintf("P(< %d errors) = %d\n", no_errors, prob);
end

function link_utilisation(d, ber, frame_length_bits, data_rate, propogation_velocity, k)
    % Determine Propogation Delay
    disp("Determine Propogation Delay:");
    tp = d/propogation_velocity;
    fprintf("Tp = %d / %d = %d\n\n", d, propogation_velocity, tp);

    % Determine Transmission Time
    disp("Determine Transmission Time:");
    tix = frame_length_bits/data_rate;
    fprintf("Tix = %d / %d = %d\n\n", frame_length_bits, data_rate, tix);

    % Calculate a
    disp("Calculate a:");
    a = tp/tix;
    one_two_a = 1 + 2*a;
    fprintf("a = Tp/Tix = %d / %d = %d\n", tp, tix, a);
    fprintf("=> 1 + 2a = %d\n\n", one_two_a);

    % Calculate Frame Error Probability
    disp("Calculate Frame Error Probability");
    pf = frame_length_bits*ber;
    one_pf = 1-pf;
    fprintf("Pf = Frame Length(bits) * BER = %d * %d = %d\n1 - Pf = %d\n\n", frame_length_bits, ber, pf, one_pf);

    % For IDLE RQ
    disp("For IDLE RQ");
    fprintf("U = (1-Pf) / (1+2a) = %d / %d = %d\n\n", one_pf, one_two_a, one_pf/one_two_a);

    % For Continuous RQ
    disp("For Continuous RQ with k=" + k);
    if k > one_two_a
        disp("k > 1+2a");
        fprintf("U = 1-Pf = %d\n", one_pf);
    else
        disp("k < 1+2a");
        fprintf("U = k(1-Pf) / (1+2a) = %d(%d)/%d = %d\n", k, one_pf, one_two_a, (k*one_pf)/one_two_a);
    end
end
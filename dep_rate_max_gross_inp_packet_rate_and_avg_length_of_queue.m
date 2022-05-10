function dep_rate_max_gross_inp_packet_rate_and_avg_length_of_queue(tx_link, avg_length_of_packet_bytes, avg_packet_delay, model)
    tsbit = 1/tx_link;
    tspacket = (avg_length_of_packet_bytes*8)/tx_link;
    fprintf("Bit transmission time is equal to:\nTsbit = 1/%d = %d\n", tx_link, tsbit);
    fprintf("Packet transmission time is equal to:\nTspacket = %d/%d = %d\n", avg_length_of_packet_bytes*8, tx_link, tspacket);
    u = 1/tspacket;
    p = 0;
    fprintf("u = 1 / Tspacket = 1 / %d = %d\n\n", tspacket, u);
    disp("Tr = Ts + Tw");
    if model == "M/M/1"
        disp("Tw = pTs / (1-p)");
        disp("Tr = Ts + (pTs/(1-p))");
        fprintf("%d >= Ts + (pTs/(1-p))\n", avg_packet_delay);
        fprintf("Ts = Tspacket = %d = 1/u\n", tspacket);
        fprintf("1/u + p/(u(1-p) <= %d\n", avg_packet_delay);
        fprintf("1 + p/(1-p) <= %d\n", avg_packet_delay*u);
        fprintf("p/(1-p) <= %d\n", avg_packet_delay*u - 1);
        fprintf("p <= %d - %dp\n", avg_packet_delay*u - 1, avg_packet_delay*u - 1);
        fprintf("%dp <= %d\n", avg_packet_delay*u, avg_packet_delay*u - 1);
        p = (avg_packet_delay*u - 1)/(avg_packet_delay*u);
        fprintf("p <= %d\n\n", p);
    elseif model == "M/G/1"
        disp("Tw = pTsA / (1-p)");
        disp("TBC");
    elseif model == "M/D/1"
        disp("Tw = pTs / 2(1-p)");
        disp("Tr = Ts + (pTs/2(1-p))");
        fprintf("%d >= Ts + (pTs/2(1-p))\n", avg_packet_delay);
        fprintf("Ts = Tspacket = %d = 1/u\n", tspacket);
        fprintf("1/u + p/(u2(1-p) <= %d\n", avg_packet_delay);
        fprintf("1 + p/2(1-p) <= %d\n", avg_packet_delay*u);
        fprintf("p/2(1-p) <= %d\n", avg_packet_delay*u - 1);
        fprintf("p <= %d - %dp\n", avg_packet_delay*u - 1, 2*avg_packet_delay*u - 2);
        fprintf("%dp <= %d\n", 2*avg_packet_delay*u - 1, avg_packet_delay*u - 1);
        p = (avg_packet_delay*u - 1)/(2*avg_packet_delay*u-1);
        fprintf("p <= %d\n\n", p);
    else
        disp("Error: Incorrect model");
        exit force
    end


    % Get Lambda Max
    lambda_max = p*u;
    disp("p = λ/u");
    fprintf("%d >= λ / %d\n", p, u);
    fprintf("λ max = %d\n\n", lambda_max);

    
    % Get W
    if model == "M/M/1"
        disp("W = p^2 / (1-p) or W = λ*Tw = λ(Tr-Ts)");      
    elseif model == "M/G/1"
        disp("W = A*p^2 / (1-p) or W = λ*Tw = λ(Tr-Ts)");
    elseif model == "M/D/1"
        disp("W = p^2 / 2(1-p) or W = λ*Tw = λ(Tr-Ts)");
    else
        disp("Error: Incorrect model");
        exit force
    end
    fprintf("W = λ(Tr-Ts) = %d*(%d - %d) = %d\n\n", lambda_max, avg_packet_delay, tspacket, lambda_max*(avg_packet_delay-tspacket));
end
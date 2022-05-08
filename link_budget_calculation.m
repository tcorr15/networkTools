function link_budget_calculation(tx_power_W, gain_t, gain_r, carrier_f, snr, rx_bw, noise_figure, d0_km)
    % Calculate Noise Power
    disp("Calculate Noise Power");
    disp("N = -174[dBm] + BW[dB] + Noise Figure[dB]");
    noise_power = -174 + 10*log10(rx_bw) + noise_figure;
    fprintf("N = -174 + %d + %d = %d\n\n", rx_bw, noise_figure, noise_power);
    
    % Use SNR Values
    disp("Use SNR Values");
    fprintf("SNR >= %d dB => Pr[dBm] - N[dBm] >= %d dB\n", snr, snr);
    fprintf("Pr[dBm] - (%d) >= %d dB\n", noise_power, snr);
    fprintf("Pr[dBm] >= %d + (%d) dB\n", snr, noise_power);
    pr_dbm = snr + noise_power;
    fprintf("Pr[dBm] >= %d\n\n", pr_dbm);

    % Calculate tx power in dBm
    disp("Calculate tx power in dBm");
    fprintf("Pt = %dW = %dmW\n", tx_power_W, tx_power_W*1000);
    pt_dbm = 10*log10((tx_power_W*1000)/1);
    fprintf("Pt[dBm] = 10log10(%dmW/1mW) = %ddBm\n\n", tx_power_W*1000, pt_dbm);
    
    % Calculate Path Loss at d (PL(d))
    disp("Calculate Path Loss at d (PL(d))");
    disp("PL[d] = Pt[dBm] - Pr[d]\n");
    fprintf("PL[d] <= %d - (%d)\n", pt_dbm, pr_dbm);
    pl_d = pt_dbm - pr_dbm;
    fprintf("PL[d] <= %d\n\n", pl_d);

    % Calculate PL(d0)
    disp("Calculate PL(d0)");
    disp("PL(d0) = -10log10((Gt*Gr*lambda^2)/(4pi)^2*d0^2)");
    lambda = (3*10^8)/(carrier_f);
    fprintf("lambda = c/f = 3*10^8 / %d = %d\n", carrier_f, lambda);
    fprintf("PL(d0) = -10log10(%d*%d*%d^2 / (4pi)^2*%d^2)\n", gain_t, gain_r, lambda, d0_km*1000);
    pl_d0 = -10*log10((gain_r*gain_t*(lambda^2))/((4*pi)^2*(d0_km*1000)^2));
    fprintf("PL(d0) = %d dB\n\n", pl_d0);

    % Solve for d_max
    disp("Solve for d_max");
    fprintf("Since:\nPL(d) <= %ddB\nPL(d0) = PL(d0) + 20log(d/d0)\nThen:\nPL(d0) + 20log10(d/d0) <= %d%\n", pl_d, pl_d);
    fprintf("%d + 20log10(d/d0) <= %d\n", pl_d0, pl_d);
    fprintf("20log10(d/d0) <= %d\n", pl_d-pl_d0);
    fprintf("d/d0 <= 10^(%d/20);", pl_d-pl_d0);
    fprintf("d/%d <= %d\n", d0_km, 10^((pl_d-pl_d0)/20));
    disp("d_max = " + (d0_km*10^((pl_d-pl_d0)/20)) + " km")
end
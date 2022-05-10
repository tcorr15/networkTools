function calculate_rtt(ack_frame_length_bytes, frame_length_bytes,  data_rate, d, propogation_velocity, k)
    % Determine Propogation Delay
    disp("Determine Propogation Delay:");
    tp = d/propogation_velocity;
    fprintf("Tp = %d / %d = %d\n\n", d, propogation_velocity, tp);

    % Determine Transmission Time
    disp("Determine Transmission Time:");
    tix = frame_length_bytes*8/data_rate;
    fprintf("Tix = %d / %d = %d\n\n", frame_length_bytes*8, data_rate, tix);

    % Calculate Tack as time to tramsit and ACK Frame
    disp("Calculate Tack as time to tramsit and ACK Frame");
    tack = ack_frame_length_bytes*8/data_rate;
    fprintf("Tack = frame length bytes / data rate = %d / %d = %d\n\n", ack_frame_length_bytes*8, data_rate, tack);

    % RTT for IDLE RQ
    disp("RTT for IDLE RQ (Stop-and-Wait)");
    fprintf("RTT = 2TP + Tix + Taxk = 2*%d + %d + %d = %d\n\n", tp, tix, tack, (2*tp + tix + tack));

     % RTT for SelRQ
    disp("RTT for SelRQ");
    fprintf("RTT = 2TP + kTix + kTaxk = 2*%d + %d*%d + %d*%d = %d\n\n", tp, k, tix, k, tack, (2*tp + k*tix + k*tack));

    % Suggested Timeout
    disp("Suggested Timeout = 2.RTT");
    fprintf("IDLE RQ = 2*%d = %d\n", (2*tp + tix + tack), 2*(2*tp + tix + tack));
    fprintf("Sel RQ = 2*%d = %d\n", (2*tp + k*tix + k*tack), 2*(2*tp + k*tix + k*tack));
end
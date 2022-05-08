function throughput_analysis(tx_rate, packet_size, no_packets, aloha_type)
    tix = packet_size/tx_rate;
    fprintf("The packet tx time:\n Tix = %d/%d \n Tix = %d\n", packet_size, tx_rate, tix);
    g = no_packets*tix;
    fprintf("The average no. of packets attempting tx per sex is:\nG/Tix = %d\nG=%d*%d\nG=%d", no_packets, no_packets, tix, g);
    if aloha_type == "pure ALOHA"
        gamma = exp(-2*g);
        disp("For Pure ALOHA: γ = e^-((G/Tix)*2Tix) = e^-2G");
        fprintf("γ = e^(-2*%d)\nγ = %d\n", g, gamma);
    elseif aloha_type == "slotted ALOHA"
        gamma = exp(-g);
        disp("For Slotted ALOHA: γ = e^-((G/Tix)*Tix) = e^-G");
        fprintf("γ = e^(-%d)\nγ = %d\n", g, gamma);
    else
        disp("Error ALOHA incorrect");
        exit force
    end
    fprintf("Probability of a collision: 1 - γ = 1 - %d = %d\n", gamma, 1-gamma);
end
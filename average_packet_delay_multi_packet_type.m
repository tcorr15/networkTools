function average_packet_delay_multi_packet_type(packet_type_array, packet_percentage_array, packet_size_array_bytes, total_packets_per_second, data_rate)
    % Starting Information regarding packet splitting
    no_packet_types = numel(packet_percentage_array);
    fprintf("%d types of packets: %s", no_packet_types, packet_type_array(1));
    for i=2:no_packet_types
        fprintf(" + %s", packet_type_array(i));
    end
    fprintf("\nIn 1 second there are %d packets: ", total_packets_per_second);
    for i=1:no_packet_types
        fprintf("%d are %s, ", packet_percentage_array(i)*total_packets_per_second, packet_type_array(i));
    end
    fprintf("\nThe probability of each are: ");
    for i=1:no_packet_types
        fprintf("%s = %d, ", packet_type_array(i), packet_percentage_array(i));
    end
    fprintf("\n\n");


    % Calculate E[S^2]
    disp("Tw = λE[S^2] / 2(1-p)");
    disp("If λ = " + total_packets_per_second + " packets/sec");
    disp("E[S^2] = ΣPj*Sj^2");
    s_two = [];
    es_two = 0;
    es = 0;
    es_two_str = "E[S^2] = ";
    es_str = "E[S] = ";
    for i=1:no_packet_types
        s = packet_size_array_bytes(i)*8/data_rate;
        fprintf("S_%s = frame length / data rate = %d/%d = %d\n", packet_type_array(i), packet_size_array_bytes(i)*8, data_rate, s);
        s_two(i) = s^2;
        fprintf("S_%s^2 = %d\n", packet_type_array(i), s_two(i));
        es_two_str = strcat(es_two_str, (packet_percentage_array(i)+"*"+s_two(i)));
        es_str = strcat(es_str, (packet_percentage_array(i)+"*"+s));
        if i+1 <= no_packet_types
            es_two_str = strcat(es_two_str, " + ");
            es_str = strcat(es_str, " + ");
        end
        es_two = es_two + packet_percentage_array(i)*s_two(i);
        es = es + packet_percentage_array(i)*s;
    end
    disp(es_two_str);
    fprintf("E[S^2] = %d\n\n", es_two);

    % Calculate p
    disp("p = λ/u");
    disp("u = 1/Ts = 1/E[S] because E[S] is average service time");
    disp(es_str);
    fprintf("E[S] = %d\n", es);
    u = 1/es;
    fprintf("u = 1/E[S] = 1/%d = %d\n", es, u);
    p = total_packets_per_second/u;
    fprintf("p = λ/u = %d/%d = %d", total_packets_per_second, u, p);

    % Calculate Tw
    disp("Tw = λE[S^2] / 2(1-p)");
    tw = (total_packets_per_second*es_two)/(2*(1-p));
    fprintf("Tw = %d*%d / 2(1-%d) = %d\n\n", total_packets_per_second, es_two, p, tw);
end
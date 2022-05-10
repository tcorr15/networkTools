function fifty_coherence_bw(pr_array, t_array)
    % Calculate sum of powers
    disp("Calculate sum of powers");
    sum_powers = 0;
    fprintf("ΣP(ti) = ");
    for i=1:numel(pr_array)
        sum_powers = sum_powers + pr_array(i);
        fprintf("%d", pr_array(i));
        if i+1 < numel(pr_array)
            fprintf(" + ");
        end
    end
    fprintf("\nΣP(ti) = %d\n\n", sum_powers);

    % Calculate Mean Excess Delay
    disp("Calculate Mean Excess Delay");
    sum_powers_t = 0;
    fprintf("ΣP(ti)ti = ")
    for i=1:numel(pr_array)
        sum_powers_t = sum_powers_t + (pr_array(i)*t_array(i));
        fprintf("%d", (pr_array(i)*t_array(i)));
        if i+1 < numel(pr_array)
            fprintf(" + ");
        end
    end
    fprintf("\nΣP(ti)ti = %d\n", sum_powers_t);
    disp("τ = ΣP(ti)ti / ΣP(ti)");
    mean_excess_delay = sum_powers_t/sum_powers;
    fprintf("τ = %d / %d = %d usec\n\n", sum_powers_t, sum_powers, mean_excess_delay);

    % Calculate 2nd Order Moment
    disp("Calculate 2nd Order Moment");
    disp("τ^2 = ΣP(ti)ti^2 / ΣP(ti)");
    sum_powers_t_squared = 0;
    fprintf("ΣP(ti)ti^2 = ")
    for i=1:numel(pr_array)
        sum_powers_t_squared = sum_powers_t_squared + (pr_array(i)*(t_array(i)^2));
        fprintf("%d", (pr_array(i)*(t_array(i)^2)));
        if i+1 < numel(pr_array)
            fprintf(" + ");
        end
    end
    fprintf("\nΣP(ti)ti^2 = %d\n", sum_powers_t_squared);
    second_order_moment = sum_powers_t_squared/sum_powers;
    fprintf("τ^2 = ΣP(ti)ti^2 / ΣP(ti) = %d / %d = %d usec^2\n\n", sum_powers_t_squared, sum_powers, second_order_moment);

    % Calculate RMS Squared
    disp("Calculate RMS Squared");
    sigma_t = sqrt(second_order_moment - (mean_excess_delay^2));
    fprintf("σt = sqrt(τ^2 - (τ)^2) = sqrt(%d -%d^2) = %d usec\n\n", second_order_moment, mean_excess_delay, sigma_t);
    
    % Calculate Coherence BW
    disp("Calculate Coherence BW");
    b_l = 1/(5*(sigma_t*10^-6));
    fprintf("Bl = 1/5σt = 1/(5*%d) = %d Hz\n\n", sigma_t, b_l);
end
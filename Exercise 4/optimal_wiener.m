%% Optimal Wiener
function [x_hat, mse] = optimal_wiener(s, v, x, w, filter_length)
     % Find the autocorrelation
    for i = 1:filter_length
        V(i, :) = v(i:end-filter_length+i);
    end
    Rvv = V * V' / size(V, 2);

    % Find the cross-correlation
    for i = 1:filter_length
        rwv(i) = sum(v(filter_length - i + 1:end - i + 1) .* w(filter_length:end));
    end
    rwv = rwv / (size(v, 2) - filter_length + 1);

    % Wiener filter coefficients
    hW = Rvv \ rwv';

    % Apply to colored noise to make it white again
    w_hat = filter(hW, 1, v);

    % Calculate the Norm of the difference. This is what we want to minimize
    norm_diff = norm(w - w_hat);

    % Now we estimate the original signal
    x_hat = x - w_hat;

    % Mean Squared Error
    mse = immse(x, x_hat);

    % Plotting
    figure;
    subplot(131); plot(s); title('original');
    subplot(132); plot(x); title('Noisy');
    subplot(133); plot(x_hat); title('Filtered');
    

    figure;
    plot(w_hat);


    fprintf('Wiener filter length: %d\n', filter_length);
    fprintf('Norm of the difference: %f\n', norm_diff);
    fprintf('Mean Squared Error: %f\n', mse);
end
function BER = SIMO

% Taking Inputs from user
bits = input('Enter the number of bits: ');       % Number of bits in data
snr0 = input('Enter the initial SNR (Signal-to-Noise Ratio): ');      % Initial SNR (e.g., 0 dB)
snr1 = input('Enter the final SNR: ');        % Final SNR (e.g., 10 dB)

% Generate random data bits
x = round(rand(1, bits));     % Generating data bits
l = length(x);

% Modulation to NRZ BPSK
tx0 = (x < 1);
tx0 = sqrt(2) * (x - tx0);

% Initialize Bit Error Rate (BER) array
BER = zeros(1, snr1 - snr0 + 1);

% Loop through different SNR values
for i = snr0:snr1
    % Add AWGN noise to the transmitted signal
    Tx0 = awgn(tx0, i);
    Tx1 = awgn(tx0, i);
    
    % Receiver decision: Demodulate and threshold the received signal
    Rx = ((Tx0 + Tx1) > 0);
    
    % Calculate Bit Error Rate (BER) by comparing received data to original data
    ber = sum(xor(Rx, x));
    BER(i - snr0 + 1) = ber;
end

% Normalize BER by dividing by the number of bits
BER = BER / l;

% Plot the BER vs. SNR
semilogy(snr0:snr1, BER, '-^');
grid on;
legend('SIMO - AWGN')                        % Add legend for the plot
xlabel('SNR (dB)')                           % Label for the x-axis
ylabel('Bit Error Rate (BER)')               % Label for the y-axis
title('BER vs. SNR - Single Input Multiple Output AWGN')             % Title for the plot


end

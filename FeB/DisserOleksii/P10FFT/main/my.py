import os
import numpy as np
import scipy.fft as fft
import matplotlib.pyplot as plt

# List of file names for the time-dependent parameters
filename_list = ['Jsc14.dat', 'Eta14.dat', 'Voc14.dat', 'FF14.dat']

# Create the output directory if it doesn't exist
output_dir = './output_data'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

fig, axs = plt.subplots(len(filename_list), 1, figsize=(10, 6 * len(filename_list)))

for i, filename in enumerate(filename_list):
    # Load the data from the file with tab-separated values
    data = np.loadtxt(filename, delimiter='\t')
    time = data[:, 0]
    parameter = data[:, 1]

    # Perform the Fourier transform
    coefficients = fft.fft(parameter)

    # Compute the amplitudes and corresponding frequencies
    amplitude = np.abs(coefficients)
    frequency = np.fft.fftfreq(len(time), 100)

    # Filter only positive frequencies
    positive_indices = frequency >= 0
    frequency = frequency[positive_indices]
    amplitude = amplitude[positive_indices]

    # Save the frequency and amplitude columns to a file
    output_data = np.column_stack((frequency, amplitude))
    output_filename = os.path.join(output_dir, os.path.splitext(filename)[0] + '_FFT.dat')
    np.savetxt(output_filename, output_data, fmt='%s')

    # Plot the Fourier transform results
    axs[i].plot(frequency, amplitude)
    axs[i].set_ylabel('Amplitude')
    axs[i].set_xlabel('Frequency')
    axs[i].set_title(filename)

plt.tight_layout()
plt.show()
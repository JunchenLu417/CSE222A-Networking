import matplotlib.pyplot as plt
import pandas as pd

# Read data from CSV file
data = pd.read_csv('cwnd_log.csv', header=None, names=['Timestamp', 'CWND'])

# Extract CWND values
cwnd_values = data['CWND']

# Prepare time intervals
time_intervals = range(len(cwnd_values))

# Plot
plt.figure(figsize=(10, 6))
plt.plot(time_intervals, cwnd_values, linestyle="-", linewidth=1, label="Congestion Window")
plt.title("Congestion Window Over Time")
plt.xlabel("Time Intervals")
plt.ylabel("Congestion Window (Packets)")
plt.grid(True)
plt.legend()
plt.show()

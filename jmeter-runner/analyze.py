import pandas as pd

# Load the CSV file
df = pd.read_csv("results.jtl",low_memory=False)

# Calculate average response time
average_time = df['elapsed'].mean()
min_time = df['elapsed'].min()
max_time = df['elapsed'].max()

print(f" Average Response Time: {average_time} ms \n Min Response Time: {min_time} ms \n Max Response Time: {max_time} ms")
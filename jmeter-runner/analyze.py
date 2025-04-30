import pandas as pd

# Load the CSV file
df = pd.read_csv("results.jtl", low_memory=False)

# Calculate metrics
average_time = df['elapsed'].mean()
min_time = df['elapsed'].min()
max_time = df['elapsed'].max()
percentile_99 = df['elapsed'].quantile(0.99)

# Display results
print(f"Average Response Time: {average_time:.2f} ms")
print(f"Min Response Time: {min_time} ms")
print(f"Max Response Time: {max_time} ms")
print(f"99th Percentile Response Time: {percentile_99:.2f} ms")

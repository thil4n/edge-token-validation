import pandas as pd

# Load the CSV file
df = pd.read_csv("results.jtl",low_memory=False)

# Calculate average response time
average_time = df['elapsed'].mean()

print(f" Average Response Time: {average_time} ms")
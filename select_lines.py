import sys

# Load patterns from a query file
with open("data/to_select.tsv") as f:
    patterns = set(line.strip() for line in f)

# Read from stdin and output lines with matching patterns
for line in sys.stdin:
    if any(pattern in line for pattern in patterns):
        print(line, end="")


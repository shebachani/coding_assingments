import pandas as pd

def group_in_quantiles(data, num_quantiles):
    # Use pandas qcut to categorize the data into 'num_quantiles' quantiles
    quantiles, bins = pd.qcut(data, num_quantiles, labels=[f"q{i+1}" for i in range(num_quantiles)], retbins=True)

    # Output each value with its corresponding quantile and range
    for value, quantile, left, right in zip(data, quantiles, bins[:-1], bins[1:]):
        print(f"{value}\t{quantile}\t{quantile} ({left}, {right}]")

if __name__ == "__main__":
    # Ask the user for the number of quantiles
    while True:
        try:
            num_quantiles = int(input("Enter the number of quantiles: "))
            if num_quantiles <= 0:
                print("Please enter a positive integer.")
            else:
                break
        except ValueError:
            print("Error: The number of quantiles should be a valid integer.")
    
    # Ask for the input file or use stdin
    file_path = input("Enter the file path for input numbers (or press Enter to use stdin): ").strip()

    # Read numbers from file or stdin
    data = []
    if file_path:
        # Read numbers from the specified file
        try:
            with open(file_path, "r") as file:
                data = [int(line.strip()) for line in file.readlines()]
        except FileNotFoundError:
            print(f"Error: The file '{file_path}' was not found.")
            exit(1)
        except ValueError:
            print("Error: The file contains non-integer data.")
            exit(1)
    else:
        # Read numbers from stdin
        try:
            data = [int(line.strip()) for line in sys.stdin.readlines()]
        except ValueError:
            print("Error: Input contains non-integer data.")
            exit(1)

    # Call the function to group data into quantiles
    group_in_quantiles(data, num_quantiles)


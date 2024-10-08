import csv

def process_csv(input_file, output_file):
    x_ids = set()
    counter = 0
    with open(input_file, 'r') as csv_file, open(output_file, 'w') as out_file:
        csv_reader = csv.DictReader(csv_file)
        
        for row in csv_reader:
            token_id = row['tokenId']
            x_id = row['x_id']

            policy = row['policy']
            
            if policy not in ["anything", "anything!"]:
                print(f"Error: Invalid policy '{policy}' for tokenId {token_id}")
                continue
            
            if x_id in x_ids:
                print(f"Error: Duplicate x_id {x_id} for tokenId {token_id}")
                continue
            out_file.write(f"nftIds[{counter}] = {token_id};\n")
            counter += 1

    print(f"Processing complete. Results saved to {output_file}")

# Usage
input_file = 'result.csv'  # Replace with your input CSV file name
output_file = 'nft_ids.txt'

process_csv(input_file, output_file)
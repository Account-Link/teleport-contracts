import csv

minted_tokens = set()
burned_tokens = set()
token_id_to_tx_hash = dict()

with open("etherscan.csv", 'r') as file:
    csv_reader = csv.DictReader(file)
    for row in csv_reader:
        tx_hash = row['Transaction Hash']
        token_id = row['Token ID']
        to_address = row['To']
        token_id_to_tx_hash[token_id] = tx_hash

        if to_address == '0x0000000000000000000000000000000000000000':
            burned_tokens.add(token_id)
        else:
            minted_tokens.add(token_id)

remaining_tokens = minted_tokens - burned_tokens

# Create a list of tuples containing NFT ID and transaction hash
nft_data = [(nft_id, token_id_to_tx_hash[nft_id]) for nft_id in remaining_tokens]

# Save the data to a CSV file
output_file = 'nft_data.csv'
with open(output_file, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    
    # Write the header
    csv_writer.writerow(['nft_id', 'tx_hash'])
    
    # Write the data
    csv_writer.writerows(nft_data)

print(f"NFT data has been saved to {output_file}")

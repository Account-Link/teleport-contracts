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

# Sort remaining tokens
sorted_remaining_tokens = sorted(remaining_tokens, key=lambda x: int(x))

filtered_remaining_tokens = [token for token in sorted_remaining_tokens if int(token) >= 873]
sorted_remaining_tokens = filtered_remaining_tokens

# Check if the array only increases by 1
is_sequential = True
for i in range(1, len(sorted_remaining_tokens)):
    if int(sorted_remaining_tokens[i]) - int(sorted_remaining_tokens[i-1]) != 1:
        is_sequential = False
        print(f"Non-sequential tokens found: {sorted_remaining_tokens[i-1]} and {sorted_remaining_tokens[i]}")
        break

if is_sequential:
    print("All tokens are sequential, increasing by 1")
else:
    print("The array is not strictly increasing by 1")


# # Print the new total count of remaining tokens after filtering
# print(f"\nTotal remaining tokens after filtering (>= 873): {len(sorted_remaining_tokens)}")


# min_token_id = sorted_remaining_tokens[0]
# max_token_id = sorted_remaining_tokens[-1]

# print(len(sorted_remaining_tokens))
# print(int(max_token_id) - int(min_token_id))



# # Create a list of tuples containing NFT ID and transaction hash
# nft_data = [(nft_id, token_id_to_tx_hash[nft_id]) for nft_id in remaining_tokens]

# print(len(nft_data))
# # Get the min and max token_id of nft_data
# min_token_id = min(int(nft_id) for nft_id, _ in nft_data)
# max_token_id = max(int(nft_id) for nft_id, _ in nft_data)
# print(f"Minimum token ID: {min_token_id}")
# print(f"Maximum token ID: {max_token_id}")

# print(max_token_id - min_token_id )


# # Save the data to a CSV file
# output_file = 'nft_data.csv'
# with open(output_file, 'w', newline='') as csvfile:
#     csv_writer = csv.writer(csvfile)
    
#     # Write the header
#     csv_writer.writerow(['nft_id', 'tx_hash'])
    
#     # Write the data
#     csv_writer.writerows(nft_data)

# print(f"NFT data has been saved to {output_file}")

import csv

def process_csv(input_file):
    x_ids = set()
    with open(input_file, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)

        unique_nfts = []

        
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

            x_ids.add(x_id)
            unique_nfts.append({
                'tokenId': token_id,
                'x_id': x_id,
            })
        
        # Sort the unique NFTs by tokenId
        unique_nfts = sorted(unique_nfts, key=lambda x: int(x['tokenId']))
        return unique_nfts



# Usage
input_file = 'result.csv'  # Replace with your input CSV file name
output_file = 'nft_ids.txt'

nfts = process_csv(input_file)
# Write the NFT IDs and X IDs to separate output files
nft_ids_file = 'nft_ids.txt'
x_ids_file = 'x_ids.txt'

filtered_nfts = [nft for nft in nfts if int(nft['tokenId']) >= 873]
nfts = filtered_nfts

saved_x_ids = set()
with open('saved_x_ids', 'r') as f:
    for line in f:
        x_id = line.strip().rstrip('.user')
        saved_x_ids.add(x_id)

# Find and print x_ids in nfts that aren't in saved_x_ids
print("X IDs in nfts that are not in saved_x_ids:")
for nft in nfts:
    if nft['x_id'] not in saved_x_ids:
        print(nft['x_id'])


with open(nft_ids_file, 'w') as f_nft:
    f_nft.write("uint256[] memory nftIds = new uint256[](" + str(len(nfts)) + ");\n\n")
    for i, nft in enumerate(nfts):
        f_nft.write(f"nftIds[{i}] = {nft['tokenId']};\n")

with open(x_ids_file, 'w') as f_x:
    f_x.write("uint256[] memory xIds = new uint256[](" + str(len(nfts)) + ");\n\n")
    for i, nft in enumerate(nfts):
        f_x.write(f"xIds[{i}] = {nft['x_id']};\n")

print(f"NFT IDs have been written to {nft_ids_file}")
print(f"X IDs have been written to {x_ids_file}")


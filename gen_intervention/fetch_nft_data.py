import json
from web3 import Web3
from eth_abi.abi import decode
import csv
import pandas as pd
from tqdm import tqdm
import os


def get_transaction_logs(tx_hash):
    # Connect to an Ethereum node
    # Replace with your own node URL or Infura endpoint
    w3 = Web3(Web3.HTTPProvider(os.environ['RPC_URL']))

    # Check if connected
    if not w3.is_connected():
        print("Failed to connect to Ethereum node")
        return

    # Get transaction receipt
    tx_receipt = w3.eth.get_transaction_receipt(tx_hash)

    if tx_receipt is None:
        print(f"No receipt found for transaction {tx_hash}")
        return

    # Get the second log (index 1)
    if len(tx_receipt['logs']) < 2:
        print(f"Transaction {tx_hash} does not have a second log")
        return

    log = tx_receipt['logs'][1]

    # Event signature
    event_signature = 'NewTokenData(uint256,uint256,address,string)'
    event_signature_hash = Web3.keccak(text=event_signature).hex()

    # Check if the log matches the event signature
    if log['topics'][0].hex() != event_signature_hash:
        print(f"The second log does not match the NewTokenData event signature")
        return

    # Decode the log
    tokenId = int(log['topics'][1].hex(), 16)
    x_id = int(log['topics'][2].hex(), 16)
    to, policy = decode(['address', 'string'], log['data'])

    # Print decoded data
    print(f"Decoded NewTokenData event:")
    print(f"  tokenId: {tokenId}")
    print(f"  x_id: {x_id}")
    print(f"  to: {to}")
    print(f"  policy: {policy}")

    return {
        'tokenId': tokenId,
        'x_id': x_id,
        'policy': policy
    }

def process_all_transactions():
    # Read the CSV file
    df = pd.read_csv('nft_data.csv')

    # Prepare the output data
    output_data = []

    # Process each transaction
    for _, row in tqdm(df.iterrows(), total=df.shape[0], desc="Processing transactions"):
        tx_hash = row['tx_hash']
        nft_id = row['nft_id']
        
        try:
            result = get_transaction_logs(tx_hash)
            if result:
                result = {**result, 'nft_id': nft_id, 'tx_hash': tx_hash}
                output_data.append(result)
        except Exception as e:
            print(f"Error processing transaction {tx_hash}: {str(e)}")

    # Save the results to a new CSV file
    output_df = pd.DataFrame(output_data)
    output_df.to_csv('result.csv', index=False)
    print("Processing complete. Results saved to 'nft_data_processed.csv'")

if __name__ == "__main__":
    process_all_transactions()

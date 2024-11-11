// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./NFT.sol";

contract Minter {
    address public owner;
    NFT public nft;
    bool public hasMinted;

    constructor() {
        owner = msg.sender;
        nft = NFT(0xfEC74AF4494438F4950968b3CFc94762B777bbEe);
        hasMinted = false;
    }

    function mintAll() public {
        require(msg.sender == owner, "Only owner can mint");
        require(!hasMinted, "NFT has already been minted");
        bytes32[] memory hashes = nftHashes();
        for (uint256 i = 0; i < hashes.length; i++) {
            nft.mintTo(
                msg.sender,
                1853810993891041280,
                "cant be offensive, cant include url, cant be promotional, must start with OH:",
                "OH",
                "OverheardX",
                "https://pbs.twimg.com/profile_images/1853881838512525312/ZLzG_HBc_400x400.png",
                hashes[i],
                1
            );
        }
        hasMinted = true;
    }

    function nftHashes() public pure returns (bytes32[] memory) {
        bytes32[] memory hashes = new bytes32[](100);
        hashes[0] = bytes32(
            0x3e3984f04f9a83e58a4ad2c8ac12dbb6ecffb0e08a41acb895bfcdde4d367d17
        );
        hashes[1] = bytes32(
            0xb5a3a2f32d72d3ef8a8d77f62af22d7fd08e5aacce01c8832b65538527931b72
        );
        hashes[2] = bytes32(
            0x6deea2cde44b198c0a8feeb372503e45f6ba44ef14b4fbefb081e0269aad9efa
        );
        hashes[3] = bytes32(
            0xec1c55b4ae7a5226b381660898ce9f4456876ab51a587d8885855e566d122c10
        );
        hashes[4] = bytes32(
            0x684d06555873dae3d27568eb4a5d9c226a5b8c7742b1ac7eef33881d1dab58bf
        );
        hashes[5] = bytes32(
            0xc9ec9ff228838ee918c79274b28f082a05b5abfdbe3036ed2e0c12e98b38f538
        );
        hashes[6] = bytes32(
            0x4fcd3fad97e1d86b3b42ebd4da22d0dc6aa4045120f7474e9e620c04f8ee4152
        );
        hashes[7] = bytes32(
            0x440fdb441877dcb511d20db4e540f717e9a3210e2e85aba5c5410f3dd3681ff6
        );
        hashes[8] = bytes32(
            0x8c9d8bb11b472294dc71bb7376b22a792340c4f768dbcc7e2ced4f643e67f7e0
        );
        hashes[9] = bytes32(
            0xd9bae9ce153facd848cac14f7a1e3d236b4125492431366dbd8b9d33edfc957b
        );
        hashes[10] = bytes32(
            0xbc12bb107480a37f9955dcdddb5aa9263e9e0408fd0198d713df6a1a21ca6b83
        );
        hashes[11] = bytes32(
            0x61b2d9fe0140b1e76c178f43d6b47853b3d0f799651a58d1d49a6834377ee940
        );
        hashes[12] = bytes32(
            0x19725e1ee88a673f01e370fd60a2b5e447abfb62107c7959a0c89b7fb3a50916
        );
        hashes[13] = bytes32(
            0x9018d39815827ac0ee3e7b823e57763e81b94a36ae7d3aa9dd8fce22a21dadee
        );
        hashes[14] = bytes32(
            0xa9ee1c83f4b5f0453adaaea23b4bca6c1f667f7ce5a1ef2b014aac3e9ad3249d
        );
        hashes[15] = bytes32(
            0xf95b62630423e9967918e73230e8e37320c577f49ae151e99c5f17bb0eb4e133
        );
        hashes[16] = bytes32(
            0x87caafae7cfaf191d6d00100c1c8c30826cda0cb44150cda7823b5d3d7128849
        );
        hashes[17] = bytes32(
            0x15e1c3e063b7f4e203a4e123782406878c9cdbea4309358e3b832e697297c49f
        );
        hashes[18] = bytes32(
            0x0db74563549b222817402f359b2c1f6593903039b6ad0a737c5341a88502859d
        );
        hashes[19] = bytes32(
            0xbaf73fa6179efd507b72f29eb48a3050012037b1a50f55dd346618883865cfef
        );
        hashes[20] = bytes32(
            0x2be290c77a4fdfd3d026252ad74fa32b0daa0777c06113348669038a829d7d8b
        );
        hashes[21] = bytes32(
            0x0bc0eeb8b9910f76c2bbdc1e9debc12deac81a9fc4f92c289ae4d1cafd4101c1
        );
        hashes[22] = bytes32(
            0xe6b6b8b44fccb9c3197178c9b8ec036e51cf35fac6117726b8e7958e6d0ed41d
        );
        hashes[23] = bytes32(
            0x48387e27534054611521d3cf7af5d3ad27e910586f29d2328de833364a36eb97
        );
        hashes[24] = bytes32(
            0xe9985476028d28a62d9c58f46494c760aead4a72a807eb35501475530da4ba77
        );
        hashes[25] = bytes32(
            0xdb7235ea1c4099a8eff617cca94ccddd374498672f504760a6f16bec2d337e4d
        );
        hashes[26] = bytes32(
            0x9fdea68768a473584cbb0a0d520f57491b8fd5f9a9f61a87cfd22a1d305be82a
        );
        hashes[27] = bytes32(
            0x3b7d390ddfce49c200ebed64b4fd1ebf7dff2ba7e2bafd23f9562341e0d5de90
        );
        hashes[28] = bytes32(
            0xc2820838bff9055ffee13097a3ead7f23e359a4ffd685e75384bb826257d9f85
        );
        hashes[29] = bytes32(
            0x83d1fe295908580f4745e58677642582a979f349a4fdc92e499579eaa78ac290
        );
        hashes[30] = bytes32(
            0x4c63d66d5f500aebfc8b43ccde5fb8cf56d0ee9179ca9e147f9fc1782851545f
        );
        hashes[31] = bytes32(
            0xb1263e2305dd3ab0f680e2e839dbbedb8c365728695d372c803f341cd1805bb5
        );
        hashes[32] = bytes32(
            0x272a8d5ff0dd1b8cbba23a20cf303f9bef44f775cfb3989dcc99936dadd51ec4
        );
        hashes[33] = bytes32(
            0x2eca234d39805f103b0b77d091b12c5c5973f14469ea4bd68bde015324f0ef9a
        );
        hashes[34] = bytes32(
            0x429eb27770e125243c8d2fe0ae7430f5fba682b2795133bf13e6ae793111a937
        );
        hashes[35] = bytes32(
            0x0f2a6ddb80c76e366eb635f4865776a8cbbbee01ba5e3750e40677ab88633a15
        );
        hashes[36] = bytes32(
            0x1d6f147a3e076f4199530afc4bc0e6f6eb41c2d8ff37016fd80ca8d3fde9ea58
        );
        hashes[37] = bytes32(
            0x06f5020e4e3e3245b27438af614f13012df60dc55e7b16682832501126b920a6
        );
        hashes[38] = bytes32(
            0xd40ae9b4a65f07e43eb1f53d8a197c06756f2966bcb2b0c99f0d4688139bec37
        );
        hashes[39] = bytes32(
            0x5bc8941791c52eee1f12d28d4f8560c399a7c7831fdc5e96a763e6e9aaec5365
        );
        hashes[40] = bytes32(
            0xaf4cb6d8d97d2834eb6c7bb47bab6217fbcddd79c1b617c8e8bfc34b61d80700
        );
        hashes[41] = bytes32(
            0x926477fb9c9e6097e067990faba6488dd62c6bf515e47144a857b1fb00cfb75b
        );
        hashes[42] = bytes32(
            0x75822341874c68ec302db88fe9691ffb7a17292c376336311121d46f0c0226d8
        );
        hashes[43] = bytes32(
            0x9a620c3d6e3fe386de9be13445475cc57a5f26cd0d30103bd83e7e8224e71d27
        );
        hashes[44] = bytes32(
            0x7ddf5d7e7b9be0a7bdc8c25a419019a1811191a22b23143c72cd6c3f407dd582
        );
        hashes[45] = bytes32(
            0x8a0d458ac9cd0a8ad1acf0e754a82e4660a7edc3f308c386461a354f770c1645
        );
        hashes[46] = bytes32(
            0xf857c27e9b0c4639c4677fc2fe59064d1264ce748c75e1bc80e885359d86060b
        );
        hashes[47] = bytes32(
            0x3a7483edad6181b8913140aabcf36db91c36cde87d8ab46e59bead6005a45128
        );
        hashes[48] = bytes32(
            0xddcd9e504774634de048bf91b03b68144d6a3a2d8ea3ce3bffdbfd09662ccea5
        );
        hashes[49] = bytes32(
            0x233cedfe349da7c14690541e01caf7c9b69cfe4e57679325b93e4a6434885997
        );
        hashes[50] = bytes32(
            0x537fc3fcf96e6981d6a1cdbbe7b61d3e1c190c9687ee52b305e8d2a2349ba6c7
        );
        hashes[51] = bytes32(
            0x0bac222513abee91f7f99e2fe50aa7c6aeb8b2e5e19f3f1f8ec64b7b49d3123e
        );
        hashes[52] = bytes32(
            0xc69d2dc682f192d009f1f9716f948d3c8df683549ea5abe0eae384726392c58b
        );
        hashes[53] = bytes32(
            0x7c82d089cc822100c35ef9a9d510e3655463cb7727a057dc83bfce5dd8e8b737
        );
        hashes[54] = bytes32(
            0x9e965a5f8b9348e8c486689a85a5dd9315b45911819f0d095219e5ed669a34d2
        );
        hashes[55] = bytes32(
            0xa387e3cc52ba773ea9c9f396aca8b89d66cefc10c50bbe58a40ae3705e2fe9d1
        );
        hashes[56] = bytes32(
            0x1afae0e651fa601d6540d8b5add04b430e447b0cd1bf8b98b01af7980415d8f9
        );
        hashes[57] = bytes32(
            0xb3f60e19a2ade7551f7eeb7d7171e08609f60c4c6d63e22b01537a9737390c77
        );
        hashes[58] = bytes32(
            0x03839d4c6de5564a3ff552c6adcd7dbbc2dad4fa25add5986ae1786f82de7cab
        );
        hashes[59] = bytes32(
            0x9eecda09bfaa6c3987fc5733b5e3931ebcffc0082fefabbdb2d5944cddc21bc2
        );
        hashes[60] = bytes32(
            0x77eba0eeeff0d61107129d5da62982abfbcbc6eafdcbe1f6877130d8529fc335
        );
        hashes[61] = bytes32(
            0x27df2a91d93ba5f0d4637a36815276b75b742f39c447a8752049a5bfe2bff8ab
        );
        hashes[62] = bytes32(
            0xaefdcdaffc58ace89c2d259f80a4ee91dc8e4e7a359ff5c714aabe7e1f4b836a
        );
        hashes[63] = bytes32(
            0xe49a4a8b943cce20fcc1fcb75b270c3f1b09bf0821ea42a977f859c31da138fa
        );
        hashes[64] = bytes32(
            0x6e237458b30d61eae92278338199adcf07da9267d9e03f64bb29116e17a1003f
        );
        hashes[65] = bytes32(
            0x4b633d071f49b3dd265dfbe80b1472c9bc9438266a26dc35cfffebffc5caaf10
        );
        hashes[66] = bytes32(
            0x06fe5fe1476d48e5efce35b2886ce2b23a8178c546656ad0ee23c15c6e4b07d6
        );
        hashes[67] = bytes32(
            0x7764996d6fb3dc276ff73bc2c30bdc13ac8fb311497fc610ecbf1cfb83d248f4
        );
        hashes[68] = bytes32(
            0x0fd479bdf37674fa03571c564a19b014849638b6688b3791d4df4f8dc43aa039
        );
        hashes[69] = bytes32(
            0x39405f64be8dcd9ffb383a91de9be0f699e32091b39e29eab1b777ecf0e4891b
        );
        hashes[70] = bytes32(
            0xe51ba8c79a00ad15d2b51247770a1535a52e18732f9a45fc96daf777d4fa734b
        );
        hashes[71] = bytes32(
            0x25de1de432acab48557dd4f70036390a13650513b602d7990c48d4f6d0dde849
        );
        hashes[72] = bytes32(
            0xe91ff14768ee0f680fff4e7062927b3860342c6f2cf055d86b795f7051f20d71
        );
        hashes[73] = bytes32(
            0xb11f4d2585d7012abf4a8f7722dd5da3d7b3e2687e261be7a765b09eff248f23
        );
        hashes[74] = bytes32(
            0xe959110c8a9e3ac662307eb850800a42d4c89cc8555cbafd709c7d4d1ce528c4
        );
        hashes[75] = bytes32(
            0x96a31d16b393104f8d5283a0d857141b1ae22509c7187a996ee18ca41bdc5bf1
        );
        hashes[76] = bytes32(
            0x4353ba7fae3fb6098ec4a9fbeebaec156ea402c97ead7d8807e5b833a48af6c2
        );
        hashes[77] = bytes32(
            0x25407ee6fb7a56de2bdbf3520358e7dcb540a306f574b4ca00012d6ae2471e1b
        );
        hashes[78] = bytes32(
            0x082cfa1dd18a46a970f956b29d7fe1dcbce4a7971bdef7e34630c4850fed2833
        );
        hashes[79] = bytes32(
            0x68e27672973aa793e5de4b26001f7d2becebdcd1daf5437005f2aba48762a8ce
        );
        hashes[80] = bytes32(
            0x4cebe0d5ea19efe816c1e94fd7da3cda04032d92deb4deaa73d8abf04890c7c5
        );
        hashes[81] = bytes32(
            0x7658fff59afa8e7806615eeb71195d2f1e66f994e8cd17ddb7baf768a5abda3d
        );
        hashes[82] = bytes32(
            0x8c0d5daaa2ec4c78e1e2f406d69e3d75cbd5fa1eae7e0a660aec405353e8c109
        );
        hashes[83] = bytes32(
            0x1116964ea94662706e1d2aa54f563772be9f3b21db09e41360e66f0324d1669a
        );
        hashes[84] = bytes32(
            0x4a1695ce3848d956165fcb355e4a043ece3db088fbba74a8dc28c35712caf3dc
        );
        hashes[85] = bytes32(
            0x05917191e97f59782d848be9c2a61a24c6cb4b50140c867379b22ed76fbfafaa
        );
        hashes[86] = bytes32(
            0x1d0114dda5db20821c73fd8b51f4ab2f8b8b7f3bce61f9e5f30b56c3cf069467
        );
        hashes[87] = bytes32(
            0xdb4cbeb7813e3c57b3130b183b954c4907bc25b4232dcf8514ddd6778a406850
        );
        hashes[88] = bytes32(
            0x6b354b4427f193af137869d5b1085d4044a17661fe4aaac4bb768dd7105dcd55
        );
        hashes[89] = bytes32(
            0xe9c9fc5cc699516b57168f68a251a971be1a206d216df95edf6ff3c139ed5529
        );
        hashes[90] = bytes32(
            0x97afa46950968f157f8062c30c5c601174eae4ea1d268cbe159a4677ac387e35
        );
        hashes[91] = bytes32(
            0x4faad98c769ce902fdfb3181371706c13f1d10e1e02c06298ae74cffea5faa51
        );
        hashes[92] = bytes32(
            0x6284c523a655496fb7bd59fb98ee4cde2bde72e4b5b5d2956f14e2063c6186af
        );
        hashes[93] = bytes32(
            0x4adf2928983ec45afa9342dafe467367aa5e9ad7dba487df6ee6d733aff7241f
        );
        hashes[94] = bytes32(
            0x548ec974324807289e0a983fd0eb72e445b033f5ca05747196bbeb166c8395d3
        );
        hashes[95] = bytes32(
            0xc8a3b0d294b9aee68112db64c47c128a774130874ffb6997411f11ebb7a50959
        );
        hashes[96] = bytes32(
            0xe9ea0eedaf452b83916ec3f747bde8dab1069f0262ff863aa5712ab58ec587b3
        );
        hashes[97] = bytes32(
            0x7df3f1aa55fc436e6ecd1bb9f714b24197aa8ac517e7615fdbfeff6db9bf7915
        );
        hashes[98] = bytes32(
            0x984785a6dabaed0e6299164a99c95c7111890d1ada72a5477edea1ac01bc9f19
        );
        hashes[99] = bytes32(
            0x07a41075804cc9901bc0c57078cb1aa28217125fb70d2fb93b726a689a3d6cfa
        );
        return hashes;
    }
}

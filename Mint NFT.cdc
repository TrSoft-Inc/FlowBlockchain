import MyNFT from 0x9af2f3f3b56ce0e7
transaction(ipfsHash: String, name: String) {
prepare(acct: AuthAccount) {
	let collection = acct.borrow<&MyNFT.Collection>(from: /storage/MyNFTCollection)
						?? panic("This collection does not exist here")
	let nft <- MyNFT.createToken(ipfsHash: ipfsHash, metadata: {"name": name})
	collection.deposit(token: <- nft)
}
execute {
	log("NFT minted to user account")
}
}
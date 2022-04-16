import MyNFT from 0x9af2f3f3b56ce0e7
import NonFungibleToken from 0x1d7e57aa55817448
import FungibleToken from 0xf233dcee88fe0abe
import FlowToken from 0x1654653399040a61
transaction () {
prepare(acct: AuthAccount) {
	acct.save(<- MyNFT.createEmptyCollection(), to: /storage/MyNFTCollection)
	acct.link<&MyNFT.Collection{MyNFT.CollectionPublic, NonFungibleToken.CollectionPublic}>(/public/MyNFTCollection, target: /storage/MyNFTCollection)
	acct.link<&MyNFT.Collection>(/private/MyNFTCollection, target: /storage/MyNFTCollection)
	
	let MyNFTCollection = acct.getCapability<&MyNFT.Collection>(/private/MyNFTCollection)
	let FlowTokenVault = acct.getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)    
}
execute {
	log("User storage collection created inside their account")
}
}

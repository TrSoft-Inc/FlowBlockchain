import MyNFT from 0x9af2f3f3b56ce0e7
import NonFungibleToken from 0x631e88ae7f1d7c20
import FungibleToken from 0x9a0766d93b6608b7
import FlowToken from 0x7e60df042a9c0868
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
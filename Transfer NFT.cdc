import MyNFT from 0x9af2f3f3b56ce0e7
        import NonFungibleToken from 0x631e88ae7f1d7c20 
        transaction(account: Address, id: UInt64) {
    let transferToken: @NonFungibleToken.NFT

    prepare(acct: AuthAccount) {
        let collectionRef = acct.borrow<&NonFungibleToken.Collection>(from: /storage/MyNFTCollection)
            ?? panic("Could not borrow a reference to the owner's collection")
        self.transferToken <- collectionRef.withdraw(withdrawID: id)
    }

    execute {        
        let recipient = getAccount(account)

        let receiverRef = recipient.getCapability<&MyNFT.Collection{NonFungibleToken.CollectionPublic}>(/public/MyNFTCollection)
        .borrow()
        ?? panic("Could not borrow receiver reference")
        receiverRef.deposit(token: <-self.transferToken)
    }
}
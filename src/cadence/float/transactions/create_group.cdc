import FLOAT from "../FLOAT.cdc"

transaction(forHost: Address, groupName: String, image: String, description: String) {

  let FLOATEvents: &FLOAT.FLOATEvents

  prepare(acct: AuthAccount) {
    if forHost != acct.address {
      let FLOATEvents = acct.borrow<&FLOAT.FLOATEvents>(from: FLOAT.FLOATEventsStoragePath)
                        ?? panic("Could not borrow the FLOATEvents from the signer.")
      self.FLOATEvents = FLOATEvents.borrowSharedRef(fromHost: forHost)
    } else {
      self.FLOATEvents = acct.borrow<&FLOAT.FLOATEvents>(from: FLOAT.FLOATEventsStoragePath)
                        ?? panic("Could not borrow the FLOATEvents from the signer.")
    }
  }

  execute {
    self.FLOATEvents.createGroup(groupName: groupName, image: image, description: description)
    log("Created a new Group.")
  }
}
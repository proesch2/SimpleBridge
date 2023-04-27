# SimpleBridge
Simple practice project to learn how network bridges work and learn web2 components

Goals: Explore how listeners are used to move assets across different networks

Components:
- Bridge Contract: manage token circulation through mint/burn, emits events to listener to initiate transfer
- Token Contract: a basic ERC20 to transfer between networks
- Bridge Script: a listener script to faciliate token transfer (mint/burn)


State:
- Bridge contracts are deployed to respective networks (ETH and BSC)
- Token contracts owned by bridge to manage mint/burn on each network
- Bridge script owns bridge to call for minting of new tokens

Workflow:
1. User calls bridge `transfer` function
2. `Transfer` event is emitted to listener, tokens are burned on initial network
3. Listener responds to event by calling for mint on destination bridge
4. Address is minted tokens on destination network
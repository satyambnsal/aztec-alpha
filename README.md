# Alpha Workshops

This GitHub repo contains all the code from the Alpha Workshops (Youtube Videos)[https://youtu.be/T3l5ZAqjP4Y]
## How to use this repo

1. Clone the starter branch
```bash
git clone --single-branch --branch starter https://github.com/catmcgee/alpha-workshops.git
```

2. Follow the video of your choosing

3. End up with the code on the `main` branch!

## What is Alpha Workshops?

This series of workshops is part of the Aztec Alpha Program, a small group of developers that are building on the Aztec Sandbox. This program inludes various opportunities to get involved in Aztec as a developer, such as hackathons, exclusive content, opportunities for ambassadorship, and of course - alpha on Aztec.

If you're interested in joining, feel free to [reach out](mailto:cat@aztecprotocol.com)




## Aztec Sandbox Initial accounts

### Account 0
Address: 0x2aad072e38986954933be8f62fb51cdb4c379e9791ce80f548597aa4d306e0c5
Partial Address: 0x11442c343063d0d07f01061841211f7b0d26efd578faa86ab28cfa3bb5ab0990
Private Key: 0x2153536ff6628eee01cf4024889ff977a18d9fa61d0e414422f7681cf085c281
Public Key:0x27c20118733174347b8082f578a7d8fb84b3ad38be293715eee8119ee5cd8a6d0d6b7d8124b37359663e75bcd2756f544a93b821a06f8e33fba68cc8029794d9

### Account 1
Address: 0x228c470c8b03d24d56aa7f4525d776765de1f4ee94539a2bbf113d44e9b6d4ec
Partial Address: 0x1f93ef648b78572c49d6cb5b2f76d904789e1cc54b5e40610bd9363464f399f0
Private Key: 0x00aebd1b4be76efa44f5ee655c20bf9ea60f7ae44b9a7fd1fd9f189c7a0b0cda
Public Key: 0x08145e8e8d46f51cda8d4c9cad81920236366abeafb8d387002bad879a3e87a81570b04ac829e4c007141d856d5a36d3b9c464e0f3c1c99cdbadaa6bb93f3257


### Account 2
Address: 0x0024070f311728a0c4d8877bf5bdc722ed966944351c5392e980d61eac992dc7
Partial Address: 0x204b49223142fa5b16962394845e190ab5d73fce1e46ba4a90f67033feff0981
Private Key: 0x0f6addf0da06c33293df974a565b03d1ab096090d907d98055a8b7f4954e120c
Public Key: 0x13e6151ea8e7386a5e7c4c5221047bf73d0b1b7a2ad14d22b7f73e57c1fa00c614bc6da69da1b581b09ee6cdc195e5d58ae4dce01b63bbb744e58f03855a94dd

## Commands

Compile Aztec contract

```
aztec-nargo compile
```

Deploy Aztec contract
```
 aztec-cli deploy target/voting_contract-PrivateVoting.json --private-key 0x0f6addf0da06c33293df974a565b03d1ab096090d907d98055a8b7f4954e120c --args 0x0024070f311728a0c4d8877bf5bdc722ed966944351c5392e980d61eac992dc7
 ```


Call a method
```
aztec-cli call view_vote --contract-address 0x2c81be53966df0ec68d4302ca6038a090cdfd8813d43429fb3b382ad12b0e9aa --contract-artifact <artifact-path> --args 1
```


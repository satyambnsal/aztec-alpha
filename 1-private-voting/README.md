# Workshop 1: Private Voting Contract

To follow this workshop, checkout the `starter` branch and follow along with the video. 

Video link:

In this workshop, we will build an Aztec.nr smart contract that does this:

https://docs.aztec.network/assets/ideal-img/voting_flow.efdc610.1030.png

* The contract will be initialized with an admin, stored publicly
* A voter can vote privately, which will call a public function and update the votes publicly
* The admin can end the voting period, which is a public boolean
* To keep things simple, we won't create ballots or allow for delegate voting.

After completing this workshop, try the next one - a token smart contract + e2e testing with Aztec.js
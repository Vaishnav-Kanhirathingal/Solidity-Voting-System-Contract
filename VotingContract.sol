// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VotingContract {
    address[] addressStorage;

    uint256 partyOneVotes;
    uint256 partyTwoVotes;
    uint256 partyThreeVotes;

    constructor() {
        partyOneVotes = 0;
        partyTwoVotes = 0;
        partyThreeVotes = 0;
    }

    function registerVote(uint256 num) public {
        require(
            num < 4 && num > 0,
            "the given number is invalid as the number is out of range"
        );
        bool a = false;
        address messageSender = msg.sender;
        uint256 i;
        for (i = 0; i < addressStorage.length; i++) {
            if (messageSender == addressStorage[i]) {
                a = false;
                //set to false for testing purposes. This allows using the same account for multiple votes
            }
        }
        require(a == false, "Your vote has already been registered");
        addressStorage.push(messageSender);
        if (num == 1) {
            partyOneVotes++;
        } else if (num == 2) {
            partyTwoVotes++;
        } else {
            partyThreeVotes++;
        }
    }

    function getAddressValues() public view returns (address[] memory) {
        return addressStorage;
    }

    function getPartyOneVotes() public view returns (uint256){
        return partyOneVotes;
    }
    function getPartyTwoVotes() public view returns (uint256){
        return partyTwoVotes;
    }
    function getPartyThreeVotes() public view returns (uint256){
        return partyThreeVotes;
    }
    
}
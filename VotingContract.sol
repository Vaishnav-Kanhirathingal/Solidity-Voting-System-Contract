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

    //convertor-function-from-stack
    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    function getAddressValues() public view returns (address[] memory) {
        return addressStorage;
    }

    function getElectionDetails() public view returns (string memory) {
        string memory party1 = string(
            abi.encodePacked("[Party 1 Votes = ", uint2str(partyOneVotes),"]-----[")
        );
        string memory party2 = string(
            abi.encodePacked("Party 2 Votes = ", uint2str(partyTwoVotes),"]-----[")
        );
        string memory party3 = string(
            abi.encodePacked("Party 3 Votes = ", uint2str(partyThreeVotes),"]")
        );
        string memory returnable = string(
            abi.encodePacked(party1, party2, party3)
        );
        return returnable;
    }
}

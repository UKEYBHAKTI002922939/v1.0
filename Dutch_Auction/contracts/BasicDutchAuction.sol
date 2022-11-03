pragma solidity ^0.8.0;

contract DutchAuction {
    address payable owner;
    uint256 reservePrice;
    address judgeAddress;
    uint256 numBlocksActionOpen;
    uint256 offerPriceDecrement;
    uint blockStartNumber;
    address payable winner;
    uint winnerBid;
    bool endOfAuction;
    bool finalBid;

    constructor (uint256 _reserve_price, address _judge_address, uint256 _numBlocks_Auction_Open, uint256 _offer_price_decrement) public {
        reservePrice = _reserve_price;
        judgeAddress = _judge_address;
        numBlocksActionOpen = _numBlocks_Auction_Open;
        offerPriceDecrement = _offer_price_decrement;
        owner = payable(msg.sender);
        blockStartNumber = block.number;
    }

    function bid() public payable returns(address) {
        require(!endOfAuction);
        require(block.number < (blockStartNumber + numBlocksActionOpen));
        require(msg.value >= (reservePrice + (offerPriceDecrement * (blockStartNumber + numBlocksActionOpen - block.number))));

        endOfAuction = true;

        if(judgeAddress ==address(0x0)){
            owner.transfer(msg.value);
        }else{
            winner = payable(msg.sender);
            winnerBid = msg.value;
        }

    }

    function finalize() public {
        require(endOfAuction && !finalBid);
        require(msg.sender == judgeAddress || msg.sender == winner);
        finalBid = true;
        owner.transfer(winnerBid);
     
    }

    function refund(uint256 refundAmount) public {
        require(endOfAuction && !finalBid);
        finalBid = true;
        winner.transfer(refundAmount);
        
    }

    //for testing framework
    function nop() public returns(bool) {
        return true;
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

error NotOreOwner();

event BarForged(address barRecipient, uint256 barId, uint256 oreId1, uint256 oreId2);

contract Item2 is ERC721, ReentrancyGuard {

    address constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    uint256 private _nextTokenId;
    string private _baseUri;
    IERC721 public oreMirror;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseUri_,
        address _oreMirror
        ) ERC721(name, symbol) {
        oreMirror = IERC721(_oreMirror);
        _baseUri = baseUri_;
    }

    /**
     * @notice       - Forges a new ERC721 token from two underlying ORE tokens.
     *                 The caller must be the owner of both ORE tokens, and they will be burned.
     * @param oreId1 - The ID of the first ORE token
     * @param oreId2 - The ID of the second ORE token
     * @dev          - The ID of the new BarERC721 token will be what is mapped off chain
     *                 to the pre-determined combination of the two ORE tokens. 
     *                 Example: 
     *                   If the combination of ORE tokens 1 and 2 is pre-determined to be BAR A,
     *                   then the ID of the new BarERC721 token that is minted will be mapped 
     *                   to BAR A and stored off chain.     
     */
    function forge(uint256 oreId1, uint256 oreId2) external nonReentrant returns (uint256) {
        if (
            oreMirror.ownerOf(oreId1) != msg.sender || 
            oreMirror.ownerOf(oreId2) != msg.sender
        ) revert NotOreOwner();

        _nextTokenId += 1;

        oreMirror.safeTransferFrom(msg.sender, BURN_ADDRESS, oreId1);
        oreMirror.safeTransferFrom(msg.sender, BURN_ADDRESS, oreId2);

        _safeMint(msg.sender, _nextTokenId); 

        emit BarForged(msg.sender, _nextTokenId, oreId1, oreId2);
        return _nextTokenId;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseUri;
    }
}
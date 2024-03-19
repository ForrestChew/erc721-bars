// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {Test, console} from "forge-std/Test.sol";
import {Item2} from "../src/Item2.sol";
import "./Constants.t.sol"; 

contract Item2Test is Test, Constants {

    IERC721 public oreMirror;
    Item2 item;

    function setUp() public {
        vm.createSelectFork(BLAST_RPC_URL, BLAST_MAINNET_CHAIN_ID);

        oreMirror = IERC721(ORE_MIRROR);
        item = new Item2("Item2", "ITEM2", "https://example.com/", ORE_MIRROR);

        vm.prank(ORE_WHALE);
        oreMirror.setApprovalForAll(address(item), true);

        assertEq(oreMirror.isApprovedForAll(ORE_WHALE, address(item)), true);
    }

    function test_forge() public {
        uint256 oreId_1 = 1; 
        uint256 oreId_2 = 2;
        uint256 barId_1 = 1;

        assertEq(oreMirror.ownerOf(oreId_1), ORE_WHALE);
        assertEq(oreMirror.ownerOf(oreId_2), ORE_WHALE);

        vm.prank(ORE_WHALE);
        item.forge(oreId_1, oreId_2);

        assertEq(item.ownerOf(barId_1), ORE_WHALE);
        assertEq(item.tokenURI(barId_1), "https://example.com/1");

        assertEq(oreMirror.ownerOf(oreId_1), BURN_ADDRESS);
        assertEq(oreMirror.ownerOf(oreId_2), BURN_ADDRESS);
    }

    function test_forgeMultipleTokens() public {
        uint256 oreId_1 = 1; 
        uint256 oreId_2 = 2;
        uint256 oreId_3 = 3;
        uint256 oreId_4 = 4;

        uint256 barId_1 = 1;
        uint256 barId_2 = 2;

        assertEq(oreMirror.ownerOf(oreId_1), ORE_WHALE);
        assertEq(oreMirror.ownerOf(oreId_2), ORE_WHALE);
        assertEq(oreMirror.ownerOf(oreId_3), ORE_WHALE);
        assertEq(oreMirror.ownerOf(oreId_4), ORE_WHALE);

        vm.prank(ORE_WHALE);
        item.forge(oreId_1, oreId_2);

        assertEq(item.ownerOf(barId_1), ORE_WHALE);
        assertEq(item.tokenURI(barId_1), "https://example.com/1");
        assertEq(oreMirror.ownerOf(oreId_1), BURN_ADDRESS);
        assertEq(oreMirror.ownerOf(oreId_2), BURN_ADDRESS);

        vm.prank(ORE_WHALE);
        item.forge(oreId_3, oreId_4);

        assertEq(item.ownerOf(barId_2), ORE_WHALE);
        assertEq(item.tokenURI(barId_2), "https://example.com/2");
        assertEq(oreMirror.ownerOf(oreId_3), BURN_ADDRESS);
        assertEq(oreMirror.ownerOf(oreId_4), BURN_ADDRESS);
    }

    function test_forgeRevertNotOwnerOfBothInputs() public {
        uint256 oreId_1 = 1; 
        uint256 oreId_2 = 2;

        assertEq(oreMirror.ownerOf(oreId_1), ORE_WHALE);
        assertEq(oreMirror.ownerOf(oreId_2), ORE_WHALE);

        vm.prank(address(42069));
        vm.expectRevert();
        item.forge(oreId_1, oreId_2);

        assertEq(oreMirror.ownerOf(oreId_2), ORE_WHALE);
        assertEq(oreMirror.ownerOf(oreId_1), ORE_WHALE);
    }
}
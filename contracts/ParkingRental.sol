// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract ParkingRental {
    uint256 public spotCount;
    uint256 public bookingCount;
    uint256 public tokenIdCounter;

    // ====== Basic ERC721-like Storage ======
    string public name = "ParkingPass";
    string public symbol = "PARK";

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Zero address");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address _owner = _owners[tokenId];
        require(_owner != address(0), "Not minted");
        return _owner;
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "Zero address");
        require(_owners[tokenId] == address(0), "Already minted");

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    // ====== Parking Logic ======

    struct Spot {
        address owner;
        uint256 pricePerHour;
        bool available;
    }

    struct Booking {
        uint256 spotId;
        address renter;
        uint256 startTime;
        uint256 endTime;
        uint256 amountPaid;
        bool active;
    }

    mapping(uint256 => Spot) public spots;       // spotId → Spot
    mapping(uint256 => Booking) public bookings; // bookingId → Booking

    /// @notice List a parking spot with hourly rate
    function listSpot(uint256 _pricePerHour) external {
        spotCount++;
        spots[spotCount] = Spot(msg.sender, _pricePerHour, true);
    }

    /// @notice Rent a spot for specific hours
    function rentSpot(uint256 _spotId, uint256 _hours) external payable {
        Spot storage spot = spots[_spotId];
        require(spot.available, "Spot not available");

        uint256 cost = spot.pricePerHour * _hours;
        require(msg.value >= cost, "Insufficient payment");

        bookingCount++;
        uint256 bookingId = bookingCount;
        uint256 start = block.timestamp;
        uint256 end = start + (_hours * 1 hours);

        bookings[bookingId] = Booking(
            _spotId,
            msg.sender,
            start,
            end,
            cost,
            true
        );

        // Mint Parking Pass NFT
        tokenIdCounter++;
        _mint(msg.sender, tokenIdCounter);
    }

    /// @notice Release funds to spot owner after rental ends
    function releaseFunds(uint256 _bookingId) external {
        Booking storage b = bookings[_bookingId];
        Spot storage s = spots[b.spotId];

        require(block.timestamp >= b.endTime, "Rental still active");
        require(b.active, "Already settled");

        b.active = false;
        payable(s.owner).transfer(b.amountPaid);
    }

    /// @notice Cancel before start for refund
    function cancelBooking(uint256 _bookingId) external {
        Booking storage b = bookings[_bookingId];
        require(msg.sender == b.renter, "Not your booking");
        require(block.timestamp < b.startTime, "Already started");
        require(b.active, "Already inactive");

        b.active = false;
        payable(b.renter).transfer(b.amountPaid);
    }
}

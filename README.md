# Parking Space Rental Smart Contract

## 📌 Overview
 
The **Parking Space Rental Contract** is a decentralized system for managing parking spot rentals.  
It allows **owners** to list their parking spaces on-chain and **renters** to book them for a specified number of hours by paying in cryptocurrency.

Each successful rental generates an **NFT Parking Pass**, which acts as digital proof of reservation.  
Funds are locked in the contract during the booking period and are automatically released to the owner once the rental ends.
  
---      
     
## ❓ Why Build This?      
     
### 🔹 Current Problems in Parking Rentals  

- ❌ Double-booking due to poor coordination 
- ❌ No transparency in pricing or payment handling
- ❌ Disputes between renters & owners (late arrivals, cancellations)
- ❌ Middlemen platforms charge high fees

### 🔹 Blockchain Solution

The Parking Rental Contract provides:

1. **Trustless Payments** → Renters deposit funds in a smart contract; owners get paid automatically after rental ends.
2. **NFT Proof of Booking** → Each rental generates a unique pass (NFT) that acts as a digital ticket.
3. **Transparency** → Availability, rates, and transactions are fully on-chain.
4. **Refund Guarantee** → Renters can cancel before the rental starts and get refunded.
5. **Global Access** → Anyone with crypto can book a spot, no centralized authority required.

---

## ⚙️ How It Works

1. **Spot Listing**

   - Owners register their parking spot.
   - Define an hourly price and mark it as available.

2. **Booking a Spot**

   - Renter selects a spot and specifies rental duration (hours).
   - Payment is sent to the smart contract.
   - Booking details (start time, end time, renter info) are stored on-chain.

3. **NFT Parking Pass**

   - An NFT is minted to the renter as proof of booking.
   - The NFT can be used for verification (e.g., QR code at the gate).

4. **Funds Handling**

   - Payment stays locked in the contract during rental.
   - After the rental ends, the owner can withdraw funds.

5. **Refunds**
   - If renter cancels before the rental begins, the contract automatically refunds them.

---

## 🔑 Core Features

- ✅ **Spot Listing System** → Owners can create listings with pricing.
- ✅ **Booking & Payment** → Renters pay ETH for their chosen rental time.
- ✅ **NFT Pass** → Each rental issues a Parking Pass NFT.
- ✅ **Time-Locked Escrow** → Funds only released after rental ends.
- ✅ **Refunds** → Full refund if canceled before rental starts.

---

## 🛠️ Tech Stack

- **Solidity (0.8.x)** → Smart contract logic
- **Minimal ERC721 Implementation** → NFT Parking Pass (without imports)

---

## 📜 License

This project is released under the **MIT License**.

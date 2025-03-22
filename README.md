# R&C Bolt Modulator mod

Ratchet & Clank mod for RaCMAN: Modifies the amount of bolts earned and spent by different factors, positive or negative. You can optionally receive a starting amount too.

## Pre-requisites

- A Homebrew Enabled (HEN) PS3
  - There are guides available online
  - The RPCS3 Emulator is not tested
- [RaCMAN](https://github.com/MichaelRelaxen/racman) installed
- A digital PAL PS3 version of one of the compatible R&C games

## Installing the mod

### Option 1: copying the files

1. Download the zip file(s) on the Releases section
2. Open the `mods` folder in the RaCMAN folder
3. Place each mod folder inside the corresponding game's folder
   - R&C1 is `NPEA00385`
   - R&C2 is `NPEA00386`
   - R&C3 is `NPEA00387`

### Option 2: in RaCMAN

1. Download the zip file(s) on the Releases section
2. Open the desired game on PS3
3. Run RaCMAN
4. Connect RaCMAN to console or emulator
5. Open `Menu` -> `Patch loader...`
6. Click `Add ZIP...` and browse the downloaded zip
7. Repeat from step 2 for any other games

## Configuring mod options

1. Open the mod folder once installed in RaCMAN
2. Open the `config.lua` file in a text editor
3. Change the parameters to your liking
   - `boltGainFactor`: The multiplier for bolts earned. Vanilla is 1. It can be over 1 to earn more bolts than usual, between 0 and 1 to earn a fraction of what you would receive, or negative to subtract bolts when you collect them.
   - `boltLossFactor`: The multiplier for bolts spent. Vanilla is 1. It can be over 1 to pay more bolts than usual, between 1 and 0 to pay a fraction of what you would spend, or negative to get bolts when you spend them.
   - `initialBolts`: The amount you receive when the mod is loaded. Vanilla is 0. It can be positive, useful when gain factor < 1 or loss factor > 1 (especially when gain < 0 and loss > 0, or you will have no bolts ever!), or negative, to give you a handicap at the start.
   - `avoidRyno` (only for R&C1-2): A boolean (true/false) to cap your bolts at 149,999 on Rilgar or 999,999 on Barlow, to ensure you cannot buy the RYNO early. The bolts will be added back when leaving the planet, and the effect will be cleared when reaching the final level.
   - `unloadRollback`: 	A boolean (true/false) to revert all mod effects when it is unloaded, taking back the initial amount and giving the result of earning/spending bolts in vanilla.

## Running the mod

1. Configure the mod to your liking
2. Open the desired game on PS3
3. Run RaCMAN
4. Connect RaCMAN to console or emulator
5. Open `Menu` -> `Patch loader...`
6. Start a game (mod will not start correctly in the main menu)
7. Select the checkbox of the mod on the list
8. Enjoy!

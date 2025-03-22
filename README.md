# R&C Bolt Modulator mod

Ratchet & Clank mod for RACMAN: Modifies the amount of bolts earned and spent by different factors, positive or negative. You can optionally receive a starting amount too.

## Pre-requisites

- A Homebrew Enabled (HEN) PS3
  - There are guides available online
  - The RPCS3 Emulator should work, but is not tested
- [RaCMAN](https://github.com/MichaelRelaxen/racman) installed

## Installing the mod

### Option 1: copying the files

1. Download the zip file(s) on the Releases section
2. Open the `mods` folder in the RaCMAN folder
3. Place the mod folder inside the corresponding game's folder
   - R&C1 is `NPEA00385`
   - R&C2 is `NPEA00386`
   - R&C3 is `NPEA00387`

### Option 2: in RaCMAN

1. Download the zip file(s) on the Releases section
2. Open the desired game on PS3 or RPCS3
3. Run RaCMAN
4. Connect RaCMAN to console or emulator
5. Open `Menu` -> `Patch Loader...`
6. Click `Install mod` and browse the downloaded zip
7. Repeat from step 2 for other games

## Changing mod settings

1. Open the mod folder once installed in RaCMAN
2. Open the `config.lua` file in a text editor
3. Change the parameters to your liking
   - `boltGainFactor`
   - `boltLossFactor`
   - `initialBolts`
   - `avoidRyno` (only for R&C2)
   - `unloadRollback`

## Running the mod

1. Configure the mod to your liking
2. Open the desired game on PS3 or RPCS3
3. Run RaCMAN
4. Connect RaCMAN to console or emulator
5. Open `Menu` -> `Patch Loader...`
6. Select the checkbox of the mod on the list

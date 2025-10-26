# R&C Bolt Modulator mod

Ratchet & Clank mod for RaCMAN: Modifies the amount of bolts earned and spent by different factors, positive or negative. You can optionally receive a starting amount too.

Use the mod to make all different kinds of challenge runs, like:
- Inflation mode: regular bolt gains but increased spendings!
- Taxes mode: a cut of your earnings gets taken away, or things cost a bit more than the price label!
- Money bleed: start with a set amount and every bolt you get actually subtracts from the total!

**Disclaimer:** This mod doesn't change actual in-game prices, it only affects bolt changes and applies the multipliers after the fact (the vanilla difference). This means items will still have their original costs even if you set a loss multiplier of 2x or 0.1x, and you will end up with negative bolts if you didn't have enough for the modulated amount, or will be paid back after the purchase, but you will get the item if you have the vanilla amount and purchase it. In these cases, the better option is usually adjusting the gain multiplier, so you get 0.5x or 10x the vanilla amount of bolts.
- Example 1: Plasma Coil and mod with 2x costs. You will be able to buy it and unlock it for 150k bolts, but if you had 200k in-game, you will be left with -100k bolts in your counter. A better option could be configuring 0.5x earnings, so the Plasma Coil costs 150k but you had to grind for what would've been 300k in vanilla.
- Example 2: RYNO II and 0.1x costs. You will still need 1M bolts to buy it in the first place, but you will immediately get 900k back. The better option would be configuring 10x earnings, so what would be 100k in vanilla already gets you to 1M bolts.

## Pre-requisites

- A Homebrew Enabled (HEN) PS3
  - There are guides available online
  - Other CFW or Jailbreaks might work but are not tested
  - The RPCS3 Emulator should also work
- [RaCMAN](https://github.com/MichaelRelaxen/racman) installed
- A digital PAL PS3 version of the compatible R&C games

## Installing the mod

### Option 1: copying the files

1. Download the zip file(s) on the [Releases](https://github.com/Alados5/rac_usa_healthcare/releases) section
2. Open the `mods` folder in the RaCMAN folder
3. Unzip the downloaded zip file(s)
4. Place each mod folder inside the corresponding game's folder
   - R&C1 is `NPEA00385`
   - R&C2 is `NPEA00386`
   - R&C3 is `NPEA00387`
   - RDL is `NPEA00423`

### Option 2: in RaCMAN

1. Download the zip file(s) on the [Releases](https://github.com/Alados5/rac_usa_healthcare/releases) section
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
   - `avoidRyno` (only for R&C1-2): A boolean (`true`/`false`) to cap your bolts at 149,999 on Rilgar or 999,999 on Barlow, to ensure you cannot buy the RYNO early. The bolts will be saved and added back when leaving the planet, and the cap will be cleared when reaching the final level.
   - `unloadRollback`: 	A boolean (`true`/`false`) to revert all mod effects when it is unloaded, taking back the initial amount and giving the result of earning/spending bolts in vanilla.

## Running the mod

1. Configure the mod to your liking
2. Open the desired game on PS3
3. Run RaCMAN
4. Connect RaCMAN to console or emulator
5. Open `Menu` -> `Patch loader...`
6. Start a game (mod will not start correctly in the main menu)
7. Select the checkbox of the mod on the list
8. Enjoy!

-----------------------------------
-- BOLT MODULATOR MOD BY ALADOS5 --
-----------------------------------

-- Change this configuration to your liking!
--[[
Examples:
- Inflation mode:
	boltGainFactor = 1,		boltLossFactor = 2,		initialBolts = 0
- Taxes mode:
	boltGainFactor = 0.8,	boltLossFactor = 1.2,	initialBolts = 0
- Money Bleed mode:
	boltGainFactor = -1,	boltLossFactor = 1,		initialBolts = 1000000
--]]

--[[
boltGainFactor
	The multiplier for bolts earned. Vanilla is 1.
	It can be over 1 to earn more bolts than usual,
	between 0 and 1 to earn a fraction of what you would receive,
	or negative to subtract bolts when you collect them!
--]]
boltGainFactor 	= -1

--[[
boltLossFactor:
	The multiplier for bolts spent. Vanilla is 1.
	It can be over 1 to pay more bolts than usual,
	between 1 and 0 to pay a fraction of what you would spend,
	or negative to get bolts when you spend them!
--]]
boltLossFactor  =  1

--[[
initialBolts
	The amount you receive when the mod is loaded. Vanilla is 0
	It can be positive, useful when gain factor < 1 or loss factor > 1
	(especially when gain < 0 and loss > 0, or you will have no bolts ever!),
	or negative, to give you a handicap at the start!
--]]
initialBolts 	=  500000

--[[
avoidRyno
	A boolean (true/false) to cap your bolts at 999,999 on Barlow,
	to ensure you cannot buy the RYNO II early.
	The bolts will be added back when leaving Barlow!
--]]
avoidRyno 		= true

--[[
unloadRollback
	A boolean (true/false) to revert all mod effects
	when it is unloaded, taking back the initial amount
	and giving the result of earning/spending bolts in vanilla.
--]]
unloadRollback	= false

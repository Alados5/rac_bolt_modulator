-----------------------------------
-- BOLT MODULATOR MOD BY ALADOS5 --
-----------------------------------

-- To customize the configuration parameters, check the config.lua file
-- This is the main code of the mod, if you find any bugs feel free to let me know!

require 'config'

function OnLoad()
	rynoPrice = 1000000
	rynoPlanet = 4
	finalPlanet = 20
	
	-- Add initial amount of bolts
	ratchet.bolts = ratchet.bolts + math.floor(initialBolts)
	
	-- Print info
	print("Adding "..math.floor(initialBolts).." bolts (initial amount)")
	print("Bolt gain factor: "..boltGainFactor.."x")
	print("Bolt loss factor: "..boltLossFactor.."x")
	if avoidRyno then
		print("Will cap bolts at "..(rynoPrice-1).." on Barlow (until Yeedil)")
	end
	if unloadRollback then
		print("Will roll back on unload")
	end
	
	currBolts = ratchet.bolts
	prevBolts = currBolts
	
	-- Track the cumulative difference to "vanilla bolts"
	boltsCumDiff = 0
	
	-- Initial logic to avoid RYNO
	boltBank = 0
	barlowBank = false
	if avoidRyno and game.planet == rynoPlanet and currBolts>rynoPrice then
		boltBank = currBolts - (rynoPrice-1)
		ratchet.bolts = rynoPrice-1
		barlowBank = true
		print("Avoiding RYNO II: Taken "..boltBank.." bolts")
	end
	
	print("Loaded!")
end

function OnTick(ticks)
	-- Detect bolt changes
	currBolts = ratchet.bolts
	deltaBolts = currBolts - prevBolts
	
	-- On bolt gains, revert and apply gain factor
	if deltaBolts > 0 then
		newDelta = math.floor(boltGainFactor*deltaBolts)
		ratchet.bolts = prevBolts + newDelta
		boltsCumDiff = boltsCumDiff + (deltaBolts-newDelta)
		currBolts = ratchet.bolts
	
	-- On bolt losses, revert and apply loss factor
	elseif deltaBolts < 0 then
		newDelta = math.floor(boltLossFactor*deltaBolts)
		ratchet.bolts = prevBolts + newDelta
		boltsCumDiff = boltsCumDiff + (deltaBolts-newDelta)
		currBolts = ratchet.bolts
		
	end
	
	-- Early RYNO avoidance: set bolts to 999999 if over 1M in Barlow
	if avoidRyno and game.planet == rynoPlanet and currBolts>rynoPrice then
		boltBank = boltBank + currBolts - (rynoPrice-1)
		ratchet.bolts = rynoPrice-1
		barlowBank = true
		print("Avoiding RYNO II: Taken "..boltBank.." bolts")
	end
	
	-- Out of Barlow: give money back
	if barlowBank and game.planet ~= rynoPlanet then
		ratchet.bolts = currBolts + boltBank
		print("Out of Barlow! Giving back "..boltBank.." bolts")
		boltBank = 0
		barlowBank = false
	end
	
	-- Reached Yeedil: stop avoiding RYNO II
	if game.planet == finalPlanet then
		avoidRyno = false
	end
	
	-- Update
	prevBolts = ratchet.bolts
end

function OnUnload()
	-- Subtract initial amount of bolts, give back bolt difference
	totalRollback = -math.floor(initialBolts) + boltsCumDiff + boltBank
	if unloadRollback then
		print("Adding "..(-math.floor(initialBolts)).." bolts (initial amount)")
		print("Adding "..boltsCumDiff.." bolts (cumulative difference)")
		print("Adding "..boltBank.." bolts (RYNO bank)")
		print("Total: "..totalRollback.." bolts")
		ratchet.bolts = currBolts + totalRollback
	else
		print("Total rollback was: "..totalRollback.." bolts (not applied)")
	end
	
	print("Unloaded!")
end

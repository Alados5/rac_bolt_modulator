-----------------------------------
-- BOLT MODULATOR MOD BY ALADOS5 --
-----------------------------------

-- To customize the configuration parameters, check the config.lua file
-- This is the main code of the mod, if you find any bugs feel free to let me know!

require 'config'

function OnLoad()
	rynoPrice = 150000
	rynoPlanet = 5
	finalPlanet = 18
	
	-- Add initial amount of bolts
	ratchet.bolts = ratchet.bolts + math.floor(initialBolts)
	
	-- Print info
	print("Adding "..math.floor(initialBolts).." bolts (initial amount)")
	print("Bolt gain factor: "..boltGainFactor.."x")
	print("Bolt loss factor: "..boltLossFactor.."x")
	if avoidRyno then
		print("Will cap bolts at "..(rynoPrice-1).." on Rilgar (until Veldin 2)")
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
	rynoBankOn = false
	if avoidRyno and game.planet == rynoPlanet and currBolts>rynoPrice then
		boltBank = currBolts - (rynoPrice-1)
		ratchet.bolts = rynoPrice-1
		rynoBankOn = true
		print("Avoiding RYNO: Taken "..boltBank.." bolts")
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
	
	-- Early RYNO avoidance: set bolts to 149999 if over 150k in Rilgar
	if avoidRyno and game.planet == rynoPlanet and currBolts>rynoPrice then
		boltBank = boltBank + currBolts - (rynoPrice-1)
		ratchet.bolts = rynoPrice-1
		rynoBankOn = true
		print("Avoiding RYNO: Taken "..boltBank.." bolts")
	end
	
	-- Out of Rilgar: give money back
	if rynoBankOn and game.planet ~= rynoPlanet then
		ratchet.bolts = currBolts + boltBank
		print("Out of Rilgar! Giving back "..boltBank.." bolts")
		boltBank = 0
		rynoBankOn = false
	end
	
	-- Reached Veldin 2: stop avoiding RYNO
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

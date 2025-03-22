-----------------------------------
-- BOLT MODULATOR MOD BY ALADOS5 --
-----------------------------------

-- To customize the configuration parameters, check the config.lua file
-- This is the main code of the mod, if you find any bugs feel free to let me know!

require 'config'

function OnLoad()
	-- Add initial amount of bolts
	ratchet.bolts = ratchet.bolts + math.floor(initialBolts)
	
	-- Print info
	print("Adding "..math.floor(initialBolts).." bolts (initial amount)")
	print("Bolt gain factor: "..boltGainFactor.."x")
	print("Bolt loss factor: "..boltLossFactor.."x")
	if unloadRollback then
		print("Will roll back on unload")
	end
	
	currBolts = ratchet.bolts
	prevBolts = currBolts
	
	-- Track the cumulative difference to "vanilla bolts"
	boltsCumDiff = 0
		
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
		
	-- Update
	prevBolts = ratchet.bolts
end

function OnUnload()
	-- Subtract initial amount of bolts, give back bolt difference
	totalRollback = -math.floor(initialBolts) + boltsCumDiff
	if unloadRollback then
		print("Adding "..(-math.floor(initialBolts)).." bolts (initial amount)")
		print("Adding "..boltsCumDiff.." bolts (cumulative difference)")
		print("Total: "..totalRollback.." bolts")
		ratchet.bolts = currBolts + totalRollback
	else
		print("Total rollback was: "..totalRollback.." bolts (not applied)")
	end
	
	print("Unloaded!")
end

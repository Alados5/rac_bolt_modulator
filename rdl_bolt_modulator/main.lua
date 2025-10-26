-----------------------------------
-- BOLT MODULATOR MOD BY ALADOS5 --
-----------------------------------

-- To customize the configuration parameters, check the config.lua file
-- This is the main code of the mod, if you find any bugs feel free to let me know!

require 'config'

boltsAddr = 0x009C32E8

-- Function to replace the missing ratchet.bolts variable
function ratchet_bolts(amount)
	if amount == nil then
		bolts = bytestoint(Ratchetron:ReadMemory(GAME_PID, boltsAddr, 4))
	else
		Ratchetron:WriteMemory(GAME_PID, boltsAddr, 4, inttobytes(amount, 4))
		bolts = amount
	end
	
	return bolts
end

function OnLoad()
	-- Add initial amount of bolts
	onLoadBolts = ratchet_bolts()
	ratchet_bolts(onLoadBolts + math.floor(initialBolts))
	
	-- Print info
	print("Adding "..math.floor(initialBolts).." bolts (initial amount)")
	print("Bolt gain factor: "..boltGainFactor.."x")
	print("Bolt loss factor: "..boltLossFactor.."x")
	if unloadRollback then
		print("Will roll back on unload")
	end
	
	currBolts = ratchet_bolts()
	prevBolts = currBolts
	
	-- Track the cumulative difference to "vanilla bolts"
	boltsCumDiff = 0
		
	print("Loaded!")
end

function OnTick(ticks)
	-- Detect bolt changes
	currBolts = ratchet_bolts()
	deltaBolts = currBolts - prevBolts
	
	-- On bolt gains, revert and apply gain factor
	if deltaBolts > 0 then
		newDelta = math.floor(boltGainFactor*deltaBolts)
		ratchet_bolts(prevBolts + newDelta)
		boltsCumDiff = boltsCumDiff + (deltaBolts-newDelta)
		currBolts = ratchet_bolts()
	
	-- On bolt losses, revert and apply loss factor
	elseif deltaBolts < 0 then
		newDelta = math.floor(boltLossFactor*deltaBolts)
		ratchet_bolts(prevBolts + newDelta)
		boltsCumDiff = boltsCumDiff + (deltaBolts-newDelta)
		currBolts = ratchet_bolts()
		
	end
		
	-- Update
	prevBolts = ratchet_bolts()
end

function OnUnload()
	-- Subtract initial amount of bolts, give back bolt difference
	totalRollback = -math.floor(initialBolts) + boltsCumDiff
	if unloadRollback then
		print("Adding "..(-math.floor(initialBolts)).." bolts (initial amount)")
		print("Adding "..boltsCumDiff.." bolts (cumulative difference)")
		print("Total: "..totalRollback.." bolts")
		ratchet_bolts(currBolts + totalRollback)
	else
		print("Total rollback was: "..totalRollback.." bolts (not applied)")
	end
	
	print("Unloaded!")
end

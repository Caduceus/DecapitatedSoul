function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	return demoneko.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
end

function onPrepareDeath(creature, lastHitKiller, mostDamageKiller)
	return demoneko.onPrepareDeath(creature, lastHitKiller, mostDamageKiller)
end
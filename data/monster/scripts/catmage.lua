function onCreatureAppear(self, creature) return false end
function onCreatureDisappear(self, creature) return false end
function onCreatureMove(self, creature, oldPosition, newPosition) return false end
function onCreatureSay(self, creature, type, message) return false end
function onThink(self, interval) return neko.onThink(self, interval) end
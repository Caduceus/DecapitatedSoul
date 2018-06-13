From 9063dccc1a8a730c6ffce6e78567e191e217be6e Mon Sep 17 00:00:00 2001
From: Ranieri Althoff <ranisalt@gmail.com>
Date: Mon, 1 Jun 2015 02:52:35 -0300
Subject: [PATCH] Fix offline traning ignoring skill/magic rate

---
 src/player.cpp | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/player.cpp b/src/player.cpp
index 82425d7..0b3c543 100644
--- a/src/player.cpp
+++ b/src/player.cpp
@@ -1236,20 +1236,20 @@ void Player::onCreatureAppear(Creature* creature, bool isLogin)
 					bool sendUpdateSkills = false;
 					if (offlineTrainingSkill == SKILL_CLUB || offlineTrainingSkill == SKILL_SWORD || offlineTrainingSkill == SKILL_AXE) {
 						float modifier = topVocation->getAttackSpeed() / 1000.f;
-						sendUpdateSkills = addOfflineTrainingTries(static_cast<skills_t>(offlineTrainingSkill), (trainingTime / modifier) / 2);
+						sendUpdateSkills = addOfflineTrainingTries(static_cast<skills_t>(offlineTrainingSkill), g_config.getNumber(ConfigManager::RATE_SKILL) * (trainingTime / modifier) / 2);
 					} else if (offlineTrainingSkill == SKILL_DISTANCE) {
 						float modifier = topVocation->getAttackSpeed() / 1000.f;
-						sendUpdateSkills = addOfflineTrainingTries(static_cast<skills_t>(offlineTrainingSkill), (trainingTime / modifier) / 4);
+						sendUpdateSkills = addOfflineTrainingTries(static_cast<skills_t>(offlineTrainingSkill), g_config.getNumber(ConfigManager::RATE_SKILL) * (trainingTime / modifier) / 4);
 					} else if (offlineTrainingSkill == SKILL_MAGLEVEL) {
 						int32_t gainTicks = topVocation->getManaGainTicks() * 2;
 						if (gainTicks == 0) {
 							gainTicks = 1;
 						}
 
-						addOfflineTrainingTries(SKILL_MAGLEVEL, trainingTime * (static_cast<double>(vocation->getManaGainAmount()) / gainTicks));
+						addOfflineTrainingTries(SKILL_MAGLEVEL, g_config.getNumber(ConfigManager::RATE_MAGIC) * trainingTime * (static_cast<double>(vocation->getManaGainAmount()) / gainTicks));
 					}
 
-					if (addOfflineTrainingTries(SKILL_SHIELD, trainingTime / 4) || sendUpdateSkills) {
+					if (addOfflineTrainingTries(SKILL_SHIELD, g_config.getNumber(ConfigManager::RATE_SKILL) * trainingTime / 4) || sendUpdateSkills) {
 						sendSkills();
 					}
 				}
-- 
2.4.2



INSERT INTO `players` VALUES (660, 'Golden Child', 1, 7, 48, 10, 1050, 875, 1626672, 62, 84, 60, 79, 134, 3, 23, 876, 730, 72730, 200, 1, 1081, 989, 8, 0x010004000002FFFFFFFF03307500001A001B00000000FE, 2200, 1, 1528602242, 2329780760, 1, 0, 0, 1528523195, 31, 2147483647, 0, 114507, 43200, -1, 2520, 10, 0, 82, 40257, 10, 0, 80, 10100, 10, 0, 74, 34876, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0);

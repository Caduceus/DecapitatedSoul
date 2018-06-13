/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2016  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef FS_ITEMS_H_4E2221634ABA45FE85BA50F710669B3C
#define FS_ITEMS_H_4E2221634ABA45FE85BA50F710669B3C

#include "const.h"
#include "enums.h"
#include "itemloader.h"
#include "position.h"

enum SlotPositionBits : uint32_t {
	SLOTP_WHEREEVER = 0xFFFFFFFF,
	SLOTP_HEAD = 1 << 0,
	SLOTP_NECKLACE = 1 << 1,
	SLOTP_BACKPACK = 1 << 2,
	SLOTP_ARMOR = 1 << 3,
	SLOTP_RIGHT = 1 << 4,
	SLOTP_LEFT = 1 << 5,
	SLOTP_LEGS = 1 << 6,
	SLOTP_FEET = 1 << 7,
	SLOTP_RING = 1 << 8,
	SLOTP_AMMO = 1 << 9,
	SLOTP_DEPOT = 1 << 10,
	SLOTP_TWO_HAND = 1 << 11,
	SLOTP_HAND = (SLOTP_LEFT | SLOTP_RIGHT)
};

enum ItemTypes_t {
	ITEM_TYPE_NONE,
	ITEM_TYPE_DEPOT,
	ITEM_TYPE_MAILBOX,
	ITEM_TYPE_TRASHHOLDER,
	ITEM_TYPE_CONTAINER,
	ITEM_TYPE_DOOR,
	ITEM_TYPE_MAGICFIELD,
	ITEM_TYPE_TELEPORT,
	ITEM_TYPE_BED,
	ITEM_TYPE_KEY,
	ITEM_TYPE_RUNE,
	ITEM_TYPE_REWARDCHEST,
	ITEM_TYPE_LAST,
};

struct Abilities {
	Abilities() : stats(), statsPercent(), skills(), fieldAbsorbPercent(), absorbPercent() {
		elementType = COMBAT_NONE;
		elementDamage = 0;

		speed = 0;
		manaShield = false;
		invisible = false;
		regeneration = false;

		healthGain = 0;
		healthTicks = 0;
		manaGain = 0;
		manaTicks = 0;

		conditionImmunities = 0;
		conditionSuppressions = 0;
	}

	uint32_t healthGain;
	uint32_t healthTicks;
	uint32_t manaGain;
	uint32_t manaTicks;

	uint32_t conditionImmunities;
	uint32_t conditionSuppressions;

	//stats modifiers
	int32_t stats[STAT_LAST + 1];
	int32_t statsPercent[STAT_LAST + 1];

	//extra skill modifiers
	int32_t skills[SKILL_LAST + 1];

	int32_t speed;

	// field damage abilities modifiers
	int16_t fieldAbsorbPercent[COMBAT_COUNT];

	//damage abilities modifiers
	int16_t absorbPercent[COMBAT_COUNT];

	//elemental damage
	uint16_t elementDamage;
	CombatType_t elementType;

	bool manaShield;
	bool invisible;
	bool regeneration;
};

class ConditionDamage;

class ItemType
{
	public:
		ItemType();

		//non-copyable
		ItemType(const ItemType& other) = delete;
		ItemType& operator=(const ItemType& other) = delete;

		ItemType(ItemType&& other) = default;
		ItemType& operator=(ItemType&& other) = default;

		bool isGroundTile() const {
			return group == ITEM_GROUP_GROUND;
		}
		bool isContainer() const {
			return group == ITEM_GROUP_CONTAINER;
		}
		bool isSplash() const {
			return group == ITEM_GROUP_SPLASH;
		}
		bool isFluidContainer() const {
			return group == ITEM_GROUP_FLUID;
		}

		bool isDoor() const {
			return (type == ITEM_TYPE_DOOR);
		}
		bool isMagicField() const {
			return (type == ITEM_TYPE_MAGICFIELD);
		}
		bool isTeleport() const {
			return (type == ITEM_TYPE_TELEPORT);
		}
		bool isKey() const {
			return (type == ITEM_TYPE_KEY);
		}
		bool isDepot() const {
			return (type == ITEM_TYPE_DEPOT);
		}
		bool isRewardChest() const {
			return (type == ITEM_TYPE_REWARDCHEST);
		}
		bool isMailbox() const {
			return (type == ITEM_TYPE_MAILBOX);
		}
		bool isTrashHolder() const {
			return (type == ITEM_TYPE_TRASHHOLDER);
		}
		bool isBed() const {
			return (type == ITEM_TYPE_BED);
		}
		bool isRune() const {
			return type == ITEM_TYPE_RUNE;
		}
		bool hasSubType() const {
			return (isFluidContainer() || isSplash() || stackable || charges != 0);
		}

		Abilities& getAbilities() {
			if (!abilities) {
				abilities.reset(new Abilities());
			}
			return *abilities;
		}

		std::string getPluralName() const {
			if (!pluralName.empty()) {
				return pluralName;
			}

			if (showCount == 0) {
				return name;
			}

			std::string str;
			str.reserve(name.length() + 1);
			str.assign(name);
			str += 's';
			return str;
		}

		itemgroup_t group;
		ItemTypes_t type;
		uint16_t id;
		uint16_t clientId;
		bool stackable;
		bool isAnimation;

		std::string name;
		std::string article;
		std::string pluralName;
		std::string description;
		std::string runeSpellName;
		std::string vocationString;

		std::unique_ptr<Abilities> abilities;
		std::unique_ptr<ConditionDamage> conditionDamage;

		uint32_t weight = 0;
 		uint32_t levelDoor = 0;
 		uint32_t decayTime = 0;
 		uint32_t wieldInfo = 0;
 		uint32_t minReqLevel = 0;
 		uint32_t minReqMagicLevel = 0;
 		uint32_t charges = 0;
 		int32_t maxHitChance = -1;
 		int32_t decayTo = -1;
 		int32_t attack = 0;
 		int32_t defense = 0;
 		int32_t extraDefense = 0;
 		int32_t armor = 0;
 		int32_t runeMagLevel = 0;
 		int32_t runeLevel = 0;

		CombatType_t combatType;

		uint16_t transformToOnUse[2] = {0, 0};
 		uint16_t transformToFree = 0;
 		uint16_t destroyTo = 0;
 		uint16_t maxTextLen = 0;
 		uint16_t writeOnceItemId = 0;
 		uint16_t transformEquipTo = 0;
 		uint16_t transformDeEquipTo = 0;
 		uint16_t maxItems = 8;
 		uint16_t slotPosition = SLOTP_HAND;
 		uint16_t speed = 0;
 		uint16_t wareId = 0;
		uint16_t wrapTo = 0;
		uint16_t rotateTo = 0;

		MagicEffectClasses magicEffect;
		Direction bedPartnerDir;
		WeaponType_t weaponType;
		Ammo_t ammoType;
		ShootType_t shootType;
		RaceType_t corpseType;
		FluidTypes_t fluidSource;

		uint8_t floorChange;
		uint8_t alwaysOnTopOrder;
		uint8_t lightLevel;
		uint8_t lightColor;
		uint8_t shootRange;
		int8_t hitChance;

		bool forceUse = false;
		bool forceSerialize = false;
		bool hasHeight = false;
		bool walkStack = true;
		bool blockSolid = false;
		bool blockPickupable = false;
		bool blockProjectile = false;
		bool blockPathFind = false;
		bool allowPickupable = false;
		bool showDuration = false;
		bool showCharges = false;
		bool showAttributes = false;
		bool replaceable = true;
		bool pickupable = false;
		bool rotatable = false;
		bool useable = false;
		bool moveable = false;
		bool alwaysOnTop = false;
		bool canReadText = false;
		bool canWriteText = false;
		bool isVertical = false;
		bool isHorizontal = false;
		bool isHangable = false;
		bool allowDistRead = false;
		bool lookThrough = false;
		bool stopTime = false;
		bool showCount = true;
};

class Items
{
	public:
		Items();
		~Items();

		// non-copyable
		Items(const Items&) = delete;
		Items& operator=(const Items&) = delete;

		bool reload();
		void clear();

		FILELOADER_ERRORS loadFromOtb(const std::string& file);

		const ItemType& operator[](size_t id) const {
			return getItemType(id);
		}
		const ItemType& getItemType(size_t id) const;
		ItemType& getItemType(size_t id);
		const ItemType& getItemIdByClientId(uint16_t spriteId) const;

		uint16_t getItemIdByName(const std::string& name);

		static uint32_t dwMajorVersion;
		static uint32_t dwMinorVersion;
		static uint32_t dwBuildNumber;

		bool loadFromXml();
		void parseItemNode(const pugi::xml_node& itemNode, uint16_t id);

		inline size_t size() const {
			return items.size();
		}

	protected:
		std::map<uint16_t, uint16_t> reverseItemMap;
		std::vector<ItemType> items;
};
#endif

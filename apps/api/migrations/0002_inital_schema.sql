-- CreateTable
CREATE TABLE "UserRoll" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "User_role_fkey" FOREIGN KEY ("role") REFERENCES "UserRoll" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UnitTag" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "tagTypeId" INTEGER,
    "description" TEXT,
    CONSTRAINT "UnitTag_tagTypeId_fkey" FOREIGN KEY ("tagTypeId") REFERENCES "UnitType" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UnitTagged" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "unitId" TEXT NOT NULL,
    "tagId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "UnitTagged_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "UnitTagged_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "UnitTag" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UnitType" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "Unit" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "typeId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "parentId" TEXT,
    "flavorText" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Unit_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Unit" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Unit_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "UnitType" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MItemCategory" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "Item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "description" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Item_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "MItemCategory" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "EquipState" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "characterId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    CONSTRAINT "EquipState_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "EquipState_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MSkillType" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "SkillTag" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "AcqRoll" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "RSkillTagged" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "skillId" TEXT NOT NULL,
    "tagId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "RSkillTagged_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "Skill" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "RSkillTagged_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "SkillTag" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MSkillTiming" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "MSkillElement" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "RSkillHaveElement" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "skillId" TEXT NOT NULL,
    "elementId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "RSkillHaveElement_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "Skill" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "RSkillHaveElement_elementId_fkey" FOREIGN KEY ("elementId") REFERENCES "MSkillElement" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SkillTarget" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "SkillRange" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "SkillShape" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "CharacterParameter" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "SkillCost" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "parameterId" TEXT NOT NULL,
    "cost" INTEGER NOT NULL,
    "description" TEXT,
    CONSTRAINT "SkillCost_parameterId_fkey" FOREIGN KEY ("parameterId") REFERENCES "CharacterParameter" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MSkillCostType" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "RSkillCost" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "skillId" TEXT NOT NULL,
    "costId" TEXT NOT NULL,
    "costTypeId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "RSkillCost_costId_fkey" FOREIGN KEY ("costId") REFERENCES "SkillCost" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "RSkillCost_costTypeId_fkey" FOREIGN KEY ("costTypeId") REFERENCES "MSkillCostType" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "RSkillEvolution" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "baseSkillId" TEXT NOT NULL,
    "evolvedSkillId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "RSkillEvolution_baseSkillId_fkey" FOREIGN KEY ("baseSkillId") REFERENCES "Skill" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "RSkillEvolution_evolvedSkillId_fkey" FOREIGN KEY ("evolvedSkillId") REFERENCES "Skill" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Bookmark" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "characterId" TEXT NOT NULL,
    "skillId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Bookmark_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Bookmark_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "Skill" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Skill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "typeId" TEXT NOT NULL,
    "acqRollId" TEXT,
    "acqRollDifficulty" INTEGER,
    "prerequisiteDesc" TEXT,
    "restrictionDesc" TEXT,
    "timingId" TEXT,
    "magicGrade" INTEGER,
    "targetId" TEXT,
    "rangeId" TEXT,
    "shapeId" TEXT,
    "useRoll" TEXT,
    "effectDesc" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Skill_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "MSkillType" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Skill_acqRollId_fkey" FOREIGN KEY ("acqRollId") REFERENCES "AcqRoll" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Skill_timingId_fkey" FOREIGN KEY ("timingId") REFERENCES "MSkillTiming" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Skill_targetId_fkey" FOREIGN KEY ("targetId") REFERENCES "SkillTarget" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Skill_rangeId_fkey" FOREIGN KEY ("rangeId") REFERENCES "SkillRange" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Skill_shapeId_fkey" FOREIGN KEY ("shapeId") REFERENCES "SkillShape" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SkillAcqType" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "SkillAcqEvent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "skillId" TEXT NOT NULL,
    "acqTypeId" TEXT NOT NULL,
    "characterId" TEXT NOT NULL,
    "isAcqed" BOOLEAN NOT NULL,
    CONSTRAINT "SkillAcqEvent_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "Skill" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "SkillAcqEvent_acqTypeId_fkey" FOREIGN KEY ("acqTypeId") REFERENCES "SkillAcqType" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "SkillAcqEvent_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "GrowthEvent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "characterId" TEXT NOT NULL,
    "gradeDelta" INTEGER NOT NULL,
    "scienceDelta" INTEGER NOT NULL,
    "magicDelta" INTEGER NOT NULL,
    "battleDelta" INTEGER NOT NULL,
    "powerDelta" INTEGER NOT NULL,
    "mentalDelta" INTEGER NOT NULL,
    "physicalDelta" INTEGER NOT NULL,
    CONSTRAINT "GrowthEvent_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "GetItemEvent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "unitId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "buyPrice" INTEGER NOT NULL,
    "getNum" INTEGER NOT NULL,
    CONSTRAINT "GetItemEvent_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "GetItemEvent_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "GetMoneyEvent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "unitId" TEXT NOT NULL,
    "money" INTEGER NOT NULL,
    CONSTRAINT "GetMoneyEvent_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "GetExpEvent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "characterId" TEXT NOT NULL,
    "exp" INTEGER NOT NULL,
    CONSTRAINT "GetExpEvent_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MEventType" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "MEventLogActionType" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "EventLog" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "eventTypeId" INTEGER NOT NULL,
    "eventId" TEXT,
    "actionTypeId" INTEGER NOT NULL,
    "actorId" TEXT NOT NULL,
    "note" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "EventLog_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "MEventType" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "EventLog_actionTypeId_fkey" FOREIGN KEY ("actionTypeId") REFERENCES "MEventLogActionType" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "EventLog_actorId_fkey" FOREIGN KEY ("actorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Character" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "unitId" TEXT NOT NULL,
    "initGrade" INTEGER NOT NULL,
    "initScience" INTEGER NOT NULL,
    "initMagic" INTEGER NOT NULL,
    "initBattle" INTEGER NOT NULL,
    "initPower" INTEGER NOT NULL,
    "initMental" INTEGER NOT NULL,
    "initPhysical" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Character_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "Unit" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Character" ("id") SELECT "id" FROM "Character";
DROP TABLE "Character";
ALTER TABLE "new_Character" RENAME TO "Character";
CREATE UNIQUE INDEX "Character_unitId_key" ON "Character"("unitId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UnitTagged_unitId_tagId_key" ON "UnitTagged"("unitId", "tagId");

-- CreateIndex
CREATE UNIQUE INDEX "RSkillTagged_skillId_tagId_key" ON "RSkillTagged"("skillId", "tagId");

-- CreateIndex
CREATE UNIQUE INDEX "RSkillHaveElement_skillId_elementId_key" ON "RSkillHaveElement"("skillId", "elementId");

-- CreateIndex
CREATE UNIQUE INDEX "RSkillCost_skillId_costId_key" ON "RSkillCost"("skillId", "costId");

-- CreateIndex
CREATE UNIQUE INDEX "RSkillEvolution_baseSkillId_evolvedSkillId_key" ON "RSkillEvolution"("baseSkillId", "evolvedSkillId");

-- CreateIndex
CREATE UNIQUE INDEX "Bookmark_characterId_skillId_key" ON "Bookmark"("characterId", "skillId");



-- Migration number: 0001 	 2025-05-10T07:49:49.334Z
-- CreateTable
CREATE TABLE "Character" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "stats" JSONB NOT NULL
);



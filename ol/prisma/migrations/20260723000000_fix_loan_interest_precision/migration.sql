-- AlterTable: Increase interest_rate precision from Decimal(5,2) to Decimal(5,4)
-- This fixes the bug where rates like 0.008 and 0.005 were truncated to 0.01
ALTER TABLE "loans" ALTER COLUMN "interest_rate" SET DATA TYPE DECIMAL(5, 4);

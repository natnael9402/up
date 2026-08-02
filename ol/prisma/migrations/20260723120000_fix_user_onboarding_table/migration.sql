-- Reconcile the onboarding table with the Prisma schema mapping (@@map("user_onboarding")).
-- The original 20260706114709_add_user_onboarding migration created "user_onboardings" (plural),
-- which never matched the generated Prisma client (which targets "user_onboarding").

ALTER TABLE "user_onboardings" RENAME TO "user_onboarding";

-- Align columns with schema.prisma (all String? @db.VarChar(255))
ALTER TABLE "user_onboarding"
    ALTER COLUMN "income_source" TYPE VARCHAR(255),
    ALTER COLUMN "income_source" DROP NOT NULL,
    ALTER COLUMN "annual_income" TYPE VARCHAR(255),
    ALTER COLUMN "annual_income" DROP NOT NULL,
    ALTER COLUMN "employment_status" TYPE VARCHAR(255),
    ALTER COLUMN "employment_status" DROP NOT NULL,
    ALTER COLUMN "investment_goal" TYPE VARCHAR(255);

-- Rename auto-generated constraints/indexes to match the new table name
ALTER INDEX "user_onboardings_pkey" RENAME TO "user_onboarding_pkey";
ALTER INDEX "user_onboardings_user_id_key" RENAME TO "user_onboarding_user_id_key";
ALTER TABLE "user_onboarding" RENAME CONSTRAINT "user_onboardings_user_id_fkey" TO "user_onboarding_user_id_fkey";

-- Drop the redundant non-unique index (user_id already has a unique index)
DROP INDEX IF EXISTS "user_onboardings_user_id_idx";

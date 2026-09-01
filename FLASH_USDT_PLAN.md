# Flash USDT Feature — Implementation Plan

> **Scope:** Simulated blockchain transactions for test/demo purposes only.  
> **Warning:** The sent token has no backing and is strictly for testing.  
> **Backend:** `/ol`  ·  **Frontend:** `/platform/frontend`  ·  **Admin:** `/platform/zent_admin`

---

## 1. Overview

Flash USDT allows authenticated users to generate **simulated** USDT transfer records that appear in their transaction history with fake blockchain metadata (tx hash, block number, network, timestamp). These transactions:
- Do **not** affect real user balances.
- Are **visually tagged** as `TEST / SIMULATED` in every UI surface.
- Are stored in a dedicated table so they can be filtered, expired, or bulk-deleted by admins.
- Carry prominent warnings that the token has no backing.

---

## 2. Database Schema Changes

### 2.1 New Model: `FlashTransfer`

Add to `ol/src/generated/prisma/schema.prisma` (or the source Prisma file if it lives elsewhere):

```prisma
model FlashTransfer {
  id            BigInt   @id @default(autoincrement())
  user_id       BigInt
  amount        Decimal  @db.Decimal(15, 2)
  currency      String   @default("USDT") @db.VarChar(10)
  network       String   @db.VarChar(20)   // TRC20 | ERC20 | BEP20
  to_address    String   @db.VarChar(255)
  tx_hash       String   @unique @db.VarChar(255)  // simulated 66-char hex
  block_number  String   @db.VarChar(50)   // simulated block
  status        FlashTransferStatus @default(active)
  is_test       Boolean  @default(true)
  warning_seen  Boolean  @default(false)   // tracks if user acknowledged warning
  expires_at    DateTime? @db.Timestamp(0) // optional auto-expiry
  created_at    DateTime? @default(now()) @db.Timestamp(0)
  updated_at    DateTime? @updatedAt @db.Timestamp(0)

  user User @relation(fields: [user_id], references: [id], onDelete: Cascade)

  @@index([user_id, created_at])
  @@index([status])
  @@map("flash_transfers")
}

enum FlashTransferStatus {
  active
  expired
  revoked

  @@map("flash_transfers_status")
}
```

### 2.2 Regenerate Prisma Client

```bash
cd ol && npx prisma migrate dev --name add_flash_transfers
```

> The generated client is output to `ol/src/generated/prisma`, so after migration run `npx prisma generate` and ensure the new files are copied to `dist` during build.

---

## 3. Backend Changes (`/ol`)

### 3.1 New Module: `flash-transfer/`

Create four new files under `ol/src/flash-transfer/` (mirrors existing deposit/withdrawal pattern):

| File | Purpose |
|------|---------|
| `flash-transfer.controller.ts` | Express handlers: list, create, revoke, stats |
| `flash-transfer.service.ts` | Business logic + simulated tx hash generation |
| `flash-transfer.routes.ts` | Route definitions + Swagger docs |
| `flash-transfer.validation.ts` | `express-validator` rules |

#### 3.1.1 Service Logic (`flash-transfer.service.ts`)

Key behaviors:
- **createFlashTransfer(userId, payload)**
  - Validate payload (`amount > 0`, `network` in allowed list, `to_address` non-empty).
  - Generate simulated blockchain metadata:
    ```ts
    const txHash = '0x' + crypto.randomBytes(32).toString('hex');
    const blockNumber = String(Math.floor(18000000 + Math.random() * 5000000));
    ```
  - Set `expires_at = now() + 24 hours` (configurable).
  - Create `FlashTransfer` record. **Do not touch `User.balance` or `AccountBalance`.**
  - Return the record.
- **getFlashTransfers(userId, isAdmin, pagination)**
  - Admins see all; users see only their own.
  - Ordered by `created_at DESC`.
- **revokeFlashTransfer(flashId, adminId)**
  - Admin-only. Sets `status = revoked`.
- **expireStaleTransfers()**
  - Called by a lightweight cron or admin action. Updates `status = expired` where `expires_at < now()`.

#### 3.1.2 Controller Endpoints (`flash-transfer.routes.ts`)

| Method | Route | Auth | Description |
|--------|-------|------|-------------|
| `GET` | `/api/flash-transfers` | JWT | List user's flash transfers (admin = all) |
| `POST` | `/api/flash-transfers` | JWT | Create a new flash transfer |
| `DELETE` | `/api/flash-transfers/:id` | JWT | User deletes their own pending/active flash |
| `PATCH` | `/api/flash-transfers/:id/revoke` | Admin JWT | Admin revokes a flash transfer |

#### 3.1.3 Validation Rules (`flash-transfer.validation.ts`)

```ts
export const createFlashTransferValidator = [
  body('amount').isFloat({ min: 0.01 }).withMessage('Amount must be at least 0.01'),
  body('network').isIn(['TRC20', 'ERC20', 'BEP20']).withMessage('Invalid network'),
  body('toAddress').trim().notEmpty().withMessage('Recipient address is required'),
];
```

### 3.2 Wire Routes into App

In `ol/src/index.ts` (or `dist/index.js` post-build):

```ts
import flashTransferRoutes from './flash-transfer/flash-transfer.routes';
// ...
app.use('/api/flash-transfers', flashTransferRoutes);
```

### 3.3 Optional: Background Expiry Job

If you want automatic expiry, add a small cron in `ol/src/flash-transfer/jobs/flash-expiry.cron.ts`:

```ts
import cron from 'node-cron';
import { expireStaleTransfers } from '../flash-transfer.service';

// Run every hour
export function startFlashExpiryCron() {
  cron.schedule('0 * * * *', async () => {
    await expireStaleTransfers();
  });
}
```

Register it in `index.ts` alongside the existing `LoanScheduler`.

---

## 4. Frontend Changes (`/platform/frontend`)

### 4.1 API Client

Extend `platform/frontend/src/shared/api/wallet.api.ts`:

```ts
export const flashApi = {
  list: () =>
    http.get<{ data: FlashTransfer[]; pagination: any }>('/flash-transfers')
      .then((res: any) => res?.data ?? []),
  create: (payload: { amount: number; network: string; toAddress: string }) =>
    http.post<FlashTransfer>('/flash-transfers', payload),
  revoke: (id: number) =>
    http.delete(`/flash-transfers/${id}`),
};
```

Add `FlashTransfer` type to `platform/frontend/src/shared/types.ts`:

```ts
export interface FlashTransfer {
  id: number;
  amount: string;
  currency: string;
  network: string;
  toAddress: string;
  txHash: string;
  blockNumber: string;
  status: 'active' | 'expired' | 'revoked';
  isTest: boolean;
  createdAt: string;
  expiresAt?: string;
}
```

### 4.2 New UI Component: `FlashModal`

Create `platform/frontend/src/features/wallet/components/FlashModal.tsx`.

**Design requirements:**
1. **Warning Banner (non-dismissible):**  
   > ⚠️ **TEST ONLY — This token has no backing.** These transactions are simulated and do not represent real value on any blockchain.
2. **Form fields:**
   - Amount (USDT)
   - Network selector: TRC20 / ERC20 / BEP20
   - Recipient wallet address
3. **Checkbox:** "I understand this is a simulated transaction with no real value." (must be checked to submit).
4. **Result view:** After creation, show the simulated `txHash`, `blockNumber`, and a "Copy Hash" button.

### 4.3 Wallet Page Integration

In `platform/frontend/src/features/wallet/WalletPage.tsx`:

- Add a fourth button in `BalanceHeader` or below the existing Deposit / Withdraw / Transfer actions:  
  **"Flash USDT"** with an orange/amber warning color (not the primary green).
- Open `<FlashModal />` when clicked.
- Add a new filter tab in the transaction list: **"Simulated"** that fetches from `/flash-transfers`.

### 4.4 Transaction Row Badge

In `platform/frontend/src/features/wallet/components/WalletBits.tsx`, update `TransactionRow` (or add a new `FlashTransferRow`) to render:
- An **amber badge** reading `TEST`
- The simulated tx hash (truncated) with a copy button
- A tooltip: "This transaction is simulated and has no blockchain backing."

---

## 5. Admin Dashboard Changes (`/platform/zent_admin`)

### 5.1 New Page: `/flash-transfers`

Create `platform/zent_admin/src/app/flash-transfers/page.tsx`.

**Columns to display:**
- ID
- User (name + email)
- Amount
- Network
- To Address
- Tx Hash (copyable)
- Block Number
- Status (active / expired / revoked)
- Created At
- Actions: **Revoke** button

### 5.2 Admin API Hook

Extend `platform/zent_admin/src/lib/api.ts` with admin-scoped flash endpoints (reuses the same backend routes, since the backend already checks `req.user.role === 'admin'`).

### 5.3 Navigation Update

Add "Flash Transfers" to the admin sidebar nav alongside Deposits / Withdrawals.

---

## 6. Security & Safety Checklist

| Concern | Mitigation |
|---------|------------|
| **User confusion** | Flash UI is amber/orange themed (not green). Every surface shows `TEST` badge + warning banner. |
| **Balance manipulation** | Flash service **never** writes to `User.balance`, `AccountBalance`, or `Asset`. |
| **Fake tx hash collision** | Use `crypto.randomBytes(32)` (1 in 2^256 collision chance). |
| **Abuse / spam** | Rate-limit `POST /api/flash-transfers` to 5 per hour per user via existing `express-rate-limit`. |
| **Admin misuse** | `revoke` is admin-only. `delete` is owner-only. |
| **Legal / compliance** | Hard-coded `is_test = true` in DB. Warning text stored server-side so it cannot be bypassed by frontend tampering. |

---

## 7. Files to Create / Modify (Summary)

### Backend (`/ol`)

```
NEW   src/flash-transfer/flash-transfer.controller.ts
NEW   src/flash-transfer/flash-transfer.service.ts
NEW   src/flash-transfer/flash-transfer.routes.ts
NEW   src/flash-transfer/flash-transfer.validation.ts
NEW   src/flash-transfer/jobs/flash-expiry.cron.ts   (optional)
MOD   src/generated/prisma/schema.prisma
MOD   src/index.ts
```

### Frontend (`/platform/frontend`)

```
MOD   src/shared/api/wallet.api.ts
MOD   src/shared/types.ts
NEW   src/features/wallet/components/FlashModal.tsx
MOD   src/features/wallet/WalletPage.tsx
MOD   src/features/wallet/components/WalletBits.tsx
```

### Admin (`/platform/zent_admin`)

```
NEW   src/app/flash-transfers/page.tsx
MOD   src/lib/api.ts
MOD   src/components/app-shell.tsx   (add nav item)
```

---

## 8. Suggested Development Order

1. **Schema & Migration** — Add `FlashTransfer` model, run `prisma migrate dev`, verify generated client.
2. **Backend Core** — Implement service + controller + routes + validation.
3. **Backend Wiring** — Mount routes in `index.ts`, test endpoints with Postman/curl.
4. **Frontend API & Types** — Add `flashApi` and `FlashTransfer` type.
5. **Frontend UI** — Build `FlashModal`, integrate into `WalletPage`, style with amber warning theme.
6. **Admin Page** — Build table, connect to backend, add nav link.
7. **Polish** — Add rate limits, expiry cron, copy-to-clipboard, empty states, loading skeletons.

---

## 9. Testing Notes

- **Unit:** Test `generateSimulatedTxHash()` for uniqueness and format (`/^0x[a-f0-9]{64}$/`).
- **Integration:** Create flash transfer → verify `User.balance` unchanged → verify it appears in list → revoke from admin → verify status updated.
- **E2E (manual):** Open Flash modal → confirm warning checkbox is required → submit → copy tx hash → check admin table.

---

## 10. Future Enhancements (Out of Scope for v1)

- Real blockchain read-only verification (query a public node to confirm the tx hash does **not** exist).
- Configurable expiry duration per flash transfer.
- Bulk revoke from admin.
- Export flash transfer history to CSV.

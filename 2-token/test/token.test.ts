// const noteTypeId = new Fr(84114971101151129711410111011678111116101n); // TransparentNote
import { createAccount } from '@aztec/accounts/testing';
import {
  AccountWallet,
  CheatCodes,
  ExtendedNote,
  Fr,
  Note,
  PXE,
  computeMessageSecretHash,
  createPXEClient,
  waitForPXE,
} from '@aztec/aztec.js';
import { TokenContract } from './Token.js';

const { PXE_URL = 'http://localhost:8080', ETHEREUM_HOST = 'http://localhost:8545' } = process.env;

describe('Testing', () => {
  describe('on local sandbox', () => {
    beforeAll(async () => {
    });

    describe('token contract deployed to PXE', () => {
      let pxe: PXE;
      let owner: AccountWallet;
      let recipient: AccountWallet;
      let token: TokenContract;

      beforeEach(async () => {
      }, 60_000);

      it('increases recipient funds on mint', async () => {
      }, 30_000);
    });

    describe('cheats', () => {
      let pxe: PXE;
      let owner: AccountWallet;
      let cheats: CheatCodes;

      beforeAll(async () => {
      }, 30_000);

      it('warps time to 1h into the future', async () => {
      });
    });
  });
});
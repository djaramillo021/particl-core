// Copyright (c) 2017-2019 The Efin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef EFIN_WALLET_TEST_HDWALLET_TEST_FIXTURE_H
#define EFIN_WALLET_TEST_HDWALLET_TEST_FIXTURE_H

#include <test/setup_common.h>
#include <interfaces/chain.h>

class CHDWallet;

/** Testing setup and teardown for wallet.
 */
struct HDWalletTestingSetup: public TestingSetup {
    HDWalletTestingSetup(const std::string& chainName = CBaseChainParams::MAIN);
    ~HDWalletTestingSetup();

    std::unique_ptr<interfaces::Chain> m_chain = interfaces::MakeChain();
    std::unique_ptr<interfaces::ChainClient> m_chain_client = interfaces::MakeWalletClient(*m_chain, {});
    std::shared_ptr<CHDWallet> pwalletMain;
};

std::string StripQuotes(std::string s);

#endif // EFIN_WALLET_TEST_HDWALLET_TEST_FIXTURE_H


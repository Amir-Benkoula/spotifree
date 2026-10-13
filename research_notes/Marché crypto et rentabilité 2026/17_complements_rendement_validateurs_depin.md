# Compléments (2e passe) : rendements passifs, validateurs, DePIN, arnaques au minage — état au 13 octobre 2026

> **Research conditions (read first).**
> - This is a gap-filling pass after `08_rendement_passif_staking_defi.md` and `09_minage_validateurs_depin.md`. Those files were not edited.
> - Tools: WebSearch only (budget 22 calls, shared quota). WebFetch and direct curl are unavailable. **Every figure below comes from WebSearch result summaries and result titles/URLs, not from reading full pages.** I attribute a figure to a page only when its title clearly matches; otherwise the line says "reported by <outlet>" or "attribution uncertain".
> - Every figure carries a date. Anything older than ~3 months is labelled "historical context".
> - Section 10 states, for each first-pass lead I checked, whether it is **confirmed / corrected / not verified**.

<<S1>>

<<S2>>

<<S3>>

## 4. 2026 incidents hitting yield seekers (Kelp DAO, MetaMask staking, Q3 2026 hack totals)

### Takeaway
**Kelp DAO (18 Apr 2026)** was a cross-chain *bridge verification* failure, not a classic smart-contract bug. About **$292M** of rsETH was minted/drained, roughly 18% of rsETH supply (reported), and the attacker's use of rsETH as collateral on Aave V3 created an estimated **$124M–$230M** bad-debt risk for Aave (estimates, not settled). **MetaMask's staking incident (30 Sep–1 Oct 2026)** forced the exit of a reported ~17,000 validators; direct loss reported as tiny (~0.36 ETH of diverted block rewards), so it is an operational-risk event, not a loss event, for stakers. Q3 2026 hack totals: <<Q3TOTALS>>

### Cited Findings
#### Kelp DAO exploit (18 Apr 2026)
- **Size and date:** about **$292M** lost on 18 Apr 2026, "2026's biggest crypto exploit", with wrapped ether "stranded across 20 chains". The first-pass notes said $293M; sources give $292M (CoinDesk, OpenZeppelin headlines) and $293M (usethebitcoin.com). → **corrected to ~$292M (±$1M, rounding)**. — [CoinDesk, 19 Apr 2026](https://www.coindesk.com/tech/2026/04/19/2026-s-biggest-crypto-exploit-kelp-dao-hit-for-usd292-million-with-wrapped-ether-stranded-across-20-chains); [OpenZeppelin, "$292 Million Lost, Zero Bugs Found"](https://www.openzeppelin.com/news/lessons-from-kelpdao-hack); [usethebitcoin.com ($293M)](https://usethebitcoin.com/news/kelp-dao-293m-exploit/)
- **Share of supply:** the attacker took roughly **18% of rsETH's circulating supply** (reported in the search summary; the specific page is uncertain among Halborn, Genfinity and KuCoin). — [Halborn, "Explained: The Kelp DAO Hack"](https://www.halborn.com/blog/post/explained-the-kelp-dao-hack-april-2026); [Genfinity, 20 Apr 2026](https://genfinity.io/2026/04/20/kelp-dao-rseth-292-million-exploit-layerzero-bridge-defi-contagion/)
- **Mechanism (sources differ):** OpenZeppelin's headline says "zero bugs found" and the summary says every contract operated as designed. Per LayerZero (as reported), attackers **compromised two RPC nodes** used by LayerZero Labs' decentralised verifier network (DVN) and **DDoS'd the remaining clean nodes** to force failover to the poisoned ones, so a fake cross-chain message was accepted. — [OpenZeppelin](https://www.openzeppelin.com/news/lessons-from-kelpdao-hack); [Halborn](https://www.halborn.com/blog/post/explained-the-kelp-dao-hack-april-2026)
- **Blame:** LayerZero says Kelp's **1-of-1 DVN** configuration enabled the exploit; Kelp's memo reportedly says it followed LayerZero's documentation and default configuration. **LayerZero preliminarily linked the attack to North Korea's Lazarus Group.** — [The Block, 20 Apr 2026](https://www.theblock.co/news/defi/2026-04-20-kelp-dao-shifts-blame-layerzero-398204); [Blockhead, 20 Apr 2026](https://www.blockhead.co/2026/04/20/kelp-dao-loses-292m-in-largest-defi-exploit-of-2026-layerzero-attributes-attack-to-lazarus-group/)
- **Aave contagion:** the attacker used stolen rsETH as collateral on **Aave V3**. Bad-debt estimates vary by scenario: about **$124M** if losses were spread across all holders, about **$230M** if they stayed on Layer 2s, and **$196M** in another report. These are scenario estimates, not realized losses. — [CoinDesk, 20 Apr 2026, "Aave could face up to $230m in losses"](https://www.coindesk.com/tech/2026/04/20/aave-could-face-up-to-usd230-million-in-losses-after-kelp-dao-bridge-exploit-triggers-defi-chaos); [The Block, 20 Apr 2026](https://www.theblock.co/news/defi/2026-04-20-kelp-dao-shifts-blame-layerzero-398204)
- **Containment:** KelpDAO says it detected the exploit and blocked further activity within the hour. On **21 Apr 2026 Arbitrum's Security Council froze 30,766 ETH (~$71M)** of attacker funds, about 25% of the stolen amount per one source. — [Halborn](https://www.halborn.com/blog/post/explained-the-kelp-dao-hack-april-2026) / [KuCoin blog](https://www.kucoin.com/blog/kelpdao-hack-2026-rseth-exploit-analysis) (attribution uncertain)
- **Confirmation of a first-pass inference:** rsETH is Kelp DAO's liquid restaking token (ETH restaking via EigenLayer is its business); the coverage above treats the event as the "rsETH bridge exploit". → first-pass background claim **confirmed**. — [OpenZeppelin](https://www.openzeppelin.com/news/lessons-from-kelpdao-hack)
- **Peg/recovery:** the search returned **no definitive figure for rsETH's price or the peg recovery** after April. Not verified.

#### MetaMask staking incident (30 Sep–7 Oct 2026)
- **What happened:** MetaMask disclosed a security incident affecting part of its infrastructure on **30 Sep 2026** (some outlets say 1 Oct) and began exiting validators from its non-custodial staking business. The affected validators include ones it runs for Lido. **Lido expects the final affected validators to exit by 7 Oct**, but full withdrawals could take up to **45 days**; Lido says stETH holders need not act. — [Cryptonomist, 1 Oct 2026](https://en.cryptonomist.ch/2026/10/01/metamask-ethereum-validator-exit/); [Crowdfund Insider, Oct 2026](https://www.crowdfundinsider.com/2026/10/314982-metamask-exits-ethereum-eth-validators-after-infrastructure-incident-says-wallets-and-funds-were-not-at-risk/); [Vanderbilt Report](https://vanderbiltreport.com/metamask-staking-security-incident-lido-validators/)
- **Scale (unconfirmed by MetaMask):** about **17,000 validators / over 523,000 staked ETH**, from an independent researcher's estimate. — [KuCoin flash](https://www.kucoin.com/news/flash/metamask-security-incident-triggers-exit-of-17-000-ethereum-validators); [SimpleFX](https://simplefx.com/trading-news/metamask-pulls-17000-validators-after-security-breach)
- **Impact:** MetaMask says it found no immediate threat to its wallets and does not control clients' **withdrawal keys**, so it cannot move staked funds. On-chain analysis reportedly puts the **direct loss at about 0.36 ETH** of diverted block rewards. MetaMask had **not said how the attack happened or whether data was accessed** (as of the reports ~10–12 days old). — [Crowdfund Insider](https://www.crowdfundinsider.com/2026/10/314982-metamask-exits-ethereum-eth-validators-after-infrastructure-incident-says-wallets-and-funds-were-not-at-risk/); [Crypto.news](https://crypto.news/metamask-exits-staking-validators-amid-security-probe/); [CryptoNinjas](https://www.cryptoninjas.net/news/metamask-exits-ethereum-validators-after-security-incident-hits-staking-infrastructure/)
- → first-pass gap ("nature, date and losses unknown") **partly closed**: date 30 Sep/1 Oct 2026, nature = infrastructure compromise (cause undisclosed), loss ≈ 0.36 ETH reported.
- **Side effect on the exit queue:** a CryptoTicker piece dated October 2026 is titled "Ethereum at $2,507: the staking buffer shrinks" (queue analysis; see section 6). — [CryptoTicker](https://cryptoticker.io/en/ethereum-staking-queue-buffer-october-2026)

### Inferences
- Kelp shows that **"restaking" yield carries bridge/verifier-configuration risk and credit risk on lenders that accept the LRT as collateral**, which is distinct from the base staking rate.
- The MetaMask event is evidence that **validator operator risk (key/infrastructure compromise) is real but, thanks to withdrawal-key separation, was not a principal-loss event**. For a staker, the cost is operational (forced exit, waiting time, interrupted rewards), not slashing.

### Gaps
- rsETH price/peg now, realized Aave bad-debt outcome, and any recovery plan: not verified.
- MetaMask root cause, official post-mortem, exact validator count: not verified.

<<S5>>

<<S6>>

<<S7>>

<<S8>>

<<S9>>

<<S10>>

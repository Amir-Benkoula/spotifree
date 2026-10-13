# Addendum (second pass, 13 Oct 2026): industry revenue rankings, trading terminals/bots, MEV, DeFi blue chips, Binance/CEX, Tether/Circle, revenue-token multiples

> **Method and limits.** Gap-filling pass after `02_carte_revenus_industrie.md` and `04_bots_mev_automatisation.md` (neither edited). Tooling: WebSearch only (22 of 22 searches used; WebFetch and curl unavailable). **Every figure below is "reported by <source>" from a search extract, not from a primary document read in full.** Each figure carries its window/date when one was visible; arithmetic done by me is labelled "my arithmetic". Tags: **[FILING]** SEC filing / official release · **[ATTEST]** Tether BDO attestation · **[DASH]** analytics dashboard (DefiLlama etc.) relayed by a secondary page · **[CLAIM]** company/DAO self-report · **[EST]** third-party estimate · **[WEAK]** blog / affiliate / SEO / aggregator source · **[HIST]** older than ~mid-April 2026 (context only).
>
> **Ledger of first-pass leads that were checked** (details inline in each section):
> - Hyperliquid ~$943M (DefiLlama dashboard): **CONFIRMED** as a DefiLlama figure (window unknown). Sky ~$209M: **CORRECTED/not reproduced** (section 4). Jupiter ~$134M, Aave ~$127M: **NOT VERIFIED** (Aave conflicting, section 4).
> - Hyperliquid $429M YTD, #1 (CoinGecko dataset): **CONFIRMED**, and the full CoinGecko top 10 is now available (section 1).
> - BullX "$2.29B of fees": **CORRECTED** to ≈ $203M lifetime (DefiLlama); BullX trading disabled 1 Jun 2026 (section 2).
> - Axiom 30-day fees $22–39M / revenue $18.8M / lifetime ≈ $737M: **CONFIRMED in order of magnitude** by new FY2025 and 2026-YTD data (section 2). "Axiom $100M in four months": **NOT VERIFIED**, superseded by DefiLlama quarterly data. "Axiom 60–72% share": **UNRESOLVED** (revenue-based parity with GMGN contradicts it).
> - Photon ($0.59M / 30 days; $441M lifetime): **NOT re-verified**.
> - Jito Q2 2026 (tips $9.9M, protocol revenue $1.28M): **CONFIRMED** (Blockworks + DefiLlama).
> - Solana sandwich "$370–500M over 16 months": **NOT VERIFIED**, still no primary source; two newer datasets added (section 3). Ethereum MEV "~$2.2B (2025) / ~$2.5B (2026)", Ethereum sandwich "~$40M (EigenPhi)", Glamsterdam/ePBS status: **NOT VERIFIED** (no new data).
> - Tether Q2 2026 "$1.5B / $4.11B": **CONFIRMED** as best-supported; competing "$1.3B / $5.2B" still unexplained. Tether FY2025 ">$10B": carried from the first pass's primary link, not re-searched. Circle Q2 2026: **CONFIRMED**, with new cost detail; the press-release EBITDA growth (+8%) is the figure to use.
> - Polymarket "≈ $1B annualised" (Sacra): **QUALIFIED**, CoinGecko shows only ≈ $115M for 1 Jan–15 Sep 2026 (section 1).
> - Binance 2025/2026 revenue estimate: **NOT FOUND**.

---

## 1. Published 2026 rankings of top protocols/apps by fees or revenue (DefiLlama, Token Terminal, Artemis, Messari, Blockworks, CoinGecko)

### Takeaway
The only complete, dated 2026 league table found is **CoinGecko's YTD revenue ranking (1 Jan to 15 Sep 2026; Tether, Circle and Grayscale excluded)**: Hyperliquid $429M, pump.fun $322M, Axiom Pro $132M, Sky $130M, GMGN $126M, Polymarket $115M, World Liberty Financial $95M, Paxos $88M, edgeX $84M, Titan Builder $83M. Two trading terminals sit in the top 5 and an Ethereum block builder (MEV) in the top 10; no Q3 2026 table from Token Terminal, Artemis, Messari or Blockworks was retrieved, and CoinGecko's Q3 2026 report is not yet published.

### Cited Findings
**CoinGecko YTD 2026 revenue ranking (data through 15 Sep 2026; reported 15 to 21 Sep 2026)**

| Rank | Project | Revenue 1 Jan to 15 Sep 2026 | Annualised (x 365/258, my arithmetic) | Type (my label) |
|---|---|---|---|---|
| 1 | Hyperliquid | $429.04M (12.62% of a $3.40B pool) | ≈ $607M | Perp DEX / app-chain |
| 2 | pump.fun | $322.21M | ≈ $456M | Memecoin launchpad |
| 3 | Axiom Pro | $132.09M | ≈ $187M | Trading terminal |
| 4 | Sky | $129.87M | ≈ $184M | CDP / stablecoin protocol |
| 5 | GMGN | $126.03M | ≈ $178M | Trading terminal |
| 6 | Polymarket | ≈ $115M | ≈ $163M | Prediction market |
| 7 | World Liberty Financial | $95.37M | ≈ $135M | USD1 stablecoin / token project (revenue definition not visible) |
| 8 | Paxos | $87.93M | ≈ $124M | Regulated stablecoin / tokenization issuer |
| 9 | edgeX | $84.37M | ≈ $119M | Perp DEX |
| 10 | Titan Builder | $83.47M | ≈ $118M | Ethereum block builder (MEV) |

- Sources for the table: ranks 1, 2, 6 — [Yahoo Finance / CCN](https://finance.yahoo.com/markets/crypto/articles/hyperliquid-dominates-2026-crypto-revenue-131527497.html); ranks 3 and 5 — [Mpost](https://mpost.io/coingecko-hyperliquid-leads-2026-crypto-revenue-rankings-with-429m-outearning-next-two-projects-combined/); rank 4 — [KuCoin News](https://www.kucoin.com/news/insight/PUMP/6ab0f2c674fd460007c47a6f); ranks 7 to 10 and the exclusions — [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/). Also: [KuCoin – Top 10 by revenue](https://www.kucoin.com/news/flash/coingecko-top-10-crypto-projects-by-revenue-in-2026); [Cryptonomist, 21 Sep 2026](https://en.cryptonomist.ch/2026/09/21/top-crypto-project-revenue/); [Phemex](https://phemex.com/news/article/hyperliquid-leads-2026-ytd-revenue-rankings-at-429-million-97314). The CoinGecko primary page was not opened. [EST, secondary reporting of a CoinGecko dataset]
- **Scope**: CoinGecko excluded **Tether and Circle** (scale would swamp the comparison) and **Grayscale** ($154.14M, asset-management sponsor fees); sector labels are "best-effort". The sum of the top 10 is ≈ **$1.605B** (my arithmetic), i.e. ≈ 47% of the $3.40B pool. — [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/)
- **Headline inconsistency**: several headlines say Hyperliquid "beat the next two projects combined", but #2 + #3 = $322.21M + $132.09M = $454.3M, which is **more** than $429.04M (my arithmetic). Do not repeat that claim. One report (not identified in the extract) says pump.fun briefly passed Hyperliquid on a 30-day basis in August 2026. — [Yahoo Finance / CCN](https://finance.yahoo.com/markets/crypto/articles/hyperliquid-dominates-2026-crypto-revenue-131527497.html); [Mpost](https://mpost.io/coingecko-hyperliquid-leads-2026-crypto-revenue-rankings-with-429m-outearning-next-two-projects-combined/)
- Aave, Uniswap, Lido, Jupiter, Ethena and Jito do **not** appear in the published top 10. Interpretation piece: Memeburn, "Crypto's top earners of 2026 show its real moat is trading, not the narratives it was sold on" (not read in full) — [Memeburn](https://memeburn.com/cryptos-top-earners-of-2026-show-its-real-moat-is-trading-not-the-narratives-it-was-sold-on/)

**DefiLlama snapshots**
- **Holders revenue, 30 days to ~16 May 2026**: the top 10 protocols captured **87%** of DeFi holders revenue; **Hyperliquid 38.4% (~$53.5M)**, **edgeX 16.7% (~$23.3M)**, **Pump 16.4% (~$22.9M)**; the three = over 71%. Implied total for the month ≈ $139M (my arithmetic: 53.5 / 0.384). "Holders revenue" = buybacks, burns and distributions to stakers or holders, not total fees. [DASH via media] — [PANews](https://www.panewslab.com/en/articles/019e2e95-33e2-75df-9a7a-b4652bcb690f); [Crypto Briefing](https://cryptobriefing.com/defi-holders-revenue-concentration-top-protocols/); [Bitget News](https://www.bitget.com/news/detail/12560605414612)
- **DefiLlama Pro "High Rev Protocols and Ecosystems" (snapshot ~May 2026, window not stated)**: Hyperliquid protocol revenue ≈ **$943M**, ≈ 90% of **$1.05B** gross fees, 99% of fees to the HYPE buyback fund; Aave, Uniswap, Aerodrome, Jupiter, Jito also listed; revenue-capture ratios from Uniswap ≈ 1.4% (before its fee switch took effect) to Aerodrome ≈ 77%. [DASH] — [DefiLlama Pro](https://defillama.com/pro/high-rev-protocols-and-ecosystems-mp464k)
- **Hyperliquid (undated snapshot, ~Sep to Oct 2026)**: 30-day fees **$87.57M**, 30-day protocol revenue **$71.05M** (first pass saw $85.87M / $69.75M on another date; consistent). [DASH] — [DefiLlama – Hyperliquid](https://defillama.com/protocol/hyperliquid)

**Network-level and whole-industry**
- **Messari, Q1 2026**: among all networks, Solana had the second-highest "Real Economic Value" (REV = vote + base + priority fees + MEV tips paid to validators) at **$89.5M**, behind **Hyperliquid ($156.0M)**. [EST] — [Messari – State of Solana Q1 2026](https://messari.io/report/state-of-solana-q1-2026)
- **1kx H1 2026 (post of 13 Aug 2026)**: total revenue −23% YoY to **$47B**; of the ~$14B drop: staking and mining rewards **−$6.2B**, CEX/derivatives/market-maker income **−$5.2B**, on-chain DeFi **−$1.8B (−32%)**, ETF/fund fees **−$1.1B**; off-chain revenue is "publicly reported (Coinbase) or estimated (Binance)". No per-company ranking is published in the post. — [1kx on X](https://x.com/1kxnetwork/status/2087900731697418732)
- **CoinGecko Q3 2026 Crypto Industry Report: not published as of 13 Oct 2026** (Q2 2026 is the latest). Q2 2026 headline: market cap −12.6% QoQ to $2.1T; HYPE entered the top 10. — [CoinGecko research index](https://www.coingecko.com/research/category/reports); [Q2 2026 slides](https://www.slideshare.net/slideshow/2026-q2-crypto-industry-report-coingecko/288608332)
- **Token Terminal / Artemis / Blockworks league tables**: none retrieved; only an indirect statement that Token Terminal snapshots (~May 2026) also rank Hyperliquid and pump.fun among the top DeFi earners — [Crypto Briefing](https://cryptobriefing.com/defi-holders-revenue-concentration-top-protocols/)
- Leads not opened: Binance Research, "Crypto's H1 2026 onchain data shows broad contraction, not sector rotation" ([CryptoRank](https://cryptorank.io/news/feed/00276-binance-research-cryptos-h1-2026-onchain-data-shows-broad-contraction-not-sector-rotation)); "The shutdown cycle: what crypto firms' H1 2026 earnings actually show" ([CFOtech](https://cfotech.news/story/the-shutdown-cycle-what-crypto-firms-h1-2026-earnings-actually-show)).

### Inferences
- **Memecoin stack vs perps**: pump.fun ($322M) + Axiom Pro ($132M) + GMGN ($126M) = **$580M** YTD, about 17% of the $3.40B pool and 36% of the top-10 total; that is more than the two perp venues in the top 10, Hyperliquid + edgeX = $513M (my arithmetic). Launchpad plus terminals out-earned perp DEXs in 2026 YTD on this dataset, even though terminals and launchpads are down sharply from 2025.
- **Stablecoin-related names persist even with Tether and Circle removed**: Sky + World Liberty + Paxos = $313M (≈ 20% of the top-10 total). Combined with the first-pass figures (Tether ≈ $2.5B operating profit in H1 2026; Circle $701M revenue in Q2), stablecoin issuance remains the largest profit pool.
- **MEV has a visible, if small, line**: Titan Builder at #10 ($83.5M) is the first hard dollar figure for an Ethereum block builder's revenue (definition not visible: could be margin or gross value).
- **Indicative combined league table** (mixed definitions; orders of magnitude only; first-pass figures from `02_*.md`): Tier A (multi-billion annualised): Tether (~$2.5B operating profit H1 2026), Coinbase (Q2 net revenue ~$1.15B), Circle (Q2 $701M revenue, $289M after distribution costs), Kraken (Q2 adj. revenue $508M), Kalshi (>$1.5B annualised, self-reported), Binance (undisclosed). Tier B ($100-430M YTD to 15 Sep, CoinGecko): Hyperliquid, pump.fun, Axiom Pro, Sky, GMGN, Polymarket. Tier C ($80-100M YTD): World Liberty, Paxos, edgeX, Titan Builder. Below: Aave (about $80M YTD on one dashboard), Lido DAO ($15.9M net in H1), Jito protocol ($1.28M in Q2), Ethena (collapsed), Uniswap (unknown).
- **Polymarket discrepancy**: Sacra's "≈ $1B annualised (June 2026)" (first pass) vs CoinGecko's ≈ $115M for 1 Jan to 15 Sep (≈ $163M annualised) is a factor of about 6. Possible causes (not verified): different revenue definition (on-chain taker fees on the international venue vs gross including US venue), or an estimate that is simply too high. The report should show Polymarket as a range and label Sacra's figure as an estimate.
- **Reconciliation flags**: edgeX holders revenue of $23.3M in one 30-day window (DefiLlama, mid-May) exceeds its average monthly CoinGecko revenue (≈ $9.8M = 84.37M / 8.5 months), which suggests distributions funded beyond revenue or different definitions. Pump's and Hyperliquid's holders-revenue figures are consistent with their YTD revenue and payout rules.

### Gaps
- No Token Terminal / Artemis / Blockworks table for Q3 2026, 90 days or YTD; CoinGecko Q3 2026 report not out; CoinGecko's primary page not opened (top 10 reconstructed from four secondary articles).
- Window of DefiLlama's $943M Hyperliquid figure; revenue definitions behind World Liberty Financial, Paxos and Titan Builder; why Aave, Uniswap, Lido and Jupiter are absent (presumably below $83.5M YTD on CoinGecko's definition, unverified).
- Binance and other private CEXs are outside every protocol-level ranking.

---

## 2. Trading terminals and Telegram bots (Axiom, Photon, GMGN, BullX, Trojan, BonkBot, Maestro, Banana Gun, Padre/Terminal)

### Takeaway
Terminals are now measurable: in CoinGecko's YTD 2026 ranking **Axiom Pro earned $132M and GMGN $126M of revenue (1 Jan to 15 Sep 2026), #3 and #5 of all projects**, while DefiLlama's 2025 quarterly data put Axiom's FY2025 gross protocol revenue near **$547M (≈ $352M net of cashback/referrals)** and Trojan near **$87M**. BullX has collapsed (DefiLlama lifetime fees ≈ $203M, 30-day fees ≈ $914, trading disabled 1 Jun 2026), correcting the first pass's "$2.29B". Banana Gun, Maestro, BonkBot, Photon (2026) and pump.fun's Terminal (ex-Padre) still have no independent revenue figures.

### Cited Findings
**Revenue, 2026 YTD**
- **Axiom Pro $132.09M** and **GMGN $126.03M** of revenue, 1 Jan to 15 Sep 2026, ranks #3 and #5 in CoinGecko's dataset (Axiom Pro described as a terminal that integrates Hyperliquid perps; GMGN as a Solana memecoin terminal). [EST] — [Mpost](https://mpost.io/coingecko-hyperliquid-leads-2026-crypto-revenue-rankings-with-429m-outearning-next-two-projects-combined/); [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/)
- **"State of the Trenches H1'26" (thelearningpill, Substack)**, as summarised in a search extract: Axiom ≈ **70%** share of Solana terminal activity and **>$200M** revenue; GMGN ≈ **11%** share and ≈ **$137M** cumulative revenue (methodology and window not visible). [WEAK] — [thelearningpill](https://thelearningpill.substack.com/p/the-state-of-the-trenches-h126)
- **Share snapshots (2026)**: DefiLlama-based read (Aug 2026): Axiom ≈ **39%** of combined "Trading App" + "Telegram Bot" fees, GMGN ≈ **36%**; Moby (June 2026): Axiom **44.6%** of Solana trading volume (down from 50.3% days earlier), Trojan ≈ **4%**, GMGN < 0.1% on that metric. [WEAK] — [Axiompedia](https://axiompedia.com/compare); [Moby](https://moby.win/best/solana-trading-apps-2026/)

**Revenue, FY2025 (DefiLlama quarterly income statements, as relayed by a search summary; sums are the summary's arithmetic and match my own re-addition)**
- **Axiom, 2025 gross protocol revenue ≈ $546.7M**: Q1 $31.14M, Q2 $197.78M, Q3 $225.92M, Q4 $91.87M; **net of cashback and referral payouts ≈ $352M** (DefiLlama defines "revenue" as fees kept after those payouts). DefiLlama's "Axiom" and "Axiom Pro" pages show identical 2025 numbers, i.e. one underlying data set. [DASH] — [DefiLlama – Axiom](https://defillama.com/protocol/axiom); [DefiLlama – Axiom Pro](https://defillama.com/protocol/axiom-pro)
- **Trojan, 2025 gross protocol revenue ≈ $87.2M**: Q1 $50.51M, Q2 $17.59M, Q3 $14.17M, Q4 $4.97M (about −90% from Q1 to Q4); "Trojan Bot Trading Fees" line, terminal fees $0 in 2025. [DASH] — [DefiLlama – Trojan](https://defillama.com/protocol/trojan?groupBy=weekly)
- **Axiom 2025 pace [HIST]**: an on-chain analyst (X, ~19 Aug 2025) said Axiom had earned >$240M of "pure revenue" since its late-January 2025 launch, "on pace for ~$665M". Consistent with DefiLlama's Q1 + Q2 2025 gross of $229M. [WEAK, HIST] — [X post](https://x.com/simononchain/status/1957523894895800539)
- A mid-2025 social post claims Axiom $227M of revenue since 15 March vs Trojan $23M and GMGN $21M (single account, undated). [WEAK] — cited in the same search summary; not independently checked.

**BullX (corrects a first-pass lead)**
- DefiLlama lists **cumulative fees $203.03M** and **30-day fees $914.08**; peak monthly fees **$54.6M in Jan 2025**; trading on the current app was **disabled at midnight UTC on 1 Jun 2026** (withdrawals still possible), announced on Discord on 31 May as a pause for "future upgrades"; one source says no formal shutdown was announced, another calls it discontinued. [DASH + WEAK] — [DefiLlama – BullX](https://defillama.com/protocol/bullx); [OurCryptoTalk](https://ourcryptotalk.com/news/bullx-shutdown-trading-airdrop); [Moby](https://moby.win/learn/bullx-shutdown/); [Axiompro](https://axiompro.app/bullx/)
- **First-pass lead "BullX $2.29B of fees through early 2026" (promotional release): CORRECTED**, DefiLlama shows ≈ $203M (other estimates $200-206M); the $2.29B figure is an outlier.

**Fee schedules (2026 comparison pages) [WEAK]**
- Banana Gun 0.5% (ETH manual) / 1% (snipes) and **40% of platform trading fees to $BANANA holders every 4 hours**; Trojan 0.9-1% with 20% cashback; Maestro 1% plus optional subscription; BonkBot flat 1%, fees used for BONK buybacks/burns; Axiom from 0.95% down to 0.75% by tier; most others (Photon, GMGN, Bloom) ≈ 1%. — [Datawallet](https://www.datawallet.com/crypto/best-telegram-crypto-trading-bots); [Crypto Reporter](https://www.crypto-reporter.com/press-releases/best-telegram-trading-bots-in-2026-7-platforms-tested-for-speed-fees-and-mev-protection-124600/); [MadeOnSol](https://madeonsol.com/compare-bots)

**Not found**: independent revenue for **Banana Gun, Maestro, BonkBot, Photon (2026)** or pump.fun **Terminal (ex-Padre)**; market share of Terminal.

### Inferences
- **Axiom's decline is real but not a collapse.** From DefiLlama: FY2025 gross $546.7M; lifetime ≈ $736.7M at 14 Aug 2026 (first pass) implies **≈ $190M of gross fees in 2026 to mid-August** (736.7 − 546.7, my arithmetic), i.e. ≈ $25M/month. That is roughly 35-40% of the Q2-Q3 2025 peak months (≈ $66-75M/month) and about 80-85% of Q4 2025 (≈ $30.6M/month). The CoinGecko net revenue of $132M over 8.5 months is ≈ $15.5M/month, consistent with the first pass's 30-day "revenue" of $18.8M against fees of $39.3M. Annualised net revenue (~$185M) is ≈ 47% below FY2025 net (~$352M), assuming CoinGecko's figure uses the same net definition (if it were gross, the drop would be larger).
- **GMGN is a near-equal of Axiom on revenue** ($126M vs $132M YTD) even though volume-share sources give Axiom 45-70%; the share claims probably measure Solana volume/users, not revenue (GMGN is multi-chain). Do not quote "Axiom = 70% of the market" as a revenue share.
- **Terminal revenue is winner-takes-most and cyclical**: Trojan fell ~90% within 2025; BullX went from $54.6M in one month to roughly zero; Photon likewise (first pass). Axiom + GMGN together ≈ $258M YTD (≈ $365M annualised, my arithmetic) is the 2026 size of the segment's two survivors.
- Definition caution for the writer: DefiLlama "fees" (gross, ~1% of volume) vs "revenue" (after referral/cashback, ≈ 48-64% of fees) differ by up to 2x; CoinGecko's ranking uses revenue.

### Gaps
- FY2025 and 2026 revenue for Banana Gun, Maestro, BonkBot, Bloom, Photon (2026), Padre/Terminal and GMGN FY2025; user-level profitability per terminal; whether the thelearningpill figures are fees or revenue.

---

## 3. MEV and chain-level revenue (Jito / Solana REV, Ethereum MEV-Boost, Solana sandwiches)

### Takeaway
MEV is a small line in 2026: Jito tips fell to **$9.9M in Q2 2026** (from $19.9M in Q1) and Solana sandwich bots took only **≈ $29.7M gross over the 11 months to 7 Oct 2026** (Bitquery, 96% on pump.fun flow). On Ethereum, one block builder (**Titan Builder**) reported **$83.5M of revenue YTD to 15 Sep 2026** (CoinGecko dataset), the best hard figure available; annual MEV-Boost totals paid to validators could not be verified, and no Solana REV for Q2 or Q3 2026 was found.

### Cited Findings
**Solana: tips and chain revenue**
- **Jito Q2 2026 (Blockworks Advisory report)**: protocol revenue **$1.28M (−45% QoQ; fifth consecutive decline from $26.1M in Q1 2025)**; MEV tips **$9.9M in Q2 vs $19.85M in Q1 2026 (≈ −50%)**; BAM at **33%** of Solana stake. **First-pass lead CONFIRMED.** — [Solana Compass](https://solanacompass.com/news/jito-q2-2026-protocol-revenue-falls-45-to-128m-as-bam-reaches-33-of-solana-stake)
- DefiLlama's Jito MEV-tips page lists **Q1 2026 gross MEV rewards ≈ $19.91M** and **Q2 2026 ≈ $9.94M** (via a search summary), consistent with Blockworks. [DASH] — [DefiLlama – Jito MEV Tips](https://defillama.com/protocol/jito-mev-tips)
- Jito Block Engine fee: **6% of MEV rewards** (third-party estimate ≈ $19M/year); Jito-Solana client ≈ 92-95% of stake; jitoSOL yield ≈ 7.2-7.8% APY vs ≈ 5.9-6.6% for native staking (one source). [WEAK] — [RPC Fast](https://rpcfast.com/blog/jito-explained-bundles-tips-mev-solana); [Solana Compass – Jito](https://solanacompass.com/projects/jito)
- **Solana REV, Q1 2026 (Messari)**: $89.5M (−1% QoQ from $90.2M), 2nd among all networks behind Hyperliquid ($156.0M). Q2 and Q3 2026 REV: not found (Messari's Q2 2026 report not indexed). — [Messari](https://messari.io/report/state-of-solana-q1-2026)
- Chain ranking by on-chain revenue on 12 Oct 2026 (first pass, Chainspect): Solana #1, Tron #2, BNB Chain #3 [DASH] — not re-checked.

**Solana: sandwich attacks (new datasets)**
- **Bitquery (reported 12 Oct 2026)**: sandwich bots took ≈ **$29.7M gross** between **30 Oct 2025 and 7 Oct 2026**: **6,850,144 attacks**, **2,545 bot wallets**, **2,154,994 unique victim wallets**; valued at the SOL price of each attack, gross not net; a small fee sample suggests bots kept ≈ **68%**; ≈ **96%** of attacks hit pump.fun's bonding curve and PumpSwap; trades allowing 20-50% slippage were attacked ≈ 14x more often than those under 3%. [EST] — [CryptoSlate](https://cryptoslate.com/solana-sandwich-bots-took-29-7-million-before-costs-bitquery-estimates/); [KuCoin News](https://www.kucoin.com/news/insight/SOL/6acd589ff25df5000749ae17); [Coinbino](https://coinbino.com/solana-sandwich-bots-took-29-7-million-before-costs-mostly-targeting-pump-fun/); [TheCryptoUpdates](https://www.thecryptoupdates.com/bitquery-finds-solana-sandwich-bots-took-29-7m-before-costs/)
- **Academic preprint (Sept 2026), July 2023 to June 2026**: >**28 million** sandwiches on "protected-flow" transactions by **8,631 bots**, ≈ **$345M profit after fees**; protections offer weaker guarantees than users expect. [EST; reported by Pluang, preprint not opened] — [Pluang](https://pluang.com/en/news-feed/studi-solana-ungkap-serangan-sandwich-flow-transaksi-terlindungi-tetap)
- **First-pass lead "$370-500M over 16 months" (Graphdex): NOT VERIFIED**, still no primary source; repeated in a DEV Community post ("sandwich bots extracted $500M"). [WEAK] — [Graphdex](https://graphdex.io/en/blog/what-is-mev-solana-2026); [DEV Community](https://dev.to/ohmygod/solana-mev-defense-in-2026-how-sandwich-bots-extracted-500m-and-the-6-protocol-level-defenses-16d9)
- [HIST] first-pass IMC 2026 paper: >$7.7M lost to 521,903 sandwiches on Jito bundles over ~4 months in early 2025.

**Ethereum: block building and MEV-Boost**
- **Titan Builder: $83.47M of revenue, 1 Jan to 15 Sep 2026, #10 in CoinGecko's ranking** (see section 1). Titan's share of blocks is reported at ≈ 52% in a 2026 blog (BuilderNet ≈ 25%, Quasar ≈ 15%); a 2025 study put the top 3 builders at 85.9% of blocks. [EST/WEAK] — [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/); [Spark](https://www.spark.money/research/ethereum-mev-pbs-validator-economics); [KuCoin](https://www.kucoin.com/blog/ethereum-staking-in-2026-yield-trends-validator-queue-dynamics-and-mev-impact-exlained)
- **Relay shares (August 2026 snapshot)**: Ultra Sound **35.1%**, bloXroute (regulated) **23.8%**, Flashbots **2.4%** (first pass: Ultra Sound 33.92% in April 2026); ≈ **25%** of payloads via OFAC-censoring relays (MEV Watch, Sep 2026); MEV-Boost adoption ≈ 88-92%. [WEAK] — [Spark](https://www.spark.money/research/ethereum-mev-pbs-validator-economics); [Talos #356](https://www.talos.com/insights/state-of-the-network-356)
- MEV share of validator rewards: still incompatible estimates (10-30% per KuCoin; +0.3 to 0.8 pp APR per Spark; ~7% in the first pass). An academic dataset (2024-2025, arXiv 2508.04003) is quoted as "MEV payments = 41% of median daily total revenue, 635 ETH/day" (definition not visible; do not use without checking). — [arXiv](https://arxiv.org/html/2508.04003v2)
- **No verified annual USD total for MEV-Boost payments (2025 or 2026)**; the first-pass "$2.2B (2025) / ~$2.5B (2026)" remains **NOT VERIFIED**.

### Inferences
- **Solana MEV tips are about one-fifth of Solana REV** in Q1 2026 ($19.85M / $89.5M, my arithmetic; assumes REV includes the full tips), and that share fell in Q2 as tips halved. The economics have moved to priority fees (Blockworks).
- **Sandwiching is a low-ticket, high-volume trade**: Bitquery's figures imply ≈ **$4.3 of gross extraction per attack** and ≈ **$13.8 per victim wallet** (29.7M / 6.85M and 29.7M / 2.155M), and an average gross of ≈ $11.7K per bot wallet over 11 months (≈ $7.9K at 68% retention, before infrastructure costs; the distribution is surely skewed). Together with a falling tip market, new sandwich entrants face thin economics.
- **The datasets are not comparable**: Bitquery ($29.7M gross, 11 months, all detected sandwiches) vs the preprint ($345M profit after fees, 36 months, protected flow) differ by ≈ 12x in totals and still by ≈ 3.5x per month (about $2.7M/month vs $9.6M/month, my arithmetic), probably because of scope, SOL prices and gross vs net definitions. Present sandwich losses as a range and state each study's scope.
- The largest identifiable MEV-related revenue line in 2026 is **Ethereum block building** (Titan $83.5M YTD to 15 Sep), ahead of Solana's Jito tips (≈ $29.8M in H1 2026 = 19.85 + 9.9) and Solana sandwich extraction ($29.7M gross over 11 months). Revenue definitions may differ across these three, so treat as an order of magnitude only.

### Gaps
- Ethereum annual MEV-Boost payments and builder/searcher margins; Solana REV for Q2 and Q3 2026; Jito Q3 2026 report (not yet published); revenue in USD for Ethereum, Base, Tron and BNB Chain; Glamsterdam/ePBS status; Ethereum sandwich losses in 2026.

---

## 4. Aave, Lido, Uniswap, Ethena, Sky (2026 revenue, buybacks, fee switch)

### Takeaway
**Sky is the largest of the five** (CoinGecko YTD revenue $129.9M; Sky's own gross revenue $123.8M in Q1 and $107.4M in Q2 2026), but it spends only a small share on SKY buybacks. **Aave** has automated buybacks since 27 Jun 2026 but cut the budget to $30M/year; **Uniswap** switched on protocol fees and a UNI burn (extended to v4 and seven networks on 27 Jul 2026); **Lido's DAO** kept just $15.9M net in H1 2026; **Ethena's** revenue collapsed with USDe supply and ENA buybacks are gated at $7.5B of supply.

### Cited Findings
**Sky (ex-MakerDAO)**
- **Q1 2026 gross protocol revenue ≈ $123.8M, net surplus ≈ $46M** (Messari project page). **Q2 2026 preliminary gross revenue $107.35M**, run-rate $419.08M (Sky June update). Sky Q2 release (23 Jul 2026): "2nd straight quarter with over $100M in revenue", **TTM net protocol revenue $159.63M**, annualised gross run-rate **$429.4M**. Largest revenue source: fees from Sky Agents (Spark, Grove) deploying Sky capital into credit/yield. [CLAIM + EST] — [Morningstar / PR Newswire, 23 Jul 2026](https://www.morningstar.com/news/pr-newswire/20260723to10255/sky-protocol-achieves-2nd-straight-quarter-with-over-100m-in-revenue); [Sky – June update](https://insights.skyeco.com/insights/sky-ecosystem-june-financial-operational-update); [Messari – Sky](https://messari.io/project/sky-protocol); [Sky docs](https://insights.skyeco.com/sky-documentation)
- **Buybacks**: Q2 2026 **$3.41M** of USDS spent buying **51M SKY at an average $0.067**; cumulative buybacks ">$121M since Feb 2025" (release) vs "~$139.4M as of 7 Apr 2026" (docs), which are inconsistent; the size of the Q2 figure looks low next to a "Smart Burn Engine ≈ $102M of SKY per year" claim and should be checked. Sky Frontier Foundation **projection** for 2026: $611.5M gross revenue, $157.8M protocol profit (forecast, not a result). [CLAIM / WEAK] — same Morningstar release; [Tokenomics.com](https://tokenomics.com/articles/sky-tokenomics-how-the-smart-burn-engine-destroys-102m-in-sky-per-year)
- **First-pass lead "Sky ≈ $209M" (Medium, window unclear): CORRECTED / not reproduced.** Sky's own figures give H1 2026 gross ≈ $231M (123.8 + 107.35, my arithmetic), TTM net $159.6M and CoinGecko YTD $129.9M; $209M matches none of them.

**Aave**
- March 2026: DAO cut the annual buyback budget **$50M to $30M**; borrow-fee revenue ≈ −25% from peak (Jan 2026 **$7.95M** vs Jan 2025 **$13.5M**); 2026 operating budget **$190M** vs 2025 revenue **$142M**; by Feb 2026 the DAO had spent ≈ **$42M** buying >205,000 AAVE (≈ 1.28% of supply). — [Aave governance – ARFC](https://governance.aave.com/t/arfc-buyback-program-budget-adjustment/24229); [Aave DAO funding insights](https://governance.aave.com/t/aave-dao-funding-insights/24192)
- **Aavenomics 3.0 live 27 Jun 2026** (automatic buybacks); "Aave Will Win" framework (Apr 2026): 100% of protocol, GHO and branded-product income to the DAO treasury. — [The Defiant](https://thedefiant.io/news/defi/aave-confirms-aavenomics-3-0-live-buybacks-dao-spending-cut); [CoinMarketCap](https://coinmarketcap.com/top-stories/6a838574e4a3fa544e445478/)
- Revenue run-rates conflict: ≈ **$400M annualised** (DefiLlama 7-day window, likely gross fees), ≈ **$134M** annualised DAO-directed revenue (Kulechov), **$80.48M** 2026-to-date on one dashboard (date unknown). [WEAK] — [CoinMarketCap](https://coinmarketcap.com/top-stories/6a838574e4a3fa544e445478/); [Phemex](https://phemex.com/blogs/aave-surging-automated-buyback-engine)

**Uniswap**
- "UNIfication" approved **Dec 2025** (protocol fees on, retroactive burn of **100M UNI ≈ 10% of supply**); expanded in Feb 2026; **Proposal 100 executed 27 Jul 2026** extended the fee machinery to **v4 pools and seven networks** (46.6M for, 1.27M against). Mechanism: v2 split 0.25% LPs / 0.05% protocol; fees accumulate in a "token jar" and UNI is burned to claim a share; Uniswap Labs has a **20M UNI/year growth budget** (vesting quarterly from 1 Jan 2026) that offsets burns. [WEAK to EST] — [Talos #346](https://www.talos.com/insights/state-of-the-network-346); [CryptBull, 31 Jul 2026](https://www.cryptbull.net/2026/07/31/uniswap-fee-switch-activation-puts-uni-burn-mechanics-back-in-focus/); [Stobox](https://www.stobox.io/blog/uniswap-unification-fee-switch-uni-burn); [Phemex](https://phemex.com/blogs/uniswap-fee-switch-revenue)
- Daily protocol revenue reportedly up to ≈ **$325K** from ≈ $114K (single source, undated). [WEAK] — [Phemex](https://phemex.com/blogs/uniswap-fee-switch-revenue)

**Lido (DAO's own H1 2026 report; unaudited)**
- **Total net DAO revenue $8.83M (Q1), $7.11M (Q2), $15.94M (H1 2026)**; gross staking revenue H1 **$27.51M**, net staking revenue **$15.71M**; fees periodically switched off to promote growth ("$0.54M ARR as of 30 June", context unclear); ETH fell 47% in H1 but staking closed both quarters in surplus (**$6.7M** product-level result, Aug 2026 update); DAO take rate rose from 4.96% to 6.11% (Feb 2026 update); protocol fee = 10% of staking rewards; DefiLlama (9 Sep 2026): ≈ **$2.71M** Lido revenue over 30 days. [CLAIM + DASH] — [Lido DAO H1 2026 report](https://lido.fi/ldo-hub/reports/h1-2026); [Lido, Aug 2026](https://blog.lido.fi/lido-poolside-recap-tokenholder-update-august-2026/); [Lido, Feb 2026](https://blog.lido.fi/recap-lido-tokenholder-update-february-2026/); [Lido – protocol fee](https://lido.fi/how-lido-works/protocol-fee)

**Ethena**
- USDe supply: peak ≈ $14-15B (mid-2025) to **$5.92B (mid-Mar 2026)** to ≈ **$3.9B (31 Jul 2026)**; cumulative protocol fees >$800M over its life; one analysis: Q1 2026 revenue **$614K (−95% QoQ)** (definition unclear, possibly net of sUSDe yield) vs >$1.2B annual revenue at the Dec 2024 peak; sUSDe APY 9.4% (7-day, late Apr 2026) then ≈ 4% in July. **Governance (Sep 2026) approved an ENA revenue-allocation framework: 5% of revenue when USDe >= $7.5B, 10% at $10B, 15% at $15B, 20% at $20B**, so no ENA buyback while supply is below $7.5B. [EST/WEAK; attribution within the cluster uncertain] — [Stablecoin Insider – Q1 2026](https://stablecoininsider.org/ethena-usde-q1-2026-report/); [TokenPost](https://www.tokenpost.com/news/business/24374); [Pickaxe](https://www.pickaxe.io/resources/news/understanding-crypto-token-buybacks-with-ethenas-2026-moves); [StablecoinX Q2 2026 release](https://www.globenewswire.com/news-release/2026/08/14/3345337/0/en/stablecoinx-inc-continues-to-build-on-the-ethena-ecosystem-reports-ena-treasury-of-approximately-3-0-billion-tokens-at-end-of-second-quarter-2026.html)

### Inferences
- **Order of magnitude, 2026 (mixed definitions)**: Sky (~$130M YTD, ~$230M gross H1) > Aave (~$80-134M) > Uniswap (unknown, tens of millions at most on a fee-switch basis) > Lido DAO ($16M net H1; $27.5M gross staking revenue) > Ethena (~$0.6M in Q1). If Aave is part of CoinGecko's dataset (not verified), its absence from the top 10 implies a CoinGecko-basis YTD revenue below $83.5M, which fits the $80.48M dashboard number and not the $127-134M mid-2026 figures (those are probably trailing-12-month or gross).
- **Holders get little of it**: Sky's Q2 buyback ($3.41M) is ≈ 3% of its Q2 gross revenue ($107.35M); Aave's $30M/year buyback budget is ≈ 21% of FY2025 revenue ($142M) or ≈ 37% of the $80.48M YTD figure (my arithmetic); Lido and Ethena return nothing via buybacks; Uniswap's burn exists but its size is unverified. This matches the first-pass finding that, outside HYPE and PUMP, holders receive little.
- **Liquid staking is a thin-margin business**: Lido keeps 10% of rewards at the protocol level, and its DAO nets only ≈ $8M/quarter, i.e. the staking "revenue pool" is overwhelmingly paid to stakers and node operators. Ethena shows the downside of yield-based stablecoins: revenue followed funding rates and supply.

### Gaps
- Uniswap 2026 YTD protocol revenue in dollars and UNI burned to date; Aave's DAO revenue and buybacks for Q3 2026; Jupiter; Ethena's revenue on a consistent basis (DefiLlama); reason for Sky's low Q2 buyback figure; Q3 2026 results for all five (not yet published).

---

## 5. Binance revenue/profit estimates and CEX market shares (spot vs derivatives)

### Takeaway
Binance publishes no audited financials and **no reliable 2025 or 2026 revenue/profit estimate was found**; only unsourced aggregator numbers for 2024 circulate. Market-share data from the first pass (Binance 32.8% to 35.3% of total volume, 36.5% of derivatives, TokenInsight Q2 2026) was consistent with what this pass saw; no new spot-vs-derivatives split was found.

### Cited Findings
- Business of Apps gives "**2024 revenue ≈ $16.8B (+40%), net income ≈ $464M (−7%)**"; this is not traceable to a primary source, and other pages conflict (Brand Histories claims ~$4.5B profit; a Medium report claims $20B revenue and a 45% net margin, unsourced). Investing in the Web reports ≈ $34T of 2025 volume across all products, spot > $7.1T and ≈ 38% of global spot share. [WEAK] — [Business of Apps](https://www.businessofapps.com/data/binance-statistics/); [Investing in the Web](https://investingintheweb.com/brokers/binance-statistics/)
- 1kx counts Binance's revenue in its $47B H1 2026 total as an **estimate** but publishes no figure. — [1kx on X](https://x.com/1kxnetwork/status/2087900731697418732)
- TokenInsight Q2 2026: Binance total share rose from **32.77% to 35.34%** (trading share, not revenue) — consistent with the first pass. Coinbase transaction revenue Q2 2026 **$599.2M, −21.6% YoY** — consistent with the first pass. — [TokenInsight](https://tokeninsight.com/en/research/reports/crypto-exchange-report-q2-2026)

### Inferences
- Any Binance revenue number in the final report would have to be flagged as an unverified third-party estimate. A defensible statement is qualitative: Binance is the largest venue by volume (about a third of CEX volume per TokenInsight) and revenue is undisclosed.

### Gaps
- Binance, OKX, Bybit and Bitget revenue/profit (2025, 2026); overall spot vs derivatives share of total CEX volume in 2026; Bullish Q2 2026 results (not searched).

---

## 6. Tether (2025 full year, H1/Q2 2026) and Circle Q2 2026: confirmation

### Takeaway
**Tether Q2 2026 is confirmed at about $1.5B of net operating profit and $4.11B of excess reserves** (BDO attestation of 31 Jul 2026, reported by several outlets and internally consistent), against an unexplained "$1.3B / $5.2B" cluster dated 3 Sep 2026. **Circle's Q2 2026 results are confirmed**: revenue and reserve income $701M (+7%), net income from continuing operations $48M, USDC $73.3B at quarter-end, and distribution costs absorbing about 59% of revenue.

### Cited Findings
**Tether**
- **Q2 2026 (BDO attestation published 31 Jul 2026)**: net operating profit ≈ **$1.5B**, driven mainly by US Treasury interest and repo; excess reserves **$4.11B** (from a record $8.23B at 31 Mar 2026); total assets **$187.75B**, liabilities **$183.64B** (187.75 − 183.64 = 4.11, consistent); added 14 tonnes of gold and ≈ 1,796 BTC in Q2 but the USD value of both fell. [ATTEST via media] — [Stablecoin Insider](https://stablecoininsider.org/tether-q2-2026-reserve-buffer-halved/); [Blockonomi](https://blockonomi.com/tether-posts-1-5b-q2-profit-as-excess-reserves-halve-to-4-11-billion/); [Spotedcrypto](https://www.spotedcrypto.com/tether-q2-2026-reserve-buffer-halved/); [Yahoo Finance](https://finance.yahoo.com/markets/crypto/articles/tether-excess-reserves-halve-disclosure-141627007.html)
- **Conflicting cluster (articles dated 3 Sep 2026)**: "Q2 profit $1.3B, excess reserves $5.2B" — [CryptoRank](https://cryptorank.io/news/feed/53e6d-tether-reports-1-3b-q2-profit-as-excess-reserves-reach-5-2b); [CryptBull](https://www.cryptbull.net/2026/09/03/tether-reports-1-3b-q2-profit-as-excess-reserves-reach-5-2b/); [The Currency Analytics](https://thecurrencyanalytics.com/stable-coins/tether-clears-5-2-billion-in-excess-reserves-as-q2-profit-hits-1-3-billion-290270). Origin not identified; does not reconcile with the 31 Jul balance sheet. **Status: first-pass choice ($1.5B / $4.11B) CONFIRMED as best supported, not verified against the BDO PDF.** Yahoo Finance's piece says the BDO report "has become notably quieter" (disclosure standards shifting; one source says the BTC dollar value no longer appears).
- **FY2025 and Q1 2026** (first pass, primary Tether.io link not re-fetched here): net profit >$10B in 2025 with $6.3B of excess reserves; Q1 2026 net operating profit ≈ $1.04B. Q3 2026 attestation: not yet published.

**Circle (NYSE: CRCL), quarter ended 30 Jun 2026, released 5 Aug 2026 [FILING]**
- Total revenue and reserve income **$701M (+7% YoY)**: reserve income **$668M (+5%)**, other revenue ≈ **$34M (+41%)**; reserve return rate **3.48%** (−66 bps YoY); average USDC **$76.5B (+25%)**; USDC at quarter-end **$73.3B (+19% YoY; down from ≈ $77B in Q1)**. — [SEC 8-K](https://www.sec.gov/Archives/edgar/data/1876042/000187604226000246/augustepr-circle_q22026f.htm); [Stablecoin Insider](https://stablecoininsider.org/circle-q2-2026-results-usdc-circulation/); [bit.com research](https://www.bit.com/research/circle-crcl-q2-2026); [Crypto Briefing](https://cryptobriefing.com/circle-q2-2026-earnings-usdc-ebitda/)
- **Distribution, transaction and other costs $412M (+1% YoY)**; **revenue less distribution costs (RLDC) $289M, a 41% margin**; net income from continuing operations **$48M** (a $530M swing, mostly the Q2 2025 IPO-related stock-compensation charge); **adjusted EBITDA $143M, +8%** (the press-release figure; the first pass saw +14% in one reading of the 10-Q: use +8%). EPS sources conflict ($0.18 diluted; "beat" vs "miss" of consensus) and were not resolved. — [bit.com research](https://www.bit.com/research/circle-crcl-q2-2026); [Beancount analysis](https://beancount.io/blog/2026/09/13/circle-q2-2026-earnings-analysis); [Investing News](https://investingnews.com/circle-reports-second-quarter-2026-results/)
- Earnings-call summary: FY2026 "other revenue" outlook raised about 2x to **$310-330M**, linked to an **Arc token presale**, with Arc mainnet planned for 16 Sept with BlackRock and DTCC (single summary, not verified). [WEAK] — [BigGo Finance](https://finance.biggo.com/news/US_CRCL_2026-08-05)

### Inferences
- Circle's costs of $412M on $701M of revenue = **58.8%** (my arithmetic), consistent with the ≈ 41% RLDC margin: more than half of the float's yield goes to distributors (Coinbase). Tether's ≈ $1.5B of quarterly operating profit is about **5x Circle's RLDC ($289M)** on a float about 2.5x larger (≈ $183.6B of liabilities vs $73.3B USDC), i.e. Tether keeps far more of the yield.
- Tether's equity buffer is now driven by gold and BTC marks (−$4.1B in a quarter while operating profit was +$1.5B), so headline "profit" depends on commodity and bitcoin prices as much as on T-bill yield.

### Gaps
- Tether Q3 2026 attestation (not yet published); the BDO PDF itself; split of Tether profit between interest income and gold/BTC marks; exact source of the $1.3B / $5.2B figures; Circle's amount paid to Coinbase; Circle EPS and consensus.

---

## 7. Price-to-revenue multiples and buyback yields (HYPE, PUMP, other "revenue tokens")

### Takeaway
No published P/S or P/E ratio for HYPE, PUMP or other revenue tokens was found; the nearest hard analysis is **TokenIntel's "Net Buyback Yield: HYPE vs PUMP" (22 May 2026)**, which argues buybacks are largely offset by token unlocks (HYPE: about $360M of buybacks vs about $4.18B of unlocks through end-2026). Payout ratios computed from sourced figures: pump.fun returned ≈ 62% of 2026 revenue via buybacks, Hyperliquid 97-99% of net fees by policy.

### Cited Findings
- **TokenIntel (22 May 2026)**: through end-2026, HYPE faces ≈ **$4.18B of unlocks vs ≈ $360M of buybacks**; PUMP ≈ **$219M of unlocks vs $130-270M of buybacks**; conclusion "same buyback intensity, opposite net pressure" (the report's conclusion, not a verified outcome). Another analysis puts the unlock-to-buyback ratio at roughly 6-8:1 on trailing-12-month fees and nearer 10:1 on the current 30-day run-rate. [EST] — [TokenIntel](https://tokenintel.org/reports/net-buyback-yield-hype-vs-pump-2026-05-22)
- **HYPE quarterly buybacks (reported)**: $316.76M (Q3 2025), $255.05M (Q4 2025), $192.25M (Q1 2026). HYPE circulating market cap ≈ **$14.56B**, FDV ≈ **$56.7B** (dates not visible); CoinGecko lists Market Cap/FDV = 0.23 (if both referred to the same date the FDV would be ≈ $63B rather than $56.7B, so the figures probably come from different dates). HYPE price snapshots disagree ($82.05 on a CoinGecko page of unknown date vs $55.27 in a mid-August 2026 report). [WEAK/EST] — [crypto.news](https://crypto.news/price-prediction/hyperliquid/); [CoinStats](https://coinstats.app/ai/a/price-potential-hyperliquid); [CoinGecko – Hyperliquid](https://www.coingecko.com/en/coins/hyperliquid)
- **Other buyback data points from this pass**: Sky $3.41M in Q2 2026 (51M SKY at $0.067); Aave $30M/year budget (cut from $50M in March 2026); Ethena none until USDe reaches $7.5B; Uniswap burn live but unsized (section 4).
- First-pass figures reused for the calculations below (not re-checked): HYPE buybacks ≈ $370M 2026 YTD (Allium, late Sep); PUMP ≈ $200M buybacks and $322M revenue in 2026 as of 1 Oct 2026 ([WalletInvestor](https://walletinvestor.com/news/crypto-news/pump-funs-pump-token-nears-0-006-as-its-buybacks-pass-200-million-in-2026/)); Hyperliquid DefiLlama Q2 2026 $201.84M and Q3 2026 $224.23M gross protocol revenue.

### Inferences
- **Payout ratios (my arithmetic)**: PUMP ≈ $200M / $322M = **62%** of 2026 revenue (consistent with a higher payout before the 28 Apr policy and 50% after); HYPE ≈ $370M buybacks / $429M CoinGecko revenue = **86%**.
- **Net absorption of unlocks (TokenIntel's inputs)**: HYPE buybacks cover about 9% of unlock value ($360M / $4.18B); PUMP 59% to 123% ($130-270M / $219M). So the "revenue token" thesis is much stronger on PUMP's net supply than HYPE's, at least on the May 2026 projections.
- **Possible inconsistency to flag**: Allium's HYPE buybacks of ≈ $370M YTD look low against the reported Q1 buyback ($192M) plus Q2 and Q3 revenue ($202M and $224M) at a 97-99% payout, which would imply ≈ $600M by end-September (my arithmetic). Either Allium counts a narrower set of transactions or the DefiLlama quarterly "gross" figures overstate the buyback base. The writer should give HYPE's 2026 buybacks as a range ($370M to ~$600M) with the definitions, not a single number.
- **Illustrative P/S only (cap date unknown)**: using the only circulating-cap figure seen ($14.56B) over HYPE's annualised revenue of $607M (CoinGecko YTD annualised) to $853M (DefiLlama 30-day x12) gives roughly **17x to 24x** revenue and a buyback yield of about 4-6%. Because HYPE's price varied from $55 to $82 across sources, the writer should recompute with a dated market cap before quoting any multiple.

### Gaps
- No dated October 2026 market caps or FDVs for HYPE, PUMP, SKY, AAVE, UNI, so no verified P/S or buyback yield; no Token Terminal or Artemis "price-to-sales" tables; PUMP supply and unlock schedule not retrieved in this pass; no multiples for edgeX, GMGN-linked tokens or other revenue tokens.

# Rendement passif en crypto (staking, DeFi, stablecoins, RWA, perp vaults, CeFi earn) : état au 13 octobre 2026

> **Research conditions (read first).** WebFetch failed on every domain tried, with DNS `ENOTFOUND` errors. The domains included defillama.com, data.ecb.europa.eu, presse.economie.gouv.fr, coindesk.com, kucoin.com, stablecoininsider.org, dwellir.com and arxiv.org. The web-search budget, shared by all agents, also ran out after 17 searches. As a result:
> - Every figure below comes from search-engine result summaries of the cited pages. None was checked against the full page text.
> - When a summary did not say which page a number came from, I list the candidate pages and mark the attribution as "uncertain".
> - Single-source numbers should be treated as provisional.
> - Several requested sub-topics could not be researched at all. These are SOL and other PoS staking, restaking rewards, Pendle, Maple/Usual/Falcon/Resolv, CeFi earn rates, Lighter/Aster/Drift/JLP, LP-vs-HODL studies and MiCA. They are listed under each section's **Gaps**, so the report can say "not verified" instead of guessing.

## 1. Staking and liquid staking (ETH, SOL, other PoS); restaking: realized rewards vs. points

### Takeaway
Lido stETH paid about **2.2–2.5% APR (in ETH) during 2026**. The latest data point is **2.23% (around 6 Oct 2026)**. That is below the US 3-month T-bill (about 4.15% on 13 Oct 2026) and about equal to the ECB deposit rate (2.50%). ETH staking is therefore a small in-kind return on top of ETH price risk, not a source of cash income. SOL and other PoS yields, and realized restaking rewards, could not be verified this session. The only restaking data point found is a large 2026 loss: the **Kelp DAO exploit, $293M, 18 Apr 2026**.

### Cited Findings
- **Lido stETH APR: 2.23%** per a KuCoin flash item dated about 6 Oct 2026. The same item says MetaMask's staking validator exit was "nearly complete". It links the exit to a "security incident" and says the ETH would gradually re-enter Lido over the following weeks. — [KuCoin flash, ~6 Oct 2026](https://www.kucoin.com/news/flash/lido-metamask-staking-validator-exit-near-completion-steth-apr-at-2-23)
- Lido's institutional page showed **2.5% APR as of 27 Mar 2026**. This is historical context (more than 6 months old). — [Coin Bureau Lido review (2026)](https://coinbureau.com/review/lido-finance-review)
- **2.4–2.6%** "as of late May 2026"; the guide is marked "last verified 4 Oct 2026". — [web3wagmi Lido guide](https://blog.web3wagmi.com/lido-guide)
- Undated or stale snapshots: Lido homepage **2.3%**, Staking Rewards **2.25%**. Do not use these as October figures. — [Lido](https://lido.fi/); [Staking Rewards](https://www.stakingrewards.com/asset/staked-ether)
- Lido's displayed APR is **net of its fee, which is 10% of staking rewards**. — [Lido, Ethereum page](https://lido.fi/ethereum) (via search summary)
- On 21 Sep 2026 Lido was the largest DeFi protocol by TVL at **~$26.0B**, ahead of Aave (~$19.2B) and Morpho (~$10.7B). These figures come from third-party write-ups citing DefiLlama; which page gave which figure is uncertain. — [InsideDeepTech, DeFi Industry Report Q3 2026](https://www.insidedeeptech.com/defi-industry-report-q3-2026/); [NOWNodes](https://nownodes.io/blog/defi-explained-how-decentralized-finance-actually-works/); [CompaniesHistory](https://www.companieshistory.com/decentralized-finance-market)
- **Kelp DAO exploit: $293M on 18 Apr 2026.** A Nansen analyst said it "compressed weeks of outflows into days". **Aave users withdrew ~$15B in deposits in the four days after the exploit.** — [Cointelegraph (~Jun 2026)](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value); [KuCoin flash](https://www.kucoin.com/news/flash/defi-tvl-drops-39-in-2026-to-70b-amid-942m-in-hacks); [BlockchainReporter](https://blockchainreporter.net/defi-tvl-shrinks-39-in-2026-hacks-cost-942m-as-only-two-chains-grow)

### Inferences
- In USD terms the ETH staking "premium" over cash is now **negative**: 2.23% against a 3-month T-bill of about 4.15% (section 7). Staking only makes sense as extra yield on ETH already held for price exposure.
- Against EUR benchmarks, stETH roughly equals the ECB deposit rate (2.50%) and exceeds Livret A (1.7%). It is still not comparable to either, because the return is in ETH and carries full price risk.
- The 2026 trend is slightly downward: 2.5% in March, 2.4–2.6% in May, 2.23% in October.
- Kelp DAO is, from background knowledge not confirmed this session, the issuer of the liquid-restaking token rsETH. If so, the April 2026 exploit is the main 2026 evidence that restaking adds smart-contract and LRT risk on top of base staking. The roughly $15B Aave outflow shows that this risk spreads to lending markets.

### Gaps
- **Rocket Pool rETH**, Coinbase cbETH, ether.fi and other ETH LSTs: no current APR collected (search budget exhausted).
- **SOL staking and LSTs (JitoSOL, Marinade mSOL, etc.)**: no 2026 yield collected. Do not reuse pre-2026 figures as current.
- **Other PoS assets** (ATOM, DOT, ADA, AVAX, TRX, SUI, HYPE staking…): not covered.
- **Restaking (EigenLayer, Symbiotic, Karak)**: not covered. This includes realized rewards vs. points or airdrop promises, AVS fee revenue and slashing status in 2026. The Kelp DAO exploit mechanism, any recovery, and any rsETH depeg are also unverified.
- **MetaMask staking "security incident" (Oct 2026)**: nature, date and losses unknown.

## 2. Stablecoin yields: DeFi lending, yield-bearing stablecoins, CeFi earn, tokenized treasuries and RWA size

### Takeaway
In late September and early October 2026, "blue-chip" on-chain dollar yields clustered at **about 3.5–3.8%**:
- Aave v3 USDC: about 3.6%.
- Sky Savings Rate: 3.6%, raised to 3.8%.
- Tokenized T-bill funds: 3.50% (7-day average).

That is at or below the 3-month T-bill (about 4.15–4.23%) after the Fed hiked to 3.75–4.00% on 16 Sep 2026.

Ethena's **sUSDe paid ~4.76% on 28 Sep 2026**, down from 9.4% in April. ENA incentives for USDe ended on 30 Sep, and USDe supply fell below $5B. CeFi earn rates (Coinbase, Binance, Kraken, OKX) and Maple, Usual, Falcon and Resolv yields could **not** be verified.

### Cited Findings
#### DeFi lending (variable, utilization-driven rates)
- **Aave v3 USDC ≈3.57% on Ethereum and ≈3.65% on Base (15 Sep 2026)**, from a DefiLlama-based roundup. The same roundup says "$58M supplied on Ethereum", which looks implausibly low; do not use it. — [eco.com, USDC yield 2026](https://eco.com/support/en/articles/15182156-usdc-yield-in-2026-where-to-earn-interest-on-usdc); [eco.com, best USDC yield platforms 2026](https://eco.com/support/en/articles/15253991-best-usdc-yield-platforms-2026-aave-morpho-sky-compared) (attribution between the two uncertain)
- **Aave v3 Ethereum on 28 Sep 2026: USDC ≈3.58%, USDT ≈3.75%** (institutional guide). — [Stablecoin Insider, Aave institutional yield](https://stablecoininsider.org/earn-stablecoin-yield-with-aave/); [RebelFi, USDC on Aave v3](https://rebelfi.io/blog/usdc-yield-aave-v3-institutional-guide) (attribution uncertain)
- Aavescan snapshot, undated: Aave v3 Ethereum USDC at **3.72% supply APR**, about **$2.41B** supplied. — [Aavescan](https://aavescan.com/)
- **Compound v3 USDC ≈4.51%** in one roundup. Aavescan's Compound v3 page contradicts itself: 6.45% headline, 5.32% for 30 Sep in its daily table. Treat Compound as unresolved, in the 4.5–5.3% range. — [Aavescan, Compound v3 Ethereum USDC](https://aavescan.com/rates/compound-v3-ethereum-usdc)
- Aave USDC briefly paid **~15% APY in April 2026**, described as a short-lived anomaly. — [MEXC flash](https://www.mexc.com/en-GB/news/flash/196129661)
- How Aave rates work: they are set algorithmically by utilization. Supply APY equals borrower interest minus a reserve factor kept by the protocol. — [Stablecoin Insider](https://stablecoininsider.org/earn-stablecoin-yield-with-aave/)

#### Sky (ex-MakerDAO) sUSDS: governance-set rate
- **Sky Savings Rate raised to 3.80% from 3.60%**, reported on 7 Oct 2026. Sky's own channels did not confirm this in the search results. — [Coinfomania](https://coinfomania.com/sky-savings-rate-rises-to-3-80-enhancing-susds-capital/)
- SSR history per DefiLlama data cited in a 2026 guide: **3.75% (15 Mar 2026) → 3.6% (1 Jun) → 3.52% (1 Aug) → 3.6% (13 Sep 2026)**. Sky's own material cites a **26 May 2026 cut from 3.75% to 3.60%**. — [eco.com, SSR deep dive 2026](https://eco.com/support/en/articles/15254003-sky-savings-rate-deep-dive-2026-ssr-susds-usds-mechanics); [Sky blog, what is sUSDS](https://sky.money/blog/what-is-susds); [earnpark, sUSDS review 2026](https://earnpark.com/en/posts/susds-review-2026-what-the-sky-savings-rate-actually-pays/)
- Sky on X: "The Sky Savings Rate is moving to 3.6%". The post ID decodes to **3 Sep 2026, 15:42 UTC**, which fits the move from 3.52% to 3.6% in the DefiLlama series, so there is no real conflict. — [Sky on X](https://x.com/SkyEcosystem/status/2095537892563009706)
- The SSR is governance-set and changes in discrete steps. — [eco.com, sUSDS explained](https://eco.com/support/en/articles/14798655-susds-explained-sky-s-savings-rate-token)

#### Ethena USDe / sUSDe: synthetic dollar, funding-rate driven
- **sUSDe ≈4.76% APY on 28 Sep 2026; 30-day average 4.79%.** — [Stablecoin Insider, sUSDe review 2026](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/)
- **7-day trailing APY: 9.4% in April 2026, 7.1% in June 2026**, as perpetual funding compressed in Q2. — [eco.com, sUSDe explained](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin) (attribution probable, not certain)
- **Ethena ended ENA token incentives for USDe on 30 Sep (2026 by context)**, after what Crypto Briefing's headline calls an 85% decline in rewards. **USDe supply contracted by more than 65% and fell below $5B by late August 2026.** — [Crypto Briefing](https://cryptobriefing.com/ethena-ends-usde-token-incentives/); [CryptoTicker](https://cryptoticker.io/en/ethena-usde-incentives-end/). A PANews headline reads "USDe issuance plummets by $6.5 billion, Ethena faces a liquidity crisis" (date not captured). — [PANews](https://www.panewslab.com/en/articles/775abb05-95a0-4466-b300-49d58a6dee4b)
- Analysis: over 2026 Ethena rebuilt USDe's backing. The basis trade is now a "minor part" of the reserve, and lending has replaced it. — [Altitude (Medium), "Ethena stops farming the basis"](https://medium.com/altitudedp/ethena-stops-farming-the-basis-d6f6edb79a5b)
- Negative funding has historically occurred about **16–20% of the time**. In **March 2026**, BTC and ETH funding turned negative and Ethena's **daily protocol fees fell 98%**. The **insurance fund was about $73M (~1.7% of supply) in June 2026**. Attribution among these pages is uncertain. — [Bitcoin Foundation analysis](https://bitcoinfoundation.org/news/analysis/ethena-ena-price-prediction-2026-is-the-project-slowly-dying-or-just-cooling-off/); [Stablecoin Insider](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/)
- Historical context: USDe market cap fell **from $14.8B (10 Oct 2025) to $12.6B (12 Oct 2025)**. — [21Shares](https://www.21shares.com//research/why-did-ethenas-stablecoin-remain-stable-onchain-but-depegged-on-binance)

#### Tokenized treasuries / RWA (rwa.xyz via secondary sources)
- **Tokenized treasury funds: $14.93B across 108 products; 7-day average yield 3.50%; the six largest funds hold about $10.8B** (September 2026 report citing rwa.xyz). — [Stablecoin Insider, top 10 tokenized treasury funds 2026](https://stablecoininsider.org/top-10-tokenized-treasury-funds-in-2026-buidl-benji-and-the-highest-yielding-on-chain-options/); [eco.com, tokenized RWA market size 2026](https://eco.com/support/en/articles/15254020-tokenized-rwa-market-size-2026-20b-aum-growth-trajectory) (attribution uncertain)
- Earlier readings: **~$16.16B (July 2026, rwa.xyz-based)** and **~$11.92B (March 2026 tracker)**. July is higher than September; this may be outflows or a change of definition, and is unresolved. — [Coinpaprika tracker](https://coinpaprika.com/education/tokenized-treasuries-market-cap-tracker-tvl-growth/); [Upshift](https://www.upshift.finance/blog/tokenized-treasuries) (attribution uncertain)
- **BlackRock BUIDL ≈$2.37B AUM** in a June 2026 rwa.xyz snapshot, **−11.67% over the prior 30 days**. Other pages give $2.3–2.9B. One claim of a "40% market share at $2.9B+" is inconsistent with a ~$15B market and should not be used. — [Altrady, BUIDL guide 2026](https://www.altrady.com/blog/cryptocurrency/blackrock-buidl-tokenized-treasury-2026); [Intellectia](https://intellectia.ai/blog/tokenized-treasuries-2026-blackrock-buidl)
- **Circle USYC ≈$3B AUM**, reportedly overtaking BUIDL as the largest single tokenized treasury fund by mid-2026 (July 2026 article). A May 2026 piece listed USYC at $3B and BUIDL at $2.5B. — [Stablecoin Insider](https://stablecoininsider.org/top-10-tokenized-treasury-funds-in-2026-buidl-benji-and-the-highest-yielding-on-chain-options/); [Upshift](https://www.upshift.finance/blog/tokenized-treasuries) (attribution uncertain)

#### Centralized "earn" products
- Nothing verified; see Gaps.

### Inferences
- **Zero or negative premium for blue-chip on-chain dollar yield.** Aave USDC (~3.6%), the SSR (3.8%) and tokenized T-bill funds (3.5%) sit at or below the 3-month T-bill (~4.15–4.23%). That rate rose after the 16 Sep 2026 Fed hike (section 7). On-chain lending rates follow borrowing demand rather than the Fed, so they lag, and in 2026 leverage demand was weak. This reverses the usual picture of DeFi paying more than T-bills.
- **sUSDe is ~4.76%, about +0.6 pp over T-bills.** That margin is the price of funding-rate, CEX custody and venue-depeg risk (section 6), and it is thin now that ENA incentives have ended. The yield is pro-cyclical: high when traders are leveraged long, collapsing (March 2026) when funding turns negative.
- **Tokenized T-bill funds** pass through T-bill yields minus fees. They are the closest on-chain thing to "risk-free", but they add issuer, custody, smart-contract and access risk. Investor-eligibility rules were not verified.
- The **15% Aave USDC spike in April 2026** coincides with the Kelp DAO exploit (18 Apr) and the ~$15B of Aave withdrawals. A utilization spike is a plausible cause, but no source confirms it. Either way, "high APY" on a blue-chip market usually signals stress, not opportunity.
- **For a euro-based (French) investor**, USD yields carry EUR/USD risk unless hedged. By standard covered-interest-parity reasoning (not sourced), a hedge costs roughly the USD–EUR short-rate gap of about 1.4–1.7 pp. That gap compares Fed funds 3.75–4.00% or the T-bill at 4.15% with the ECB rate of 2.50%. So:
  - Aave USDC at ~3.6%, hedged, is worth about 1.9–2.2% in EUR before tax, against Livret A at 1.7%, which is tax-free and state-backed.
  - sUSDe at ~4.8%, hedged, is worth about 3.1–3.4% in EUR before tax.

### Gaps
- **Spark, Morpho vaults and Euler** current USDC/USDT rates: not collected.
- **Maple syrupUSDC, Usual USD0++, Falcon USDf/sUSDf, Resolv USR/RLP**: 2026 yields and any incidents not collected.
- **Coinbase USDC rewards** (rate and EU availability), and **Binance, Kraken and OKX earn rates**: not collected.
- **MiCA / EU**: not verified this session. Background knowledge says MiCA stablecoin rules applied from mid-2024 and the full CASP regime from end-2024, and that EU platforms then restricted non-MiCA stablecoins such as USDT for EU users. Verify before citing; this background is not a source.
- **Ondo (OUSG/USDY) and Franklin (BENJI)**: individual AUM and yields not collected. Minimum investment sizes for tokenized T-bill funds also not verified.
- **Euro stablecoin (EURC, etc.) lending yields**: relevant for French users, not collected.
- Ethena reserve composition in late 2026 and the exact sUSDe yield after incentives ended (October): not collected.

## 3. Pendle fixed yields, PT/YT strategies, and looping

### Takeaway
**No 2026 Pendle data could be collected.** The indirect evidence points one way:
- The yields Pendle PTs lock in (sUSDe, LSTs) fell sharply in 2026: sUSDe went from 9.4% in April to ~4.8% in late September.
- Leverage loops and recursive minting were key amplifiers in the 2025–2026 failures: Stream/Elixir, USDe on Binance, and the Aave liquidity run after Kelp.

### Cited Findings
- sUSDe yield path: **9.4% (Apr 2026) → 7.1% (Jun 2026) → ~4.76% (28 Sep 2026)**. — [eco.com](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin); [Stablecoin Insider](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/)
- OKX CEO Star Xu blamed Binance's USDe-linked yield campaign for enabling **leverage loops** that worsened the 10 Oct 2025 liquidation spiral. Binance leadership, including CZ, blamed tariff-driven macro conditions. The claim is contested, and the source is a mirror site. — [OKX CEO blames Binance (mirror)](https://san-1510.aid.brainsum.com/news/top-news/okx-ceo-blames-binance-october-liquidation-spiral)
- On Binance, margin systems valued USDe collateral at the distressed Binance spot price, which forced liquidations. USDe stayed near $1 on Curve and through Ethena's mint/redeem. — [21Shares](https://www.21shares.com//research/why-did-ethenas-stablecoin-remain-stable-onchain-but-depegged-on-binance)
- Stream and Elixir reportedly used **recursive cross-minting**, each minting the other's token. The claim comes from Yearn developer "Schlag" and was not independently confirmed. — [BlockEden](https://blockeden.xyz/blog/2025/11/08/m-defi-contagion/); [Zircuit](https://www.zircuit.com/blog/behind-cryptos-biggest-collapses) (attribution uncertain)
- About **$15B was withdrawn from Aave in the four days after the Kelp DAO exploit** (Apr 2026). — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value)

### Inferences
- A loop's net carry is roughly (collateral yield − borrow rate) × leverage. With sUSDe at ~4.8% and USDT *supply* rates on Aave already ~3.75% (borrow rates are higher), the sUSDe/stablecoin loop spread was **thin to negative in late September 2026**. Loopers were mostly taking depeg and liquidation risk for little carry. Borrow rates were not collected, so this is not sourced.
- PT fixed yields should mirror these lower underlying yields. Any "fixed" stablecoin PT yield far above ~5–6% in October 2026 would imply the market is pricing extra risk in the underlying.
- Liquidity runs are the main risk for loopers: Aave after Kelp, and Morpho vault liquidity shortages in November 2025 (section 6). At 100% utilization, unwinding stalls and borrow costs spike.

### Gaps
- Pendle TVL; PT implied APYs for sUSDe, USDe, stETH and others in Sep–Oct 2026; YT performance; Pendle Boros: not collected.
- Quantified looping losses in 2025–2026: not collected.

## 4. Perp-DEX liquidity vaults (Hyperliquid HLP, JELLY, 10 Oct 2025; Lighter, Aster, Drift, JLP)

### Takeaway
**Hyperliquid's HLP vault has been profitable over its life:**
- About $137M cumulative profit since May 2023.
- "10–25% annualised in most months".
- About **22% net APR over the 12 months to Q2 2026** in one analysis.

**2026 snapshots show much lower trailing returns**, about **3–7% annualised** over the past month. TVL is down from a **$604M peak to ~$180–184M**, and **fee receipts fell from $7.15M (Q3 2025) to $1.5M (Q2 2026)**.

Two tail events stand out:
- **JELLY (March 2025)**: about −$12M to −$13.5M unrealized. It was resolved only when validators intervened.
- **The 10 Oct 2025 crash**: about **+$41.5M, or roughly +10%, in one weekend**.

Lighter LLP, Aster, Drift and Jupiter JLP could not be verified.

### Cited Findings
- Trailing-month return **~7% APR**; historical quarterly range **~15–30%**. — [eco.com, Hyperliquid vault strategies 2026](https://eco.com/support/en/articles/15197987-hyperliquid-vault-strategies-2026-hlp-and-user-vaults-explained) (attribution probable)
- **~22% net APR** over the 12 months to Q2 2026 (one analysis). — [KuCoin HLP article](https://www.kucoin.com/news/articles/maximizing-the-liquidation-alpha-how-hyperliquid-s-hlp-vault-converts-whale-losses-into-liquidity-provider-yield); [VaultVision](https://vaultvision.tech/blog/hyperliquid-yield-guide) (attribution uncertain)
- **"Roughly 10–25% annualised in most months."** — [Datawallet](https://www.datawallet.com/crypto/hyperliquid-hlp-explained); [DexTools](https://www.dextools.io/tutorials/what-is-hyperliquid-hlp-vault-strategy-guide-2026) (attribution uncertain)
- Hyperliquid app HLP page: **"Past Month Return 3%", TVL ~$180.5M**. The snapshot date is unclear, and so is whether 3% is a raw 30-day return or annualized. — [Hyperliquid app, HLP vault](https://app.hyperliquid.xyz/vaults/0xdfc24b077bc1425ad1dea75bcb6f8158e10df303)
- **6% APR** based on past-month performance. — [Finestel](https://finestel.com/blog/hyperliquid-vaults-explained/)
- Further figures from third-party HLP guides; which page gave which figure is uncertain:
  - About **$137M cumulative profit since May 2023**.
  - TVL down from a **$604M peak to ~$184M**.
  - About **12–13 points** of return from market-making spread capture.
  - **HLP fee receipts: $7.15M in Q3 2025 vs $1.5M in Q2 2026**.
  - **0% performance fee; 4-day lock-up**.
  - Sources: [eco.com](https://eco.com/support/en/articles/15197987-hyperliquid-vault-strategies-2026-hlp-and-user-vaults-explained); [Datawallet](https://www.datawallet.com/crypto/hyperliquid-hlp-explained); [DexTools](https://www.dextools.io/tutorials/what-is-hyperliquid-hlp-vault-strategy-guide-2026); [VaultVision](https://vaultvision.tech/blog/hyperliquid-yield-guide); [Supa](https://supa.is/article/hyperliquid-hlp-vs-user-vaults-vs-hype-staking-best-yield-2026)
- **JELLY incident (March 2025; historical context).**
  - A manipulated short squeeze pushed a whale's short position onto HLP. A large JELLYJELLY long then drove the price up about 500%.
  - HLP's unrealized loss peaked at about **−$12M to −$13.5M**; sources differ.
  - **Validators delisted JELLY (26 Mar 2025)** and settled the position at a price that left about **$700K profit**.
  - HYPE reportedly fell about 20%.
  - Sources: [FXStreet, 26 Mar 2025](https://www.fxstreet.com/cryptocurrencies/news/hyperliquid-escapes-liquidity-crisis-following-jellyjelly-short-squeeze-delists-token-202503262225); [Boorghani (repost), "$13M tussle"](https://rss.boorghani.com/?p=294325); [Forklog](https://forklog.com/en/?p=22910)
- After JELLY, the vault "came back from the ashes" with **+$250M TVL in two months** (French headline). — [CoinAcademy](https://coinacademy.fr/?p=704476)
- **10–11 Oct 2025 crash (historical context):** the flash crash added **~$41.5M to HLP's PnL over one weekend, about a 10% gain for depositors**. This is a single secondary source. — [CoinGecko, HLP vault analysis](https://www.coingecko.com/learn/hyperliquid-hlp-vault-analysis)
- Liquidations on 10–11 Oct 2025: **Hyperliquid $10.31B vs Binance $2.41B** (preprint). — [Research Square preprint](https://www.researchsquare.com/article/rs-9459584/v1)
- Hyperliquid was one of only two top-10 chains (with TRON) whose DeFi TVL grew in H1 2026. — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value)

### Inferences
- **Who pays HLP:** traders, through liquidations, spreads and funding. HLP acts as a market maker and liquidation backstop. It tends to profit in disorderly crashes (October 2025). It is exposed to manipulation of illiquid listings (JELLY) and depends on discretionary validator action, which is a centralization risk; a future bailout cannot be assumed.
- **2026 returns look much lower than the historical average.** Trailing-month annualized returns of about 3–7% are close to T-bill levels, and quarterly fee receipts are down about 80% (Q3 2025 → Q2 2026). The 15–30% historical APRs reflect 2024–2025 volume and volatility; projecting them forward would be misleading.
- Any amount can be deposited (no minimum was verified), but the **4-day lock-up** means exit is delayed during stress.

### Gaps
- An official, time-weighted HLP return series for Sep–Oct 2026: not verified. The "3% past month" figure is ambiguous.
- **Lighter LLP, Aster, Drift and Jupiter JLP**: returns, drawdowns and incidents not collected.
- Any 2026 HLP loss events: not collected.

## 5. Liquidity provision: does LPing beat holding? (IL/LVR, fee yields)

### Takeaway
**Not researched this session** (search budget exhausted; arXiv unreachable). The only verified LP-relevant data point is a contract risk, not a fee or impermanent-loss statistic: the **Balancer v2 exploit (3 Nov 2025, ~$128M drained from pools)**. The well-known academic LP-profitability findings are listed under Gaps as *unverified* references.

### Cited Findings
- **Balancer v2 exploit (3 Nov 2025):**
  - Cause: a rounding error in `_upscaleArray`, combined with crafted batchSwaps, suppressed BPT prices.
  - Check Point: **$128.64M across six chains in under 30 minutes**. BlockSec: over $125M. OpenZeppelin: $120M+ including forks. Balancer's own post-mortem: **~$94.8M of user funds stolen**, partly recovered via white-hats and chain-level interventions.
  - Flash loans amplified the rounding issue (Bates White).
  - LP funds in the affected pools bore the loss.
  - Sources: [Check Point Research](https://research.checkpoint.com/2025/how-an-attacker-drained-128m-from-balancer-through-rounding-error-exploitation/); [BlockSec](https://blocksec.com/blog/in-depth-analysis-the-balancer-v2-exploit); [OpenZeppelin](https://www.openzeppelin.com/news/understanding-the-balancer-v2-exploit); [Balancer post-mortem](https://medium.com/balancer-protocol/nov-3-exploit-post-mortem-51dcbeb6b020); [Bates White](https://www.bateswhite.com/newsroom/publications/how-flash-loans-amplified-a-rounding-error-into-a-100-million-loss-by-Julian-Chan-and-Kory-Shipp)

### Inferences
- An LP's net return is fees minus impermanent loss / LVR minus gas and rebalancing costs, **and minus the risk of the pool contract itself** (Balancer). On top of that comes the price risk of the assets.

### Gaps
- **Not verified; background references only.** Verify before citing:
  - Loesch, Hindman, Richardson and Welch (Topaze Blue / Bancor), "Impermanent Loss in Uniswap v3", Nov 2021, arXiv:2111.09192. From memory, it reported that about **49.5% of Uniswap v3 LPs in its sample had negative returns vs. HODL**.
  - Milionis, Moallemi, Roughgarden and Zhang, "Automated Market Making and Loss-Versus-Rebalancing", 2022, arXiv:2208.06046. It is the reference paper on LVR, the adverse-selection cost that passive LPs pay to arbitrageurs.
  - Neither page could be fetched this session.
- **Current fee APRs on major pools** (Uniswap ETH/USDC, Curve stable pools, Aerodrome, Orca/Raydium) as of Sep–Oct 2026: not collected.

## 6. 2025–2026 blowups and losses hitting yield seekers

### Takeaway
In late 2025, yield seekers lost money in four main ways:
1. **Opaque off-chain strategies packaged as stablecoins.** Stream's xUSD lost $93M, which became about $285M of lender exposure. Elixir's deUSD fell to about 1.5¢.
2. **Contagion through curated vaults.** MEV Capital's Morpho USDC vaults took haircuts of 3.5% and 12%. Re7 Labs had about $27M of exposure.
3. **AMM bugs.** Balancer lost about $128M.
4. **Exchange-specific depegs.** USDe traded at $0.65 on Binance on 10 Oct 2025.

In 2026, **121 hacks and ~$942M of losses were recorded by about June** (CryptoRank). The largest was **Kelp DAO ($293M, 18 Apr 2026)**, which set off ~$15B of withdrawals from Aave.

### Cited Findings
#### 10–11 October 2025 crash (historical context)
- About **$19B of leveraged positions were liquidated** over 10–11 Oct 2025. The trigger was Trump's announcement of 100% tariffs on Chinese imports. — [CoinGecko](https://www.coingecko.com/learn/october-10-crypto-crash-explained)
- **USDe hit $0.65 on Binance** (preprint), or about $0.66 per Bit.com. It stayed near $1 on Curve and through Ethena's mint/redeem. Binance margin marked collateral at its own distressed price, which forced liquidations. — [Research Square](https://www.researchsquare.com/article/rs-9459584/v1); [Bit.com](https://www.bit.com/es/square/october-10-crypto-crash-binance-usde); [21Shares](https://www.21shares.com//research/why-did-ethenas-stablecoin-remain-stable-onchain-but-depegged-on-binance)
- Binance's data reportedly showed **75% of that day's liquidations happened before its internal prices deviated**. Binance reportedly paid **more than $328M in compensation**. Both are single secondary-source figures and unverified. — [Bit.com](https://www.bit.com/es/square/october-10-crypto-crash-binance-usde)
- One KuCoin article contradicts the others by claiming the risk engine avoided marking down collateral, so it is not relied on. That article (Sept 2026) also describes a **separate brief USDe wick to $0.92 on Binance in 2026**, details unverified. — [KuCoin blog](https://www.kucoin.com/blog/usde-depeg-binance-0-92-1011-contagion-risk)

#### Stream Finance xUSD / Elixir deUSD (November 2025)
- On about 3–4 Nov 2025, Stream disclosed that an **unnamed external fund manager had lost ~$93M** of Stream funds. It suspended deposits and withdrawals and hired Perkins Coie. One analysis found no smart-contract exploit. — [BeInCrypto](https://beincrypto.com/elixir-deusd-stablecoin-collapse-stream-finance-loss/); [Bitget News](https://www.bitget.com/amp/news/detail/12560605052425); [CoinNews](https://coinnews.com/news/elixir-halts-deusd-stablecoin-after-stream-finances-93m-collapse-sparks-market-turmoil/)
- Stream reportedly owed **~$285M to multiple lenders**, including **~$68M to Elixir**. — [BlockEden, 8 Nov 2025](https://blockeden.xyz/blog/2025/11/08/m-defi-contagion/)
- **xUSD fell to ~$0.26 within 24 hours**; some reports put the low at **$0.10**. — [KuCoin flash](https://www.kucoin.com/news/flash/2025-s-defining-crisis-stream-finance-collapse-and-elixir-depeg); [OurCryptoTalk](https://ourcryptotalk.com/blog/stream-finance-collapse-explained) (attribution uncertain)
- Elixir and deUSD:
  - Per Nansen, Elixir had placed **~65% of deUSD collateral with Stream**.
  - It processed redemptions for **~80% of deUSD holders** before the depeg.
  - **deUSD fell to ~$0.015** (CoinGecko data).
  - Elixir then **wound down deUSD**.
  - Sources: [BeInCrypto](https://beincrypto.com/elixir-deusd-stablecoin-collapse-stream-finance-loss/); [CryptoRank](https://cryptorank.io/news/feed/a6870-elixir-stablecoin-collapses-after-stream-finance-loss)

#### Curated-vault contagion: Morpho, Euler, Silo (November 2025)
- Re7 Labs disclosed:
  - **$14.65M** of exposure to an isolated xUSD/USDT0 cluster on Plasma.
  - **$12.75M** of exposure to bad sdeUSD/deUSD collateral across four Euler and Morpho markets.
- Silo reported **$15.4M** of user deposits exposed to xUSD vaults.
- **MEV Capital USDC vaults on Morpho** imposed **depositor haircuts of 3.5% on Ethereum and 12% on Arbitrum**.
- Morpho co-founder Merlin Egalite acknowledged **temporary liquidity shortages** in some Ethereum vaults as users de-risked.
- One article put total bad-debt exposure across lending protocols at $285M, which overlaps with the Stream lender figure.
- Sources (aggregator reposts): [MEXC News 162019](https://www.mexc.com/news/162019); [MEXC News 157092](https://www.mexc.com/news/157092); [MEXC News 156872](https://www.mexc.com/news/156872); [MEXC News, "Has DeFi learned anything from yield-vault collapse"](https://www.mexc.com/news/has-defi-learned-anything-from-yield-vault-collapse/171234)
- Morpho documentation: in **Vault v1.1, bad debt is not automatically realized across all depositors; "the last depositors will face the bad debt unless action is taken"**. — [Morpho docs, bad debt](https://docs.morpho.org/curation/tutorials/bad-debt); [Morpho docs v1](https://docs.morpho.org/curate/tutorials-v1/bad-debt/)

#### Balancer v2 (3 Nov 2025)
- About $128M, or $94.8M of user funds per Balancer; see section 5. — [Check Point](https://research.checkpoint.com/2025/how-an-attacker-drained-128m-from-balancer-through-rounding-error-exploitation/); [Balancer post-mortem](https://medium.com/balancer-protocol/nov-3-exploit-post-mortem-51dcbeb6b020)

#### Hyperliquid HLP / JELLY (March 2025)
- See section 4.

#### 2026 incidents
- **121 hacks, ~$942M lost year-to-date as of about June 2026** (CryptoRank). — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value); [KuCoin flash](https://www.kucoin.com/news/flash/defi-tvl-drops-39-in-2026-to-70b-amid-942m-in-hacks); [BlockchainReporter](https://blockchainreporter.net/defi-tvl-shrinks-39-in-2026-hacks-cost-942m-as-only-two-chains-grow)
- **Kelp DAO exploit, $293M, 18 Apr 2026**, followed by **~$15B of Aave withdrawals in four days**. — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value)
- **Aave USDC supply APY spiked to ~15% in April 2026.** — [MEXC flash](https://www.mexc.com/en-GB/news/flash/196129661)
- **Ethena, March 2026:** BTC and ETH funding turned negative and daily protocol fees fell 98%. This was a yield shock, not a loss of principal. — [Bitcoin Foundation](https://bitcoinfoundation.org/news/analysis/ethena-ena-price-prediction-2026-is-the-project-slowly-dying-or-just-cooling-off/) / [Stablecoin Insider](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/) (attribution uncertain)
- **MetaMask staking "security incident"** led to a validator exit from Lido (around October 2026); details unknown. — [KuCoin flash](https://www.kucoin.com/news/flash/lido-metamask-staking-validator-exit-near-completion-steth-apr-at-2-23)

### Inferences
- **Pattern:** losses clustered where yields were well above T-bills without a transparent source:
  - Off-chain "delta-neutral" managers (Stream).
  - Recursive minting (Stream/Elixir).
  - Curators accepting exotic collateral to lift vault APY (MEV Capital, Re7).
  - Exchange-specific collateral pricing (USDe on Binance).
- **Curated vaults shift losses onto whoever withdraws last** (Morpho v1.1 mechanics). That rewards running for the exit and turns credit events into liquidity crunches.
- **A stablecoin can hold its peg on-chain while depegging on a CEX where it serves as margin.** "Peg" depends on the venue.
- **2026 loss totals:** at ~$942M by June, DeFi hack losses in H1 2026 are significant. The Kelp DAO exploit alone accounts for about 31% of that.

### Gaps
- 2026 incidents after June (Q3 2026 hack totals; CertiK, Immunefi, Chainalysis, PeckShield reports): not collected.
- Kelp DAO: mechanism, recovery, any rsETH depeg, any Aave bad debt: not verified.
- An authoritative tally of losses realized by Morpho, Euler and Silo depositors from xUSD/deUSD: not found.
- Any 2026 losses at HLP or other perp vaults, Pendle, or yield-bearing stablecoins other than Ethena: not collected.

## 7. DeFi TVL trend (2025–2026) and benchmark rates: the real "crypto premium"

### Takeaway
DeFi TVL peaked around October 2025 and **fell every month in H1 2026, to ~$70–72B by June**. That is −37% to −39% year-to-date from about $115B in January. It then **rebounded to ~$94–96B by late September 2026**, +38% from 30 June. Meanwhile **risk-free rates rose**:
- **Fed funds: 3.75–4.00%** after a hike on 16 Sep 2026.
- **3-month T-bill: ~4.15%** on 13 Oct 2026.
- **ECB deposit rate: 2.50%** from 16 Sep 2026.
- **Livret A: 1.7%** from 1 Aug 2026.

The crypto premium for passive dollar yield is now **about zero, or negative, for blue-chip lending, sUSDS and tokenized T-bills**. It is **about +0.6 pp for sUSDe**. Only riskier strategies such as HLP have paid materially more historically, and less in 2026.

### Cited Findings
#### DeFi TVL
- About **−39% year-to-date, to ~$70B in late June 2026, from ~$115B in January**, a loss of roughly $45B (CryptoRank). Most of the decline is attributed to the market correction after the October 2025 peak. — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value); [KuCoin flash](https://www.kucoin.com/news/flash/defi-tvl-drops-39-in-2026-to-70b-amid-942m-in-hacks)
- Mid-June 2026: **$71.77B**, −37.3% year-to-date and **−59.6% from the November 2021 all-time high of $177.48B** (DefiLlama-based). — [Finbold](https://finbold.com/defi-tvl-falls-over-39-so-far-in-2026/); [CoinLaw](https://coinlaw.io/decentralized-finance-market-statistics/) (attribution uncertain)
- **Every month of 2026 (through June) saw a TVL contraction.** One outlet said TVL "could challenge" the 2022 lows; that was a projection, not a confirmed low. — [BeInCrypto](https://beincrypto.com/defi-tvl-decline-2026-downtrend/)
- Among the top-10 chains, **only TRON and Hyperliquid grew** in H1 2026. **Ethereum DeFi TVL fell ~43% to $38.91B.** TVL also moves with token prices, not only with deposits. — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value); [BlockchainReporter](https://blockchainreporter.net/defi-tvl-shrinks-39-in-2026-hacks-cost-942m-as-only-two-chains-grow)
- **Q3 2026 rebound:**
  - **$95.4B on 26 Sep 2026**, with a high of **$96.4B on 23 Sep**; **+38% vs 30 June**.
  - **Stablecoin supply** (DefiLlama peggedUSD): **~$311.6B on 26 Sep 2026**.
  - Source: [Dwellir, State of DeFi Q3 2026](https://www.dwellir.com/blog/state-of-defi-q3-2026)
- Other late-September snapshots:
  - **$94.2B (24 Sep)** and **$93.9B (21 Sep)**.
  - By chain on 21 Sep: Ethereum ~$52.7B, Solana ~$6.2B, Base ~$5.9B.
  - Sources: [NOWNodes](https://nownodes.io/blog/defi-explained-how-decentralized-finance-actually-works/); [InsideDeepTech](https://www.insidedeeptech.com/defi-industry-report-q3-2026/); [CompaniesHistory](https://www.companieshistory.com/decentralized-finance-market) (attribution uncertain; DefiLlama's own pages could not be loaded)
- DefiLlama defines TVL as the value of tokens locked in a protocol's contracts. — [DefiLlama docs](https://docs.llama.fi/)

#### US rates
- **Fed:**
  - **+25 bp to 3.75–4.00% on 16 Sep 2026**, voted 12-0. It was the **first hike since 2023**.
  - Stated aim: "support a quicker return" to the 2% inflation target. Coverage cited rising oil prices.
  - The previous easing cycle ended in December 2025 at 3.50–3.75%.
  - 16 of 18 officials see at least one more hike in 2026. The **median year-end 2026 projection is 4.1%**.
  - **Next FOMC: 28 Oct 2026.**
  - Sources: [CNBC, 16 Sep 2026](https://www.cnbc.com/2026/09/16/fed-rate-decision-september-2026.html); [Atlanta Fed, FOMC statement](https://www.atlantafed.org/news-and-events/2026/09/16/fomc-statement); [Chase](https://www.chase.com/personal/investments/learning-and-insights/article/federal-reserve-raises-rates-officials-signal-one-more-hike-in-2026); [Trading Economics](https://tradingeconomics.com/united-states/interest-rate); [Bondsavvy](https://www.bondsavvy.com/fixed-income-investments-blog/fed-dot-plot)
- **US 3-month T-bill:**
  - **4.15% on 13 Oct 2026**, 0.20 pp higher than a year earlier.
  - **4.23%** at the 8 Oct close.
  - **4.22%** on 5 Oct (par yield, Treasury data).
  - Sources: [Trading Economics](https://tradingeconomics.com/united-states/3-month-bill-yield); [Slickcharts](https://www.slickcharts.com/treasury/3-month); [StockMarketWatch](https://stockmarketwatch.com/bonds/3-month-treasury-yield)

#### Euro and French rates
- **ECB:**
  - **Deposit facility rate +25 bp to 2.50%**, decided 10 Sep 2026 and **effective 16 Sep 2026**.
  - Main refinancing rate 2.65%; marginal lending facility 2.90%.
  - This was the second hike of 2026. The first was on 11 Jun (to 2.25%), and the rate was held on 23 Jul.
  - Driver: energy-led inflation tied to the Middle East conflict.
  - **Next meeting: 29 Oct 2026.**
  - Sources: [ECB data portal, key rates](https://data.ecb.europa.eu/key-figures/ecb-interest-rates-and-exchange-rates/key-ecb-interest-rates); [DNB](https://www.dnb.nl/en/the-euro-and-europe/the-ecb-s-monetary-policy/ecb-interest-rates/); [OrbitRemit](https://blog.orbitremit.com/ecb-rate-decision-september-2026/); [Kagels Trading](https://kagels-trading.com/blog/ecb-interest-rate-decision/); [FinanceCalendar](https://www.financecalendar.com/event/ecb-rate-decision-september-2026/)
- **Livret A:**
  - **1.7% from 1 Aug 2026**, up from 1.5% since 1 Feb 2026, set on a proposal from the Banque de France.
  - Formula inputs: average H1 2026 inflation excluding tobacco **1.52%**; **average €STR 1.95% (Jan–Jun 2026)**.
  - **LDDS 1.7%; LEP 2.5%.**
  - The Cercle de l'Épargne had expected about 1.8%.
  - Sources: [Ministère de l'Économie, press release](https://presse.economie.gouv.fr/?p=181486); [info.gouv.fr](https://www.info.gouv.fr/actualite/augmentation-du-taux-du-livret-a-a-compter-du-1er-aout-2026); [La finance pour tous, 15 Jul 2026](https://www.lafinancepourtous.com/2026/07/15/livret-a-un-taux-de-17-au-1er-aout-2026/)

### Inferences
- **Crypto premium vs the US 3-month T-bill** (4.15% on 13 Oct 2026). These are my calculations from the figures above. The yield dates (Sept to early Oct) differ slightly from the T-bill date.

| Product (date) | Yield | Premium vs T-bill | Note |
|---|---|---|---|
| Aave v3 USDC, Ethereum (28 Sep) | ~3.58% | ≈ −0.6 pp | variable rate |
| Aave v3 USDT, Ethereum (28 Sep) | ~3.75% | ≈ −0.4 pp | |
| Sky sUSDS SSR (7 Oct) | 3.80% | ≈ −0.35 pp | governance-set |
| Tokenized T-bill funds, average (Sept, 7-day) | 3.50% | ≈ −0.65 pp | net of fees; lags the Fed hike |
| Compound v3 USDC (Sept) | ~4.5% (unresolved) | ≈ +0.35 pp | single roundup, conflicting data |
| Ethena sUSDe (28 Sep) | ~4.76% | ≈ +0.6 pp | incentives ended 30 Sep |
| HLP, trailing month (2026) | ~3–7% annualized | ≈ −1 to +3 pp | very volatile; ~22% over 12 months to Q2 2026 |
| stETH (6 Oct) | 2.23%, in ETH | ≈ −1.9 pp | not a USD yield |

- **For a French saver**, the hurdle is the **Livret A at 1.7% (tax-free, state-backed)**, or the **ECB deposit rate at 2.50%** for euro cash. Once USD yields are hedged to EUR (cost ≈ rate gap of ~1.4–1.7 pp), Aave USDC or sUSDS end up near 1.9–2.4% before tax. That is only slightly above Livret A, with much higher risk. Unhedged, EUR/USD exposure dominates the result.
- In 2026 both the Fed and the ECB **raised** rates because of an energy shock, while crypto-native yield sources shrank: funding rates, ENA incentives, HLP fees. That makes **2026 an unusually poor year for the risk/return of passive crypto dollar yield**.
- **TVL's fall and rebound** largely track crypto prices. The stablecoin supply (~$311.6B) is a better gauge of on-chain dollar liquidity.
- The €STR averaged 1.95% in H1 2026. After the +25 bp hikes in June and September it is probably near 2.4% now, but I did not verify this.

### Gaps
- Official DefiLlama end-of-September/October 2026 TVL, read directly (pages unreachable).
- Current €STR (October 2026) and EUR/USD hedging costs: not collected.
- French tax treatment of crypto yields vs tax-free Livret A/LEP: not covered here, and likely needed for the final comparison.

## 8. Best risk-adjusted passive strategies in 2026, and the main risk types

### Takeaway
On the evidence gathered, as of October 2026:
1. **For dollar cash, T-bills or tokenized T-bill funds are at least as good as DeFi lending**: about 3.5–4.2% with the fewest risk layers.
2. **Blue-chip over-collateralized lending (Aave) and the Sky Savings Rate (~3.6–3.8%)** are the lowest-risk DeFi yields, but they pay **no premium** over T-bills and carry run and liquidity risk (Aave after Kelp).
3. **sUSDe pays a thin premium (~+0.6 pp) with fat tails**: venue depeg, negative funding, and incentives now gone.
4. **HLP** has high historical returns but compressed 2026 returns, plus event and governance risk.
5. **Curated vaults and opaque "delta-neutral" stablecoins** caused the largest 2025 losses for yield seekers.
6. **ETH staking (~2.2–2.5%)** is an in-kind carry only for people who already want ETH exposure.

For a French investor, Livret A (1.7%, tax-free) and the ECB rate (2.50%) set a hurdle that hedged on-chain dollar yields barely clear.

### Cited Findings
#### Consolidated dated yield table (all figures from search summaries; see per-section sources)
| Strategy | Yield | As of | Where the yield comes from | Type of figure | Source |
|---|---|---|---|---|---|
| Lido stETH | 2.23% APR (in ETH) | ~6 Oct 2026 | ETH consensus and execution rewards, net of Lido's 10% fee | protocol-displayed, variable | [KuCoin flash](https://www.kucoin.com/news/flash/lido-metamask-staking-validator-exit-near-completion-steth-apr-at-2-23) |
| Lido stETH (earlier) | 2.5% / 2.4–2.6% | 27 Mar / late May 2026 | same | historical | [Coin Bureau](https://coinbureau.com/review/lido-finance-review); [web3wagmi](https://blog.web3wagmi.com/lido-guide) |
| Aave v3 USDC (Ethereum) | ~3.57–3.58% | 15 and 28 Sep 2026 | borrower interest (utilization) minus reserve factor | variable snapshot | [eco.com](https://eco.com/support/en/articles/15182156-usdc-yield-in-2026-where-to-earn-interest-on-usdc); [Stablecoin Insider](https://stablecoininsider.org/earn-stablecoin-yield-with-aave/) |
| Aave v3 USDT (Ethereum) | ~3.75% | 28 Sep 2026 | same | variable snapshot | [Stablecoin Insider](https://stablecoininsider.org/earn-stablecoin-yield-with-aave/) / [RebelFi](https://rebelfi.io/blog/usdc-yield-aave-v3-institutional-guide) |
| Aave v3 USDC (Base) | ~3.65% | 15 Sep 2026 | same | variable snapshot | [eco.com](https://eco.com/support/en/articles/15182156-usdc-yield-in-2026-where-to-earn-interest-on-usdc) |
| Compound v3 USDC | ~4.5% (conflicting 5.3–6.45%) | Sep 2026 | same | unresolved | [Aavescan](https://aavescan.com/rates/compound-v3-ethereum-usdc) |
| Sky sUSDS (SSR) | 3.80% (from 3.60%) | 7 Oct 2026 | governance-set rate paid from Sky protocol income | governance rate (secondary report; not officially confirmed) | [Coinfomania](https://coinfomania.com/sky-savings-rate-rises-to-3-80-enhancing-susds-capital/) |
| Ethena sUSDe | ~4.76% (30-day average 4.79%) | 28 Sep 2026 | perp funding/basis, increasingly lending and reserve income; ENA incentives ended 30 Sep | realized trailing | [Stablecoin Insider](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/) |
| Ethena sUSDe (earlier) | 9.4% → 7.1% | Apr → Jun 2026 | same | 7-day trailing, historical | [eco.com](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin) |
| Tokenized T-bill funds (market average) | 3.50% (7-day average); market $14.93B | Sep 2026 | US T-bills/repo minus fund fees | realized | [Stablecoin Insider](https://stablecoininsider.org/top-10-tokenized-treasury-funds-in-2026-buidl-benji-and-the-highest-yielding-on-chain-options/) (citing rwa.xyz) |
| Hyperliquid HLP | ~3–7% annualized (past month); ~22% net over 12 months to Q2 2026; 15–30% historical quarterly range | 2026 snapshots | market-making spreads, liquidations, funding (traders' losses) | realized trailing, very volatile | [Hyperliquid app](https://app.hyperliquid.xyz/vaults/0xdfc24b077bc1425ad1dea75bcb6f8158e10df303); [Finestel](https://finestel.com/blog/hyperliquid-vaults-explained/); [eco.com](https://eco.com/support/en/articles/15197987-hyperliquid-vault-strategies-2026-hlp-and-user-vaults-explained) |
| **Benchmark:** US 3-month T-bill | 4.15% | 13 Oct 2026 | US Treasury | market | [Trading Economics](https://tradingeconomics.com/united-states/3-month-bill-yield) |
| **Benchmark:** Fed funds | 3.75–4.00% | from 16 Sep 2026 | Fed | official | [CNBC](https://www.cnbc.com/2026/09/16/fed-rate-decision-september-2026.html) |
| **Benchmark:** ECB deposit rate | 2.50% | from 16 Sep 2026 | ECB | official | [ECB data portal](https://data.ecb.europa.eu/key-figures/ecb-interest-rates-and-exchange-rates/key-ecb-interest-rates) |
| **Benchmark:** Livret A / LDDS / LEP | 1.7% / 1.7% / 2.5% (tax-free) | from 1 Aug 2026 | French state | official | [Ministère de l'Économie](https://presse.economie.gouv.fr/?p=181486) |

Not in the table because unverified: Rocket Pool, SOL LSTs, restaking, Spark, Morpho, Euler, Maple, Usual, Falcon, Resolv, Pendle PTs, Lighter, Aster, Drift, JLP, Uniswap/Curve LP fees, and Coinbase, Binance, Kraken and OKX earn.

#### Risk types, with 2025–2026 evidence (sources in sections 4–7)
- **Smart-contract / protocol bugs:** Balancer v2, ~$128M (Nov 2025); Kelp DAO, $293M (Apr 2026); 121 hacks and ~$942M in H1 2026. — [Check Point](https://research.checkpoint.com/2025/how-an-attacker-drained-128m-from-balancer-through-rounding-error-exploitation/); [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value)
- **Off-chain counterparty / manager risk:** Stream's external fund manager lost ~$93M. — [BeInCrypto](https://beincrypto.com/elixir-deusd-stablecoin-collapse-stream-finance-loss/)
- **Depeg risk:** xUSD fell to $0.26 (or $0.10); deUSD to ~$0.015; USDe to $0.65 on Binance (Oct 2025) and $0.92 on Binance (2026 wick). — [BeInCrypto](https://beincrypto.com/elixir-deusd-stablecoin-collapse-stream-finance-loss/); [21Shares](https://www.21shares.com//research/why-did-ethenas-stablecoin-remain-stable-onchain-but-depegged-on-binance); [KuCoin blog](https://www.kucoin.com/blog/usde-depeg-binance-0-92-1011-contagion-risk)
- **Curator / risk-management risk:** MEV Capital Morpho vault haircuts of 3.5% and 12%; Re7 exposure of ~$27M; under Morpho's design, losses fall on the last withdrawers. — [MEXC News](https://www.mexc.com/news/162019); [Morpho docs](https://docs.morpho.org/curation/tutorials/bad-debt)
- **Liquidity / run risk:** ~$15B left Aave in four days (Apr 2026); temporary liquidity shortages in Morpho vaults (Nov 2025); Stream froze withdrawals; HLP has a 4-day lock-up. — [Cointelegraph](https://cointelegraph.com/news/defi-tvl-falls-39-2026-erases-45b-value); [MEXC News](https://www.mexc.com/news/171234)
- **Strategy / yield-source risk:** in March 2026 negative funding cut Ethena's daily fees by 98%; ENA incentives ended on 30 Sep; HLP fee receipts fell ~80% between Q3 2025 and Q2 2026. — [Bitcoin Foundation](https://bitcoinfoundation.org/news/analysis/ethena-ena-price-prediction-2026-is-the-project-slowly-dying-or-just-cooling-off/); [Crypto Briefing](https://cryptobriefing.com/ethena-ends-usde-token-incentives/)
- **Market manipulation / governance discretion:** JELLY squeeze on HLP, resolved by validators delisting the token (Mar 2025). — [FXStreet](https://www.fxstreet.com/cryptocurrencies/news/hyperliquid-escapes-liquidity-crisis-following-jellyjelly-short-squeeze-delists-token-202503262225)
- **Venue / oracle risk:** Binance margin priced USDe off its own order book. — [21Shares](https://www.21shares.com//research/why-did-ethenas-stablecoin-remain-stable-onchain-but-depegged-on-binance)
- **Macro / opportunity-cost risk:** the Fed and ECB both hiked in 2026, so the risk-free hurdle rose. — [CNBC](https://www.cnbc.com/2026/09/16/fed-rate-decision-september-2026.html); [OrbitRemit](https://blog.orbitremit.com/ecb-rate-decision-september-2026/)
- **Regulatory risk (MiCA / EU):** not verified this session; see Gaps.

### Inferences
- **Who makes money, and from whom:**
  - Lenders earn from leveraged borrowers and loopers.
  - sUSDe holders earn from leveraged longs paying funding, and from lending and reserve income.
  - HLP earns from traders' losses and spreads.
  - Tokenized T-bill holders earn from the US Treasury.
  - Stakers earn from ETH issuance and fees.
  - When leverage demand dries up, as in H1 2026, every crypto-native yield source shrinks at the same time, while T-bill yields don't.
- **A realistic tiered view for October 2026**, ranked by risk:
  - Tier 0: Livret A / ECB deposit rate / T-bills, 1.7–4.2% depending on currency and tax.
  - Tier 1: tokenized T-bills, Sky SSR, Aave USDC/USDT, ~3.5–3.8% in USD.
  - Tier 2: sUSDe, ~4.8%, or Compound v3 at ~4.5% if confirmed.
  - Tier 3: HLP and other perp vaults, ~3–7% recently and 15–30% historically, with lumpy outcomes.
  - Tier 4: curated vaults on exotic collateral, points-driven restaking, and new yield stablecoins. This tier produced most of the 2025–2026 losses.
- **Above Tier 1, extra yield has mostly paid for tail risk rather than skill.** The sUSDe premium (~0.6 pp) is smaller than a single depeg or haircut such as MEV Capital's 3.5–12%. HLP is the exception with genuinely higher historical realized returns, but they are compressing.
- **Capital required:**
  - No minimums were verified.
  - The table carries no transaction costs, gas or bridging; for small tickets these can absorb a sub-1-pp premium.
  - The hedging cost (~1.4–1.7 pp) applies to euro investors who want to avoid FX risk.
  - Taxes apply to crypto yields; Livret A is tax-exempt.

### Gaps
- Systematic risk-adjusted comparisons (Sharpe or drawdown studies) of DeFi yield strategies in 2026, e.g. from Steakhouse, Kaiko, Galaxy, Messari or Blockworks: not collected.
- **MiCA / EU rules on earn and staking products and on non-compliant stablecoins** (USDT, USDe) for French users in 2026; position of the AMF and ESMA: not collected.
- **CeFi earn rates** (Coinbase USDC rewards, Binance Simple Earn, Kraken, OKX) and their counterparty risk: not collected.
- **French tax treatment** of staking and DeFi income: not covered here.
- Every item listed under the Gaps of sections 1–5 applies here as well.

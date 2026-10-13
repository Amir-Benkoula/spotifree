# Bots de trading, MEV et automatisation en crypto : qui gagne de l'argent, combien, et à quel prix (situation au 13 octobre 2026)

> **Note méthodologique, à lire avant toute réutilisation.** La recherche a été faite le 13/10/2026. Depuis l'environnement de recherche, il a été impossible d'ouvrir directement les pages primaires : DefiLlama (y compris son API), Dune, l'explorateur Jito, mevboost.pics, EigenPhi, arXiv, CoinDesk, The Block, Decrypt et Solana Compass étaient bloqués par le réseau ou par le DNS. De plus, le quota de recherches web de la session a été épuisé avant que tous les axes soient couverts. Les chiffres viennent donc **d'extraits de résultats de recherche** et chacun renvoie à l'URL de sa page source. Quand un extrait résumait plusieurs pages à la fois et qu'on ne pouvait pas attribuer un chiffre à une page précise, **toutes les URL candidates sont citées** avec la mention « attribution incertaine ». Seules sources consultées en texte intégral : les README GitHub de Freqtrade, Hummingbot et Jesse (13/10/2026). Une grande partie des sources 2026 sur les bots sont des sites comparatifs ou affiliés qui touchent des commissions de parrainage, donc de fiabilité moyenne à faible. Le tag **[HISTORIQUE]** marque toute donnée de plus d'environ 6 mois, c'est-à-dire antérieure à mi-avril 2026. Les axes suivants sont **insuffisamment couverts** : bots CEX (rendements), algo DIY (retours de praticiens), arbitrage CEX–DEX et cross-chain, tokens ai16z/aixbt, exploits de bots Telegram (Banana Gun 2024, etc.), spécificités France/UE. Pour ces axes, les sections « Gaps » indiquent des pistes précises à vérifier. Pour la fiscalité et la réglementation France/UE, voir le fichier `12_fiscalite_reglementation_france_ue.md` produit par un autre chercheur.

## 1. Terminaux de trading Telegram/web et sniper bots (Axiom, Photon, BullX, GMGN, Trojan, BonkBot, Maestro, Banana Gun, Padre/Terminal, Bloom) : revenus, utilisateurs, parts de marché, part d'utilisateurs rentables

### Takeaway
En 2026, l'argent des bots memecoin va d'abord aux **opérateurs**, qui prennent environ 1 % de frais par trade et reversent 20 à 35 % de ces frais aux parrains.
- **Axiom** domine. Selon les instantanés 2026, il encaisse environ 22 à 39 M$ de frais sur 30 jours, soit environ 39 à 55 % des frais du segment selon la méthode. **GMGN** est n°2 (environ 36 % selon une estimation).
- **Photon** s'est effondré : environ 0,5 à 0,6 M$ par mois mi-2026, contre 84,6 M$ en janvier 2025.
- **Pump.fun** a racheté **Padre** (octobre 2025) pour capter ce flux.

Côté utilisateurs, la meilleure preuve disponible est historique : selon Dune (Pump.fun, janvier 2025), environ 0,4 % des portefeuilles avaient réalisé plus de 10 000 $ de gains. Les pourcentages « mensuels » publiés en 2026 se contredisent. Aucune donnée publique fiable n'a été trouvée sur la part d'utilisateurs rentables d'un terminal donné.

### Cited Findings
**Revenus et parts de marché (2026)**
- Page Axiom de DefiLlama (instantané non daté dans l'extrait, indexé au plus tard le 13/10/2026) : **39,27 M$ de frais sur 30 jours, dont 18,81 M$ de « protocol revenue »** — [DefiLlama – Axiom](https://defillama.com/protocol/axiom)
- Un comparatif 2026 attribue à Axiom **22,35 M$ de frais sur 30 jours et 55,3 %** des frais d'une cohorte de terminaux (Axiom, Photon, GMGN, fomo, Trojan). Une autre lecture des données DefiLlama place Axiom à **environ 39 %** des catégories « Trading App » et « Telegram Bot » réunies, et **GMGN à environ 36 %**. Ce sont des sites affiliés et l'attribution exacte entre les pages est incertaine. L'écart de 22 à 39 M$ pour Axiom vient probablement de dates ou de définitions différentes — [Axiompedia – comparatif des frais 2026](https://axiompedia.com/compare) ; [TheTradingMarkets – Axiom Trade Review 2026](https://thetradingmarkets.com/axiom-trade-review-2026/)
- Un classement de juin 2026 « basé sur Blockworks » donne à Axiom **44,6 % du volume spot quotidien sur Solana**, contre **1,7 % pour Photon**. D'autres trackers revendiquent 60 à 72 % pour Axiom, sans source solide. Attribution incertaine — [Moby – Best Solana trading apps 2026](https://moby.win/best/solana-trading-apps-2026/) ; [Axiompedia – Axiom vs Photon (2026)](https://axiompedia.com/compare/axiom-vs-photon)
- **Effondrement de Photon** : environ 0,5 M$ de frais par mois mi-2026, contre un pic de **84,6 M$ en un seul mois (janvier 2025)**. Données DefiLlama citées : environ **0,59 M$ de frais sur 30 jours au 14/08/2026** et environ **441 M$ de frais cumulés**. Sites tiers, attribution incertaine — [Photonguides – What is Photon (2026)](https://photonguides.com/ecosystem/what-is-photon) ; [Memegateway – Photon review 2026](https://memegateway.com/bot/photon/)
- Identité de Photon incertaine : certains sites disent que Photon a été « rebrandé » en Axiom fin 2025, d'autres le traitent comme un produit distinct toujours en ligne (photon-sol.tinyastro.io). Non tranché — [Memegateway – Axiom (ex-Photon) guide](https://memegateway.com/academy/axiom-trading-bot-guide/) ; [Photonguides](https://photonguides.com/ecosystem/what-is-photon)
- L'affirmation « Axiom a fait 100 M$ de revenus en quatre mois » ne vient que de sites secondaires, sans communication vérifiable de l'entreprise. **Non vérifié** — [TheTradingMarkets](https://thetradingmarkets.com/axiom-trade-review-2026/)
- Contexte macro : selon PANews (T1 2026), les revenus du réseau Solana ont baissé de **68 % sur un an** et la base de développeurs de **30 %** — [PANews – Solana Q1 report](https://panewslab.com/en/articles/019da9c6-e9d5-76c0-904a-878418fd7fbc)

**Bots Telegram (chiffres auto-déclarés, mars–avril 2026)**
Pour les quatre points ci-dessous, l'attribution exacte entre les sites cités est incertaine.
- **Banana Gun** : environ **16,09 Md$ de volume cumulé, 25,3 M de trades et 1,3 M d'utilisateurs** (mars 2026, auto-déclaré, non audité). Le bot promet de reverser 40 % des frais aux détenteurs de $BANANA, mais une source signale qu'une vérification on-chain ponctuelle ne l'a pas confirmé — [Nerdbot (17/04/2026)](https://nerdbot.com/2026/04/17/best-telegram-trading-bots-in-2026-7-platforms-tested-for-speed-fees-and-mev-protection/) ; [AMBCrypto – Top 11 Telegram trading bots (mars 2026)](https://ambcrypto.com/top-11-telegram-trading-bots-of-march-2026/) ; [Dropstab](https://dropstab.com/research/product/top-telegram-trading-bots-for-crypto)
- **Trojan** : environ 25 Md$ de volume cumulé et environ 2 M d'utilisateurs, sans token ni partage de revenus.
  **Maestro** : environ 12,8 Md$ de volume cumulé et plus de 573 000 utilisateurs ; un abonnement mensuel s'ajoute aux frais par trade.
  **BONKbot** : frais fixe de 1 % ; 100 % des frais servent à racheter du BONK, dont 10 % sont brûlés.
  Sources : [Nerdbot](https://nerdbot.com/2026/04/17/best-telegram-trading-bots-in-2026-7-platforms-tested-for-speed-fees-and-mev-protection/) ; [Crawlux](https://www.crawlux.com/blog/best-telegram-trading-bot/) ; [Kulfiy](https://www.kulfiy.com/telegram-trading-bots-in-2026-how-they-work-what-they-cost-which-one-to-pick/)
- **Modèle économique** : les frais par trade tournent autour de **1 %** et les programmes de parrainage reversent **20 à 35 %** des frais des filleuls — [Openliquid – guide 2026](https://openliquid.io/telegram-trading-bot/) ; [Nerdbot](https://nerdbot.com/2026/04/17/best-telegram-trading-bots-in-2026-7-platforms-tested-for-speed-fees-and-mev-protection/)

**Padre devient « Terminal » de Pump.fun [HISTORIQUE, mais structurant pour 2026]**
- Le 24/10/2025, Pump.fun rachète le terminal multichaîne Padre (Solana, BNB Chain, Ethereum L1, Base) pour un montant non divulgué. Son cofondateur Alon Cohen justifie le rachat : les terminaux ont « captured most trading volumes in the ecosystem » sur l'année écoulée, et le rachat était un « no-brainer » — [Crypto Briefing](https://cryptobriefing.com/pump-fun-acquires-padre-trading-terminal-multi-chain-expansion/) ; [Coin Edition](https://coinedition.com/pumpfun-acquires-padre-faster-multichain-trading/) ; [TradingView/Cointelegraph](https://www.tradingview.com/news/cointelegraph:747d37f84094b:0-pump-fun-expands-with-padre-acquisition-as-memecoin-market-cools/)
- Le token PADRE perd son utilité et chute de **plus de 76 %** (de plus de 0,076 $ à 0,011 $). Des utilisateurs parlent de « rug ». Après la polémique, une compensation en PUMP est promise selon DL News (cité par Solbotrank) — [crypto.news](https://crypto.news/padre-token-dumps-after-pump-fun-acquires-trading-terminal/) ; [CoinCentral](https://coincentral.com/pump-fun-acquires-padre-trading-terminal-and-discards-padre-token-utility/) ; [Solbotrank](https://solbotrank.com/guides/padre-terminal-explained)
- Padre est renommé « Terminal » et devient le produit de trading phare de Pump.fun — [Terminalpedia (auteur indépendant)](https://terminalpedia.com/ecosystem/what-is-terminal) ; [BloFin Academy](https://blofin.com/en/academy/education/pumpfun/pump-fun-terminal-explained)

**Rentabilité des utilisateurs (proxy : Pump.fun)**
- [HISTORIQUE, janvier 2025] Analyse Dune d'Adam Tehc, sur environ 13,55 M de portefeuilles et en gains **réalisés** seulement :
  - environ **55 296 portefeuilles (≈ 0,4 %)** ont réalisé plus de 10 000 $ ;
  - **0,048 %** ont réalisé plus de 100 000 $ ;
  - environ **293 portefeuilles (0,00217 %)** ont réalisé plus de 1 M$.
  Sources : [Cointelegraph](https://cointelegraph.com/news/pump-fun-crypto-traders-majority-do-not-realize-profits-dune-data) ; [ChainCatcher](https://www.chaincatcher.com/en/article/2161942)
- Le fondateur de Pump.fun conteste ces chiffres : l'analyse ignore les achats faits après la migration vers Raydium, beaucoup de portefeuilles sont des bots ou des agents IA, et environ 30 % n'ont fait qu'une seule transaction. L'analyste Alon estime que le vrai nombre de portefeuilles rentables pourrait être 10 fois plus élevé — [ChainCatcher](https://www.chaincatcher.com/en/article/2161945)
- **2026 : deux sources se contredisent directement sur mars.**
  - Selon la première, **50,6 %** des traders Pump.fun étaient en perte en mars 2026, et **45,4 %** de plus avaient gagné moins de 500 $ — [OurCryptoTalk](https://ourcryptotalk.com/news/pump-fun-96-percent-traders-losing-money)
  - Selon la seconde, la part de portefeuilles « rentables » est passée de **50,1 % (janvier 2026)** à **56,8 % (février)**, **70,0 % (mars)** puis **73,3 % (avril)** — [CoinsProbe](https://coinsprobe.com/pump-fun-traders-are-finally-making-money-profitability-hits-ath-after-two-years/)

### Inferences
- **Le terminal est un péage sur le volume.** Il prend environ 0,75 à 1 % par trade et reverse une partie aux parrains. L'opérateur gagne donc quel que soit le résultat de l'utilisateur.
  - Ordre de grandeur pour Axiom en 2026 : 22 à 39 M$ sur 30 jours, soit environ 0,27 à 0,47 Md$ par an une fois annualisé. C'est une extrapolation, pas un chiffre publié.
  - L'écart entre frais (39,27 M$) et « revenue » (18,81 M$) sur DefiLlama pourrait refléter les reversements de parrainage et de cashback. C'est une hypothèse non vérifiée.
- **Le marché est très concentré et instable.** Les frais de Photon ont baissé d'environ 99 % entre janvier 2025 et mi-2026. La rente dépend du cycle memecoin et d'une logique où le gagnant prend presque tout. Les tokens de bots (BANANA, PADRE) ajoutent un risque propre aux détenteurs.
- **Les pourcentages 2026 de « portefeuilles rentables » sont probablement biaisés par la survie.** Les perdants arrêtent de trader, et la base restante est plus professionnelle et compte plus de bots. Le comptage se fait aussi par portefeuille (une personne en possède souvent plusieurs, et les bots sont inclus). Il ne faut pas les lire comme « 73 % des particuliers gagnent ».
- Les volumes et nombres d'utilisateurs cumulés des bots Telegram sont auto-déclarés et relayés par des sites affiliés payés en commissions de parrainage (20 à 35 %), ce qui crée un **conflit d'intérêts**.

### Gaps
- DefiLlama (catégories « Telegram Bot » et « Trading App ») et les dashboards Dune n'étaient pas accessibles. Les revenus annuels 2025 et cumulés 2026 ne sont donc pas vérifiés pour GMGN, BullX, Bloom, Trojan, Maestro, Banana Gun et Pump.fun Terminal, pas plus que le total du secteur.
- Aucune donnée publique trouvée sur la **part d'utilisateurs rentables par terminal** (Axiom, Photon, GMGN…). Pump.fun reste le seul proxy disponible.
- Pas de nombre d'**utilisateurs actifs 2026** par plateforme, seulement des cumuls auto-déclarés.
- Part de marché 2026 de Pump.fun Terminal (ex-Padre) non trouvée.

## 2. Copy-trading et suivi de portefeuilles (Cielo, GMGN copy trade, Kolscan, « smart money ») : est-ce que ça marche, et les copieurs se font-ils front-runner ?

### Takeaway
Aucune preuve chiffrée indépendante ne montre que copier la « smart money » soit rentable pour les copieurs. À l'inverse, des travaux académiques décrivent des bots de front-running et de dissimulation, ainsi que des KOL multi-portefeuilles qui exploitent leurs copieurs. Il existe aussi un cas concret et grave. **Fin février 2026**, ZachXBT a accusé un employé d'**Axiom** d'avoir utilisé des outils internes pour pister les portefeuilles d'utilisateurs et de KOL et trader avant eux, « depuis début 2025 ». Axiom a reconnu un abus de ses outils internes.

### Cited Findings
- Un article de chercheurs UCL, « Resisting Manipulative Bots in Meme Coin Copy Trading: A Multi-Agent Approach with Chain of Thought Reasoning » (date non visible dans l'extrait), décrit des « frontrunning and concealment bots » qui ciblent les copieurs. Extrait : « Extreme illiquidity and high volatility, combined with the naïveté of copy traders, create an ideal environment for exploitation. » Il décrit aussi un KOL qui coordonne plusieurs portefeuilles pour sortir et dumper le memecoin une fois les copieurs entrés. C'est un schéma modélisé : les données empiriques ne sont pas visibles dans l'extrait — [UCL Discovery (PDF)](https://discovery.ucl.ac.uk/id/eprint/10220650/1/Resisting_Manipulative_Bots_in_Meme_Coin_Copy_Trading__A_Multi_Agent_Approach_with_Chain_of_Thought_Reasoning.pdf)
- Le même papier note que Solana n'a pas de mempool publique où les transactions resteraient longtemps visibles : elles sont transmises directement aux validateurs. La capacité de réagir se concentre donc chez les acteurs les mieux connectés — [UCL Discovery (PDF)](https://discovery.ucl.ac.uk/id/eprint/10220650/1/Resisting_Manipulative_Bots_in_Meme_Coin_Copy_Trading__A_Multi_Agent_Approach_with_Chain_of_Thought_Reasoning.pdf)
- **Autopromotion d'un fournisseur RPC (non indépendant)** : son bot passerait ses transactions dans le même slot que des portefeuilles KOL suivis sur Kolscan, et aurait réussi à « front-run or follow » ces traders. Date non visible — [RPC Fast – case study](https://rpcfast.com/blog/copy-trading-bot-case-study)
- **Affaire Axiom [HISTORIQUE récent, février 2026]**. ZachXBT accuse Broox Bauer, employé senior en business development chez Axiom (société soutenue par Y Combinator) :
  - il aurait abusé des outils internes pour « look up sensitive user details to insider trade by tracking private wallet activity since early 2025 » ;
  - ces outils permettent de relier plusieurs portefeuilles à une même personne ;
  - il aurait tenu un tableur Google de portefeuilles de KOL ciblés, pour acheter avant leurs « shills » ;
  - dans des extraits audio qui lui sont attribués, il affirme pouvoir pister « any Axiom user » à partir d'un code de parrainage, d'une adresse ou d'un UID.
  Sources : [Decrypt](https://decrypt.co/359223/y-combinator-backed-axiom-employees-accused-insider-trading-zachxbt) ; [Yahoo Finance](https://finance.yahoo.com/news/zachxbt-investigation-accuses-axiom-employee-141228617.html) ; [Galaxy – Weekly Top Stories 27/02/2026](https://www.galaxy.com/insights/research/weekly-top-stories-02-27-26)
- Réponse d'Axiom : « We are shocked and disappointed to hear that someone on our team abused internal customer support tools to look up user wallets ». L'accès aux outils a été retiré et une enquête est en cours — [Decrypt](https://decrypt.co/359223/y-combinator-backed-axiom-employees-accused-insider-trading-zachxbt) ; [Datawallet Daily](https://datawallet.beehiiv.com/p/zachxbt-accuses-axiom-employees-of-crypto-insider-trading)
- Environ 3 heures avant la publication de l'enquête, des portefeuilles tout juste créés ont parié massivement sur Polymarket qu'Axiom serait la cible. Un délit d'initié est possible mais n'est pas établi — [Cryptopolitan](https://cryptopolitan.beehiiv.com/p/zachxbt-s-investigation-got-front-run)
- Ce qui s'écrit en 2026 sur les outils grand public (Kolscan, GMGN copy trade, Cielo, etc.) est surtout fait de listes affiliées promettant des gains invérifiables — [MadeOnSol – Best copy trading 2026](https://madeonsol.com/best/copy-trading) ; [Walletmaster – Solana copy trading tools 2026](https://www.walletmaster.tools/blog/best-solana-copy-trading-tools/)

### Inferences
- **Le copieur arrive toujours après le portefeuille copié**, à cause du temps de détection puis d'envoi de la transaction. Sur des marchés très illiquides, il achète donc plus cher. Il sert ensuite de liquidité de sortie si le portefeuille suivi (ou un KOL multi-portefeuilles) revend. La « smart money » la plus visible est donc aussi la moins exploitable.
- **L'affaire Axiom montre un risque propre aux terminaux centralisés.** L'opérateur voit le flux d'ordres et peut relier plusieurs portefeuilles à une même identité. Face à lui, l'anonymat par portefeuilles multiples n'existe pas.
- **Les classements de portefeuilles (Kolscan, etc.) ont un biais du survivant.** On y voit a posteriori les portefeuilles gagnants, pas les milliers de portefeuilles comparables qui ont perdu.

### Gaps
- Aucune étude on-chain trouvée qui mesure le rendement net des copieurs (Cielo, GMGN copy trade, Kolscan) ou la fréquence du front-running ciblant les copieurs.
- Le profit allégué dans l'affaire Axiom n'est pas confirmé : les sources divergent. Un chiffre de « 400 000 $+ » sur environ 10 mois circule dans un résumé de résultats de recherche, sans source primaire identifiée. Les suites (poursuites, remboursements) ne sont pas vérifiées.
- La date et les données empiriques du papier UCL ne sont pas vérifiées (PDF non ouvert).

## 3. Le MEV en 2026 (Ethereum et Solana) : valeur extraite, qui la capte (searchers, builders, validateurs), concurrence pour les nouveaux entrants, pertes des particuliers par sandwich

### Takeaway
Le MEV reste une **industrie de professionnels très concentrée**.

**Sur Solana**, la valeur payée via Jito s'est effondrée en 2026 avec le reflux des memecoins, et l'économie bascule vers les priority fees :
- pourboires Jito : **19,85 M$ au T1 2026, puis 9,9 M$ au T2 2026** ;
- revenu du protocole Jito : 1,28 M$ au T2 2026, en **baisse pour le 5e trimestre consécutif**.

Les sandwiches coûtent toujours aux particuliers : au moins 7,7 M$ mesurés sur environ 4 mois début 2025 dans les bundles Jito. Des estimations bien plus élevées circulent mais ne sont pas vérifiées.

**Sur Ethereum**, aucune statistique officielle 2026 n'a pu être vérifiée. Les estimations agrégées non officielles parlent d'environ 2,2 Md$ en 2025. La valeur captée par les validateurs via MEV-Boost recule en 2026, la construction des blocs est dominée par BuilderNet et Titan, et les relais par Ultra Sound, Titan et bloXroute.

### Cited Findings
**Solana**
- Rapport Jito du T2 2026 pour les détenteurs du token (Blockworks Advisory, publié vers le T3 2026) :
  - revenu du protocole **1,28 M$, en baisse de 45 % sur le trimestre**, 5e baisse trimestrielle consécutive depuis le pic de **26,1 M$ au T1 2025** ;
  - pourboires traités **9,9 M$ au T2 2026, contre 19,85 M$ au T1** (environ −50 %) ;
  - nombre de transactions stable, autour de 1,045 Md (+0,13 %) ;
  - « Solana's transaction economics continue to shift toward priority fees and away from out-of-protocol tips » ;
  - BAM (Block Assembly Marketplace) atteint **33 % du stake Solana**.
  Sources : [Solana Compass – Jito Q2 2026](https://solanacompass.com/news/jito-q2-2026-protocol-revenue-falls-45-to-128m-as-bam-reaches-33-of-solana-stake) ; [Blockworks sur X – Jito Q2 Token Holder Report](https://x.com/Blockworks/article/2086815115874013246)
- Messari, State of Solana T1 2026 : la « Real Economic Value » (frais de vote, de base et de priorité, plus pourboires MEV versés aux validateurs) passe de **90,2 M$ au T4 2025 à 89,5 M$ au T1 2026** (−1 %) — [Messari](https://messari.io/report/state-of-solana-q1-2026)
- PANews, T1 2026 : pourboires Jito **en baisse de 19,7 % sur le trimestre et de 72,3 % sur un an** — [PANews](https://panewslab.com/en/articles/019da9c6-e9d5-76c0-904a-878418fd7fbc)
- Papier de mesure présenté à la conférence IMC 2026, « Quantifying the Threat of Sandwiching MEV on Jito » [données HISTORIQUES : plus de 4 mois de données Jito, début 2025] :
  - **521 903 attaques sandwich**, pour un coût de **plus de 7,7 M$** pour les utilisateurs ;
  - **plus de 86 %** des bundles Jito ne contiennent qu'une seule transaction, avec un pourboire trop faible pour obtenir une priorité. Les utilisateurs se servent donc des bundles surtout pour se protéger du MEV.
  Source : [IMC 2026 (PDF)](https://cnitarot.github.io/papers/imc26_solana.pdf)
- [HISTORIQUE, fin 2025 environ, date approximative] Selon des chercheurs, **93 %** des attaques sandwich observées étaient des « wide sandwiches » : les transactions d'avant et d'après ne sont pas dans le même bloc. Jito a banni **15 validateurs supplémentaires** pour sandwich — [CryptoRank](https://cryptorank.io/news/feed/4d1c4-jito-bans-15-additional-validators-after-data-emerges-of-widespread-sandwich-attacks) ; [BitcoinEthereumNews](https://bitcoinethereumnews.com/finance/jito-cracks-down-on-solana-validators-after-on-chain-report-exposes-mev-abuse/)
- Un article de 2026 explique que les règles « do-not-front-run » de Jito ne couvrent pas les sandwiches étalés sur plusieurs slots. Il cite une estimation de **370 à 500 M$** extraits des utilisateurs Solana par les bots sandwich **sur 16 mois**. Source primaire non identifiée, **non vérifié** — [Graphdex – MEV on Solana 2026](https://graphdex.io/en/blog/what-is-mev-solana-2026)
- [HISTORIQUE] Selon une analyse interne de Jito rapportée par Helius, près de la moitié des sandwiches sur Solana venaient d'un seul programme (vpeNAL…oax38b). Helius donne l'exemple d'un bundle sandwich avec un pourboire de 0,000148 SOL, soit environ 0,03 $ — [Helius – Solana MEV Report](https://www.helius.dev/blog/solana-mev-report)
- Des guides de 2026 donnent un pourboire Jito « typique » de 0,001 à 0,01 SOL par transaction. Attribution incertaine — [SmartContractAudit – Solana MEV & Jito 2026](https://www.smartcontractaudit.com/guides/solana-mev-jito-bundle-security-2026) ; [Arbitrage Scanner – Solana MEV guide 2026](https://arbitragescanner.io/blog/solana-mev-arbitrage-guide-2026)
- Un vendeur affirme au contraire que les pourboires Jito représentent plus de 60 % du volume des priority fees en 2025–2026. C'est en conflit avec la tendance mesurée par Blockworks — [RPC Fast – Jito explained](https://rpcfast.com/blog/jito-explained-bundles-tips-mev-solana)

**Ethereum**
- Taille annuelle du MEV (estimations agrégées, non officielles) : environ **1,8 Md$ en 2024, 2,2 Md$ en 2025 et « près de 2,5 Md$ » en 2026**. D'autres sources disent seulement « de quelques centaines de millions à plusieurs milliards selon la méthode ». Faible fiabilité, d'autant que l'année 2026 n'est pas terminée. Attribution incertaine — [VaaSBlock – MEV in 2026](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/) ; [Web3wagmi – MEV reference 2026](https://blog.web3wagmi.com/what-is-mev-guide)
- Adoption de MEV-Boost, selon des estimations de blogs : environ **90 % des blocs**, ou environ **92 % des validateurs stakés**. Attribution incertaine — [Plisio – MEV bot guide 2026](https://plisio.net/crypto/mev-bot) ; [VaaSBlock](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/)
- Parts des relais :
  - [HISTORIQUE, fin 2025, relayscan sur 7 jours] **Ultra Sound 32,3 %, Titan 24,75 %, les deux relais bloXroute environ 26 %, Flashbots 3,44 %** ;
  - avril 2026 : relay.ultrasound.money traite **33,92 %** des payloads sur 24 h (Relayscan).
  Sources : [VaaSBlock](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/) ; [KuCoin – Ethereum staking in 2026](https://www.kucoin.com/blog/ethereum-staking-in-2026-yield-trends-validator-queue-dynamics-and-mev-impact-exlained)
- [HISTORIQUE] Flashbots a cessé d'opérer des builders centralisés le 05/12/2024, au profit de BuilderNet, réseau de construction de blocs décentralisé lancé en novembre 2024 — [VaaSBlock](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/) ; [Grokipedia – Flashbots](https://grokipedia.com/page/Flashbots)
- Talos, « State of the Network » n°356 (2026, date exacte non visible) :
  - la valeur quotidienne captée par les validateurs recule globalement, ce que Talos attribue aux améliorations du réseau ;
  - **en 2026, seuls BuilderNet et Titanbuilder ont eu une journée à plus de 500 ETH de « MEV-Boost Value »**, en partie parce que Beaverbuild a rejoint BuilderNet pour partager son flux de transactions.
  Source : [Talos](https://www.talos.com/insights/state-of-the-network-356)
- Part du MEV dans la rémunération des validateurs : les estimations sont incompatibles entre elles. Attribution incertaine pour le chiffre de 7 %.
  - Selon une source, les récompenses de couche d'exécution (MEV inclus) font **environ 7 % des récompenses totales au T1 2026**.
  - KuCoin avance 10 à 30 %.
  - Spark estime que le MEV ajoute 0,3 à 0,8 point d'APR.
  Sources : [KuCoin](https://www.kucoin.com/blog/ethereum-staking-in-2026-yield-trends-validator-queue-dynamics-and-mev-impact-exlained) ; [Chainlabo](https://www.chainlabo.com/blog/maximizing-ethereum-staking-yield-2026-validator-guide) ; [Spark – MEV & PBS](https://www.spark.money/research/ethereum-mev-pbs-validator-economics)
- Septembre 2026 : environ **25 %** des payloads MEV-Boost passent par des relais qui appliquent la censure OFAC (données MEV Watch) — [Spark](https://www.spark.money/research/ethereum-mev-pbs-validator-economics)
- La mise à jour Glamsterdam (EIP-7732, ePBS) doit remplacer MEV-Boost par une enchère intégrée au protocole. La cible était « mi-2026 » (juin), avec un possible glissement à T3 ou T4. **Le statut au 13/10/2026 n'est pas vérifié** — [Web3wagmi](https://blog.web3wagmi.com/what-is-mev-guide) ; [VaaSBlock](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/)
- Pertes dues aux sandwiches sur Ethereum : **environ 40 M$ en 2025 selon EigenPhi**. Chiffre de seconde main, non vérifié à la source, attribution incertaine — [Web3wagmi](https://blog.web3wagmi.com/what-is-mev-guide) ; [VaaSBlock](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/)

### Inferences
- **Qui capte la valeur.**
  - Sur Ethereum, l'enchère PBS (MEV-Boost) reverse l'essentiel du MEV disputé aux validateurs qui proposent les blocs, donc aux stakers. Les builders dominants (BuilderNet, Titan) et quelques searchers intégrés gardent une marge.
  - Sur Solana, les pourboires Jito vont aux validateurs et aux stakers (par exemple via JitoSOL). Mais en 2026, environ 10 M$ par trimestre au T2, c'est peu comparé à 2025.
  - Les sandwiches sont payés par les particuliers, à travers le slippage.
- **Pour un nouvel entrant, le MEV en 2026 est une course d'infrastructure** : latence, colocation, accès au flux d'ordres, relations avec builders et validateurs. Sur Solana, le gâteau rétrécit en plus. Pour un individu sans avantage spécifique, le rendement attendu est probablement **négatif après coûts d'infrastructure et transactions ratées**. C'est une inférence : aucune statistique de rentabilité des searchers n'a été trouvée.
- **Le coût réel des sandwiches pour les particuliers sur Solana reste incertain.** L'IMC mesure 7,7 M$ sur 4 mois dans les bundles Jito ; d'autres annoncent 370 à 500 M$ sur 16 mois. Cet écart d'environ deux ordres de grandeur vient probablement du périmètre (les « wide sandwiches » hors bundles échappent à la mesure IMC) et de la méthode.
- **Pour un particulier, la façon réaliste de toucher du MEV est passive** : staker via un validateur ou un jeton de staking liquide qui redistribue MEV et pourboires (surplus modeste). La priorité est de se protéger (RPC protégés, slippage serré), pas d'essayer d'extraire du MEV.

### Gaps
- Données primaires 2025–2026 inaccessibles (mevboost.pics, libMEV, EigenPhi, Flashbots, explorateur Jito, sandwiched.me, Dune). Non vérifiés : total du MEV Ethereum en 2025 et 2026, paiements MEV-Boost aux validateurs, profits des searchers, pertes par sandwich en 2026.
- Statut de Glamsterdam/ePBS au 13/10/2026 non vérifié.
- Répartition 2026 entre searchers, builders et validateurs non chiffrée.
- Rien sur les mempools privées de Solana en 2026, ni sur BAM au-delà de sa part de stake ; un « MEV bot front-runs $7,8M Ethereum hack (2026) » a été repéré (shattered.io) mais les détails ne sont pas vérifiés.

## 4. Bots sur exchanges centralisés (grid, DCA, rééquilibrage ; Pionex, 3Commas, bots natifs Binance/OKX/Bybit, Kraken) : rendements réels des utilisateurs et fuite des clés API de 3Commas

### Takeaway
**Cette session n'a trouvé aucune preuve indépendante des rendements nets des utilisateurs de bots grid ou DCA.** Les chiffres qui circulent viennent du marketing, notamment des classements de « top bots » soumis au biais du survivant. Le principal risque documenté est sécuritaire. La fuite des clés API de 3Commas (décembre 2022, [HISTORIQUE]) a coûté **au moins 6 M$** aux utilisateurs. Aucune nouvelle fuite 3Commas n'a été trouvée en 2026.

### Cited Findings
- [HISTORIQUE, décembre 2022 – janvier 2023] Fuite des clés API de 3Commas :
  - un utilisateur anonyme revendique **environ 100 000 clés API** ;
  - le CEO Yuriy Sorokin confirme que les données sont authentiques ;
  - les utilisateurs perdent **au moins 6 M$** à cause de trades passés avec les clés volées ; des clés Binance et KuCoin sont concernées ;
  - 3Commas avait d'abord parlé de phishing, avant que les données publiées ne montrent qu'il s'agissait bien d'une fuite.
  Sources : [Cointelegraph](https://cointelegraph.com/news/3commas-ceo-confirms-api-key-leak-following-warning-from-cz) ; [Blockworks](https://blockworks.com/news/crypto-trading-bot-platform-3commas-rocked-by-critical-api-leak) ; [SC World](https://www.scworld.com/brief/massive-api-theft-confirmed-by-crypto-trading-platform-3commas) ; [Mpost](https://mpost.io/3commas-data-leak-confirmed-hackers-threaten-to-publish-over-100k-leaked-api-keys/) ; [FAQ officielle 3Commas](https://3commas.io/blog/api-security-incident-faq)
- Mode d'exploitation : des trades « contra » sur des paires illiquides ont servi à transférer la valeur des comptes victimes (des fonds d'utilisateurs FTX sont cités) — [Wublock (Substack)](https://wublock.substack.com/p/review-of-the-whole-process3commas) ; voir aussi [Securities.io](https://www.securities.io/3commas-api-leak-highlights-yet-another-way-to-lose-your-money/)
- La recherche du 13/10/2026 n'a fait remonter aucun article de 2026 sur une nouvelle fuite 3Commas. C'est une absence de résultat, pas la preuve qu'il n'y en a pas eu. Voir les sources ci-dessus, toutes de 2022–2023.

### Inferences
- **Mécanique des bots** (inférence générale, non sourcée ici) :
  - un bot grid gagne dans un marché qui oscille dans une fourchette ;
  - dans une tendance baissière, il accumule des positions perdantes ;
  - un bot DCA ne fait que lisser le prix d'entrée, donc son rendement est d'abord celui du marché, moins les frais.
- **Les bots natifs des exchanges sont gratuits ou bon marché parce que l'exchange monétise le volume** via les frais de trading. C'est la même logique de péage que pour les bots Telegram : voir le modèle « broker » de Hummingbot en section 5.
- **Une clé API avec droit de trading suffit à vider un compte, même sans droit de retrait** : il suffit de trader contre des paires illiquides contrôlées par l'attaquant (cas 3Commas). Bonnes pratiques : restreindre par IP, ne jamais donner de droit de retrait, renouveler régulièrement les clés.

### Gaps
- **Non vérifié, faute de quota de recherche :** pour Pionex, Binance, OKX, Bybit et Kraken, aucune statistique indépendante sur la part d'utilisateurs de bots gagnants ni sur les rendements moyens.
- Pistes :
  - pages « marketplace de bots » qui affichent un ROI, à traiter comme du marketing soumis au biais du survivant ;
  - études académiques sur le grid trading ;
  - retours sur r/algotrading et r/CryptoCurrency.
- Incidents 2025–2026 sur les plateformes de bots CEX non vérifiés.
- Ce que MiCA impose aux prestataires qui proposent des bots, et les mises en garde de l'AMF sur les « robots de trading » : non couverts ici (voir le fichier 12).

## 5. Trading algorithmique DIY et market making (Hummingbot, Freqtrade, Jesse, CCXT) : résultats réalistes des praticiens ; liquidity mining et rebates maker

### Takeaway
Les frameworks open source préviennent eux-mêmes qu'ils ne garantissent aucun résultat. Freqtrade et Jesse disent être « à but éducatif » et demandent de ne pas risquer d'argent qu'on a peur de perdre. Hummingbot affirme que ses utilisateurs ont généré **plus de 34 Md$ de volume en un an** (auto-déclaré). Le projet est financé par des **partenariats « broker » et des liens de parrainage d'exchanges**, ce qui montre que le volume des bots rémunère d'abord les exchanges. Cette session n'a pu collecter aucun retour chiffré et vérifiable de praticiens (Reddit, GitHub).

### Cited Findings
- **Freqtrade** (README consulté le 13/10/2026) : « This software is for educational purposes only. Do not risk money which you are afraid to lose. USE THE SOFTWARE AT YOUR OWN RISK. THE AUTHORS AND ALL AFFILIATES ASSUME NO RESPONSIBILITY FOR YOUR TRADING RESULTS. » Le projet demande de toujours commencer en mode simulé (« Dry-Run ») avant d'engager de l'argent, et recommande fortement des connaissances en code et en Python — [GitHub freqtrade/freqtrade](https://github.com/freqtrade/freqtrade)
- **Jesse** (README consulté le 13/10/2026) : même avertissement, plus « There might be bugs in the code - this software DOES NOT come with ANY warranty ». Fonctionnalités mises en avant : backtests sans biais d'anticipation, tests de significativité des règles, simulations de Monte Carlo — [GitHub jesse-ai/jesse](https://github.com/jesse-ai/jesse)
- **Hummingbot** (README consulté le 13/10/2026) :
  - « Over the past year, Hummingbot users have generated over $34 billion in trading volume across 140+ unique trading venues » (auto-déclaré) ;
  - stratégies proposées : market making simple, Avellaneda, market making entre exchanges, arbitrage, DCA, grid, TWAP, fourniture de liquidité ;
  - le projet est soutenu par des exchanges via des « broker partnerships and sponsorships » (Binance, OKX, KuCoin, Gate.io, Bitget, Backpack, Derive…), avec des liens de parrainage qui offrent 10 à 20 % de réduction sur les frais.
  Source : [GitHub hummingbot/hummingbot](https://github.com/hummingbot/hummingbot)
- Pour l'arbitrage de funding et de basis comme stratégie DIY, voir la section 7 : rendements comprimés à environ 5 à 15 % en conditions normales.

### Inferences
- **Le volume des bots DIY ne dit rien de leur rentabilité.** Les 34 Md$ par an d'Hummingbot sont un revenu certain pour les exchanges (frais) et pour le projet (partage de frais broker). Le résultat des utilisateurs, lui, n'est jamais publié.
- **Faire du market making en particulier sur un CEX est structurellement désavantageux** : pas de rebates de niveau VIP, latence plus élevée, et on est exécuté surtout quand le prix part contre soi. L'écart entre backtest et réel (frais, slippage, surajustement) est la cause d'échec classique. C'est cohérent avec l'insistance de Freqtrade et Jesse sur le mode simulé, le biais d'anticipation et les tests de significativité.
- **Ce qu'il faut pour se lancer** (inférence) : savoir coder en Python, avoir une discipline statistique, prévoir des semaines de simulation, surveiller une infrastructure. Le capital peut être modeste, mais le rendement attendu net de frais n'est pas démontré.

### Gaps
- Aucun retour chiffré de praticiens collecté (r/algotrading, Discord ou GitHub de Freqtrade et Hummingbot).
- Programmes de liquidity mining (« Hummingbot Miner » : arrêté ? quand ?) et barèmes de rebates maker 2026 (Hyperliquid, Binance, OKX, Bybit) non vérifiés.
- CCXT : rien collecté en dehors d'un article de blog sur l'arbitrage (section 7).

## 6. Agents de trading IA : compétitions de LLM (Nof1 Alpha Arena), tokens d'agents IA (Virtuals, elizaOS/ai16z), fonds autonomes ; gagnent-ils de l'argent ?

### Takeaway
Les preuves publiques sont minces et défavorables.
- **Alpha Arena Saison 1** (perpétuels crypto sur Hyperliquid, terminée les 3–4 novembre 2025) : **4 modèles sur 6 ont perdu de l'argent**, Qwen 3 Max a gagné.
- **Saison 1.5** (actions US, terminée le 3 décembre 2025) : gagnée par un modèle non annoncé, « Grok 4.2 ». Le meilleur résultat relevé est d'environ +34,59 %.
- **Au 6 août 2026, aucun résultat public de Saison 2 n'était visible.**

Côté tokens, **VIRTUAL est environ 84 % sous son plus haut en octobre 2026**. Les frais de Virtuals sur 30 jours (environ 0,62 M$) sont minimes face aux 74 à 75 M$ cumulés.

### Cited Findings
- **Saison 1** [HISTORIQUE, octobre–novembre 2025] : tournoi entre modèles d'IA tradant des perpétuels crypto sur Hyperliquid, dont la fin était annoncée pour le 4 novembre 2025 — [KuCoin News](https://www.kucoin.com/news/flash/ai-trading-competition-alpha-arena-to-conclude-on-november-4). Résultat : « Four out of six AI models suffer losses », Qwen 3 Max vainqueur — [ForkLog](https://forklog.com/en/four-out-of-six-ai-models-suffer-losses-in-trading-tournament/)
- **Saison 1.5** [HISTORIQUE, terminée le 03/12/2025, actions US] : un modèle non annoncé, Grok 4.2, l'emporte devant GPT-5.1 (2e) et Gemini 3 (3e) — [ForkLog](https://forklog.com/en/ai-model-grok-4-2-triumphs-in-trading-tournament/). Selon un guide, le meilleur participant plafonne à **+34,59 %** — [TradeRank.ai (vérifié le 06/08/2026)](https://www.traderank.ai/blog/alpha-arena-alternatives-2026)
- **Saison 2** : au 06/08/2026, ni participants, ni classement, ni résultats n'étaient visibles publiquement, et la page d'accueil de nof1.ai affichait encore la Saison 1.5. CoinDesk aurait évoqué une « Season Two » qui pourrait se dérouler en privé — [TradeRank.ai](https://www.traderank.ai/blog/alpha-arena-alternatives-2026)
- **Virtuals Protocol (octobre 2026)** :
  - environ 75 M$ de frais cumulés, dont environ 42 M$ conservés par le protocole ; DefiLlama n'enregistre aucun revenu pour les détenteurs du token — [OwnYourMind.ai](https://ownyourmind.ai/projects/virtuals/)
  - une autre analyse donne 74,32 M$ de frais cumulés et **0,62 M$ sur 30 jours** (attribution incertaine) — [CoinStats – analyse octobre 2026](https://coinstats.app/ai/a/investment-analysis-virtual-protocol)
- **Prix du token VIRTUAL** :
  - le 03/05/2026 : 0,739 $, pour une capitalisation de 485 M$ (rang 104 sur CoinGecko) — [Yellow.com](https://yellow.com/news/virtuals-protocol-gains-5-percent-ai-agent-tokens-demand)
  - en octobre 2026 : **84,24 % sous son plus haut historique de 5,07 $** ; 658,4 M de tokens en circulation sur 1 Md — [CoinStats (octobre 2026)](https://coinstats.app/ai/a/investment-analysis-virtual-protocol)
- **Indicateurs auto-déclarés par Virtuals** : un « agentic GDP » (AGDP, la valeur produite par les agents) de 479 à 481,79 M$, pour environ 4,5 M USDC de revenus totaux. Une analyse se demande si cet AGDP reflète une valeur réelle — [Bex.co (04/04/2026)](https://bex.co/blog/2026/04/04/virtuals-protocol-ai-economic-operating-system-on-chain-agent-economy) ; [Bex.co (09/05/2026)](https://bex.co/blog/2026/05/09/virtuals-protocol-ai-economic-os-agdp-agent-platform)
- Le « Virtuals Revenue Network », lancé en février 2026, distribue jusqu'à 1 M$ par mois aux agents qui vendent des services via ACP. Pour les détenteurs de VIRTUAL, la captation de valeur n'est qu'indirecte (rachats et destruction de tokens, trésorerie, staking). Attribution incertaine — [CoinStats – analyse fondamentale juin 2026](https://coinstats.app/ai/a/fundamental-analysis-virtual-protocol) ; [Datawallet](https://www.datawallet.com/crypto/what-is-virtuals-protocol)

### Inferences
- **Ces compétitions ne permettent pas de séparer compétence et chance** : elles durent quelques semaines, comptent peu de participants et une seule exécution par modèle. Une majorité de perdants en Saison 1 et l'absence de Saison 2 publique en 2026 ne soutiennent pas l'idée qu'un bot IA grand public produise une performance supérieure durable.
- **Dans l'économie des agents IA, les gagnants ont surtout été les émetteurs, les launchpads et les premiers détenteurs** pendant la bulle de fin 2024–début 2025. En 2026, les frais (environ 0,6 M$ sur 30 jours) et le prix (−84 % pour VIRTUAL) montrent un effondrement. Inférence tirée des chiffres ci-dessus.
- **Les « bots de trading IA » vendus aux particuliers sont un terrain privilégié pour les arnaques** : voir la section 8, avec des vidéos YouTube présentées par des avatars générés par IA.

### Gaps
- **Non vérifié :** les performances 2025–2026 de ai16z/elizaOS, aixbt et des autres tokens d'agents (quota épuisé).
- **Non vérifié :** le détail chiffré de la Saison 1 d'Alpha Arena (capital de départ, résultat de chaque modèle). Pistes **non vérifiées, À NE PAS CITER sans contrôle sur nof1.ai** : 10 000 $ par modèle ; Qwen autour de +20 % ; GPT-5 et Gemini autour de −60 %.
- **Non vérifié :** les « fonds autonomes » gérés par des agents IA, faute d'avoir trouvé un résultat.
- **Non couvert :** les autres compétitions de 2026 (Recall, etc.).

## 7. Bots d'arbitrage (entre CEX, CEX–DEX, cross-chain, arbitrage de funding) : rentabilité actuelle et concurrence

### Takeaway
L'arbitrage « facile » a disparu.
- Le portage sur le funding et le basis rapportait **30 à 50 % par an en 2020–2021**. En 2026, il est retombé à **environ 5 à 15 % en conditions normales**, voire autour de 5 % net selon certains praticiens, avec des pics pendant les phases haussières où tout le monde fait le même trade.
- Les modèles académiques qui affichent environ 100 % par an reposent sur des **hypothèses synthétiques**.
- Aucune donnée 2026 vérifiée n'a été collectée sur l'arbitrage CEX–DEX ou cross-chain, un domaine tenu par quelques searchers et teneurs de marché professionnels.

### Cited Findings
- Basis trades : **30 à 50 % par an en 2020–2021**, comprimés à **5 à 15 % en conditions normales** en 2026, avec des pics occasionnels — [Quantt – Crypto quant strategies 2026](https://www.quantt.co.uk/resources/crypto-quant-strategies-2026)
- [HISTORIQUE, 2025] Selon CF Benchmarks, le basis du BTC est passé d'environ **25 % par an à 4,46 %** en moins de deux ans — [TV-Hub – Market neutral strategy](https://www.tv-hub.org/guide/market-neutral-strategy-crypto)
- Calcul du funding : 0,01 % toutes les 8 heures donne environ **11 % par an avant coûts**. À 0,05 % par 8 heures, on atteint environ **55 % brut**, ce qui attire les capitaux et comprime vite le trade. Attribution incertaine — [Medium – Funding rate arbitrage in 2026](https://medium.com/@arbitrageghost/funding-rate-arbitrage-in-2026-the-complete-guide-with-real-calculations-40e6cf341e52) ; [Zipmex – guide 2026](https://zipmex.com/blog/how-to-analyze-funding-rates-in-crypto/)
- Un rendement net « honnête » se situe en général **autour de 5 % par an** sur une position propre. Le même article liste ce qui « paie encore » et les pièges à éviter. Attribution incertaine — [CCXT blog – The crypto arbitrage playbook (2026)](https://docs.ccxt.com/blog/crypto-arbitrage-strategies)
- Article académique de 2026 (Springer, *Digital Finance*) sur l'arbitrage de funding entre CEX et DEX : environ **100,11 % par an en simulation**. L'article précise qu'il s'agit d'un « model-implied net return » sous des hypothèses synthétiques de DEX et de coûts, et pas d'un rendement réalisé en trading réel. Il analyse aussi le risque de défaillance d'une plateforme — [Springer – Digital Finance (2026)](https://link.springer.com/article/10.1007/s42521-026-00213-3)
- Les rendements sont « modestes et variables, non garantis », et ils disparaissent quand le funding se comprime ou s'inverse — [BJF Trading Group](https://bjftradinggroup.com/funding-rate-arbitrage/)

### Inferences
- **Pour un particulier, l'arbitrage de funding est la forme d'automatisation la plus réaliste.** Mais son rendement net (environ 5 à 10 % par an en régime normal) se rapproche d'un taux sans risque, avec en plus un risque de contrepartie : faillite d'exchange, désendettement forcé (ADL), liquidation d'une des deux jambes.
- **À titre d'illustration (calcul, pas une donnée)** : 10 000 $ à 8 % net rapportent environ 800 $ par an avant impôts.
- **L'arbitrage entre exchanges ou entre CEX et DEX demande une latence et des accords de frais hors de portée d'un particulier.**
- **Un « bot d'arbitrage » clé en main promettant des rendements élevés et stables est incompatible avec la compression observée.** C'est un signal d'alerte d'arnaque (section 8).

### Gaps
- **Non vérifié :** l'arbitrage CEX–DEX sur Ethereum (concentration des searchers, profits) et l'arbitrage cross-chain. Pistes **non vérifiées** : études de Heimbach et al. sur l'arbitrage non atomique entre CEX et DEX, études 2025 sur l'arbitrage cross-chain. Chiffres à contrôler sur arXiv.
- **Non collectés :**
  - les taux de funding moyens de 2026 (Binance, Bybit, Hyperliquid) ;
  - le rendement de sUSDe (Ethena), qui sert de proxy du basis ;
  - les coûts réels d'un bot d'arbitrage entre exchanges (frais, retraits, latence).

## 8. Arnaques et risques : faux « bots MEV » sur YouTube, bots Telegram malveillants, exploits de plateformes (Banana Gun 2024…), garde des clés privées, phishing

### Takeaway
Les pertes documentées viennent moins du marché que de la **sécurité et de la fraude** :
- **faux « bots MEV » promus sur YouTube** : environ 245 à 256 ETH, soit plus de 900 000 $, volés dans une campagne documentée en 2025 ;
- **fuites de clés API** : 3Commas, au moins 6 M$ ;
- **abus internes** : Axiom, 2026 ;
- **validateurs qui pratiquent eux-mêmes le sandwich** : bannis par Jito ;
- **tokens de bots dévalorisés** : PADRE −76 %.

Les bots Telegram et les terminaux détiennent souvent les clés privées de leurs utilisateurs. Une compromission expose donc tous les utilisateurs à la fois.

### Cited Findings
- **Faux bots MEV** [HISTORIQUE, août 2025, mais le schéma est toujours actif]. Selon SentinelLABS :
  - des tutoriels YouTube incitent à déployer un contrat Solidity présenté comme un « bot MEV » ou d'arbitrage, puis à le financer ;
  - le contrat envoie en réalité les ETH à l'attaquant, dont l'adresse est dissimulée dans le code (XOR, concaténation, conversion décimal-hexadécimal) ;
  - une seule vidéo, vue plus de 387 000 fois, a rapporté **244,9 ETH** ;
  - les escrocs utilisent des comptes YouTube anciens ou piratés et des présentateurs générés par IA.
  Sources : [SentinelOne Labs](https://www.sentinelone.com/labs/smart-contract-scams-ethereum-drainers-pose-as-trading-bots-to-steal-crypto/) ; [CoinCentral (256 ETH)](https://coincentral.com/youtube-crypto-bot-scam-steals-256-eth-using-fake-trading-videos/) ; [CCN (900 000 $)](https://www.ccn.com/news/technology/ethereum-fake-trading-bots-smart-contract-scam/) ; [Yahoo Finance (environ 1 M$)](https://finance.yahoo.com/news/weaponized-trading-bots-drain-1m-083048955.html)
- **Comment la victime est piégée** : elle voit le solde du contrat augmenter (par exemple de 1 à 1,1 ETH) et dépose donc davantage. Les règles qui en découlent : ne jamais déployer un contrat tiré d'une vidéo, ne jamais envoyer de fonds pour « activer » un bot — [SentinelOne Labs](https://www.sentinelone.com/labs/smart-contract-scams-ethereum-drainers-pose-as-trading-bots-to-steal-crypto/) ; [KuCoin – MEV bot scam deep dive](https://www.kucoin.com/news/articles/a-deep-dive-into-the-mev-bot-scam-how-to-spot-and-avoid-web3-arbitrage-traps) ; [Cointelegraph (contenu sponsorisé)](https://cointelegraph.com/commissioned/how-fake-mev-bots-turn-crypto-traders-into-their-own-victims)
- [HISTORIQUE] Fuite des clés API de 3Commas : au moins 6 M$ perdus — [Cointelegraph](https://cointelegraph.com/news/3commas-ceo-confirms-api-key-leak-following-warning-from-cz)
- [Février 2026] Axiom : abus d'outils internes pour pister et front-runner des portefeuilles d'utilisateurs et de KOL — [Decrypt](https://decrypt.co/359223/y-combinator-backed-axiom-employees-accused-insider-trading-zachxbt)
- [Fin 2025 environ] Jito bannit 15 validateurs Solana supplémentaires pour avoir pratiqué le sandwich — [CryptoRank](https://cryptorank.io/news/feed/4d1c4-jito-bans-15-additional-validators-after-data-emerges-of-widespread-sandwich-attacks)
- [Octobre 2025] Le token PADRE chute de 76 % et perd son utilité à l'annonce du rachat par Pump.fun — [crypto.news](https://crypto.news/padre-token-dumps-after-pump-fun-acquires-trading-terminal/)
- Copy-trading : des KOL multi-portefeuilles revendent sur leurs copieurs, aidés de bots de front-running — [UCL Discovery (PDF)](https://discovery.ucl.ac.uk/id/eprint/10220650/1/Resisting_Manipulative_Bots_in_Meme_Coin_Copy_Trading__A_Multi_Agent_Approach_with_Chain_of_Thought_Reasoning.pdf)
- Promesses invérifiables des bots : par exemple, le partage de 40 % des frais de Banana Gun avec les détenteurs de son token n'a pas pu être confirmé on-chain selon une source. Attribution incertaine — [Nerdbot](https://nerdbot.com/2026/04/17/best-telegram-trading-bots-in-2026-7-platforms-tested-for-speed-fees-and-mev-protection/) ; [AMBCrypto](https://ambcrypto.com/top-11-telegram-trading-bots-of-march-2026/)

### Inferences
- **Les risques pour un particulier qui utilise des bots, du plus grave au moins grave :**
  1. fraude pure : faux bots, faux sites, phishing ;
  2. compromission de clés : bots Telegram qui détiennent les clés, clés API d'exchange ;
  3. conflit d'intérêts de l'opérateur, qui voit le flux d'ordres (cas d'initié chez Axiom) ;
  4. coûts d'exécution : environ 1 % de frais par trade, MEV, slippage ;
  5. risque de marché propre aux memecoins.
- **Tout produit promettant des rendements « garantis » grâce à un bot MEV ou d'arbitrage est incompatible avec la concurrence documentée** (sections 3 et 7).

### Gaps
- **Exploit de Banana Gun (septembre 2024) non vérifié dans cette session.** Piste **non vérifiée, À CONTRÔLER avant toute citation** : environ 563 ETH (2 à 3 M$) volés via une faille de l'oracle de messages Telegram, puis utilisateurs remboursés.
- **Autres exploits non vérifiés :** Maestro (routeur, octobre 2023), Unibot (octobre 2023), Solareum (2024), ainsi que les bots et dépôts GitHub malveillants de 2025–2026 (faux bots Solana qui volent les clés privées).
- **Non collecté :** le phishing de 2026 visant les utilisateurs de terminaux (faux sites Axiom ou Photon, extensions malveillantes).
- **France/UE, non couvert ici (voir le fichier 12) :** mises en garde de l'AMF et de l'ESMA sur les « robots de trading » ; statut MiCA des bots et terminaux selon qu'ils détiennent ou non les clés ; fin de la période transitoire des PSAN en France (à vérifier) ; fiscalité des gains réalisés via des bots.

## 9. Synthèse transversale (objectif global) : combien d'argent les bots et l'automatisation rapportent en 2026, à qui, et quels rendements réalistes pour un particulier

### Takeaway
En 2026, l'argent de l'automatisation crypto va, par ordre de certitude :
1. **aux plateformes**, terminaux et exchanges, qui prennent un péage sur le volume (Axiom seul : 22 à 39 M$ de frais sur 30 jours) ;
2. **aux validateurs, aux stakers et aux builders**, via les pourboires, les priority fees et l'enchère MEV ;
3. **à une poignée de professionnels** (searchers, teneurs de marché, arbitragistes), sur des marges en compression ;
4. **aux parrains et KOL**, qui touchent 20 à 35 % des frais de leurs filleuls et peuvent exploiter leurs copieurs.

Les particuliers qui utilisent des sniper bots ou du copy-trading sur memecoins sont, **globalement, perdants**. Les stratégies passives ou neutres au marché (arbitrage de funding, staking avec redistribution du MEV) offrent des rendements modestes, de l'ordre de 5 à 15 % brut par an en régime normal, avec des risques de queue.

### Cited Findings
- Axiom : 22,35 à 39,27 M$ de frais sur 30 jours en 2026 — [DefiLlama – Axiom](https://defillama.com/protocol/axiom) ; [Axiompedia](https://axiompedia.com/compare). Photon : environ 441 M$ de frais cumulés, mais seulement environ 0,59 M$ sur 30 jours au 14/08/2026 — [Photonguides](https://photonguides.com/ecosystem/what-is-photon) ; [Memegateway](https://memegateway.com/bot/photon/)
- Pourboires Jito : 19,85 M$ au T1 2026, puis 9,9 M$ au T2 2026 — [Solana Compass / Blockworks Advisory](https://solanacompass.com/news/jito-q2-2026-protocol-revenue-falls-45-to-128m-as-bam-reaches-33-of-solana-stake). Real Economic Value de Solana au T1 2026 : 89,5 M$ — [Messari](https://messari.io/report/state-of-solana-q1-2026)
- MEV Ethereum : environ 2,2 Md$ en 2025 selon des estimations agrégées non officielles — [VaaSBlock](https://www.vaasblock.com/news/mev-flashbots-suave-ethereum-extraction-redistribution-2026/) ; [Web3wagmi](https://blog.web3wagmi.com/what-is-mev-guide)
- [HISTORIQUE, janvier 2025] Environ 0,4 % des portefeuilles Pump.fun avaient réalisé plus de 10 000 $ de gains — [Cointelegraph](https://cointelegraph.com/news/pump-fun-crypto-traders-majority-do-not-realize-profits-dune-data)
- Arbitrage de funding et de basis : environ 5 à 15 % par an en conditions normales en 2026 — [Quantt](https://www.quantt.co.uk/resources/crypto-quant-strategies-2026)
- Agents IA : en Saison 1 d'Alpha Arena, 4 modèles sur 6 ont perdu — [ForkLog](https://forklog.com/en/four-out-of-six-ai-models-suffer-losses-in-trading-tournament/)
- Fraude : faux bots MEV, plus de 900 000 $ — [SentinelOne Labs](https://www.sentinelone.com/labs/smart-contract-scams-ethereum-drainers-pose-as-trading-bots-to-steal-crypto/). Fuite 3Commas : au moins 6 M$ — [Cointelegraph](https://cointelegraph.com/news/3commas-ceo-confirms-api-key-leak-following-warning-from-cz)

### Inferences
**Rendements réalistes par profil (inférences tirées des sections 1 à 8, pas des statistiques publiées) :**
- **Sniping et trading de memecoins via un terminal** : peu de capital nécessaire, mais une espérance négative pour la grande majorité. Seule une très petite minorité gagne beaucoup (les données Pump.fun montrent environ 0,4 % au-delà de 10 000 $, une fréquence comparable à celle d'une loterie). Les frais d'environ 1 %, le MEV et le slippage pèsent sur chaque aller-retour.
- **Copy-trading** : aucune preuve d'un rendement net positif. Le risque d'être exploité est structurel.
- **Bots grid ou DCA sur un CEX** : le rendement suit celui du marché, moins les frais. Pas d'alpha démontré. Le risque lié aux clés API s'ajoute.
- **Algo DIY et market making** : il faut savoir coder, avoir une discipline statistique et consacrer beaucoup de temps. Aucun rendement net démontré publiquement, et les frameworks eux-mêmes déclinent toute responsabilité.
- **Searcher MEV ou arbitrage entre exchanges** : une affaire d'ingénieurs disposant d'infrastructure et de capital, sur des marchés en compression (Solana) et concentrés (Ethereum). Pour un nouvel entrant, le résultat net attendu est probablement négatif.
- **Arbitrage de funding** : la piste la plus réaliste, à environ 5 à 10 % net par an en régime normal, mais avec un risque de contrepartie. Le gain croît linéairement avec le capital.
- **Agents IA** : aucune preuve de performance supérieure durable. Les tokens d'agents se sont effondrés.

**Biais du survivant, à rappeler partout** :
- les classements de portefeuilles et de bots, ainsi que les ROI affichés sur les marketplaces de bots, ne montrent que les gagnants ;
- les volumes et nombres d'utilisateurs sont auto-déclarés ;
- les pourcentages mensuels de « portefeuilles rentables » sont calculés sur ceux qui restent actifs.

### Gaps
- Aucun total sectoriel vérifié pour 2025 ou 2026 (frais de l'ensemble des bots et terminaux, MEV total des deux chaînes, pertes totales des particuliers par sandwich).
- Aucune donnée vérifiée sur les rendements des bots CEX, les résultats de praticiens DIY, l'arbitrage CEX–DEX ou cross-chain, ni les tokens ai16z et aixbt.
- Pour combler ces lacunes, consulter directement :
  - DefiLlama (catégories « Telegram Bot » et « Trading App ») ;
  - les dashboards Dune consacrés aux bots Telegram ;
  - mevboost.pics, libMEV et EigenPhi ;
  - les rapports trimestriels Jito et Blockworks ;
  - nof1.ai ;
  - r/algotrading.

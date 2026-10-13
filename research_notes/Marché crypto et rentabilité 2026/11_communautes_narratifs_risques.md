# Communautés crypto, narratifs dominants, revenus alternatifs et paysage des risques (situation au 13 octobre 2026)

> **Note d'accès et de méthode (à lire avant usage)**
> - **[SERP]** : information tirée des *résumés* renvoyés par le moteur de recherche (WebSearch). Les pages elles-mêmes n'ont **pas** pu être ouvertes : WebFetch échouait systématiquement (erreur DNS `getaddrinfo ENOTFOUND`) et le proxy de sortie refusait la connexion directe aux sites de presse (HTTP 403 sur decrypt.co). Fiabilité **moyenne** : chiffres repris par plusieurs titres concordants = plus solides ; formulation exacte et date de publication souvent non vérifiables.
> - **[PRIMAIRE]** : document source lu directement, via un clone git de dépôts GitHub publics : `jlopp/physical-bitcoin-attacks` (dernier commit le 6 oct. 2026, « thailand home invasion »), `SunWeb3Sec/DeFiHackLabs` (dernier commit le 12 oct. 2026) et `slowmist/knowledge-base` (commit du 30 sept. 2026, « add SlowMist Investigation Progress Report - Bitget »).
> - **Budget de recherche épuisé** : le quota de recherche web, partagé entre tous les agents de la session (200 requêtes par tour), a été atteint après ma **8e** requête. Les axes podcasts, Reddit/forums, sources francophones, bug bounties, emplois, arnaques et études sur les pertes des particuliers sont donc **très peu ou pas couverts** (voir les sections Gaps). Il faudrait une seconde passe de recherche.
> - **Non accessibles** : X/Twitter, Discord, Telegram, Reddit, YouTube, transcriptions Spotify/Apple, tableaux de bord Kaito, LunarCrush, Santiment et Google Trends, sites des podcasts, médias français (hors résumés SERP).

## 1. Narratifs dominants en 2026 et preuves de « mindshare » : lesquels montent et lesquels reculent (oct. 2026)

### Takeaway
Début octobre 2026, le marché est dominé par Bitcoin et en phase de prudence : BTC autour de 82–84 k$, soit environ 34 % sous son record d'oct. 2025, dominance d'environ 59 % et sorties des ETF. Les listes éditoriales de narratifs 2026 mettent en avant des thèmes « institutionnels / utilité » (stablecoins, RWA et actions tokenisées, marchés de prédiction, perp DEX, IA/compute, ETF/DAT). À l'inverse, l'InfoFi s'est effondrée en janvier 2026 et certains sous-secteurs memecoins ont reculé d'environ 30 % au printemps-été. Aucune donnée quantitative de mindshare (Kaito, LunarCrush, Google Trends) n'a pu être récupérée.

### Cited Findings
**Toile de fond du marché (8–13 oct. 2026)**
- Le 12 oct. 2026, BTC cotait environ 82 000–84 000 $. Il avait touché 86 978 $ au plus haut début de la semaine précédente, puis 81 749,83 $ au plus bas le 8 oct. Il restait environ 34 % sous son record (plus de 126 000 $, atteint le 6 oct. 2025). [SERP] — [Decrypt (oct. 2026)](https://decrypt.co/380708/bitcoin-spooked-crypto-fear-greed-drops) ; [The Cryptonomist, 12 oct. 2026](https://en.cryptonomist.ch/2026/10/12/bitcoin-price-volatility-october/)
- Hebdo Zerocap du 12 oct. 2026 (Zerocap est une société de trading et d'investissement crypto, donc intéressée) :
  - les ETF Bitcoin spot US ont perdu 681,1 M$, les ETF Ethereum 542,1 M$ ;
  - les ETF Solana ont connu des rachats nets, ce qui met fin à 14 semaines consécutives d'entrées ;
  - Zerocap qualifie le mouvement de « leverage flush rather than a change in trend » ;
  - la dominance BTC est d'environ 59 %, et ETH et SOL ont davantage baissé. [SERP]
  — [Zerocap, 12 oct. 2026](https://zerocap.com/insights/weekly-crypto-market-wrap/weekly-crypto-market-wrap-12-october-2026)
- Selon le résumé SERP, les fonds Ethereum affichaient une série de 9 jours de sorties. [SERP] — sources listées : [Decrypt](https://decrypt.co/380708/bitcoin-spooked-crypto-fear-greed-drops) ; [KuCoin News](https://kucoin.com/news/flash/crypto-fear-and-greed-index-drops-to-56-as-bitcoin-sentiment-cools)
- Contexte macro : le rendement du Trésor US à 30 ans a atteint 5,70 %, son plus haut depuis 2002 selon The Cryptonomist. Un article du 13 oct. relie la baisse aux chocs pétroliers, aux taux et au levier : « crypto still trades with global macro risk despite the digital-gold narrative ». [SERP] — [The Cryptonomist, 12 oct. 2026](https://en.cryptonomist.ch/2026/10/12/bitcoin-price-volatility-october/) ; source probable de l'article du 13 oct. : [Crypto Economy](https://crypto-economy.com/crypto-market-rebounds-then-slips)
- Offre à venir : 845,8 M$ de tokens débloqués la 3e semaine d'octobre 2026, dont les plus gros déblocages sont Cronos, Arbitrum et Starknet. [SERP] — [BeInCrypto (oct. 2026)](https://beincrypto.com/token-unlocks-third-week-of-october-2026)

**Listes de narratifs 2026 (CoinGecko)**
- La page CoinGecko « Top 10 Narratives for 2026 (UPDATED) » liste : Stablecoins & Stablechains, Real-World Assets (RWA), AI x Crypto, AI x DePIN, Quantum, Prediction Markets, Perp DEXs, Privacy/ZK, ETFs/DATcos, Collectible Cards. La date exacte de mise à jour n'est pas vérifiée. [SERP] — [CoinGecko](https://www.coingecko.com/learn/crypto-narratives)
- Une version antérieure de CoinGecko (publication Threads, non datée dans les résultats) en listait 9 : Meme Launchpads, ICO Launchpads, Prediction Markets, Privacy & ZK, Perp DEXs, Stablecoins & Stablechains, ETFs & DATCos, RWA, Crypto Cards. [SERP] — [CoinGecko sur Threads](https://www.threads.com/@coingecko/post/DTZzO5zgFip/top-crypto-narratives-for-meme-launchpads-ico-launchpads-prediction-markets)
- Les bons du Trésor tokenisés forment la plus grosse catégorie hors stablecoins, avec environ 11,5 Md$. Securitize a lancé des actions tokenisées, et la valeur des actions on-chain a dépassé 3 Md$. Date non vérifiée. [SERP] — [CoinGecko](https://www.coingecko.com/learn/crypto-narratives)
- Selon CoinGecko, les catégories memecoins « Dog-Themed » et « 4chan-Themed » ont perdu environ 30 % ou plus entre mi-avril et juillet 2026. [SERP] — [CoinGecko](https://www.coingecko.com/learn/crypto-narratives)
- Contexte historique 2025 : selon le classement CoinGecko repris par CCN, les RWA ont été le narratif le plus rentable de 2025 (rendement moyen depuis le début d'année de +185,76 %), tandis que l'IA et les memecoins ont été les « perdants ». Les memecoins restaient le narratif le plus suivi, avec 25,02 % de l'intérêt des investisseurs. [SERP] — [CCN](https://www.ccn.com/news/crypto/crypto-sector-coingecko-rwa-win-ai-memecoin-lose/)
- Contexte historique 2024 : les memecoins étaient le narratif « le plus populaire » de 2024, avec environ 31 % des recherches liées à la crypto selon CoinGecko. [SERP] — [Benzinga](https://benzinga.com/content/42677759/meme-coins-were-the-most-popular-crypto-narrative-in-2024-coingecko)

**Autres signaux de narratifs**
- IA / compute : une newsletter du 13 oct. 2026 estime que la « crypto IA » passe d'un narratif spéculatif à un thème d'investissement d'infrastructure, et évoque la puissance de calcul comme actif négociable. C'est une opinion ; l'éditeur, une newsletter « altcoin », a des intérêts potentiels non vérifiés. [SERP] — [Altcoin Investing, 13 oct. 2026](https://altcoininvesting.co/p/ai-compute-could-become-cryptos-next)
- Marchés de prédiction : l'épisode Bankless du 2 oct. 2026 traite du « path to the Supreme Court » des marchés de prédiction, c'est-à-dire de leurs batailles juridiques. Un autre épisode Bankless, non daté, s'intitule « The Duopolies of 2026: Ethereum & Solana, Coinbase & Robinhood, Polymarket & Kalshi ». [SERP] — [Bankless, Apple Podcasts](https://podcasts.apple.com/us/podcast/bankless/id1499409058) ; [Bankless : The Duopolies of 2026](https://www.bankless.com/podcast/the-duopolies-of-2026)
- InfoFi en recul : le 15 janv. 2026, X a interdit les applications qui rémunèrent les publications. Kaito a alors arrêté ses « Yaps » et le token KAITO a chuté (voir section 4). [SERP] — [BeInCrypto](https://beincrypto.com/x-kills-kaito-infofi-tokens-crash/) ; [Coinspeaker](https://www.coinspeaker.com/x-bans-infofi-crypto-apps-kaito-token-drops/)
- Bruit promotionnel : la recherche « crypto narratives October 2026 » renvoie, parmi les premiers résultats, un communiqué openPR pour une prévente de token (« Apeing Stage 7 Ending in 4 Days ») et une liste marketing d'exchange (« 10 Best Cryptocurrencies For Short-Term Gains In October 2026 », Mudrex). [SERP] — [openPR](https://openpr.com/news/4659081/crypto-rally-returns-10-best-cryptos-to-buy-now-in-2026-apeing) ; [Mudrex](https://mudrex.com/learn/best-crypto-short-term-gains/)

### Inferences
- **Narratifs en hausse** (confiance modérée, faute de données quantitatives de mindshare) :
  - tokenisation (bons du Trésor et actions on-chain) ;
  - stablecoins ;
  - marchés de prédiction, très présents dans les podcasts et objets de batailles juridiques ;
  - IA x crypto / compute et « Quantum », ajoutés à la liste CoinGecko mise à jour.
- **Narratifs en recul** :
  - InfoFi (interdiction par X en janvier 2026) ;
  - sous-secteurs memecoins (environ −30 % d'avril à juillet) ;
  - « Meme Launchpads » et « ICO Launchpads », qui disparaissent entre les deux listes CoinGecko. Cette dernière inférence repose sur la comparaison de deux listes dont la méthode et la date exactes ne sont pas connues.
- La dynamique est **Bitcoin d'abord** : dominance d'environ 59 %, flux des ETF comme principal moteur, déblocages de tokens qui pèsent sur les altcoins. Cela contredit le récit communautaire d'une « altseason » (hypothèse à confronter aux données des autres chercheurs).
- Il existe un contraste entre l'optimisme saisonnier « Uptober » (titre Bankless du 2 oct.) et la réalité des 8–12 oct. : sorties des ETF, indice Fear & Greed redescendu à 56, BTC à environ 82 k$.
- Les résultats de recherche grand public sur les « narratifs » sont saturés de contenu promotionnel (préventes, listes d'exchanges), ce qui est en soi un indicateur du poids du marketing payé dans l'information perçue par les particuliers.

### Gaps
- Aucune donnée **Kaito mindshare**, **LunarCrush**, **Santiment** ou **Google Trends** pour sept.–oct. 2026 (budget de recherche épuisé, sites inaccessibles).
- Le rapport trimestriel CoinGecko du T3 2026 et le classement des « most-viewed categories » 2026 n'ont pas été trouvés.
- Non vérifié pour 2026 :
  - perp DEX (part de marché de Hyperliquid et de ses concurrents) ;
  - volumes des marchés de prédiction (Polymarket/Kalshi) ;
  - suite du rally Zcash et des privacy coins de fin 2025 ;
  - état des sociétés « Bitcoin treasury » / DAT ;
  - ICO / « ownership coins ».
- Trajectoire du marché au S1 2026 inconnue. Un titre CoinInsider affirme que le T3 2026 a été « Bitcoin's best quarter since 2024 », ce qui suggère un S1 faible ; non vérifié. Source du titre : [CoinInsider](https://www.coininsider.org/news/crypto-lost-1-26-billion-to-hacks-in-q3-even-as-bitcoin-posted-its-best-quarter-since-2024/).
- Les capitalisations de catégories au 10 oct. 2026 (DePIN, DeSci, modularité) apparaissent dans un résumé SERP, mais sans URL attribuable : chiffres **exclus**.

## 2. Ce que disent les podcasts et émissions de référence (anglophones et francophones)

### Takeaway
Seuls des **titres et sujets d'épisodes Bankless** ont pu être vérifiés, et seulement via des résumés de listings. Aucune position détaillée d'animateur n'est vérifiable. Rien n'a pu être collecté sur les autres podcasts anglophones ni sur les médias et créateurs francophones (Cryptoast hors articles sur les enlèvements, Hasheur, Powl, etc.). C'est la principale lacune de ces notes.

### Cited Findings
- **Bankless, « ROLLUP: Uptober Green Light? »**, 2 oct. 2026, 59 min, présenté par Ryan Sean Adams et David Hoffman. Sujets : « Uptober », offensive de Robinhood sur le trading, hack de Bitget, « prediction markets' path to the Supreme Court ». Seuls les sujets sont connus, pas les positions exprimées. [SERP] — [Bankless sur Apple Podcasts](https://podcasts.apple.com/us/podcast/bankless/id1499409058) ; [Podchaser](https://www.podchaser.com/podcasts/bankless-1020475)
- **Bankless, « The Duopolies of 2026: Ethereum & Solana, Coinbase & Robinhood, Polymarket & Kalshi »** : date non vérifiée. Le titre traduit une thèse de consolidation du marché en duopoles. [SERP] — [Bankless](https://www.bankless.com/podcast/the-duopolies-of-2026)
- **Bankless, « Where is Crypto Going in 2026? »** avec Ben Cowen : date non vérifiée. [SERP] — [Bankless](https://www.bankless.com/podcast/where-is-crypto-going-in-2026-ben-cowen)
- **Bankless, « 12 Big Crypto Predictions for 2026 »** : date non vérifiée, probablement un épisode de prévisions de fin 2025, à traiter comme contexte historique. [SERP] — [Spotify](https://open.spotify.com/episode/7enpZAipeHkoU0YEfYs7JF)
- Le listing Apple Podcasts de Bankless montre des épisodes récents, non datés, sur le « agentic commerce », les actions tokenisées et les agents IA devenant des acteurs économiques. [SERP] — [Apple Podcasts](https://podcasts.apple.com/us/podcast/bankless/id1499409058)
- Côté francophone, **Cryptoast** est la principale source sur la vague d'enlèvements. Il publie l'article « Enlèvements et séquestrations : les crypto volées sont-elles récupérées ? » (2026), qui cite une source proche du dossier : 103 faits du 1er janvier au 7 septembre 2026. Il tient aussi une liste des enlèvements et agressions liés aux cryptos en France. [SERP]/[PRIMAIRE, lien cité dans le dépôt Lopp] — [Cryptoast, article 2026](https://cryptoast.fr/enlevements-sequestration-crypto-volees-recuperes/) ; [liste Cryptoast](https://cryptoast.fr/liste-enlevements-agressions-lies-cryptomonnaies-france/)
- Contexte historique : **Owen Simonin (Hasheur)**, principal influenceur crypto francophone, a été visé le 26 janv. 2022 par une tentative de home-jacking armé par un faux expert en assurance, repoussée par la victime. Source : Le Parisien, référencé par le dépôt Lopp. [PRIMAIRE] — [jlopp/physical-bitcoin-attacks](https://github.com/jlopp/physical-bitcoin-attacks)

### Inferences
- Sur le seul indice disponible (les titres), le plus gros podcast anglophone a cadré début octobre autour de la saisonnalité (« Uptober »), de la structure de marché (courtiers, duopoles, marchés de prédiction et leur régulation) et de la sécurité (Bitget), plutôt qu'autour de paris altcoins. Ce constat reste faible et ne doit pas être présenté comme la « position » de Bankless.
- Bankless a un positionnement historiquement centré sur Ethereum : c'est un conflit d'intérêts potentiel à signaler, mais **non sourcé dans cette session**.

### Gaps
- Rien de vérifié sur **Unchained, Empire, Bell Curve, Lightspeed, The Rollup, 0xResearch, Real Vision / Raoul Pal, Coin Bureau, What Bitcoin Did, The Chopping Block** pour sept.–oct. 2026 : budget de recherche épuisé avant ces requêtes.
- Rien sur les sources **francophones** : Cryptoast (vidéos et analyses de marché), Journal du Coin, Hasheur, Powl, Grand Angle Crypto, CryptoMatin, Coin Academy, segments crypto de BFM et Zonebourse, The Big Whale. Leurs positions récentes sont inconnues ; ne rien leur attribuer.
- Aucune transcription consultée : aucune citation d'animateur n'est utilisable.

## 3. Sentiment Reddit et forums : ce qui marche ou échoue selon les intervenants (anecdotique)

### Takeaway
**Aucune donnée Reddit ou forum n'a pu être collectée** : Reddit inaccessible, recherche épuisée. Les seuls indicateurs de sentiment disponibles sont agrégés (indice Fear & Greed, flux des ETF, voir sections 1 et 6) et ne reflètent pas la parole des communautés.

### Cited Findings
- Aucune donnée vérifiable collectée pour r/CryptoCurrency, r/Bitcoin, r/ethfinance, r/solana, r/CryptoMarkets, r/vosfinances, r/eupersonalfinance, r/FIREFrance, ni pour les forums Boursorama ou Hardware.fr.
- Indicateur de remplacement, non communautaire : l'indice Fear & Greed est passé de 82 le 26 août 2026 (plus haut de l'année, « extreme greed ») à 56 vers le 10–12 oct. 2026, soit les « pre-rally August lows ». [SERP] — [Decrypt](https://decrypt.co/380708/bitcoin-spooked-crypto-fear-greed-drops) ; [KuCoin News](https://kucoin.com/news/flash/crypto-fear-and-greed-index-drops-to-56-as-bitcoin-sentiment-cools)

### Inferences
- Aucune inférence possible sur le discours Reddit et forums sans données. Le rapport final ne doit pas affirmer ce que « disent les Redditors » sur la base de ces notes.

### Gaps
- Fils Reddit et forums de sept.–oct. 2026 : témoignages de gains et pertes, stratégies citées (staking, airdrops, DCA, perps, marchés de prédiction), sentiment sur les altcoins. À rechercher lors d'une seconde passe.
- Volume d'activité des subreddits (abonnés, publications) : non obtenu.

## 4. Revenus alternatifs : InfoFi/« yapping », promotions KOL, parrainage, création de contenu, bug bounties, emplois

### Takeaway
Le principal canal de revenu « grand public » de 2024–2025, le « yapping » rémunéré (InfoFi via Kaito, Cookie, etc.), a été **coupé le 15 janvier 2026** quand X a interdit les applications qui paient pour publier. Kaito l'a remplacé par une place de marché sélective qui met en relation créateurs vérifiés et marques (Kaito Studio). Autrement dit, la rémunération s'est concentrée sur des créateurs « vetted », ce qui revient à une campagne KOL formalisée. Aucune donnée vérifiée sur les bug bounties, le parrainage ou les salaires 2026.

### Cited Findings
- Le **15 janvier 2026**, Nikita Bier, responsable produit de X, a annoncé que X n'autoriserait plus les applications rémunérant les utilisateurs pour publier, et a révoqué leur accès à l'API. Motif invoqué : un afflux de spam généré par IA et de bruit dans les réponses. Une source décrit la mesure comme visant Kaito, Cookie DAO et « every other InfoFi platform ». [SERP] — [Coinspeaker](https://www.coinspeaker.com/x-bans-infofi-crypto-apps-kaito-token-drops/) ; [BeInCrypto](https://beincrypto.com/x-kills-kaito-infofi-tokens-crash/) ; [coti.news](https://www.coti.news/news/x-cracks-down-on-infofi-forcing-cookie-dao-and-kaito-to-shut-down-reward-programs)
- **Kaito** a mis fin au programme **Yaps** et aux classements incitatifs. Citation attribuée au fondateur Yu Hu : « a fully permissionless reward distribution system is no longer sustainable ». [SERP] — [Coinspeaker](https://www.coinspeaker.com/x-bans-infofi-crypto-apps-kaito-token-drops/)
- **Kaito Studio** remplace Yaps : c'est une place de marché créateurs-marques sélective, organisée par paliers, couvrant crypto, finance et IA sur X, YouTube et TikTok, avec des récompenses à la performance pour des créateurs vérifiés sur des campagnes de marques. Kaito Pro, l'API, Capital Launchpad et Kaito Markets n'étaient pas affectés. [SERP] — [Coinspeaker](https://www.coinspeaker.com/x-bans-infofi-crypto-apps-kaito-token-drops/) ; [CoinGecko, guide Kaito 2026](https://www.coingecko.com/learn/what-is-kaito-earn-yap-points)
- Impact : le token KAITO a chuté d'environ 15 à 20 % en quelques heures, selon des chiffres qui varient d'une source à l'autre. Une communauté d'environ **157 000 « yappers »** aurait perdu son canal de récompense ; ce chiffre vient d'une source unique. [SERP] — [BeInCrypto](https://beincrypto.com/x-kills-kaito-infofi-tokens-crash/) ; [Bloomingbit](https://en.bloomingbit.io/feed/news/104143)
- **Cookie DAO** a fermé son système de campagnes créateurs « Snaps ». Il indique rester client de l'API Enterprise mais ne plus pouvoir opérer de programmes de publication rémunérée. [SERP] — [Bloomingbit](https://en.bloomingbit.io/feed/news/104143) ; [coti.news](https://www.coti.news/news/x-cracks-down-on-infofi-forcing-cookie-dao-and-kaito-to-shut-down-reward-programs)
- Analyses a posteriori, qui sont des blogs d'entreprises crypto, donc des interprétations :
  - « The Rise and Fall of InfoFi » (16 mars 2026) — [BlockEden](https://blockeden.xyz/blog/2026/03/16/infofi-collapse-kaito-studio-pivot-tokenized-attention-x-api-ban-web3-creator-economy/) ;
  - « InfoFi's Trial by Fire: How Tokenized Attention Survived X's Ban and Found Its Real Purpose » (28 mars 2026) — [bex.co](https://bex.co/blog/2026/03/28/infofi-information-finance-tokenized-attention-kaito-intuition-cookie-dao) ;
  - « InfoFi's Reckoning » (21 avr. 2026) — [BlockEden](https://blockeden.xyz/blog/2026/04/21/infofi-information-finance-kaito-grass-attention-data-prediction-markets/).
  [SERP]
- Économie de la promotion payée, en illustration : des préventes de tokens sont promues par communiqués de presse diffusés sur openPR (« Apeing Stage 7 Ending in 4 Days », 2026). [SERP] — [openPR](https://openpr.com/news/4659081/crypto-rally-returns-10-best-cryptos-to-buy-now-in-2026-apeing)

### Inferences
- Pour un particulier francophone, le « yapping » rémunéré n'est plus, depuis janvier 2026, une source de revenu accessible à grande échelle. Ce qui subsiste, ce sont des campagnes de marques sur sélection (Kaito Studio), qui favorisent les créateurs déjà établis : effet « winner-takes-most ».
- Le motif officiel de X (spam IA) indique qu'une partie du « mindshare » mesuré sur Crypto Twitter en 2025 était artificiellement gonflée par des publications rémunérées. Les métriques de mindshare de cette période doivent donc être lues avec prudence.

### Gaps
- **Bug bounties** : paiements Immunefi 2025–2026 (total versé, plus gros paiements, médiane) non obtenus.
- **Promotions KOL** : prévalence, tarifs, part non déclarée et application en France de la loi « influenceurs » de 2023 aux promotions crypto : non vérifiés.
- **Parrainage d'exchanges** : taux de commission 2026 (Binance, Bybit, OKX, Bitget, Coinbase, plateformes françaises) non obtenus.
- **Emplois et salaires crypto 2026** : aucun rapport (Pantera, Electric Capital, web3.career, etc.) consulté.
- Revenus de création de contenu (YouTube, newsletters) : aucune donnée.

## 5. Paysage des risques 2025–2026 : hacks, arnaques, rug pulls, arnaques par IA, attaques physiques, fuites de données, faillites

### Takeaway
- **Hacks 2025** : environ 3,4 Md$ volés selon Chainalysis, dont environ 1,5 Md$ pour le seul hack de Bybit (21 févr. 2025) et environ 2 Md$ attribués à la Corée du Nord.
- **Hacks 2026** : 2,68 Md$ volés au 30 sept. selon CertiK, dont 1,26 Md$ au T3 (+54 % par rapport au T2). Septembre 2026 a été le pire mois de l'année (environ 768 M$, 99 incidents), avec le vol chez Bitget (environ 387 M$, attribué à la Corée du Nord).
- **Attaques physiques (« wrench attacks »)** : la France est devenue l'épicentre mondial. Le Pnaco recense plus de 70 enlèvements et séquestrations sur les 8 premiers mois de 2026, contre 67 sur toute l'année 2025 et une vingtaine en 2024. Dans la base publique de Jameson Lopp, 43 des quelque 62 attaques recensées en 2026 ont eu lieu en France.
- **Non couverts** : statistiques sur les arnaques (pig-butchering, address poisoning, drainers), les arnaques par IA, les fuites de données et les faillites d'exchanges.

### Cited Findings
**Hacks et vols : 2025 (contexte historique)**
- Selon le rapport Crypto Crime 2026 de Chainalysis, environ **3,4 Md$** ont été volés en 2025, dont environ **2 Md$** par des hackers liés à la Corée du Nord et environ **1,5 Md$** pour le seul hack de **Bybit**. PeckShield, avec un périmètre plus large, compte **4,04 Md$** pour 2025. [SERP, résumés secondaires] — [Stingrai](https://www.stingrai.io/blog/crypto-hacking-statistics-2026) ; [Libertify, synthèse Chainalysis 2026](https://www.libertify.com/interactive-library/chainalysis-crypto-crime-report/)
- Date du hack Bybit : 21 févr. 2025, catégorisé « phishing attack » dans l'index DeFiHackLabs. [PRIMAIRE] — [SunWeb3Sec/DeFiHackLabs](https://github.com/SunWeb3Sec/DeFiHackLabs)
- D'après les titres de synthèses secondaires du rapport Chainalysis 2026, le volume illicite aurait atteint « 154 milliards $ » et la criminalité crypto « étatique » aurait augmenté de 694 %. Ces chiffres sont à vérifier sur la source primaire avant usage. [SERP] — [Libertify](https://www.libertify.com/interactive-library/chainalysis-crypto-crime-report/) ; [Fibo Crypto](https://fibo-crypto.fr/en/blog/chainalysis-2026-report-state-level-crypto-crime-surges-694/)

**Hacks et vols : 2026**
- Article Forbes du 17 juil. 2026 (entretien avec le PDG de CertiK), intitulé « Fewer But Far More Surgical Crypto Hacks Hit $1.3 Billion In 2026 » : bilan du S1, avec des attaques moins nombreuses mais plus ciblées. [SERP] — [Forbes, 17 juil. 2026](https://www.forbes.com/sites/boazsobrado/2026/07/17/fewer-but-far-more-surgical-crypto-hacks-hit-13-billion-in-2026/)
- **CertiK, T3 2026** (publication début oct. 2026, date exacte non vérifiée) :
  - pertes d'environ **1,26 Md$** sur **247 incidents**, contre 819,4 M$ et 219 incidents au T2, soit +53,9 % en valeur et environ +13 % en nombre ;
  - **septembre 2026**, pire mois de l'année : **99 incidents** (le plus depuis février 2025) et **768,5 M$** ;
  - **cumul 2026 : 2,68 Md$**.
  [SERP, concordant entre plusieurs titres] — [Cointelegraph](https://cointelegraph.com/news/bitget-hack-q3-industry-losses-1-26-billion) ; [CoinCentral](https://coincentral.com/crypto-security-losses-hit-1-26-billion-in-third-quarter-as-bitget-hack-leads-incidents) ; [PANews](https://panews.io/articles/01a0f749-0770-73dc-81bb-41415c2899c2) ; [Yahoo Finance](https://finance.yahoo.com/markets/crypto/articles/crypto-industry-lost-1-26-132400809.html)
- Le tableau de bord CertiK, dans un autre instantané, affiche 1,27 Md$ et 253 incidents pour le T3, et 773,4 M$ pour septembre. Répartition affichée : exploits 739,9 M$ (95,7 %), compromission de clés privées 14,2 M$. Vu le calcul 739,9 / 0,957 ≈ 773 M$, cette répartition porte vraisemblablement sur septembre. [SERP] — [CertiK, tableau de bord](https://www.certik.com/certik-report/dashboard)
- Principaux incidents du T3 2026 selon CertiK :
  - **Bitget**, environ 387,5 M$, soit environ 31 % des pertes du trimestre ;
  - **Liquid Network**, environ 319 M$, le 6 sept. ;
  - **Tectonic**, 120 M$ ;
  - « **Coldcard theft** », 112,7 M$.
  La nature exacte des trois derniers incidents n'a pas pu être vérifiée. [SERP] — [Cointelegraph](https://cointelegraph.com/news/bitget-hack-q3-industry-losses-1-26-billion) ; [CoinCentral](https://coincentral.com/crypto-security-losses-hit-1-26-billion-in-third-quarter-as-bitget-hack-leads-incidents)
- **Bitget** : selon Chainalysis, des acteurs attribués à la Corée du Nord ont volé **387 M$** le **24 sept. 2026**. Ce vol porte le total nord-coréen de 2026 au-delà de **1 Md$**. Chainalysis dit avoir utilisé l'IA pour tracer les fonds. [SERP] — [Chainalysis](https://www.chainalysis.com/blog/387m-bitget-theft-2026/)
- **Rapport d'étape SlowMist sur Bitget** (état au 29 sept. 2026) [PRIMAIRE] :
  - première activité malveillante détectée le **31 août**, via une **faille zero-day** sur un nœud d'un produit de sécurité tiers (« Product A »), avec lecture du mot de passe de la base de données ;
  - le 25 sept., accès à la plateforme d'un second produit (« Product B ») sous l'**identité d'un employé interne** ;
  - **outil de retrait sur mesure** qui falsifiait les paramètres de contrôle des risques ;
  - vol démarré à 01h49 (UTC+8) le 25 sept., transferts étalés sur environ **2 h 52** sur plusieurs blockchains ;
  - tentatives ultérieures de falsifier des ordres de retrait BTC.
  — [slowmist/knowledge-base, « SlowMist Investigation Progress Report - Bitget »](https://github.com/slowmist/knowledge-base/tree/master/open-report-V2/incident-response)
- **DeFiHackLabs** (reproductions d'exploits DeFi sur EVM, état au 12 oct. 2026) [PRIMAIRE] — [SunWeb3Sec/DeFiHackLabs](https://github.com/SunWeb3Sec/DeFiHackLabs) :
  - **146 incidents datés de 2026** dans l'index. Répartition par mois : janv. 6, févr. 3, mars 13, avr. 15, mai 25, juin 25, juil. 4, août 15, **sept. 34**, oct. (jusqu'au 12) 6. Le pic de septembre coïncide avec celui de CertiK. Ces comptes reflètent toutefois l'activité de reproduction des contributeurs, pas l'incidence réelle.
  - Exemples 2026 avec montants :
    - Makina, environ 5,1 M$ (20 janv., manipulation d'oracle) ;
    - Moonwell, 1,78 M$ (15 févr., oracle défaillant) ;
    - TrustedVolumes, environ 5,87 M$ (7 mai) ;
    - VerusBridge, environ 11,58 M$ (17 mai) ;
    - New Market Trading, environ 3,98 M$ (25 mai) ;
    - DxSale, environ 7,3 M$ (28 mai) ;
    - Summer.fi, environ 6 M$ (6 juil.) ;
    - Notional Finance, environ 1,73 M$ (3 sept.) ;
    - rsETH Safe Module, environ 7,8 M$ brut, dont environ 7,73 M$ net captés par un **frontrunner MEV** (15 sept.).
  - Tendance notable de l'été-automne 2026 : vidage de **contrats anciens ou dormants**. Exemples : keeper « flip » ETH-A dormant de MakerDAO (200 ETH, 6 oct.), prise de gouvernance de la DAO dormante de Yam Finance (12 sept.), « abandoned governor » de StrongBlock (5 août), Set Protocol (6 oct.), DAOstack (26 sept.), Reflexer GEB (1er sept.), Balancer V1 sur 5 pools (31 août), Aztec V1 / Aztec Connect (juin).

**Attaques physiques (« wrench attacks »)**
- **Chainalysis, rapport de mi-année 2026** (publication estimée juillet-août, date exacte non vérifiée) [SERP] — [The Block](https://www.theblock.co/post/410984/more-than-30-million-stolen-in-violent-crypto-attacks-in-2026-as-france-emerges-as-wrench-attack-hotspot-chainalysis) ; [Decrypt](https://decrypt.co/375014/crypto-wrench-attacks-30m-stolen-2026-chainalysis) ; [Infosecurity Magazine](https://www.infosecurity-magazine.com/news/violent-physical-crypto-thefts/) ; [BigGo Finance](https://finance.biggo.com/news/ad162575-d7df-4ce0-b8a0-d98d27bc031a)
  - **46 attaques violentes** documentées jusqu'à fin juin 2026, pour **plus de 30 M$** de pertes. À ce rythme, le record de 2025 (58 M$) pourrait être dépassé.
  - Les home-jackings représentent **37 %** des incidents.
  - **La France arrive en tête avec 30 attaques** à mi-2026.
  - Taux de réussite de **26 %**, contre 49 % en 2025 (selon BigGo).
  - En incluant tentatives, transferts bloqués et récupérations, Chainalysis évoque environ 107 M$, et le juge lui-même probablement sous-estimé.
- **Base publique de Jameson Lopp** (commit du 6 oct. 2026) [PRIMAIRE] — [jlopp/physical-bitcoin-attacks](https://github.com/jlopp/physical-bitcoin-attacks)
  - Attaques recensées par année : 2024 : 41 ; 2025 : 86 ; 2026 au 6 oct. : **62** (entre 62 et 65 selon le mode d'extraction).
  - **France : 1 attaque en 2024, 22 en 2025, 43 en 2026**, soit environ 69 % des cas mondiaux de 2026. Les États-Unis n'en comptent que 4 en 2026.
  - Cas français marquants de 2026 :
    - Sallanches, 14 janv. : couple enlevé pour les « 8 M€ en crypto » de son fils ;
    - Val-de-Marne, 12 févr. : domicile du PDG de Binance France fouillé par 3 hommes alors qu'il était absent ;
    - Le Chesnay-Rocquencourt, 9 mars : 900 000 € en BTC volés par de faux policiers ;
    - Ploudalmézeau, 20 avr. : 700 000 € extorqués à une famille de 5 personnes, dont 2 enfants ;
    - Taverny, 13 juil. : famille séquestrée pour 100 € de crypto ;
    - Jouy-en-Josas, 24 août : 6 M€ exigés ;
    - Vendin-le-Vieil, 19 sept. : couple et deux enfants de 8 et 12 ans, 40 000 € transférés ;
    - Saint-Jean-de-Védas, 29 sept. : couple visé une deuxième fois en 6 mois.
  - Hors de France :
    - Mexique (Atizapán), 1er sept. 2026 : une famille et une employée de maison tuées pour un hardware wallet. Le README indique environ 118 000 $ de BTC, le fichier attacks.json environ 1,5 M$ : incohérence interne à la base.
    - Bali, 2 juil. 2026 : 5 M$.
    - Pattaya, 6 oct. 2026 : 820 000 $.
  - Contexte historique France 2025 :
    - David Balland, cofondateur de Ledger, enlevé avec son épouse le 21 janv. 2025 ; doigt sectionné, libéré par le GIGN ;
    - 1er mai 2025 : père d'un entrepreneur crypto enlevé à Paris, rançon de 5 M€, doigt sectionné ;
    - 13 mai 2025 : tentative d'enlèvement en pleine rue de la fille de Pierre Noizat (PDG de Paymium).
- **Parquet national anticriminalité organisée (Pnaco)**, annonce du 11 sept. 2026 : **plus de 70 enlèvements et séquestrations** sur les 8 premiers mois de 2026, contre **67 en 2025** et **une vingtaine en 2024**. [SERP] — [franceinfo](https://www.franceinfo.fr/economie/bitcoin/cryptomonnaies-plus-de-70-enlevements-et-sequestrations-recenses-sur-les-huit-premiers-mois-de-2026-d-apres-le-parquet-national-anticriminalite-organisee_8188352.html) ; [ICI](https://www.ici.fr/infos/faits-divers-justice/cryptomonnaies-les-enlevements-et-sequestrations-en-forte-hausse-plus-de-70-faits-recenses-depuis-le-debut-de-l-annee-9287600?at_locale=56)
  - **Ce décompte est contredit** par un autre : **103 faits** du 1er janv. au 7 sept. 2026, contre **56** pour toute l'année 2025, selon une source proche du dossier citée par Cryptoast. [SERP] — [Cryptoast](https://cryptoast.fr/enlevements-sequestration-crypto-volees-recuperes/)
- Interpellations de septembre 2026 [SERP] :
  - 4 personnes arrêtées entre le 8 et le 11 sept. en Auvergne-Rhône-Alpes. Selon la gendarmerie, le réseau était **piloté depuis la prison par 3 détenus via les réseaux sociaux**, avec une complice libre. — [Clubic](https://www.clubic.com/actualite-630067-cryptomonnaies-la-gendarmerie-arrete-quatre-suspects-en-auvergne-rhone-alpes-pour-enlevements-et-sequestrations.html)
  - 4 hommes arrêtés les 7 et 8 sept. dans le Finistère pour la séquestration de Ploudalmézeau. Source : résumé SERP, URL précise non identifiée parmi les résultats.
- Fin juin 2026, le ministre de l'Intérieur Laurent Nuñez a promis un plan pour renforcer la sécurité des acteurs du secteur. [SERP, résumé de la recherche « enlèvement cryptomonnaie France septembre 2026 »] — sources listées : [franceinfo](https://www.franceinfo.fr/economie/bitcoin/cryptomonnaies-plus-de-70-enlevements-et-sequestrations-recenses-sur-les-huit-premiers-mois-de-2026-d-apres-le-parquet-national-anticriminalite-organisee_8188352.html) ; [Renseignement Économique](https://renseignementeconomique.fr/vagues-d-agressions-contre-des-detenteurs-de-crypto-la-france-confrontee-a-une-criminalite-ciblee)
- Un expert en sécurité, cité par franceinfo (date non vérifiée, antérieure à sept. 2026), estime que la vague d'enlèvements « ne ralentit pas » et pointe des « prestataires défaillants ». [SERP] — [franceinfo](https://www.franceinfo.fr/faits-divers/cryptomonnaies-la-vague-d-enlevements-contre-le-secteur-ne-ralentit-pas-alerte-un-expert-en-securite-qui-pointe-des-prestataires-defaillants_7790333.html)
- Fortune, 19 mars 2026 : « France is experiencing wave of crypto assault ». [SERP] — [Fortune](https://www.fortune.com/2026/03/19/france-is-experiencing-wave-of-crypto-assault)
- Étude académique « Investigating Wrench Attacks: Physical Attacks Targeting Cryptocurrency Users » (Ordekian, Atondo-Siu, Hutchings, Vasek ; UCL et Cambridge), hébergée dans le dépôt Lopp [PRIMAIRE] — [PDF dans jlopp/physical-bitcoin-attacks](https://github.com/jlopp/physical-bitcoin-attacks/blob/master/Wrench_Attacks_Research.pdf) :
  - ces attaques sont « underreported due to revictimization fears » ;
  - « users with advanced security experience were not immune » ;
  - corpus : 10 entretiens, 146 articles de presse, 37 forums.

### Inferences
- **Le hack de plateforme reste le risque n°1 en valeur.** En 2026, il passe surtout par des intrusions sophistiquées dans la chaîne d'approvisionnement et l'infrastructure : produits de sécurité tiers et identité interne chez Bitget. Ce n'est pas un risque que le particulier contrôle, hormis par le choix et la diversification des plateformes et l'auto-conservation.
- **Les « contrats zombies »** (anciens protocoles DeFi dormants) sont une source récurrente d'exploits en 2026 : les fonds oubliés dans d'anciens protocoles sont exposés.
- **La France est le pays le plus touché au monde par les attaques physiques.** La base publique (Lopp : 40 cas en France de janvier à août 2026) ne capture qu'environ la moitié des faits connus du Pnaco (plus de 70 sur la même période). En 2025, le rapport est d'environ un tiers (22 contre 67). C'est cohérent avec la sous-déclaration documentée par l'étude académique. La divergence entre Pnaco (plus de 70) et la source de Cryptoast (103) s'explique probablement par des périmètres différents (tentatives, faits connexes) ; à présenter comme une fourchette.
- Plusieurs victimes françaises de 2026 ont été ciblées **par erreur** ou pour des montants dérisoires (Taverny, 100 € ; Vaires-sur-Marne ; Vern-sur-Seiche ; Grivesnes ; Vaucresson). La **perception** de richesse, alimentée par l'exposition sur les réseaux sociaux et par des fuites de données, suffit à faire de quelqu'un une cible.

### Gaps
- **Arnaques** : non obtenus. Cela concerne :
  - les revenus des arnaques en 2025 selon le chapitre « Scams » du rapport Chainalysis 2026 (la page existe : [Chainalysis, Crypto Scams 2026](https://www.chainalysis.com/blog/crypto-scams-2026/)) ;
  - le pig-butchering, l'address poisoning et les wallet drainers (ScamSniffer) ;
  - les arnaques par IA et deepfakes ;
  - le rapport FBI IC3 2025 (publié en 2026) ;
  - les données Europol.
- **Rug pulls** et memecoins (pump.fun, etc.) : statistiques 2025–2026 non obtenues.
- **Fuites de données** visant des détenteurs de crypto, par exemple des plateformes fiscales ou des exchanges français, et leur lien avec les enlèvements : non vérifiées, en dehors du titre franceinfo sur les « prestataires défaillants ».
- **Faillites d'exchanges** 2025–2026 : aucune trouvée ni vérifiée. Les conséquences du hack Bitget pour ses clients (remboursement, fonds de protection) ne sont pas vérifiées.
- Rapports **Immunefi** et **TRM Labs** 2026 : non consultés.
- La nature des incidents « Liquid Network » (319 M$), « Tectonic » et « Coldcard theft » n'est pas vérifiée au-delà du résumé CertiK.

## 6. Preuves comportementales : biais du survivant, pertes des particuliers, signaux de « top » ou de « bottom »

### Takeaway
Le sentiment agrégé a culminé fin août 2026 (Fear & Greed à 82, plus haut de l'année), puis est redescendu à un niveau neutre (environ 56) début octobre, sur fond de sorties des ETF. Ce profil va contre l'euphorie d'« Uptober ». Aucune étude 2025–2026 sur les pertes des particuliers ou sur le biais du survivant dans les PnL publiés n'a pu être consultée. Les données d'attaques physiques montrent en revanche que l'affichage de gains sur les réseaux sociaux constitue un risque concret.

### Cited Findings
- Indice Fear & Greed : **82 le 26 août 2026**, « the highest reading this year », zone « extreme greed ». Il redescend à **56** (neutre) vers le 10–12 oct. 2026. [SERP] — [Decrypt](https://decrypt.co/380708/bitcoin-spooked-crypto-fear-greed-drops) ; [KuCoin News](https://kucoin.com/news/flash/crypto-fear-and-greed-index-drops-to-56-as-bitcoin-sentiment-cools)
- Les lectures divergent selon les fournisseurs pour la même journée : Tokenpost cite 69 (« greed ») et souligne que ces chiffres contradictoires empêchent une description unique du sentiment ; l'indice spécifique Bitcoin de CFGI.io affiche 47 (neutre) le 12 oct. 2026 à 22h05 UTC. [SERP] — [Tokenpost](https://tokenpost.com/news/investing/30605) ; [CFGI.io](https://cfgi.io/bitcoin-fear-greed-index/)
- Titre CoinInsider (début oct. 2026) : le T3 2026 aurait été « Bitcoin's best quarter since 2024 ». [SERP] — [CoinInsider](https://www.coininsider.org/news/crypto-lost-1-26-billion-to-hacks-in-q3-even-as-bitcoin-posted-its-best-quarter-since-2024/)
- Lecture d'un acteur intéressé : Zerocap qualifie la baisse d'octobre de « leverage flush rather than a change in trend ». [SERP] — [Zerocap, 12 oct. 2026](https://zerocap.com/insights/weekly-crypto-market-wrap/weekly-crypto-market-wrap-12-october-2026)
- Exposition sur les réseaux sociaux et ciblage [PRIMAIRE] — [jlopp/physical-bitcoin-attacks](https://github.com/jlopp/physical-bitcoin-attacks) :
  - un « TikTok trader » enlevé à Juvisy-sur-Orge (13 juin 2025) a été relâché une fois son wallet ouvert, qui ne contenait qu'un « tiny balance » ;
  - un influenceur de 18 ans a été enlevé au Brésil (3 juil. 2026) après que ses ravisseurs ont appris qu'il investissait en crypto ;
  - à Grivesnes (juin 2026), un groupe a filmé l'agression sur Snapchat ;
  - un réseau d'enlèvements a été piloté depuis la prison via les réseaux sociaux (sept. 2026) — [Clubic](https://www.clubic.com/actualite-630067-cryptomonnaies-la-gendarmerie-arrete-quatre-suspects-en-auvergne-rhone-alpes-pour-enlevements-et-sequestrations.html).
- Capture de valeur par des acteurs sophistiqués : environ 7,73 M$ de l'exploit rsETH Safe Module (15 sept. 2026) ont été captés en net par un **frontrunner MEV**. [PRIMAIRE] — [SunWeb3Sec/DeFiHackLabs](https://github.com/SunWeb3Sec/DeFiHackLabs)
- X a justifié l'interdiction de l'InfoFi par l'afflux de spam IA et de réponses automatisées, ce qui montre une pollution de l'engagement mesuré sur Crypto Twitter. [SERP] — [BeInCrypto, « The Death of AI Slop? »](https://beincrypto.com/x-kills-kaito-infofi-tokens-crash/)

### Inferences
- **Signal de sentiment** : la séquence est la suivante :
  1. pic d'avidité fin août (82) ;
  2. trimestre présenté comme le meilleur depuis 2024 ;
  3. reflux à environ 56 début octobre, avec des sorties d'ETF.
  C'est le profil d'une **euphorie retombée** plutôt que d'un « bottom » de capitulation : on n'observe pas de « extreme fear ». Cela reste une lecture d'indicateurs agrégés, divergents entre fournisseurs.
- **Biais du survivant** : la visibilité donnée aux gains (PnL publiés, influenceurs) ne mesure pas la rentabilité moyenne. En France, elle crée en plus un **risque physique** démontré. Ce point est étayé par les cas recensés, pas par une étude statistique sur les PnL.
- **Qui capture la valeur** : en 2026, les profits visibles dans les données de sécurité vont à des acteurs sophistiqués (groupes étatiques nord-coréens, frontrunners MEV), pas aux particuliers.

### Gaps
- **Études sur les pertes des particuliers** (BIS, AMF/ESMA, études académiques 2025–2026) : non consultées. Piste historique **non vérifiée dans cette session**, à confirmer avant tout usage : le BIS Bulletin n° 69 (2023), « Crypto shocks and retail losses ».
- Distribution des gains et pertes sur **Polymarket**, **Hyperliquid** et les launchpads memecoins (pump.fun) en 2025–2026 : non obtenue.
- Études sur le biais du survivant dans les PnL publiés sur les réseaux sociaux : non obtenues.
- Google Trends (« bitcoin », « crypto », « acheter bitcoin » en France) et données d'activité Reddit comme signaux d'un « top » ou d'un « bottom » côté particuliers : non obtenus.
- Enquêtes 2026 sur les détenteurs français (AMF, ADAN, KPMG) : non consultées.

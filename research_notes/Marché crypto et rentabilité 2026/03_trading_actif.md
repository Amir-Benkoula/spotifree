# Trading actif crypto en 2026 : rentabilité réelle, qui gagne, qui perd (spot, perps/levier, options, copy-trading, prop firms, stratégies delta-neutres)

*Notes de recherche, état au 13 octobre 2026.*

> **Avertissement méthodologique pour le rédacteur.**
> 1. Le budget de recherche web partagé entre agents (200 requêtes par tour) a été épuisé après environ 22 requêtes de ce module.
> 2. L'outil WebFetch a échoué (erreur DNS `ENOTFOUND`) sur toutes les pages tentées : coinglass.com, cryptofundresearch.com, datalab.financemagnates.com, yieldfund.com et coindesk.com.
>
> Tous les chiffres ci-dessous proviennent donc des extraits et résumés renvoyés par le moteur de recherche (mode « extended »). Aucune page n'a été lue en entier. Quand l'attribution d'un chiffre à une URL précise est incertaine, la mention **(attribution à vérifier)** est ajoutée.
>
> **Étiquettes de qualité :**
> - **[Donnée dure]** : données de marché ou on-chain, document réglementaire, fiche produit officielle.
> - **[Étude]** : travail académique ou de régulateur.
> - **[Vendeur/Marketing]** : source ayant un intérêt commercial.
> - **[Agrégateur]** : blog ou site qui compile des données tierces.
> - **[Historique]** : donnée de plus de 6 mois, à présenter comme contexte.
>
> **Rappel :** un volume de liquidations est le **notionnel** des positions fermées de force. Ce n'est pas une perte nette.

---

## Q1. Quelle part des traders particuliers en crypto gagne ou perd de l'argent ? (études, régulateurs, données on-chain)

### Takeaway
Aucune étude indépendante publiée en 2025-2026 ne mesure directement la part de traders crypto particuliers rentables. Les meilleures données disponibles convergent pourtant : de 73 % à 89 % des particuliers perdent de l'argent. Elles viennent de la BIS (2022, spot), d'un échantillon on-chain Hyperliquid (novembre 2024, seulement 16,5 % de wallets rentables sur 30 jours) et de l'AMF (2014, CFD/Forex). Les rares gains se concentrent sur les très gros comptes. Dans l'UE, l'ESMA a estimé le 24/02/2026 que les « perpetual futures » proposés aux particuliers relèvent probablement du régime CFD, avec un levier crypto plafonné à 2:1.

### Cited Findings
**Études et régulateurs**
- **[Étude][Historique]** Working paper BIS de novembre 2022 (Auer, Cornelli, Doerr, Frost, Gambacorta). Les auteurs ont construit une base des applis d'échange crypto utilisées chaque jour par les particuliers dans 95 pays, de 2015 à 2022. Constat : « à la date de rédaction, 73-81 % des utilisateurs avaient probablement perdu de l'argent » sur leurs investissements en bitcoin. Sources : [Bloomberg, 16/11/2022](https://www.bloomberg.com/news/articles/2022-11-16/vast-majority-of-retail-investors-in-bitcoin-lost-money-bis-says) ; [Bloomberg Law](https://news.bloomberglaw.com/crypto/about-75-of-retail-buyers-of-bitcoin-lost-money-bis-study-says) ; [The Register, 16/11/2022](https://www.theregister.com/2022/11/16/bitcoin_investors_lose/).
- **[Étude][Historique]** Même étude, précisions :
  - Le haut de la fourchette (81 %) suppose que chaque nouvel utilisateur achète 100 $ de BTC le mois où il installe l'appli, puis chaque mois.
  - Les nouveaux utilisateurs sont surtout jeunes et masculins, le segment le plus preneur de risque.
  - L'adoption suit le prix : les téléchargements augmentent quand le BTC monte, ce que les auteurs lisent comme du trading spéculatif.
  - Sources : [Bloomberg](https://www.bloomberg.com/news/articles/2022-11-16/vast-majority-of-retail-investors-in-bitcoin-lost-money-bis-says) ; [Advisor.ca](https://www.advisor.ca/investments/market-insights/most-retail-investors-lose-on-bitcoin-trades-bis/).
  - **Limites :** l'étude mesure l'investissement spot via une appli, pas le trading à levier. Aucune mise à jour par la BIS n'a été trouvée.
- **[Étude]** BIS WP 1087 « Crypto carry » (Schmeling, Schrimpf, Todorov, révisé en octobre 2025). Le papier cite Kogan et al. (2023) : les particuliers sont des suiveurs de tendance (*trend followers*) sur les cryptoactifs. Il cite aussi Christin et al. (2022) sur la manière dont les plateformes facilitent le levier des acheteurs (positions longues). Source : [BIS WP 1087](https://www.bis.org/publ/work1087.pdf).
- **[Étude][Historique]** Working paper de NYU Stern (Duron-Carielo) citant une étude Binance de 2020 :
  - 79 % des clients de Binance tradaient avec un levier supérieur à 20x.
  - Dans une simulation à 125x, 98,32 % des trades seraient liquidés. C'est une simulation, pas un résultat observé.
  - Source : [NYU Stern](https://www.stern.nyu.edu/sites/default/files/assets/documents/Duron-Carielo_Is%20There%20A%20Future%20In%20Perpetual%20Futures.pdf).
- **[Étude]** Lettre de commentaire adressée à la SEC le 18/08/2026 (dossier S7-2026-21). Elle cite une étude de BitMEX selon laquelle les liquidations étaient un trait marquant des premiers marchés de perpétuels, « en particulier pour les petits traders ». Selon la lettre, le risque dépend de l'ensemble des règles (marge initiale et de maintenance, politique de liquidation, liquidité, ressources pour absorber les déficits), pas seulement du levier maximal. Source : [SEC, 18/08/2026](https://www.sec.gov/comments/S7-2026-21/s7202621-1011079-3235289.pdf).
- **[Étude][Historique]** Étude AMF sur le Forex et les CFD, publiée en octobre 2014. Elle porte sur 14 799 clients actifs suivis pendant 4 ans (2009-2012).
  - Plus de 89 % de clients perdants.
  - Perte moyenne de 10 887 € par client.
  - Perte totale de 161,1 M€ selon l'AMF ; 175 M€ selon une autre source.
  - Sources : [AMF, Lettre de l'Observatoire de l'épargne n°10, oct. 2014](https://www.amf-france.org/sites/institutionnel/files/contenu_simple/lettre_ou_cahier/lettre_observatoire/La%20lettre%20de%20l%27Observatoire%20de%20l%27epargne%20de%20l%27AMF%20-%20ndeg%2010%20-%20Octobre%202014.pdf) ; [Que Choisir](https://www.quechoisir.org/actualite-trading-en-ligne-neuf-particuliers-sur-dix-perdent-de-l-argent-n4671/) ; [Moneyvox](https://www.moneyvox.fr/bourse/actualites/47908/cfd-forex-10.000-euros-de-perte-moyenne-pour-les-boursicoteurs-francais).
- **[Historique]** Sur la crypto, l'AMF ne publie que des données de plaintes et d'arnaques, pas de taux de perte des traders :
  - plus de 9 M€ de pertes recensées en quelques mois début 2018 ;
  - de 500 € à 104 000 € perdus par victime selon le médiateur.
  - Sources : [La finance pour tous, 23/05/2018](https://www.lafinancepourtous.com/2018/05/23/bilan-alarmant-de-lamf-concernant-les-pertes-liees-aux-crypto-actifs-depuis-janvier-2018/) ; [Actu-Juridique](https://www.actu-juridique.fr/affaires/le-mediateur-de-lamf-met-en-garde-contre-les-arnaques-aux-cryptoactifs/).

**UE et France : le cadre réglementaire en 2026**
- **[Donnée dure]** Déclaration de l'ESMA du 24/02/2026. L'ESMA et les régulateurs nationaux constatent une offre croissante de dérivés à levier vendus comme « perpetual futures ». Selon eux, ces produits relèvent « probablement » des mesures nationales permanentes d'intervention sur les CFD. L'étiquette commerciale ne change rien, pas plus que le mécanisme de funding ou l'existence d'un fonds d'assurance. Sources : [Finance Magnates](https://www.financemagnates.com/forex/regulation/esma-tells-firms-perpetual-futures-fall-under-eu-cfd-rules/) ; [Cryptonomist, 24/02/2026](https://en.cryptonomist.ch/2026/02/24/cfds-regulation-esma-perpetual-futures/) ; [Delano](https://delano.lu/article/perpetual-does-not-mean-unregulated-esma) ; [MFSA (Malte), circulaire de mars 2026](https://www.mfsa.mt/wp-content/uploads/2026/03/Circular-on-ESMA-Public-Statement-Identifying-Derivatives-within-the-Scope-of-CFDs-National-Product-Intervention-Measures.pdf).
- **[Donnée dure]** Protections qui en découlent pour les particuliers :
  - levier maximal de 2:1 sur les CFD crypto ;
  - clôture automatique des positions en cas d'insuffisance de marge ;
  - protection contre le solde négatif ;
  - avertissement de risque standardisé ;
  - interdiction des incitations commerciales ;
  - évaluation du caractère approprié du produit.
  - Sources : [Cryptonomist](https://en.cryptonomist.ch/2026/02/24/cfds-regulation-esma-perpetual-futures/) ; [Cryptoticker](https://cryptoticker.io/en/perpetuals-mifid-classification-leverage-cap/).
- Le « Hyperliquid Policy Center » a contesté cette classification devant la Commission européenne. Il a déposé son dossier au moment de la clôture de la consultation sur la révision de MiCA, le 30 septembre (2026). Source : [Fintelegram](https://fintelegram.com/esma-draws-the-line-why-hyperliquids-crypto-perpetuals-look-increasingly-like-cfds-in-defi-clothing/) **(attribution à vérifier)**.

**Données on-chain (Hyperliquid)**
- **[Agrégateur][Historique]** Analyse de 10 000 wallets Hyperliquid, publiée en 2026 mais fondée sur des données de novembre 2024, sur une fenêtre de 30 jours.
  - 16,5 % de wallets rentables, 73,8 % perdants, 9,7 % à l'équilibre.
  - Parmi les comptes de 10 à 100 M$, 85,7 % sont rentables.
  - L'auteur précise qu'il mesure la probabilité d'être rentable, pas la marge de profit.
  - Source : [Medium / envyprotocol](https://medium.com/@envyprotocol/i-analyzed-10-000-hyperliquid-traders-the-results-are-brutal-a29adcca8c2a).
- **[Agrégateur]** Guide 2026 d'un outil de suivi de wallets :
  - 82 586 wallets actifs suivis ;
  - seuls 230 d'entre eux (environ 0,3 %) affichent plus de 1 M$ de profit cumulé ;
  - la cohorte « non rentable » compte 58 848 wallets, soit environ 71 % (calcul personnel).
  - Source : [Buildix, guide 2026](https://www.buildix.trade/blog/hyperliquid-copy-trading-smart-money-tracker-whale-wallets-2026) **(attribution à vérifier : le chiffre vient d'un résumé de recherche qui regroupait plusieurs agrégateurs)**.
- **[Vendeur/Marketing]** Étude de juin 2026 portant sur plus de 247 000 wallets :
  - une cohorte « disciplinée », repérée par des signaux de comportement, aurait gagné 50,0 % en 6 mois ;
  - sur la même période, le trader « qualifié » moyen perd 7,3 % et le BTC 25,3 % ;
  - résultats auto-publiés et backtestés, non audités.
  - Source : [Dropstab Research](https://news.dropstab.com/research/hyperliquid-smart-money) **(attribution à vérifier)**.
- **[Donnée dure]** Le classement officiel d'Hyperliquid exclut les comptes de moins de 100 000 USDC et ceux de moins de 10 M USDC de volume. Source : [Hyperliquid Leaderboard](https://app.hyperliquid.xyz/leaderboard).
- **[Agrégateur]** Les classements se contredisent. Le même wallet n°1 affiche 427 734 583 $ de PnL sur 30 jours (ROI de 55,78 %) chez un agrégateur, contre 42 515 687 $ (ROI de 4,18 %) sur la page officielle. Sources : [CoinDuck](https://www.coinduck.io/blog/hyperliquid-leaderboard-top-profitable-traders) contre [Hyperliquid Leaderboard](https://app.hyperliquid.xyz/leaderboard) **(attribution à vérifier)**.

### Inferences
- Trois mesures très différentes donnent le même ordre de grandeur, entre 73 % et 89 % de perdants : spot via appli (2015-2022), perps on-chain sur 30 jours (2024), CFD et Forex en France (2009-2012). On peut donc écrire qu'environ 3 particuliers sur 4 perdent de l'argent, et plutôt 8 à 9 sur 10 avec levier. Il faut préciser qu'aucune mesure directe ne date de 2026.
- Les gains sont concentrés : 85,7 % de gagnants chez les comptes de 10 à 100 M$, contre 16,5 % sur l'ensemble (novembre 2024). L'écart reflète un avantage de compétence, de capital ou d'information. Il reflète aussi un biais de survie, car un compte est gros en partie parce qu'il a gagné.
- Les classements sont biaisés par construction : seuils d'entrée élevés, wallets perdants invisibles, snapshots divergents. Ils ne mesurent jamais le rendement typique.
- Pour un lecteur français, l'accès aux perps à fort levier via des acteurs régulés (CASP sous MiCA, brokers de CFD) devrait se réduire avec l'interprétation de l'ESMA. Les DEX hors UE comme Hyperliquid restent toutefois accessibles techniquement, sans les protections CFD (solde négatif, levier 2:1).

### Gaps
- Aucune étude académique ou réglementaire de 2025-2026 ne mesure la part de traders crypto particuliers rentables, que ce soit sur les plateformes centralisées (CEX) ou les DEX.
- Aucune plateforme (Binance, Bybit, OKX, Bitget) ne publie la part de ses comptes rentables, d'après les recherches menées.
- Les mentions obligatoires des brokers de CFD (« X % des comptes de particuliers perdent de l'argent ») n'ont pas été collectées pour la crypto, chez eToro ou ailleurs.
- La fourchette de pertes sur CFD publiée par l'ESMA en 2018 n'a pas été vérifiée dans cette session.
- La distribution complète des PnL des wallets Hyperliquid (Dune, Hyperdash, Hypurrscan) n'a pas été consultée directement : WebFetch indisponible et budget de recherche épuisé.
- Le papier de Kogan et al. (2023) n'a pas été lu.
- Le contexte de marché de novembre 2024 n'a pas été sourcé ici. Une forte hausse après l'élection américaine est à vérifier : si elle se confirme, n'avoir que 16,5 % de gagnants pendant un mois haussier renforcerait le constat.

---

## Q2. Liquidations 2025-2026 : volumes, événements majeurs, ce qu'ils révèlent du levier des particuliers

### Takeaway
- **2025 :** environ 150 Md$ de liquidations selon CoinGlass, dont le record des 10-11/10/2025 (19,1 Md$ en 24 h, 1,6 million de traders, surtout des positions longues).
- **S1 2026 :** 73,35 Md$ de liquidations, dont 62 % de longs. Plus grosse journée : 2,59 Md$ le 31/01/2026. Pire mois : juin, avec 16,14 Md$.
- **Depuis :** record de liquidations de shorts en août 2026 (plus de 4 Md$ en deux jours) et environ 1,19 Md$ les 8-9/10/2026.
- Début octobre 2026, aucun événement de l'année n'approche le record du 10/10/2025.

### Cited Findings
- **[Donnée dure][Historique] 10-11/10/2025 :** 1 618 240 traders liquidés pour 19,13 Md$ en 24 h selon CoinGlass. CoinGlass précise que le total réel est sans doute bien plus élevé, car Binance ne publie qu'un ordre de liquidation par seconde. Source : [CoinGlass sur X](https://x.com/coinglass_com/status/1976796969961193641). D'autres chiffres circulent : 19,16 Md$, seuil de référence d'un marché Polymarket ([Polymarket](https://polymarket.com/event/record-crypto-liquidation-in-2026)), et environ 19,3 Md$ ([KuCoin](https://www.kucoin.com/blog/id-top-10-largest-crypto-liquidation-events-of-all-time)).
- **[Agrégateur][Historique]** Selon une estimation externe de Bitcoinist, l'ampleur réelle du 10/10 aurait pu atteindre 30 à 40 Md$, avec 85 à 90 % des pertes sur des positions longues. Ce n'est pas un chiffre CoinGlass. Source : [HTX News / Bitcoinist](https://www.htx.com/news/crypto-liquidations-topped-150-billion-in-2025-coinglass-rep-zShH4Aq1/).
- **[Historique]** Déclencheur : l'annonce par Donald Trump de droits de douane de 100 % sur les importations chinoises, effectifs au 1er novembre. Sources : [CoinDesk, 13/10/2025](https://coindesk.com/markets/2025/10/13/trader-who-made-usd192m-shorting-the-crypto-crash-is-betting-against-bitcoin-again) ; [The Defiant](https://thedefiant.io/newsletter/defi-daily/the-ultimate-10-10-crash-autopsy) **(attribution à vérifier)**.
- **[Historique]** Hyperliquid ce jour-là :
  - plus gros volume de liquidations du marché, 10,31 Md$ selon CoinGlass ;
  - premier ADL (auto-deleveraging) en marge croisée en plus de deux ans de fonctionnement ;
  - l'ADL a été critiqué : il a fermé de force des shorts gagnants et aminci encore les carnets d'ordres.
  - Sources : [The Defiant](https://thedefiant.io/newsletter/defi-daily/the-ultimate-10-10-crash-autopsy) ; [Sentora](https://sentora.com/research/articles/structural-shifts-in-crypto-the-black-friday-drawdown-and-hyperliquid-s-bid-to-challenge-cexs) ; en français, [Journal du Coin](https://journalducoin.com/trading/hyperliquid-manipulation-polemique-autour-systeme-adl/) **(attribution à vérifier)**.
- **[Donnée dure][Historique] Année 2025**, d'après le rapport annuel de CoinGlass couvert les 25-26/12/2025, donc avant la clôture de l'année (estimation quasi finale) :
  - environ 150 Md$ de liquidations, soit 400 à 500 M$ par jour ;
  - 85,70 T$ de volume total sur les dérivés ;
  - 748,3 Md$ de volume le 10/10, près du triple de la moyenne quotidienne de l'année (264,5 Md$).
  - Sources : [HTX News / Bitcoinist](https://www.htx.com/news/crypto-liquidations-topped-150-billion-in-2025-coinglass-rep-zShH4Aq1/) ; [MEXC News / PANews](https://www.mexc.com/news/346724).
- **[Donnée dure] S1 2026**, d'après le rapport semestriel de CoinGlass (échantillon de plateformes) :
  - 73,35 Md$ de liquidations, dont environ 62 % sur des positions longues ;
  - plus grosse journée : le 31/01/2026, avec 2,588 Md$ ;
  - mois le plus lourd : juin 2026, avec 16,14 Md$.
  - Source : [CoinGlass, rapport S1 2026](https://www.coinglass.com/learn/2026h1-market-report-en).
- **[Agrégateur] 02/06/2026 :** environ 1,8 Md$ liquidés et plus de 272 000 traders touchés (données CoinGlass). L'article parle du « plus gros wipeout de 2026 ». Source : [Bitcoin Foundation](https://bitcoinfoundation.org/news/altcoins/crypto-liquidations-surge-near-1-8b-as-btc-longs-get-crushed/). **Contradiction** avec le rapport S1 de CoinGlass, qui place le record journalier de 2026 au 31/01 (2,588 Md$). L'écart vient probablement d'une fenêtre glissante de 24 h comparée à un jour calendaire, ou d'un titre erroné.
- **[Donnée dure] 20-21/08/2026 :** squeeze des vendeurs à découvert, avec un BTC au-dessus de 77 000 $. Plus de 4 Md$ de shorts ont été liquidés en deux jours. La journée de jeudi est la plus lourde pour les shorts depuis 2021. Source : [CoinDesk, 21/08/2026](https://www.coindesk.com/markets/2026/08/21/bitcoin-ether-and-solana-climb-as-another-usd1-billion-shorts-get-wiped-out).
- **[Agrégateur]** Épisode de 1,23 Md$ de shorts liquidés en une heure. Sa date n'est pas confirmée ; il s'agit probablement du squeeze d'août 2026.
  - Le wallet 0x8c96 a perdu sur Hyperliquid l'intégralité d'un short de 1 800 BTC (environ 117 M$), selon Hypurrscan.
  - Trois baleines BTC ont perdu 194 M$ au total.
  - Source : [Yahoo Finance](https://finance.yahoo.com/markets/crypto/articles/crypto-shorts-lose-1-23-161225766.html).
- **[Agrégateur] 8-9/10/2026 :** environ 1,19 Md$ liquidés en 24 h, surtout des positions longues (données CoinGlass). Source : [CoinCentral](https://coincentral.com/crypto-liquidation-statistics-key-facts-every-leveraged-trader-should-know).
- **[Donnée dure] 09/10/2026 :** une baleine Hyperliquid a été liquidée sur 28 716 ETH (environ 69,69 M$) quand l'ETH est tombé vers 2 420 $. Elle a aussitôt reversé de la marge et rouvert une position longue. Source : [Bitcoin.com News](https://news.bitcoin.com/featured/ether-whale-liquidated-69m-hyperliquid-reloads-long/).
- **[Donnée dure] Contexte de marché :** au 30/09/2026, le S&P Bitcoin Index recule de 26,96 % sur un an et de 4,55 % depuis le début de l'année. Source : [NEOS Funds, page BTCI](https://neosfunds.com/btci/).

### Inferences
- Les liquidations représentent en moyenne environ 400 M$ de notionnel par jour, en 2025 comme au S1 2026 (73,35 Md$ sur 181 jours, soit environ 405 M$ par jour, calcul personnel). Ce n'est pas un accident mais un flux régulier, des traders trop endettés vers les liquidateurs, les fonds d'assurance, les vaults (HLP) et les contreparties.
- 62 % de longs liquidés au S1 2026, et 85 à 90 % (estimation) le 10/10/2025 : le levier des particuliers est surtout acheteur, ce que confirme Christin et al. cité par la BIS. Le record de liquidations de shorts d'août 2026 montre que les vendeurs trop endettés se font aussi balayer.
- Les chiffres agrégés sous-estiment la réalité, puisque Binance ne publie qu'un ordre par seconde.
- La plus grosse journée du S1 2026 (2,6 Md$) est environ 7 fois plus petite que le record du 10/10/2025.
- Le réflexe de « recharger » après une liquidation (baleine ETH du 09/10/2026, James Wynn en Q3) relève d'un comportement de joueur plus que d'investisseur.

### Gaps
- Le total des liquidations du T3 2026 et le cumul 2026 à ce jour n'ont pas été trouvés. La page de CoinGlass n'a pas pu être ouverte (erreur DNS).
- La répartition des liquidations de 2026 par plateforme n'a pas été collectée.
- Aucune estimation des pertes nettes (marge perdue) derrière les montants notionnels n'a été trouvée.

---

## Q3. Paysage des perp DEX en 2026, distribution des PnL on-chain, baleines célèbres

### Takeaway
Hyperliquid domine nettement fin T3 2026 : environ 196 Md$ de volume sur 30 jours fin juillet, et environ 8,2 Md$ d'open interest au 30/09/2026 contre environ 1,4 Md$ pour Aster. Aster avait pris environ 50 % du marché en septembre 2025, porté par des incitations, avant de reculer. Le grand gagnant est le protocole lui-même : 429 M$ de revenus du 1er janvier au 15 septembre 2026, presque entièrement consacrés au rachat de HYPE. Les baleines célèbres illustrent surtout la ruine :
- James Wynn : environ −100 M$ en 2025 ;
- la « baleine du 10/10 » : de +190 M$ à une perte nette estimée de −128 M$ ;
- un short BTC de 117 M$ liquidé ;
- une position longue ETH de 69,7 M$ liquidée le 09/10/2026.

### Cited Findings
**Volumes et parts de marché**
- **[Donnée dure][Historique] Septembre 2025 :** le volume mensuel des perp DEX dépasse pour la première fois 1 000 Md$ (environ 1,05 T$ selon The Block, 1,226 T$ sur 30 jours selon DefiLlama).
  - Aster : plus de 420 Md$ selon The Block, ou 493,61 Md$ selon DefiLlama, soit près de 50 % du marché.
  - Hyperliquid : environ 282,5 Md$.
  - Lighter : environ 164,4 Md$, alors en bêta privée.
  - Sources : [The Block](https://www.theblock.co/post/373210/perp-dex-monthly-trading-volume-1-trillion-usd-hyperliquid-aster-lighter) ; [Yahoo Finance](https://finance.yahoo.com/news/perp-dexs-hit-1-trillion-155117093.html).
- **[Agrégateur] Janvier 2026 :** Hyperliquid creuse l'écart pendant que le volume de ses rivaux baisse. Son open interest atteint environ 9,57 Md$, contre environ 7,34 Md$ pour les autres grands perp DEX réunis. Le volume de Lighter chute après son airdrop. Source : [CoinDesk, 19/01/2026](https://www.coindesk.com/markets/2026/01/19/hyperliquid-extends-lead-in-perp-dex-race-as-rivals-volumes-fade) **(attribution des chiffres d'open interest à vérifier)**.
- **[Agrégateur]** Selon le titre d'un billet de blog de janvier 2026, les perp DEX auraient capté 26 % du marché des futures. Source : [BlockEden, 29/01/2026](https://blockeden.xyz/blog/2026/01/29/perp-dex-wars-2026-hyperliquid-lighter-aster-edgex-paradex-decentralized-derivatives/).
- **[Agrégateur] 05/02/2026** (volume sur 24 h, données DefiLlama) : Hyperliquid environ 31 %, Aster environ 14,6 %, edgeX environ 11 %, Lighter environ 9,5 %. Source : [Bitget News](https://www.bitget.com/amp/news/detail/12560605186706).
- **[Vendeur/Marketing] Avril 2026**, d'après un blog promotionnel consacré aux airdrops :
  - Aster serait tombé de 70 % de part de marché (pic de septembre 2025) à 15 % ;
  - Hyperliquid serait remonté à 44 % ;
  - edgeX aurait dépassé 3 Md$ de volume par jour en mars 2026.
  - Source : [bex.co, 28/04/2026](https://bex.co/blog/2026/04/28/perp-dex-cohort-2026-lighter-airdrop-hyperliquid-long-tail).
- **[Agrégateur] 30/07/2026** (données DefiLlama) :
  - Hyperliquid : environ 196 Md$ de volume sur 30 jours ;
  - n°2 : environ 41,7 Md$, avec environ 1,93 Md$ d'open interest (nom non confirmé, probablement Aster) ;
  - Lighter, n°3 : environ 35,7 Md$.
  - Source : [MetaMask](https://metamask.io/news/best-perps-dexs-in-2026).
- **[Agrégateur] 30/09/2026** (données DefiLlama) :
  - open interest : Hyperliquid environ 8,2 Md$, Aster (n°2) environ 1,4 Md$ ;
  - fourchettes de volume quotidien : Hyperliquid 7 à 11 Md$, Aster 1 à 3 Md$, Lighter 1,1 à 1,5 Md$.
  - Source : [Cryptoticker](https://cryptoticker.io/en/comparison/best-perp-dex/).

**Qui gagne : le protocole et ses vaults**
- **[Agrégateur]** Hyperliquid a encaissé 429,04 M$ de revenus du 1er janvier au 15 septembre 2026, ce qui en fait le protocole le plus rémunérateur de l'année d'après un classement fondé sur CoinGecko. Source : [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/).
- **[Agrégateur]** Autres mesures des revenus d'Hyperliquid :
  - environ 688 M$ sur 12 mois, dont 56,4 M$ sur les 30 jours au 27/09/2026 ;
  - presque tous les frais vont à l'Assistance Fund, qui rachète du HYPE sur le marché ;
  - Source : [eco.com](https://eco.com/support/en/articles/15197987-hyperliquid-vault-strategies-2026-hlp-and-user-vaults-explained) **(attribution à vérifier)**.
  - DefiLlama affichait un rythme annuel de 914,76 M$ de frais et 696,03 M$ de revenus, mais la date du snapshot est incertaine. Source : [DefiLlama](https://defillama.com/protocol/hyperliquid).
- **[Agrégateur]** En avril 2026, Hyperliquid a enregistré une journée à 5,23 M$ de revenus, son plus haut depuis février, avec un BTC au-dessus de 77 000 $. Source : [The Crypto Times, 18/04/2026](https://www.cryptotimes.io/2026/04/18/hyperliquid-posts-5-23m-revenue-day-biggest-since-february-as-bitcoin-tops-77k/).
- **[Agrégateur]** HLP, le vault de market making et de liquidation ouvert aux dépôts :
  - au 27/09/2026, environ 138 M$ de profit cumulé et un rendement annualisé d'environ 3,7 % ([eco.com](https://eco.com/support/en/articles/15197987-hyperliquid-vault-strategies-2026-hlp-and-user-vaults-explained), **attribution à vérifier**) ;
  - mi-août 2026, 22,24 M$ de frais cumulés versés à HLP ([VaaSBlock](https://www.vaasblock.com/news/hyperliquid-hlp-vault-economics-perp-dex-2026/), **attribution à vérifier**) ;
  - des commentaires plus anciens citaient 15 à 30 % par an « selon le régime de volatilité », sans vérification on-chain ([DEXTools](https://www.dextools.io/tutorials/what-is-hyperliquid-hlp-vault-strategy-guide-2026)).
- **[Historique]** En 2025, HLP a déjà subi des pertes et des retraits de liquidité à cause des trades d'une baleine ETH à fort levier. Source : [Cryptopolitan](https://www.cryptopolitan.com/hyperliquid-losing-liquidity-whale-eth-trade/).

**Baleines célèbres**
- **[Donnée dure][Historique] James Wynn, mai 2025 :** plus de 1 Md$ d'exposition longue sur le BTC avec environ 20 M$ de collatéral, soit un levier de 40x. Il a été liquidé quand le BTC est passé sous 105 000 $ le 30/05/2025, pour une perte d'environ 100 M$. Sources : [DL News](https://www.dlnews.com/articles/defi/hyperliquid-whale-loses-100m-on-leveraged-bitcoin-bet/) ; [CryptoSlate](https://cryptoslate.com/hyperliquid-bitcoin-whale-loses-100-million-as-btc-price-falls-below-105k/). Un autre article évoque 99,1 M$ perdus « en vendant à découvert » : le sens de la position est donc contesté. Source : [U.Today](https://u.today/hyperliquid-whale-loses-991-million-shorting-bitcoin-amid-price-uptick).
- **[Historique]** Wynn est revenu plusieurs fois avec du capital frais et un levier extrême, par exemple un short BTC à 40x. Chaque tentative s'est terminée par une liquidation. Sources : [Coinpedia](https://coinpedia.org/news/gambling-with-a-timer-james-wynn-returns-to-hyperliquid-with-a-40x-bitcoin-short/) ; [Cryptopolitan](https://www.cryptopolitan.com/trader-james-wynn-liquidated-market-crash/).
- **[Historique]** Le wallet 0xa523 a détrôné Wynn comme plus gros perdant d'Hyperliquid : plus de 40 M$ perdus en moins d'un mois. Il a notamment perdu 39,66 M$ sur le HYPE, après avoir vendu 886 287 tokens juste avant un rebond. Date exacte non confirmée (2025). Sources : [Cointelegraph](https://cointelegraph.com/news/whale-ousts-james-wynn-as-hyperliquid-s-biggest-loser-after-40m-blowup) ; [BeInCrypto](https://beincrypto.com/crypto-whale-losses-hyperliquid/).
- **[Donnée dure][Historique] « Baleine initiée » du 10/10/2025 :**
  - des shorts sur le BTC et l'ETH ont été ouverts peu avant l'annonce des droits de douane ;
  - Arkham estime le profit entre 190 et 200 M$ ;
  - le même trader a ensuite ouvert un nouveau short BTC de 163 M$ ([CoinDesk, 13/10/2025](https://coindesk.com/markets/2025/10/13/trader-who-made-usd192m-shorting-the-crypto-crash-is-betting-against-bitcoin-again)) ;
  - le groupe de wallets a été relié à Garrett Jin, ex-PDG de BitForex, qui nie en être le propriétaire mais reconnaît connaître la personne ;
  - aucune conclusion d'un régulateur sur un délit d'initié n'a été trouvée ([Bubblemaps](https://intel.bubblemaps.io/cases/64/systemic-price-dump) ; [The Defiant](https://thedefiant.io/newsletter/defi-daily/the-ultimate-10-10-crash-autopsy)).
- **[Agrégateur]** La même « baleine du 10/10 » serait passée à une perte nette estimée d'environ 128 M$ après une série de trades à fort levier sur l'ETH. Date non confirmée, probablement 2026. Sources : [Grafa](https://grafa.com/en/news/crypto/hyperliquid-whale-128m-loss) ; [AskFuzz](https://askfuzz.ai/discover/news/cryptocurrencies/10-10-whale-down-128m-after-eth-leverage-trades).
- **[Agrégateur]** Autres cas en 2026 :
  - avril 2026 : une position liée au pétrole (Hyperliquid propose aussi des marchés de matières premières) perd 17,18 M$ lors d'une hausse de 7,5 % du pétrole ([Bitcoin Foundation](https://bitcoinfoundation.org/news/trading/whale-liquidated-oil/)) ;
  - mai 2026 : un trader sur le HYPE perd plus de 12,5 M$ en 30 jours, et 26,8 M$ sur ses trades HYPE ([HokaNews](https://www.hokanews.com/2026/05/hyperliquid-whale-loses-125m-268m-hit.html)) ;
  - le wallet 0x8c96 (short BTC, −117 M$) et la baleine ETH du 09/10/2026 (−69,69 M$) sont détaillés en Q2.

### Inferences
- Le modèle gagnant est celui de « la maison ». En 2026, Hyperliquid encaisse environ 1,7 M$ par jour (429 M$ en 258 jours, soit environ 607 M$ annualisés, calcul personnel), payés par les frais des traders. Les déposants de HLP n'obtiennent qu'un rendement modeste (environ 3,7 % annualisé fin septembre 2026) et restent exposés aux pertes extrêmes : baleines toxiques, ADL.
- Les classements par volume sont fragiles. Les volumes sont gonflés par les points et les airdrops (Aster en 2025, Lighter avant son airdrop, edgeX avant son token), et les chiffres varient selon la source et la période. L'open interest reflète mieux l'activité réelle : celui d'Hyperliquid vaut environ 6 fois celui d'Aster au 30/09/2026.
- Les histoires de baleines sont un cas d'école de biais de survie. On médiatise un gain spectaculaire de 190 à 200 M$, alors que le même acteur aurait fini en perte nette d'environ 128 M$. Wynn, 0xa523 et 0x8c96 montrent que le levier peut anéantir même des dizaines de millions.
- Les gains les plus spectaculaires semblent tenir à un avantage d'information (soupçonné) plus qu'à la compétence technique. Un particulier ne peut pas reproduire ce type d'avantage.

### Gaps
- Les grilles de frais maker/taker de 2026 (Hyperliquid, Aster, Lighter, edgeX) n'ont pas été collectées.
- Les volumes mensuels et les parts de marché de septembre 2026 n'ont pas été trouvés : seulement l'open interest et des fourchettes de volume quotidien.
- Aucune analyse récente (2026, Dune ou Hyperdash) de la distribution des PnL de l'ensemble des wallets n'a été trouvée.
- Les soupçons de wash trading visant Aster n'ont pas été vérifiés auprès d'une source primaire.
- La date de l'épisode 0x8c96 et celle de la perte nette de 128 M$ ne sont pas confirmées.

---

## Q4. Stratégies delta-neutres (funding, basis, cash-and-carry) : rendement en 2026 par rapport à 2024-2025, et qui le capte

### Takeaway
En 2026, le portage (*cash-and-carry*) est retombé au niveau des taux sans risque américains :
- base CME à 3 mois d'environ 3 % annualisés en août 2026, contre environ 3,8 % pour le T-note à 2 ans ;
- funding BTC d'environ 0,0067 % par tranche de 8 h fin septembre 2026, soit environ 7,3 % par an brut (calcul simple) ;
- sUSDe d'Ethena à environ 4,8 % fin septembre 2026 ;
- offre d'USDe divisée par trois depuis son pic d'octobre 2025.

Ce rendement est capté par les fonds (via le CME et les ETF) et par Ethena. Les particuliers n'y accèdent que par des produits (sUSDe, vaults) qui rapportent à peine plus que des T-bills, avec des risques extrêmes en plus.

### Cited Findings
**Base CME et ETF**
- **[Donnée dure] Avril 2026 :**
  - l'open interest moyen quotidien des futures BTC du CME tombe sous 8 Md$ en mars, puis à 7,2 Md$ début avril 2026, son plus bas depuis février 2024 ;
  - la baisse est attribuée en partie au débouclage du basis trade : une base d'environ 5 % ne laissait presque plus de prime sur le taux sans risque (environ 4,5 %) ;
  - le titre de l'article parle d'un plus bas de 14 mois de l'« activité », ce qui ne colle pas avec « plus bas depuis février 2024 » pour l'open interest (**à vérifier**) ;
  - source : [The Block, 09/04/2026](https://www.theblock.co/news/business/2026-04-09-cme-bitcoin-futures-activity-slumps-to-14-month-low-as-basis-trade-unwind-drains-institutional-demand-396722).
- **[Donnée dure] Août 2026 :** la base annualisée des futures BTC à 3 mois est d'environ 3 %, sous le rendement du T-note à 2 ans (environ 3,8 %). Fait rare, les hedge funds (*leveraged funds*) abandonnent leurs shorts structurels sur le CME pour se positionner à l'achat. Sources : [CoinDesk, 10/08/2026](https://www.coindesk.com/markets/2026/08/10/a-rare-cme-shift-hedge-funds-abandon-structural-shorts-to-bet-on-a-bitcoin-rally) ; [BigGo Finance](https://finance.biggo.com/news/9c11c1e7-4988-4ad7-998f-7d4f8a51f6ad).
- **[Agrégateur]** Une autre mesure, au 07/08/2026, compare les prix de règlement du CME à l'indice de référence de 16 h (heure de New York). Elle donne une base brute annualisée de 5,69 % à 7,89 %, au-dessus du T-note à 2 ans (4,19 %). L'article prévient que le funding, la marge, les frais et l'exécution peuvent effacer cet écart : parler de trade « sans risque » est exagéré. Source : [CryptoSlate](https://cryptoslate.com/bitcoin-futures-carry-treasury-yield-etf-flows/).
- **[Donnée dure]** Dans sa version ETF, le trade consiste à acheter des ETF spot et à vendre des futures CME. Le rendement avec levier dépend du coût de financement (SOFR plus un écart) : la base affichée n'est pas un rendement net. Sources : [CF Benchmarks](https://www.cfbenchmarks.com/blog/revisiting-the-bitcoin-basis-how-momentum-sentiment-impact-the-structural-drivers-of-basis-activity) ; [Seeking Alpha](https://seekingalpha.com/article/4839008-spot-etfs-give-rise-to-crypto-basis-trading).

**Funding des contrats perpétuels**
- **[Donnée dure] 30/09/2026 :** le funding des perpétuels BTC est de 0,0067 % par tranche de 8 h (0,0066 % à la tranche précédente). Source : [MacroMicro](https://en.macromicro.me/charts/49213/bitcoin-perpetual-futures-funding-rate). En annualisé simple, cela donne environ 7,3 % (0,0067 % × 1 095, calcul personnel).
- **[Agrégateur]** La composante d'intérêt de base de Binance est de 0,01 % par 8 h, soit 10,95 % par an en simple. Hyperliquid utilise la même composante, mais avec un funding horaire, et l'affiche à 11,6 % APR (intérêts composés chaque heure). Source : [eco.com](https://eco.com/support/en/articles/15082536-hyperliquid-funding-rate-how-it-works-track-profit).
- **[Agrégateur]** Multiplier par 1 095 n'est valable que si le contrat reste sur un cycle de 8 h. Binance, Bybit et OKX raccourcissent l'intervalle quand le taux touche son plafond ou son plancher. Selon le titre de l'article, le funding est resté au niveau de base de 0,01 % pendant 78 % d'un trimestre. Source : [Coincub](https://coincub.com/blog/perpetual-futures-funding-rates-78-of-a-quarter-at-0-01/).
- **[Agrégateur]** La moyenne sur 7 jours du funding BTC chez Binance affichait environ 4,4 % APY sur un snapshot daté d'environ début juillet 2026 (page vieille d'environ 98 jours, date approximative). Source : [The Block Data](https://www.theblock.co/data/crypto-markets/futures/btc-funding-rates).

**Ethena (USDe/sUSDe), principal capteur du funding**
- **[Agrégateur]** L'offre d'USDe est d'environ 4,95 Md$ au 28/09/2026, contre un pic d'environ 14,82 Md$ le 04/10/2025, soit −66 % (calcul personnel). Elle grossit quand le funding est élevé et se contracte quand il baisse. Source : [eco.com](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin) **(attribution à vérifier)**.
- **[Agrégateur]** Rendement du sUSDe :
  - environ 4,76 % APY sur Ethereum fin septembre 2026, avec une moyenne sur 30 jours de 4,79 % ([Stablecoin Insider](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/)) ;
  - environ 4,14 % fin juillet 2026 sur Aave, où les dépôts ont baissé de 9 % (152,4 M USDe) en 30 jours ([Aavescan](https://aavescan.com/rates/ethena-susde)).
- **[Agrégateur]** Rendement du sUSDe sur 7 jours : environ 9,4 % en avril 2026 et 7,1 % en juin 2026 selon un article ([BingX Learn](https://bingx.com/en/learn/article/usde-2-ethena-internet-bond-diversification-2026), **attribution à vérifier**). **Contradiction :** une page de CoinMarketCap donne environ 4,5 % en juin ([CoinMarketCap](https://coinmarketcap.com/cmc-ai/ethena-usde/price-prediction/)).
- **[Agrégateur]** Le fonds de réserve d'Ethena, qui sert de tampon contre un funding négatif, représentait environ 61 M$ en mars 2026 pour 5,6 Md$ d'USDe en circulation, soit environ 1,1 %. Quand le funding est faible ou négatif, Ethena place davantage de collatéral en stablecoins rémunérés au taux des T-bills. Source : [Stablecoin Insider, rapport T1 2026](https://stablecoininsider.org/ethena-usde-q1-2026-report/) **(attribution à vérifier)**.

**Risques documentés**
- **[Étude]** Gornall, Rinaldi et Xiao (papier préliminaire présenté à l'AEA 2026) :
  - lors des grands chocs, les futures trimestriels baissent de 8 à 10 % de plus que le spot, contre 3 % pour les perpétuels ;
  - dans une simulation de basis trade à levier 10x, passer des trimestriels aux perpétuels réduit la perte maximale (*drawdown*) d'environ deux tiers.
  - Source : [AEA 2026](https://www.aeaweb.org/conference/2026/program/paper/ByyFEfr4).
- **[Historique]** Le 10/10/2025, l'ADL d'Hyperliquid a fermé de force des positions gagnantes (voir Q2). Cela peut toucher la jambe vendeuse d'un portefeuille delta-neutre. Source : [The Defiant](https://thedefiant.io/newsletter/defi-daily/the-ultimate-10-10-crash-autopsy).

### Inferences
- Fin T3 2026, le rendement brut du portage sur le BTC se situe entre environ 3 % (base CME à 3 mois en août) et 7 à 8 % (mesure CME du 07/08 ; funding d'environ 7,3 % annualisé au 30/09). C'est au mieux de 0 à 4 points de plus que les T-bills et T-notes (3,8 à 4,2 %), avant coût de financement, frais, marge immobilisée et risque de plateforme.
- Le débouclage observé va dans le même sens : open interest du CME au plus bas depuis février 2024, hedge funds passés à l'achat, offre d'USDe en baisse de 66 % depuis son pic d'octobre 2025. Tout indique une prime de portage quasi nulle en 2026.
- Pour un particulier en France, sUSDe (environ 4,8 %) et HLP (environ 3,7 %) ne paient pas assez les risques pris : contrepartie de plateforme, smart contract, perte d'ancrage (dépeg), ADL, fonds de réserve d'environ 1 % seulement. Face à un placement monétaire, le jeu n'en vaut pas la chandelle. Cette stratégie reste un métier d'institutionnels qui disposent d'un financement bon marché.
- Pour un trader directionnel à l'achat, le funding est un coût. Au taux de base de 0,01 % par 8 h, il représente environ 11 % du notionnel par an, soit environ 110 % de la marge par an à levier 10x (calcul personnel).

### Gaps
- Les niveaux de 2024 et 2025 de la base CME et du funding n'ont pas été vérifiés dans cette session, donc aucune comparaison chiffrée sur trois ans n'est possible. Ne pas citer de chiffre de 2024 sans source.
- Le funding moyen de septembre et octobre 2026 par plateforme (Binance, Bybit, OKX, Hyperliquid) et la base sur l'ETH n'ont pas été collectés.
- Le rendement net réalisé en 2026 par les fonds de basis trade n'a pas été trouvé, pas plus que celui du sUSDe depuis le début de l'année.
- Le papier arXiv 2605.05089 (mai 2026, gestion dynamique du collatéral pour le basis trading on-chain) a été repéré mais pas lu. Source : [arXiv](https://arxiv.org/pdf/2605.05089).

---

## Q5. Options : Deribit, volatilité implicite en 2026, rendement des stratégies de vente d'options

### Takeaway
Deribit, filiale de Coinbase depuis le 14/08/2025 (rachat de 2,9 Md$), reste la plateforme centrale des options crypto. La volatilité implicite du BTC était relativement basse mi-2026 : DVOL d'environ 37 à 42 en juin-juillet, après des pics en janvier et février. Cela réduit les primes encaissées par les vendeurs d'options. Les ETF « covered call » sur le BTC affichent des rendements totaux négatifs sur 12 mois :
- NEOS BTCI : −26,0 % au 30/09/2026 ;
- Global X BCCC : −34,5 % au 30/06/2026.

Leurs « rendements » affichés sont trompeurs : BTCI annonce 28 % mais son rendement SEC sur 30 jours n'est que de 1,24 %.

### Cited Findings
- **[Donnée dure][Historique]** Coinbase a finalisé le rachat de Deribit le 14/08/2025 pour 2,9 Md$ : 700 M$ en numéraire et 11 millions d'actions Coinbase de classe A. Source : [CoinLaw](https://coinlaw.io/options-market-in-crypto-statistics/) **(attribution à vérifier)**.
- **[Agrégateur] Février 2026 :** 79,54 Md$ d'options BTC échangées sur Deribit (1,12 million de contrats), le troisième meilleur mois de l'histoire de la plateforme. Source : [CoinLaw](https://coinlaw.io/options-market-in-crypto-statistics/) **(attribution à vérifier)**.
- **[Donnée dure] Fin janvier 2026 :** le DVOL, l'indice de volatilité implicite à 30 jours de Deribit (l'équivalent crypto du VIX), passe d'environ 37 à plus de 44. C'est sa plus forte hausse depuis novembre. Source : [CoinDesk, 30/01/2026](https://www.coindesk.com/markets/2026/01/30/bitcoin-options-flash-troubling-signs-as-dvol-spikes-most-since-november).
- **[Donnée dure] 23/06/2026 :** DVOL à 41,5 %, « bien en dessous du pic de 90 % de février ». Environ 10 Md$ d'options arrivent à échéance fin juin. Le pic de 90 % n'est confirmé par aucune autre source trouvée. Source : [CoinDesk, 23/06/2026](https://www.coindesk.com/daybook-us/2026/06/23/bitcoin-volatility-looks-cheap-as-usd10-billion-options-settlement-nears).
- **[Agrégateur] 26/07/2026 :** DVOL à 37,56 %, ratio put/call (en volume) de 0,64. Source : [PerpFinder](https://perpfinder.com/options).
- **[Agrégateur]** Deux repères supplémentaires :
  - un indice de volatilité de Volmex (différent du DVOL) a touché un plus bas de 9 mois à 36,11 en mai 2026 ;
  - Cboe a lancé en mars 2026 BITVX, un indice de volatilité du BTC fondé sur les options de l'ETF IBIT.
  - Sources : [FinanceFeeds](https://financefeeds.com/how-the-bitcoin-implied-volatility-index-helps/) ; [CoinLaw](https://coinlaw.io/options-market-in-crypto-statistics/) **(attribution à vérifier pour les deux)**.
- **[Donnée dure]** NEOS Bitcoin High Income ETF (BTCI), au 30/09/2026 :
  - performance de la valeur liquidative sur un an : −25,99 %, contre −26,96 % pour le S&P Bitcoin Index ;
  - depuis le début de l'année : −6,70 %, contre −4,55 % pour l'indice ;
  - rendement affiché de 28 %, mais rendement SEC sur 30 jours de 1,24 % ;
  - après impôt américain sur les distributions : −32,80 % sur un an.
  - Source : [NEOS Funds](https://neosfunds.com/btci/).
- **[Agrégateur]** BTCI facture 0,99 % de frais de gestion, avec un écart achat/vente de 0,12 %. Une analyse critique, vieille d'environ 200 jours, note que son rendement total ne bat le BTC que de 2,7 % sur 12 mois glissants en marché baissier. Source : [Seeking Alpha](https://seekingalpha.com/article/4884906-btci-no-it-does-not-really-have-a-43-percent-yield).
- **[Donnée dure]** Global X Bitcoin Covered Call ETF (BCCC) : −34,54 % sur un an (valeur liquidative) au 30/06/2026, et un rendement SEC sur 30 jours de −0,70 % au 04/09/2026. Source : [Global X](https://www.globalxetfs.com/funds/bccc).
- **[Vendeur/Marketing]** iShares Bitcoin Premium Income ETF (BlackRock), lancé le 16/06/2026 :
  - objectif de 15 à 25 % de rendement par an, via la vente mensuelle d'options sur 25 à 35 % de l'actif ;
  - au moins 70 % de la hausse du BTC conservés ;
  - frais de 0,65 % ;
  - aucun rendement réalisé n'a été trouvé.
  - Source : [Investing.com](https://www.investing.com/analysis/coveredcall-bitcoin-etfs-test-demand-beyond-pure-spot-exposure-200682250).
- **[Historique]** Grayscale Bitcoin Covered Call ETF (BTCC) : environ −5 % depuis le début de l'année au 25/02/2026, pour environ 20,7 M$ d'actifs. Source : [Yahoo Finance](https://finance.yahoo.com/quote/BTCC/performance/).

### Inferences
- Vendre des calls de façon systématique ne protège pas d'un marché baissier. BTCI ne bat son indice que d'environ 1 point sur 12 mois, et fait moins bien que lui depuis janvier 2026. La stratégie plafonne la hausse et subit presque toute la baisse.
- Les « rendements » de 15 à 28 % affichés par ces produits sont des taux de distribution : des primes, plus une part de remboursement du capital. Ce ne sont pas des profits. Les bons indicateurs sont le rendement total et le rendement SEC sur 30 jours.
- Une volatilité implicite basse (DVOL autour de 37 à 42) réduit le revenu des vendeurs d'options. Elle augmente aussi le risque de vendre de la volatilité bon marché juste avant un pic, comme en janvier et février 2026.

### Gaps
- Les volumes annuels de Deribit (2025 et 2026 à ce jour) et sa part de marché face au CME et aux options sur IBIT n'ont pas été vérifiés.
- Aucune série de rendement d'une stratégie systématique de vente d'options (indice de vente de volatilité) n'a été trouvée pour 2026, ni de rendement réalisé du fonds BlackRock.
- Aucune donnée sur la rentabilité des particuliers acheteurs d'options n'a été trouvée.

---

## Q6. Copy-trading : rendement des copieurs comparé aux rendements affichés des traders copiés (« lead traders »)

### Takeaway
La seule donnée chiffrée trouvée vient d'une étude publiée par un vendeur, YieldFund. Elle porte sur environ 100 000 résultats sur 90 jours, chez Binance, Bybit et MEXC :
- 48,48 % des copieurs finissent gagnants ;
- 97,04 % des traders copiés sont gagnants sur leur propre compte, mais seulement 43,61 % font gagner leurs copieurs.

L'écart entre la performance affichée et la performance réellement obtenue en copiant est donc massif. Aucune étude indépendante ni aucune donnée publiée par une plateforme n'a été trouvée.

### Cited Findings
- **[Vendeur/Marketing]** Étude « 90 jours, multi-plateformes » (environ 100 000 résultats ; Binance, Bybit, MEXC) :
  - 48,48 % des copies finissent rentables ;
  - 97,04 % des traders copiés ont un PnL positif sur leur propre compte ;
  - seulement 43,61 % génèrent un PnL positif pour leurs copieurs.
  - Source : [YieldFund](https://yieldfund.com/is-copy-trading-profitable-a-90-day-multi-exchange-study/).
  - Le blog de KuCoin reprend l'étude en la qualifiant d'« indépendante », alors qu'elle est publiée par un vendeur de produits de copy-trading ([KuCoin Blog](https://www.kucoin.com/blog/is-crypto-copytrading-profitable-in-2026)).
  - La date exacte de l'étude n'est pas confirmée.
- **[Agrégateur]** Explications avancées par des commentateurs, non testées : entrée en position retardée, exécution différente, taille de position mal ajustée, coûts de transaction. Sources : [Stax Investing](https://staxinvesting.com/blog/is-copy-trading-profitable-the-honest-risk-picture) ; [Goat Funded Trader](https://www.goatfundedtrader.com/blog/is-copy-trading-profitable).
- **[Agrégateur]** Biais de survie : les fournisseurs de signaux qui échouent disparaissent des classements, si bien que ce qui reste visible paraît meilleur que la réalité. Sources : [Stax Investing](https://staxinvesting.com/blog/is-copy-trading-profitable-the-honest-risk-picture) ; [Goat Funded Trader](https://www.goatfundedtrader.com/blog/is-copy-trading-profitable).
- **[Agrégateur]** Sur Hyperliquid, le copy-trading passe par les vaults d'utilisateurs et par le suivi de wallets « smart money » avec des outils tiers (Buildix, Hyperdash…). Sources : [Buildix](https://www.buildix.trade/blog/hyperliquid-copy-trading-smart-money-tracker-whale-wallets-2026) ; [Hyperdash](https://hyperdash.com/learn/best-tools-trading-hyperliquid).
- **[Historique]** Une page d'un broker renvoie aux études des régulateurs (France, Royaume-Uni, UE) montrant que la plupart des comptes de particuliers perdent sur les CFD et le Forex. Ce ne sont pas des études sur le copy-trading. Source : [Radex Markets](https://www.radexmarkets.com/en/News/NewsDetail?p=OXpRL2Yrb2UxbGs9).

### Inferences
- D'après un vendeur intéressé, un copieur a à peu près une chance sur deux d'être gagnant sur 90 jours, et ce avant de tenir compte du biais de sélection de l'échantillon. Le PnL affiché par un trader copié (97 % de gagnants) ne dit presque rien du résultat du copieur (44 %).
- Le trader copié peut gagner grâce à sa commission sur les profits des copieurs, ou en passant ses ordres avant eux. L'incitation est asymétrique : il ne supporte pas les pertes de ceux qui le copient.
- Sur Hyperliquid, la transparence on-chain des wallets réduit le risque de faux historiques, mais pas le biais de survie ni le décalage d'exécution.

### Gaps
- Aucune donnée publiée par Bitget, Binance, Bybit, OKX ou eToro sur le PnL agrégé des copieurs, et aucune étude académique.
- Aucune preuve documentée de faux classements ou de wash trading chez les traders copiés n'a été trouvée : la recherche n'a pas abouti faute de budget.
- Un chiffre de 60 % de copieurs gagnants sur trois mois circule sans source identifiable. Il n'a pas été retenu.
- Les conditions des vaults Hyperliquid (part des profits revenant au trader copié, mise minimale) n'ont pas été vérifiées.

---

## Q7. Prop firms crypto : taux de réussite, taux de paiement, modèle économique

### Takeaway
Les données publiques de FPFX Technology (plus de 300 000 comptes, septembre 2024, surtout du Forex et des CFD) indiquent :
- environ 14 % de réussite au challenge ;
- seulement environ 7 % des participants qui reçoivent un paiement ;
- un paiement typique d'environ 4 % de la taille du compte.

Les guides de 2026 citent 5 à 10 % de réussite par tentative. Pour les 10 plus grandes firmes, les paiements réglés en crypto et suivis on-chain ont atteint 115,1 M$ au T1 2026, avec un paiement moyen de 1 865 $. Aucune donnée auditée n'existe pour HyroTrader ou Breakout (Kraken).

### Cited Findings
- **[Donnée dure][Historique]** FPFX Technology, prestataire logiciel des prop firms, a publié des chiffres sur plus de 300 000 comptes, en exclusivité dans Finance Magnates en septembre 2024 :
  - environ 14 % des traders réussissent un challenge ;
  - environ 7 % de l'ensemble des participants reçoivent un paiement ;
  - le paiement typique représente environ 4 % de la taille du compte.
  - Chiffres repris par [PropFirmBacktester](https://www.propfirmbacktester.com/prop-firm-statistics) ; [Fortunly](https://fortunly.com/statistics/prop-firm-challenge-pass-rate-statistics/) ; [TradersYard](https://tradersyard.com/blog-posts/how-many-people-get-payouts-from-prop-firms) **(attribution précise à vérifier)**.
- **[Agrégateur]** Les guides de 2026 donnent un taux de réussite d'environ 5 à 10 % par tentative, tiré de déclarations des firmes et de compilations secondaires. Seuls les paiements on-chain y sont jugés réellement vérifiables. Sources : [CryptoFundTrader](https://cryptofundtrader.com/crypto-prop-firm-statistics/) ; [CryptoBrowser](https://cryptobrowser.io/news/crypto-prop-firm-statistics-failure-rate-challenge-and-payout-reality-2026/) ; [Fortunly](https://fortunly.com/statistics/prop-firm-challenge-pass-rate-statistics/).
- **[Donnée dure]** Finance Magnates Datalab suit on-chain les paiements réglés en crypto par les 10 plus grandes prop firms :
  - environ 115,1 M$ au T1 2026 ;
  - environ le double du T1 2025, mais stable par rapport au T4 2025 ;
  - paiement moyen en baisse, à 1 865 $.
  - Source : [Finance Magnates Datalab](https://datalab.financemagnates.com/market-insights/tracked-prop-firm-crypto-payouts-doubled-to-115m-in-q1-2026).
  - Attention : ce chiffre couvre les paiements réglés en crypto par toutes les prop firms, pas seulement celles spécialisées dans le trading crypto.
- **[Vendeur/Marketing]** Breakout :
  - rachetée par Kraken en septembre 2025 selon une revue, en 2024 selon un autre guide (contradiction) ;
  - revendique plus de 60 M$ versés, sans vérification indépendante ;
  - la revue souligne que l'appartenance à Kraken ne garantit pas les paiements individuels.
  - Source : [PropTradingVibes](https://proptradingvibes.com/prop-firms/breakout).
  - Selon la page comparative de Kraken, le trader garde 80 % des profits au départ ([Kraken Learn](https://www.kraken.com/learn/breakout-vs-hyrotrader)).
- **[Vendeur/Marketing]** HyroTrader : le trader garde 70 % des profits, jusqu'à 90 % ensuite. Un stop-loss est obligatoire sur chaque trade. Sources : [HyroTrader Blog](https://www.hyrotrader.com/blog/best-crypto-prop-trading-firms/) ; [Kraken Learn](https://www.kraken.com/learn/breakout-vs-hyrotrader).
- **[Agrégateur]** Les comparatifs de 2026 listent les principales firmes crypto, mais sans aucun taux de réussite audité. Sources : [CoinGecko](https://www.coingecko.com/learn/best-crypto-prop-firms) ; [The Coin Republic, 09/10/2026](https://www.thecoinrepublic.com/2026/10/09/top-5-crypto-prop-firms-for-crypto-traders-in-2026/).

### Inferences
- Entre 86 et 95 % des participants échouent après avoir payé les frais de challenge, et seuls 7 % environ sont un jour payés. L'essentiel du chiffre d'affaires vient donc des frais d'évaluation. Les paiements servent de vitrine marketing et récompensent une minorité de traders réellement rentables.
- 115,1 M$ divisés par 1 865 $ donnent environ 62 000 paiements au T1 2026 pour les 10 plus grandes firmes (calcul personnel, ordre de grandeur). Il s'agit donc surtout de petits paiements, ce qui colle avec un paiement typique modeste.
- Les comptes « financés » sont souvent simulés. La firme n'a pas besoin que le trader gagne sur le marché, d'où un conflit d'intérêts et des règles strictes (perte maximale, stop obligatoire).

### Gaps
- Aucun taux de réussite ni de paiement audité pour HyroTrader, Breakout, FTMO (offre crypto) ou les autres firmes crypto.
- La page de Finance Magnates n'a pas pu être ouverte (erreur DNS) : la liste des firmes suivies n'a pas été vérifiée.
- La date et le montant du rachat de Breakout par Kraken ne sont pas confirmés.
- Aucune firme ne publie le rapport entre frais encaissés et paiements versés.

---

## Q8. Professionnels et institutionnels : hedge funds crypto et market makers

### Takeaway
Même les professionnels peinent :
- l'indice CFR (309 fonds crypto) affiche −1,64 % en 2025 et −6,12 % depuis le début de 2026 ;
- en 2025, seuls les fonds quantitatifs ou algorithmiques sont (à peine) positifs, à +0,4 % en moyenne, contre −15,3 % pour les fonds long-only et −6,3 % pour le BTC.

Les market makers comme Wintermute se disent rentables mais ne publient aucun chiffre. Leurs volumes baissent : environ 10 Md$ par jour en moyenne en 2026, contre 15 Md$ en 2025.

### Cited Findings
- **[Donnée dure]** CFR Crypto Fund Index (309 hedge funds et fonds de capital-risque crypto, suivi mensuel depuis 2017) :
  - 2026 depuis le début de l'année : environ −6,12 % (mois de référence non confirmé) ;
  - 2025 : environ −1,64 % ;
  - 2024 : environ +46,25 %.
  - Source : [Crypto Fund Research](https://cryptofundresearch.com/cfr-crypto-fund-index/).
- **[Donnée dure][Historique]** Résultats de 2025 par stratégie :
  - algorithmiques/quantitatifs : +0,4 % en moyenne, seule catégorie positive ;
  - multi-stratégies : −2,4 % ;
  - long-only : −15,3 % ;
  - bitcoin : −6,3 % sur l'année.
  - Source : [Crypto Fund Research, revue annuelle 2025](https://cryptofundresearch.com/crypto-hedge-fund-performance/).
- **[Agrégateur] Contradictions :** certaines pages affirment que les fonds market-neutral ont gagné 14,4 % en 2025 ([TV-Hub](https://www.tv-hub.org/guide/market-neutral-strategy-crypto)) ou 13 % ([SQ Magazine](https://sqmagazine.co.uk/crypto-hedge-funds-statistics/)), et les fonds quant environ 48 % ([SQ Magazine](https://sqmagazine.co.uk/crypto-hedge-funds-statistics/) ; [StockMaven](https://stockmaven.com/best-crypto-hedge-funds/)). Ces chiffres ne sont pas sourcés et sont incompatibles avec les +0,4 % de CFR.
- **[Agrégateur]** Wintermute :
  - son fondateur Evgeny Gaevoy affirme que la firme a été rentable en 2025 et compte le rester en 2026, sans donner de chiffres ;
  - son volume quotidien moyen est tombé à environ 10 Md$ en 2026, contre 15 Md$ en 2025 ;
  - elle prévoit d'investir 1 Md$ sur 5 ans dans l'IA et le trading haute fréquence, avec pour objectif de tirer plus de 50 % de ses revenus de marchés non crypto d'ici fin 2027.
  - Source : [CoinMarketCap Academy](https://coinmarketcap.com/academy/article/wintermute-plans-dollar1b-push-into-ai-and-traditional-finance-over-5-years).
- **[Historique]** Wintermute en 2021 : 1,05 Md$ de revenus et 582 M$ de bénéfice net selon Forbes. Rémunération moyenne d'environ 1,2 M$ par salarié en 2024 (non vérifié). Source : [London Strategic Edge](https://www.londonstrategicedge.com/directory/hft-firms/wintermute/) **(attribution à vérifier)**.
- **[Donnée dure][Historique]** D'après un document déposé par Robinhood à la SEC (T1 2025), B2C2 représente 12 % et Wintermute 11 % des revenus transactionnels de Robinhood (paiements pour flux d'ordres crypto). Source : [The Block, 01/05/2025](https://www.theblock.co/news/markets/2025-05-01-robinhood-lists-b2c2-and-wintermute-as-market-makers-for-the-first-time-in-latest-sec-filing-352819).
- **[Agrégateur]** GSR :
  - société privée sans chiffre de revenus fiable ; l'estimation d'Owler (5 à 25 M$) paraît peu plausible pour une firme de cette taille ;
  - a racheté en 2025 Equilibrium Capital Services, un broker-dealer enregistré auprès de la SEC ;
  - aurait racheté Autonomous pour 57 M$ en mars 2026 selon Owler (non vérifié).
  - Source : [Owler](https://www.owler.com/company/gsr-markets).

### Inferences
- 2025 a été une année blanche ou négative pour la plupart des fonds crypto. Seuls les quants s'en sortent, à l'équilibre en moyenne. Le « market-neutral à deux chiffres » vanté par des sites marketing n'est pas confirmé par l'indice le plus large.
- Les gagnants structurels sont ceux qui encaissent l'écart achat/vente et les frais (market makers, plateformes), pas ceux qui parient sur une direction. Mais même les market makers voient leurs volumes baisser en 2026 et se diversifient hors crypto.
- Le passage de +46 % en 2024 à −6 % en 2026 montre que la performance des fonds reste très liée à l'évolution générale du marché crypto.

### Gaps
- Les indices HFR Cryptocurrency et PivotalPath pour 2025-2026 n'ont pas été trouvés. L'indice BarclayHedge Cryptocurrency Traders n'était pas exploitable ([BarclayHedge](https://portal.barclayhedge.com/cgi-bin/indices/displayHfIndex.cgi?indexCat=Barclay-CTA-Indices&indexName=Cryptocurrency-Traders-Index)).
- Aucun chiffre de rentabilité pour 2025-2026 chez Jump, GSR, DWF ou Wintermute.
- Le mois de référence du −6,12 % de CFR pour 2026 n'est pas confirmé (page non ouverte).

---

## Q9. Coûts du trading : frais, écarts de prix, funding, slippage, fiscalité

### Takeaway
Cette recherche a surtout pu mesurer deux types de coûts :
- le funding : au taux de base, environ 11 % du notionnel par an pour les positions longues, soit environ 110 % de la marge par an à levier 10x ;
- les frais des produits : BTCI 0,99 % plus 0,12 % d'écart achat/vente, ETF BlackRock 0,65 %.

Les frais des plateformes se lisent dans les revenus d'Hyperliquid : environ 430 M$ en 8,5 mois en 2026. Les grilles de frais maker/taker, les écarts de prix et la fiscalité française n'ont pas pu être vérifiés.

### Cited Findings
- **[Agrégateur]** Le funding de base de 0,01 % par 8 h représente 10,95 % par an en simple. Hyperliquid applique un funding horaire et affiche 11,6 % APR. Source : [eco.com](https://eco.com/support/en/articles/15082536-hyperliquid-funding-rate-how-it-works-track-profit). Binance, Bybit et OKX raccourcissent l'intervalle quand le taux touche ses limites. Source : [Coincub](https://coincub.com/blog/perpetual-futures-funding-rates-78-of-a-quarter-at-0-01/).
- **[Agrégateur]** Le basis trade dit « sans risque » est grignoté par le funding, la marge, les frais et l'exécution ([CryptoSlate](https://cryptoslate.com/bitcoin-futures-carry-treasury-yield-etf-flows/)). Son rendement avec levier dépend du financement à SOFR plus un écart ([CF Benchmarks](https://www.cfbenchmarks.com/blog/revisiting-the-bitcoin-basis-how-momentum-sentiment-impact-the-structural-drivers-of-basis-activity)).
- **[Agrégateur]** Frais des produits : BTCI facture 0,99 % avec un écart achat/vente de 0,12 % ([Seeking Alpha](https://seekingalpha.com/article/4884906-btci-no-it-does-not-really-have-a-43-percent-yield)) ; l'ETF BlackRock Bitcoin Premium Income facture 0,65 % ([Investing.com](https://www.investing.com/analysis/coveredcall-bitcoin-etfs-test-demand-beyond-pure-spot-exposure-200682250)).
- **[Donnée dure]** Effet de la fiscalité, à titre d'illustration (fiscalité américaine) : BTCI perd 25,99 % sur un an avant impôt, et 32,80 % après impôt sur les distributions, au 30/09/2026. Source : [NEOS Funds](https://neosfunds.com/btci/).
- **[Agrégateur]** Les revenus d'Hyperliquid, c'est-à-dire les frais payés par les traders nets des remises, atteignent 429,04 M$ du 01/01 au 15/09/2026. Source : [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/).
- **[Vendeur/Marketing]** Prop firms : le trader garde de 70 à 90 % des profits (HyroTrader) ou 80 % au départ (Breakout), en plus des frais de challenge. Source : [Kraken Learn](https://www.kraken.com/learn/breakout-vs-hyrotrader).
- **[Agrégateur]** Copy-trading : coûts structurels liés à l'entrée retardée, à l'exécution, à la taille de position et aux frais. Source : [Stax Investing](https://staxinvesting.com/blog/is-copy-trading-profitable-the-honest-risk-picture).

### Inferences
- Pour un trader actif à levier, le funding et les frais sont des coûts certains face à un gain incertain. À 10x, le funding de base consomme à lui seul environ 110 % de la marge par an. Même un trader dont l'espérance de gain brute est nulle finit donc mécaniquement perdant.
- Les revenus de la plateforme, environ 0,6 Md$ annualisés pour Hyperliquid seul en 2026, sont un transfert direct des traders vers la plateforme, puis vers les détenteurs de HYPE via les rachats.

### Gaps
- Les grilles de frais maker/taker de 2026 n'ont pas été collectées (Binance, Bybit, OKX, Hyperliquid, Lighter). Pour Lighter, l'information de frais nuls sur les comptes standards n'a pas été vérifiée.
- Les écarts de prix, le slippage et le coût d'impact n'ont pas été mesurés.
- La fiscalité française de 2026 n'a pas été vérifiée dans cette session : prélèvement forfaitaire sur les plus-values crypto, éventuelle hausse de la CSG, régime BNC des traders habituels, imposition des gains sur dérivés et CFD. Ne citer aucun taux sans source.

---

## Q10. Synthèse : qui gagne vraiment, quels rendements réalistes, quelles stratégies offrent le meilleur rapport rendement/risque (octobre 2026)

### Takeaway
En 2026, les gagnants structurels du trading crypto actif sont :
- les plateformes (Hyperliquid : 429 M$ de revenus du 01/01 au 15/09/2026) ;
- les market makers, rentables selon leurs propres dires ;
- une petite minorité de très gros comptes.

La majorité des particuliers perd, entre 70 et 85 % voire davantage. Les stratégies présentées comme peu risquées (portage, vaults, vente d'options) ne rapportent en 2026 qu'à peu près le taux des T-bills, environ 3 à 5 % et jusqu'à environ 7 % brut. Elles ajoutent en plus des risques extrêmes que le placement sans risque n'a pas.

### Cited Findings
| Stratégie ou acteur | Chiffre daté | Source |
|---|---|---|
| Plateforme Hyperliquid | 429,04 M$ de revenus (01/01-15/09/2026) | [crypto.news](https://crypto.news/hyperliquid-posts-strong-429m-revenue-leads-2026/) |
| Market maker (Wintermute) | « Rentable en 2025 », sans chiffre ; volume quotidien moyen de 10 Md$ en 2026 contre 15 Md$ en 2025 | [CoinMarketCap Academy](https://coinmarketcap.com/academy/article/wintermute-plans-dollar1b-push-into-ai-and-traditional-finance-over-5-years) |
| Fonds crypto (indice CFR, 309 fonds) | 2025 : −1,64 % ; 2026 à ce jour : −6,12 % ; quants en 2025 : +0,4 % | [CFR Index](https://cryptofundresearch.com/cfr-crypto-fund-index/) ; [CFR 2025](https://cryptofundresearch.com/crypto-hedge-fund-performance/) |
| Traders de perps sur Hyperliquid | 16,5 % rentables sur 30 jours (novembre 2024) ; 85,7 % chez les comptes de 10 à 100 M$ | [Medium](https://medium.com/@envyprotocol/i-analyzed-10-000-hyperliquid-traders-the-results-are-brutal-a29adcca8c2a) |
| Particuliers acheteurs de BTC via une appli | 73 à 81 % en perte (2015-2022) | [Bloomberg / BIS](https://www.bloomberg.com/news/articles/2022-11-16/vast-majority-of-retail-investors-in-bitcoin-lost-money-bis-says) |
| CFD et Forex en France (AMF) | 89 % de clients perdants (2009-2012) | [AMF 2014](https://www.amf-france.org/sites/institutionnel/files/contenu_simple/lettre_ou_cahier/lettre_observatoire/La%20lettre%20de%20l%27Observatoire%20de%20l%27epargne%20de%20l%27AMF%20-%20ndeg%2010%20-%20Octobre%202014.pdf) |
| Copy-trading | 48,48 % de copieurs gagnants sur 90 jours ; 43,61 % des traders copiés font gagner leurs copieurs (étude d'un vendeur) | [YieldFund](https://yieldfund.com/is-copy-trading-profitable-a-90-day-multi-exchange-study/) |
| Prop firms | Environ 14 % de réussite et 7 % de participants payés (2024) ; T1 2026 : 115,1 M$ payés en crypto par les 10 plus grandes firmes, 1 865 $ en moyenne | [PropFirmBacktester](https://www.propfirmbacktester.com/prop-firm-statistics) ; [FM Datalab](https://datalab.financemagnates.com/market-insights/tracked-prop-firm-crypto-payouts-doubled-to-115m-in-q1-2026) |
| Base CME BTC à 3 mois | Environ 3 % (août 2026), contre environ 3,8 % pour le T-note à 2 ans ; 5,69 à 7,89 % brut selon une autre mesure du 07/08/2026 | [CoinDesk](https://www.coindesk.com/markets/2026/08/10/a-rare-cme-shift-hedge-funds-abandon-structural-shorts-to-bet-on-a-bitcoin-rally) ; [CryptoSlate](https://cryptoslate.com/bitcoin-futures-carry-treasury-yield-etf-flows/) |
| Funding BTC | 0,0067 % par 8 h (30/09/2026), soit environ 7,3 % par an en simple (calcul personnel) | [MacroMicro](https://en.macromicro.me/charts/49213/bitcoin-perpetual-futures-funding-rate) |
| sUSDe (Ethena) | Environ 4,76 % APY (fin septembre 2026) ; offre d'USDe de 4,95 Md$ contre un pic de 14,82 Md$ | [Stablecoin Insider](https://stablecoininsider.org/ethenas-staked-usde-stablecoin/) ; [eco.com](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin) |
| HLP (Hyperliquid) | Environ 3,7 % annualisé (27/09/2026) | [eco.com](https://eco.com/support/en/articles/15197987-hyperliquid-vault-strategies-2026-hlp-and-user-vaults-explained) |
| Covered call BTC (BTCI) | −25,99 % sur un an au 30/09/2026 (indice : −26,96 %) | [NEOS](https://neosfunds.com/btci/) |
| Levier directionnel (liquidations) | 73,35 Md$ au S1 2026 (62 % de longs) ; environ 150 Md$ en 2025 ; record de 19,13 Md$ le 10/10/2025 | [CoinGlass S1 2026](https://www.coinglass.com/learn/2026h1-market-report-en) ; [HTX/Bitcoinist](https://www.htx.com/news/crypto-liquidations-topped-150-billion-in-2025-coinglass-rep-zShH4Aq1/) ; [CoinGlass X](https://x.com/coinglass_com/status/1976796969961193641) |

### Inferences
- **Classement indicatif du rapport rendement/risque pour un particulier en octobre 2026**, du moins mauvais au pire (inférence fondée sur les chiffres ci-dessus) :
  1. **Portage delta-neutre via un produit** (sUSDe environ 4,8 %, HLP environ 3,7 %, base de 3 à 8 % brut). Le rendement est proche des T-bills, avec des risques extrêmes en plus : plateforme, smart contract, ADL, perte d'ancrage. C'est le meilleur rapport rendement/risque au sein du trading crypto actif, mais il reste en dessous d'un placement monétaire sans risque pour un particulier français. Cette stratégie ne rapporte vraiment qu'aux institutionnels qui se financent à bas coût.
  2. **Vente d'options et covered calls.** Cette stratégie n'a pas protégé en 2025-2026 (environ −26 % sur un an). Elle n'a d'intérêt que pour qui veut de toute façon détenir du BTC, et les rendements affichés sont trompeurs.
  3. **Copy-trading.** Au mieux une chance sur deux selon un vendeur intéressé, avec un fort biais de survie.
  4. **Prop firms.** Environ 7 % des participants sont payés. Le coût, ce sont les frais de challenge, et l'espérance de gain est négative pour la grande majorité.
  5. **Trading directionnel à levier (perps).** 16,5 % de gagnants sur 30 jours (2024), environ 400 M$ liquidés par jour, un funding d'environ 11 % du notionnel par an. L'espérance de gain est négative pour la quasi-totalité des particuliers.
- **Ce qu'ont en commun les gagnants observés :** du capital, une infrastructure (latence, données), un accès au financement bon marché (pour le basis trade), parfois un avantage d'information (soupçons de délit d'initié le 10/10/2025) et une gestion du risque disciplinée. Rien de cela n'est reproductible par un particulier qui trade à temps partiel.
- **Biais de survie omniprésent :** classements, histoires de baleines, marketing des prop firms et des plateformes de copy-trading. Toute « preuve » de rentabilité issue de ces sources doit être écartée ou fortement relativisée.
- **Spécificités France/UE :** les perps vendus aux particuliers relèvent probablement du régime CFD (levier crypto de 2:1, protection contre le solde négatif) depuis la déclaration de l'ESMA du 24/02/2026. L'AMF avait mesuré 89 % de perdants sur les CFD et le Forex (étude de 2014). Hyperliquid conteste la classification devant la Commission européenne (septembre 2026).

### Gaps
- Il n'existe pas de mesure directe pour 2026 de la part de particuliers rentables.
- Aucun rendement net réalisé en 2026 n'a été trouvé pour un portefeuille delta-neutre accessible aux particuliers.
- Aucune comparaison chiffrée du portage entre 2024-2025 et 2026 n'a été possible, au-delà de l'évolution de l'offre d'USDe et de l'open interest du CME.
- La recherche a été limitée par l'épuisement du budget de recherche web partagé et par l'indisponibilité de WebFetch (erreurs DNS). Toutes les données viennent d'extraits de résultats de recherche : il est recommandé de vérifier les chiffres clés (CoinGlass S1 2026, CFR, Finance Magnates, YieldFund) avant publication.

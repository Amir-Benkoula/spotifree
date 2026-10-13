# Compléments (2e passe) : qui gagne de l'argent avec le trading actif, le copy-trading, les prop firms, les fonds, les bots et les agents IA en crypto (état au 13 octobre 2026)

*Addendum aux fichiers `03_trading_actif.md` et `04_bots_mev_automatisation.md` (non modifiés). Recherche du 13/10/2026.*

> **Note méthodologique pour le rédacteur.**
> 1. **Budget :** les 22 appels WebSearch autorisés ont tous été utilisés (mode « extended »). WebFetch et curl étaient indisponibles : **aucune page n'a été lue en entier**. Chaque chiffre vient d'un extrait ou d'un résumé du moteur de recherche. Un résumé peut déformer un chiffre : les valeurs décisives sont à recouper avant publication.
> 2. **Convention :** « rapporté par X » = chiffre vu seulement dans l'extrait de recherche de la page X. « Date non visible » = ni date de publication ni date de mesure dans l'extrait.
> 3. **Étiquettes :** **[Donnée dure]** (régulateur, indice, plateforme) ; **[Étude]** ; **[Sondage]** (déclaratif) ; **[Vendeur/Marketing]** (source avec intérêt commercial) ; **[Agrégateur]** ; **[Historique]** (plus de 6 mois, donc avant mi-avril 2026) ; **[Calcul personnel]**.
> 4. Chaque question contient un bloc **« Statut des pistes de la 1re passe »** (confirmé / corrigé / non vérifié). Un tableau récapitulatif des chiffres datés et des pistes figure à la fin.
> 5. Rappel : un volume de liquidations est un notionnel fermé de force, pas une perte nette.
> 6. Les pistes que cette passe n'a pas pu ou pas eu le budget d'examiner restent « non vérifiées » : Wintermute, GSR, Deribit, 3Commas, Banana Gun, arbitrage CEX-DEX, Hummingbot Miner, Hyperliquid Policy Center.

---

## Q1. Part des particuliers qui perdent (mentions de risque des brokers, régulateurs, études, PnL des wallets Hyperliquid)

### Takeaway
Aucune étude BIS, NBER ou SSRN de 2025-2026 sur la rentabilité des traders crypto particuliers n'a été trouvée (deux recherches dédiées). Les seuls chiffres récents sont les mentions de risque des brokers de CFD (51 % de comptes perdants chez eToro, 76 à 81 % chez Plus500, tous CFD confondus) et l'échantillon Hyperliquid de novembre 2024 (73,8 % de wallets perdants, 16,5 % de rentables sur 30 jours). Aucun n'est une mesure de 2026 portant sur la crypto seule.

### Cited Findings

**Mentions de risque des brokers de CFD (part des comptes de particuliers qui perdent chez ce prestataire)**
- **[Donnée dure, relayée par des comparateurs]** eToro : « 51 % des comptes de particuliers perdent de l'argent en négociant des CFD avec ce prestataire », rapporté par le résumé de la page « General Risk Disclosure » d'eToro. Des pages tierces affichent 61 % ou 68 %, ce qui suggère des éditions successives de la mention (hypothèse). Date et entité juridique non visibles. Chiffre portant sur l'ensemble des CFD, sans ventilation crypto. — [eToro, General Risk Disclosure](https://www.etoro.com/customer-service/general-risk-disclosure/) ; [BrokerChooser](https://brokerchooser.com/broker-reviews/etoro-review/cfd-risk-warning)
- **[Donnée dure, relayée par des comparateurs]** Plus500 : entre 76 % et 81 % de comptes perdants selon les pages (un comparateur donne 81 %, un autre 76 %), date non visible. Attribution précise des deux chiffres incertaine entre ces pages. — [FXEmpire](https://www.fxempire.com/brokers/compare/etoro-vs-plus500) ; [Investing.com UK](https://uk.investing.com/brokers/compare/etoro-vs-plus500/) ; [BrokerChooser](https://brokerchooser.com/compare/etoro-vs-plus500)
- **[Agrégateur secondaire]** Selon fortraders.com, les mentions imposées par l'ESMA chez les grands brokers régulés sur 2024-2026 donnent 74 % à 89 % de comptes de CFD perdants selon le broker et le produit. Résumé secondaire, non vérifié auprès de l'ESMA ; attribution incertaine entre les deux pages. — [fortraders.com (day trading)](https://fortraders.com/blog/day-trading-profitable) ; [fortraders.com (crypto)](https://fortraders.com/blog/is-crypto-day-trading-worth-it)

**Études et régulateurs**
- **[Étude][Historique]** AMF, octobre 2014 (confirmé, avec une nuance importante) : environ 15 000 clients suivis pendant 4 ans, 89 % de perdants, perte moyenne d'environ 10 900 € (le résumé dit « par client perdant », la 1re passe « par client » : à vérifier dans le PDF). L'AMF n'a pas pu séparer Forex et CFD, et une part minoritaire des chiffres inclut des options binaires : **le 89 % ne concerne donc pas la crypto**. Aucune étude AMF de 2026 sur les pertes des particuliers (CFD ou crypto) n'est apparue. — [AMF, étude sur les résultats des investisseurs particuliers (PDF)](https://www.amf-france.org/sites/institutionnel/files/contenu_simple/rapport_etude_analyse/epargne_prestataire/Etude%20des%20resultats%20des%20investisseurs%20particuliers%20sur%20le%20trading%20de%20CFD%20et%20de%20Forex%20en%20France.pdf)
- **[Étude]** NBER Working Paper 31317, « Are Cryptos Different? Evidence from Retail Trading » : s'appuie sur les données de 200 000 traders particuliers d'eToro ; ils sont contrariens sur les actions et l'or, mais suivent la tendance sur la crypto. Le résumé de recherche ne mentionne aucun taux de rentabilité. C'est vraisemblablement le papier « Kogan et al. (2023) » cité par la BIS que la 1re passe n'avait pas pu lire (inférence). Non lu ici non plus. — [NBER w31317](https://www.nber.org/system/files/working_papers/w31317/w31317.pdf)
- **[Étude][Historique]** NYU Stern (Duron-Carielo) : dans une simulation à 125x, 98,32 % des trades sont liquidés ; les auteurs concluent que le trading de perpétuels à fort levier ressemble à du jeu. Simulation, pas résultat observé. Piste de la 1re passe reconfirmée. — [NYU Stern](https://www.stern.nyu.edu/sites/default/files/assets/documents/Duron-Carielo_Is%20There%20A%20Future%20In%20Perpetual%20Futures.pdf)
- **[Étude]** Gornall, Rinaldi et Xiao (AEA 2026, préliminaire) : les traders contraints financièrement qui font du basis trade sur perpétuels convergent vers un profit presque sans risque, mais peuvent subir de lourdes pertes en cas de stress de marché (données de marché, pas de comptes de particuliers). — [AEA 2026](https://www.aeaweb.org/conference/2026/program/paper/ByyFEfr4)
- **[Étude][Historique][hors crypto]** Un blog cite Chague, De-Losso et Giovannetti (2020) : 97 % de perdants parmi des day traders brésiliens de futures sur actions ; le blog ne donne pas le lien de l'article (à vérifier à la source). — [10pmtrader.com](https://10pmtrader.com/why-retail-traders-lose-money/)
- **Pistes repérées, non lues :** note de plaidoyer de Better Markets sur les perpétuels pour particuliers ; analyse de FTI Consulting du crash d'octobre 2025 ; article MDPI sur les perpétuels en finance décentralisée. — [Better Markets](https://bettermarkets.org/analysis/perpetual-futures-are-inappropriate-for-retail-investors-just-like-single-stock-etfs/) ; [FTI Consulting](https://www.fticonsulting.com/insights/articles/crypto-crash-october-2025-leverage-met-liquidity) ; [MDPI](https://www.mdpi.com/2227-7072/14/7/178)

**Sondages (déclaratifs, fiabilité faible)**
- **[Sondage]** 84 % de 1 005 traders crypto particuliers interrogés en août 2025 déclarent avoir perdu de l'argent la première année, et 58 % presque tout leur capital ; commanditaire et méthode non précisés dans l'extrait. — [NFTEvening](https://nftevening.com/84-percent-of-retail-crypto-traders-lose-money-in-their-first-year/)
- **[Sondage][Vendeur/Marketing probable]** Étude « How Retail Traders Trade Crypto in 2026 » de Traders Union (1 200 traders) : 75 à 90 % de traders en perte, sur déclarations. — [Traders Union](https://tradersunion.com/interesting-articles/retail-crypto-trading-study/)

**Hyperliquid : distribution des PnL des wallets**
- **[Agrégateur][Historique]** Échantillon de 10 000 wallets déposants tirés au hasard, données de novembre 2024, fenêtre de 30 jours, publié en janvier 2026 d'après le résumé de recherche : 16,5 % rentables, 73,8 % perdants, 9,7 % à l'équilibre ; 85,7 % de rentables dans la tranche 10-100 M$. — [Medium / envyprotocol](https://medium.com/@envyprotocol/i-analyzed-10-000-hyperliquid-traders-the-results-are-brutal-a29adcca8c2a)
- **[Agrégateur]** 82 586 wallets actifs suivis, dont seulement 230 (environ 0,28 %, [calcul personnel]) avec plus de 1 M$ de profit cumulé ; cohorte « non rentable » de 58 848 wallets (environ 71 %, [calcul personnel]). Le résumé attribue ces chiffres à **Hyperdash** (la 1re passe les attribuait à Buildix). Méthode non détaillée, date non visible. — [Hyperdash](https://hyperdash.com/learn/best-tools-trading-hyperliquid)
- **[Donnée dure]** Le classement officiel n'affiche que les comptes d'au moins 100 000 USDC de valeur de compte et 10 M USDC de volume (reconfirmé par le résumé de recherche). — [Hyperliquid Guide](https://hyperliquidguide.com/guides/trading/pnl-sharing-leaderboard) ; [classement officiel](https://app.hyperliquid.xyz/leaderboard)
- **[Agrégateur]** Une analyse de 43 618 comptes applique des filtres (fonds propres d'au moins 10 000 $, PnL cumulé positif, etc.) et ne livre qu'une short-list de meilleurs comptes, pas une part de rentables ; date non visible. — [Techflow](https://www.techflowpost.com/en-US/article/33650). Un article de CoinMarketMan propose une classification des traders par PnL, sans chiffre visible dans l'extrait. — [CoinMarketMan](https://coinmarketman.com/blog/pnl-based-trader-classification-why-performance-matters-more-than-size-on-hyperliquid--en/)
- Aucune analyse de 2026 sur la distribution complète des PnL de tous les wallets n'a été trouvée.

**Statut des pistes de la 1re passe (Q1)**
- Échantillon 16,5 % / 73,8 % / 9,7 % (envyprotocol) : **confirmé** (publication en janvier 2026 selon le résumé, données de novembre 2024).
- 82 586 wallets / 230 à plus de 1 M$ / 58 848 non rentables (attribués à « Buildix ») : **corrigé** pour l'attribution (Hyperdash selon le résumé) ; chiffres identiques.
- Seuils du classement officiel (100 000 USDC, 10 M USDC) : **confirmé**.
- Étude Dropstab (247 000 wallets, juin 2026) et écart CoinDuck / classement officiel : **non vérifiés** (non retrouvés).
- Papier de Kogan et al. (2023) : **identifié** comme probablement NBER w31317, **non lu**.
- Étude AMF d'octobre 2014 : **confirmée**, avec la nuance Forex/CFD non séparés et options binaires incluses pour une partie.
- Simulation à 125x (98,32 %) : **confirmée** (simulation).
- Lacune « mentions de risque des brokers » : **comblée en partie** (eToro, Plus500), sans ventilation crypto.
- Fourchette ESMA de 2018 sur les pertes sur CFD : **non vérifiée** (seul un résumé secondaire à 74-89 %).

### Inferences
- Les mentions de risque sont la seule source récente et chiffrée sur les pertes, mais elles couvrent tous les CFD (forex, indices, actions, crypto) et comptent des comptes sur une période donnée, pas des euros perdus. Elles vont de 51 % (eToro) à 81 % (Plus500) : le résultat dépend donc aussi de la clientèle et de la méthode du broker (hypothèses : part d'investisseurs de long terme, de copieurs, levier moyen), pas seulement de la compétence. Il vaut mieux écrire « de la moitié à plus de 80 % selon le broker » que citer un chiffre unique.
- Pour la crypto seule, la mesure directe de 2025-2026 manque toujours. Les repères disponibles sont de natures différentes : BIS 2022 (spot, 73-81 %, 1re passe), échantillon Hyperliquid de novembre 2024 (73,8 % de perdants sur 30 jours), mentions CFD (51-81 %, tous actifs). Ils vont dans le même sens (majorité de perdants, environ 3 sur 4 au centre) sans le prouver pour 2026.
- **Biais de survie et de sélection :** l'échantillon Hyperliquid ne voit que les déposants d'une fenêtre de 30 jours, pas les trajectoires complètes ; le classement officiel ne montre que les comptes de plus de 100 000 USDC et 10 M USDC de volume ; les 230 wallets à plus de 1 M$ décrivent la queue de la distribution, pas le rendement typique ; les 85,7 % de gagnants parmi les comptes de 10 à 100 M$ sont conditionnés par le fait d'être déjà devenu gros.
- Les sondages (84 %, 75-90 %) ne doivent pas servir de preuve : déclaratifs, commanditaires inconnus ou commerciaux.

### Gaps
- Aucune étude académique ou réglementaire de 2025-2026 mesurant la part de traders crypto particuliers rentables (BIS, NBER, SSRN, arXiv, AMF, ESMA, FCA) : deux recherches dédiées, aucun résultat.
- Date, entité juridique et périmètre exacts du 51 % d'eToro non confirmés. Pour IG, un extrait de comparateur non identifié (page d'environ 300 jours, soit vers décembre 2025, [calcul personnel]) donnait environ 70 % : non retenu comme fait faute de source identifiable.
- Aucune mention de risque de broker ne donne la part de comptes perdants sur la seule crypto.
- Distribution complète des PnL des wallets Hyperliquid en 2026 (Dune, Hypurrscan, Hyperdash en accès direct) non consultée.
- À lire si le rédacteur y a accès : NBER w31317, Better Markets, FTI Consulting, MDPI.

---

## Q2. Liquidations en 2026 : cumul, T3 2026, grands événements

### Takeaway
Aucun total du T3 2026 ni cumul 2026 n'a été trouvé après trois recherches. Les repères datés de l'été et de l'automne montrent un basculement de camp : plus de 9,7 Md$ liquidés sur deux semaines fin août (dont 6,55 Md$ de shorts) pendant la remontée du BTC au-dessus de 80 000 $, puis 555,6 M$ liquidés le 06/10/2026 (environ 88 % de longs) lors du repli sous 84 000 $.

### Cited Findings
- **[Donnée dure] 06/10/2026 :** le BTC repasse brièvement sous 84 000 $ ; 555,6 M$ liquidés en 24 h, dont 487,2 M$ de longs (environ 88 %, [calcul personnel]), selon CoinGlass cité par The Block. Un analyste de ViaBTC cité par l'article indique que le BTC a clos le T3 en hausse d'environ 40 %, avec 6,5 Md$ d'entrées dans les ETF spot. — [The Block, 06/10/2026](https://www.theblock.co/news/markets/2026-10-06-bitcoin-slides-crypto-long-liquidations-surge-417882)
- **[Donnée dure] 25/08/2026 :** la remontée du BTC au-dessus de 80 000 $ vient de rachats de positions short plus que d'un excès de levier ; l'open interest en BTC tombe à 587 584 BTC, son plus bas en près de cinq mois (Glassnode), contre 645 760 BTC le 14/08. — [CoinDesk, 25/08/2026](https://www.coindesk.com/markets/2026/08/25/a-bitcoin-short-squeeze-for-the-ages-as-futures-open-interest-collapses)
- **[Agrégateur] fin août / début septembre 2026 (date non visible, déduite du contexte) :** plus de 9,7 Md$ liquidés sur deux semaines, dont 6,55 Md$ de shorts (environ 68 %, [calcul personnel]) et 3,16 Md$ de longs. — [BigGo Finance](https://finance.biggo.com/news/938e56a0-a3ab-4100-931f-d3c14b1cbe8c). Un autre relevé donne un open interest BTC de 318 600 BTC au 31/08 (331 100 le 21/08), sur un périmètre différent de celui de Glassnode (les deux séries ne sont pas comparables). — [Bloomingbit](https://en.bloomingbit.io/feed/news/119412)
- **[Agrégateur] 03/06/2026 :** 939,87 M$ liquidés et 185 298 traders touchés (CoinGlass, relayé par BingX). — [BingX News](https://bingx.com/en/news/post/coinglass-m-crypto-liquidations-hit-traders-on-june). Le titre « Crypto Liquidations Hit $1.8B in Biggest 2026 Wipeout So Far » (Bitcoin Foundation) réapparaît — [Bitcoin Foundation](https://bitcoinfoundation.org/news/altcoins/crypto-liquidations-surge-near-1-8b-as-btc-longs-get-crushed/) — mais cela ne règle pas la contradiction avec le record journalier du 31/01/2026 (2,588 Md$, rapport S1 de CoinGlass, 1re passe).
- **[Agrégateur][date approximative]** Amberdata : 31,4 Md$ de liquidations BTC cumulées sur l'année, dont 60 % de longs. L'âge affiché de la page (environ 202 jours) la place vers fin mars 2026 ([calcul personnel]) ; date non confirmée. — [Amberdata](https://blog.amberdata.io/leverage-liquidations-the-31b-deleveraging)
- **Total T3 2026 et cumul 2026 : non trouvés.** La recherche « septembre 2026 » n'a renvoyé que des relevés quotidiens de septembre 2025 (MEXC News).

**Statut des pistes de la 1re passe (Q2)**
- Rapport S1 2026 de CoinGlass (73,35 Md$, 62 % de longs, record du 31/01 à 2,588 Md$) : **non revérifié** (page inaccessible), aucun élément contraire.
- 1,8 Md$ le 02/06/2026 (« plus gros wipeout de 2026 ») : **contradiction non résolue**.
- Squeeze d'août 2026 (plus de 4 Md$ de shorts en deux jours, CoinDesk 21/08) : **complété** par CoinDesk du 25/08 et BigGo (plus de 9,7 Md$ sur deux semaines).
- 1,19 Md$ liquidés les 8-9/10/2026 (CoinCentral) : **non vérifié** ; The Block donne 555,6 M$ pour le 06/10 (autre journée).
- Total du T3 2026 : **toujours manquant**.

### Inferences
- Le camp qui se fait liquider a basculé avec le régime : longs majoritaires au S1 (62 %, 1re passe) pendant la baisse du BTC, shorts majoritaires fin août (environ 68 % de 9,7 Md$) pendant le rebond, puis longs à 88 % le 06/10. Le levier est puni du côté où le marché se retourne : il n'y a pas de « bon côté » pour un trader à fort levier.
- Contexte de prix ([calcul personnel], ordre de grandeur) : un BTC à environ 84 000 $ fin septembre après +40 % au T3 implique environ 60 000 $ fin juin, ce qui cadre avec un S1 baissier (longs liquidés, juin mois le plus lourd à 16,14 Md$ en 1re passe) suivi d'un T3 haussier (shorts liquidés). La 1re passe donne un indice S&P Bitcoin à −4,55 % depuis le début de l'année au 30/09, cohérent avec ce niveau.
- Un open interest au plus bas depuis cinq mois pendant le squeeze du 25/08 va dans le sens de la lecture de CoinDesk : des shorts forcés de racheter, plus qu'un nouvel afflux de levier, ont alimenté la hausse.
- Aucun total du T3 n'existe dans les sources trouvées : ne pas en extrapoler.

### Gaps
- Total du T3 2026 et cumul 2026 jusqu'au 13/10 : introuvables après trois recherches. Source à consulter : historique des liquidations de CoinGlass (somme de juillet à septembre).
- Date exacte de l'épisode BigGo et de la page Amberdata ; ventilation par plateforme ; pertes nettes (marge perdue) derrière les notionnels.
- Plus grands événements de 2026 : seule la liste de la 1re passe est disponible (31/01, 02-03/06, 20-21/08, 08-09/10). Les liquidations de février 2026 (pic du DVOL cité en 1re passe) n'ont pas été examinées.

---

## Q3. Portage actuel : funding, base CME, sUSDe (et comparaison avec 2024-2025)

### Takeaway
Début octobre 2026, le funding du BTC est d'environ 11 % annualisé sur Hyperliquid et en moyenne sur cinq plateformes (de 6,4 % chez OKX à 15,4 % chez Kraken), soit à peu près le niveau de base de la composante d'intérêt (0,01 % par 8 h, soit 10,95 % par an en simple). La base CME de septembre-octobre n'a pas été trouvée ; en août elle valait environ 3 % (CoinDesk) ou 5,7 à 7,9 % brut (CryptoSlate), contre environ 15 % après l'élection de 2024 et environ 5 % fin 2025 et au printemps 2026. Le sUSDe rapportait environ 4,1 % fin juillet 2026 (9,4 % fin avril).

### Cited Findings

**Funding des perpétuels**
- **[Donnée dure] 06/10/2026 :** funding du BTC sur Hyperliquid d'environ +10,9 % annualisé ; moyenne sur cinq plateformes d'environ +11,5 % par an, de +6,4 % (OKX) à +15,4 % (Kraken) ; Binance n'est pas sur la page (elle bloque les requêtes américaines). Le funding de l'ETH n'apparaît pas dans l'extrait. — [defirate.com](https://defirate.com/perp/)
- **[Donnée dure]** MacroMicro affiche 0,01 % par tranche de 8 h au 08/10/2026 (plateforme ou colonne non identifiée ; une seconde colonne à 0,0047 %). — [MacroMicro](https://en.macromicro.me/charts/49213/bitcoin-perpetual-futures-funding-rate)
- **[Agrégateur]** Moyenne sur 7 jours du funding BTC chez Binance d'environ 4,4 % APY ; la page a environ 98 jours, soit un relevé vers le 07/07/2026 ([calcul personnel]). — [The Block Data](https://www.theblock.co/data/crypto-markets/futures/btc-funding-rates)
- Rappel de la 1re passe, non revérifié : 0,0067 % par 8 h au 30/09/2026, soit environ 7,3 % par an en simple ([MacroMicro](https://en.macromicro.me/charts/49213/bitcoin-perpetual-futures-funding-rate)). La base d'intérêt de 0,01 % par 8 h correspond à 10,95 % par an en simple ([calcul personnel] : 0,01 × 3 × 365).

**Base CME**
- Aucun chiffre annualisé de septembre-octobre 2026 trouvé. Le contrat de septembre 2026 a expiré le 25/09/2026 (CNBC). Une série de futures CME BTC affiche une clôture de 83 925 $ le 30/09/2026 (Investing.com, mois de contrat non précisé). — [CNBC](https://www.cnbc.com/quotes/@BTC.1) ; [Investing.com](https://www.investing.com/crypto/bitcoin/bitcoin-futures-historical-data)
- **Trajectoire de la base annualisée :**
  - **Fin 2024 :** environ 15 % après le rallye post-électoral, rapporté par CoinDesk (le résumé ne précise pas l'article ; attribution à l'article de décembre 2025 incertaine). **[Historique]**
  - **Fin 2025 :** environ 5 % selon Velo, cité par CoinDesk, avec des opportunités d'arbitrage qui se réduisent et Binance qui dépasse le CME en open interest. — [CoinDesk, 22/12/2025](https://www.coindesk.com/markets/2025/12/22/cme-loses-top-spot-to-binance-in-bitcoin-futures-open-interest-as-institutional-demand-wanes) **[Historique]**
  - **Avril 2026 :** base comprimée alors que le BTC est passé de plus de 120 000 $ à moins de 70 000 $ ; base d'environ 5 % contre un taux sans risque d'environ 4,5 %. — [The Block, 09/04/2026](https://www.theblock.co/news/business/2026-04-09-cme-bitcoin-futures-activity-slumps-to-14-month-low-as-basis-trade-unwind-drains-institutional-demand-396722) ; [crypto.news](https://crypto.news/cme-bitcoin-futures-slump-as-basis-trade-unwinds-and-wall-street-steps-back/)
  - **Août 2026 :** environ 3 % à trois mois contre environ 3,8 % pour le T-note à 2 ans (CoinDesk, 10/08/2026) ; ou 5,69 % à 7,89 % brut contre 4,19 % pour le T-note, selon un contrôle sur les règlements CME du 07/08 (CryptoSlate). Les deux mesures diffèrent probablement par la méthode ou le contrat (hypothèse du résumé de recherche : brut ou net de coûts, contrats différents). — [CoinDesk, 10/08/2026](https://www.coindesk.com/markets/2026/08/10/a-rare-cme-shift-hedge-funds-abandon-structural-shorts-to-bet-on-a-bitcoin-rally) ; [CryptoSlate](https://cryptoslate.com/bitcoin-futures-carry-treasury-yield-etf-flows/) ; [BigGo Finance](https://finance.biggo.com/news/9c11c1e7-4988-4ad7-998f-7d4f8a51f6ad)
- Une page de dépôt GitHub (« comparative analysis ») annonce 15-25 % en 2024 et 4-5 % au T3 2026 ; elle n'est pas vérifiée et ses chiffres ne correspondent pas aux articles de presse : **écartée, non citée**.

**sUSDe (Ethena)**
- **[Donnée dure] 28/07/2026 :** 4,14 % ; 1 542 030 562 USDe déposés sur Aave, en baisse de 9 % (152,4 M USDe) en 30 jours. — [Aavescan](https://aavescan.com/rates/ethena-susde)
- **[Agrégateur]** APY d'offre de 4,09 % (DefiLlama, non daté) ; moyenne sur 30 jours de 3,96 % (Stablewatch, non daté) ; 5,37 % (Datawallet, d'après DefiLlama, non daté). — [DefiLlama](https://defillama.com/yields/pool/66985a81-9c51-46ca-9977-42b4fe7bc6df) ; [Stablewatch](https://www.stablewatch.io/analytics/assets/sUSDe-Ethena) ; [Datawallet](https://www.datawallet.com/crypto/best-stablecoin-interest-rates)
- **[Agrégateur]** Moyenne glissante sur 7 jours de 9,4 % au 25/04/2026 (eco.com) ; environ 4,5 % en juin 2026, « en baisse depuis des niveaux à deux chiffres » (CoinMarketCap, niveaux antérieurs non chiffrés). — [eco.com](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin) ; [CoinMarketCap](https://coinmarketcap.com/cmc-ai/ethena-usde/price-prediction/)

**Statut des pistes de la 1re passe (Q3)**
- Base CME ≈ 3 % (CoinDesk 10/08/2026) et 5,69-7,89 % (CryptoSlate 07/08/2026) : **confirmés** comme deux mesures coexistantes ; l'écart reste non tranché.
- Titre de The Block du 09/04/2026 : « plus bas de 14 mois », ce qui renvoie à février 2025 et non à « plus bas depuis février 2024 » (1re passe) : **contradiction confirmée, en faveur du titre** ; la formulation « depuis février 2024 » est probablement erronée (non résolu sans lire l'article).
- Funding Binance ≈ 4,4 % APY (page ≈ 98 jours) : **confirmé** comme relevé daté d'environ début juillet 2026.
- Funding BTC 0,0067 % par 8 h au 30/09/2026 : **non revérifié** ; relevés plus récents : 0,01 % par 8 h le 08/10 (MacroMicro, plateforme non identifiée) et ≈ 10,9 % annualisé sur Hyperliquid le 06/10 (defirate).
- sUSDe 4,14 % au 28/07/2026 sur Aave, dépôts −9 % : **confirmé**.
- sUSDe 9,4 % en avril 2026 : **confirmé** (eco.com, moyenne 7 jours au 25/04 ; la 1re passe l'attribuait à BingX Learn : attribution corrigée).
- sUSDe 7,1 % en juin 2026 (BingX) : **non confirmé**, contredit par CoinMarketCap (≈ 4,5 %).
- sUSDe ≈ 4,76 % fin septembre, offre d'USDe de 4,95 Md$ au 28/09, fonds de réserve de 61 M$ : **non vérifiés** (non retrouvés).
- Lacune « niveaux 2024-2025 de la base CME » : **comblée en partie** (≈ 15 % fin 2024, ≈ 5 % fin 2025) ; le funding de 2024-2025 reste non sourcé.

### Inferences
- Un funding de 10,9 % sur Hyperliquid correspond au niveau de base (10,95 %) : le perpétuel se négocie près de l'indice, sans prime haussière marquée. Ce n'est pas le signe d'un levier acheteur excessif, ce qui rejoint la lecture de CoinDesk sur un marché dominé par les rachats de shorts fin août. Un portage « long spot / short perp » rapporterait donc environ 6 à 15 % brut selon la plateforme le 06/10, avant coûts, frais, marge immobilisée et risque de plateforme.
- Ce funding est volatil : environ 4,4 % début juillet (Binance, moyenne 7 jours), 7,3 % le 30/09 (en simple), 10,9 % le 06/10. Une moyenne de long terme ne peut pas se déduire de ces points.
- Comparaison 2024 → 2026 de la base CME : environ 15 % (fin 2024) → environ 5 % (fin 2025 et avril 2026) → environ 3 % net ou 5,7-7,9 % brut (août 2026). Contre un taux sans risque de 3,8 à 4,5 %, la prime nette se réduit à 0-1 point, et à 2-4 points dans la mesure brute d'août.
- sUSDe : de niveaux « à deux chiffres » (non datés) à 9,4 % (avril 2026) puis environ 4-4,8 % : au niveau des T-bills et des T-notes (3,8 à 4,2 % en août). Pour un particulier, le portage delta-neutre accessible via sUSDe ne rapporte pratiquement pas plus qu'un placement monétaire.
- Les écarts entre mesures (3 % contre 5,7-7,9 % pour la même période) imposent de toujours citer la méthode (brut/net, contrat, indice de référence).

### Gaps
- Base CME annualisée de septembre-octobre 2026 : introuvable (sources à consulter : règlements CME contre indice de référence, CryptoQuant « CME Futures Annualized Basis »).
- Funding Binance d'octobre 2026 et funding/base de l'ETH : non trouvés.
- sUSDe de septembre-octobre 2026 et offre d'USDe : non retrouvés dans cette passe.
- Niveaux de 2024-2025 du funding et du sUSDe : non sourcés.

---

## Q4. Copy-trading, prop firms crypto, rachat de Breakout par Kraken

### Takeaway
Copy-trading : toujours une seule étude chiffrée, celle de YieldFund (vendeur, publiée fin 2025 selon KuCoin) : 48,48 % de copieurs rentables sur 90 jours, alors qu'environ 97 % des traders copiés sont positifs ; rien d'indépendant ni de publié par eToro ou Bitget. Prop firms : aucun taux de réussite ou de paiement audité pour la crypto ; le meilleur proxy reste FPFX (14 % de réussite, 7 % de payés, septembre 2024) et les paiements crypto des dix plus grandes firmes ont atteint 115,1 M$ au T1 2026 (+108,9 % sur un an, croissance stagnante depuis décembre). Kraken a racheté Breakout début septembre 2025, sans divulguer le prix.

### Cited Findings

**Copy-trading**
- **[Vendeur/Marketing]** Étude YieldFund sur 90 jours, plus de 100 000 résultats, Binance, Bybit et MEXC, publiée « fin 2025 » selon la page de KuCoin : 48,48 % de copieurs rentables après frais et risque ; près de 97 % des traders copiés sont positifs sur 90 jours, mais moins de la moitié de leurs copieurs. Par plateforme, les copieurs de Binance afficheraient un taux de gain de 66,5 % contre 43,65 % sur Bybit ; le résumé précise qu'il s'agit d'un taux de gain dont le sens exact (copieurs ou trades) n'est pas clair : **à ne pas utiliser sans lire la page d'origine**. — [KuCoin Blog](https://www.kucoin.com/blog/is-crypto-copytrading-profitable-in-2026) ; [YieldFund (1re passe)](https://yieldfund.com/is-copy-trading-profitable-a-90-day-multi-exchange-study/)
- **[Vendeur/Marketing]** Les guides de plateformes et d'outils reprennent presque tous cette étude ; aucune donnée agrégée d'eToro ou de Bitget n'a été trouvée (seul un cas isolé de trader à +25 % par an depuis 2013 sur eToro, anecdotique). — [Copi Tools](https://copi-tools.com/blog/copytrade-profitable/) ; [SocialTrading.ai](https://socialtrading.ai/education/copy-trading-can-you-actually-make-money-or-is-it-a-hype/) ; [Quo Markets](https://www.quomarkets.com/blog/is-copy-trading-actually-profitable-a-realistic-breakdown/)

**Prop firms**
- **[Donnée dure]** Finance Magnates Datalab : paiements réglés en crypto et suivis on-chain pour dix grandes prop firms : 115,1 M$ au T1 2026, soit +108,9 % sur un an ; la croissance stagne depuis décembre 2025 (titre de la reprise TradingView). Ces paiements viennent de toutes les prop firms qui paient en crypto, pas seulement des firmes de trading crypto (1re passe). — [FM Datalab](https://datalab.financemagnates.com/market-insights/tracked-prop-firm-crypto-payouts-doubled-to-115m-in-q1-2026) ; [TradingView News](https://www.tradingview.com/news/financemagnates:9f4359a05094b:0-prop-firm-crypto-payouts-doubled-to-115-million-in-q1-2026-but-growth-has-stalled-since-december/)
- **[Donnée dure][Historique]** FPFX Technology (300 000 comptes) : environ 14 % de réussite au challenge, environ 7 % de participants payés, paiement typique d'environ 4 % de la taille du compte ; chiffres attribués à Finance Magnates en septembre 2024, mais certaines pages les présentent comme des données de 2026 (datation incertaine). Ils portent surtout sur le Forex et les CFD. — [Prop Firm Backtester](https://www.propfirmbacktester.com/prop-firm-statistics) ; [il.ly](https://il.ly/blog/prop-firm-pass-rates)
- **[Agrégateur]** Autres chiffres circulants : 13-15 % de réussite moyenne (attribués à Finance Magnates), 5-10 % par tentative dans des guides SEO, de 8,89 % à 36,22 % selon les firmes ; FTMO, FundedNext et Apex ne publient aucun taux actuel ; Topstep (futures) affiche 51,8 % par trader mais en comptant tous ceux qui ont tenté un ou plusieurs « Combines » (non comparable à un taux par tentative) ; environ 45 % des traders devenus financés auraient reçu au moins un paiement (source non identifiée). Aucun taux audité spécifique à la crypto en 2026. Attribution par chiffre incertaine. — [il.ly](https://il.ly/blog/prop-firm-pass-rates) ; [CryptoFundTrader](https://cryptofundtrader.com/crypto-prop-firm-statistics/) ; [Alex Firdaus](https://alexfirdaus.com/prop-firm-pass-rate/) ; [AtmosFunded](https://atmosfunded.com/prop-firm-statistics/) ; [ThePropFirmGuide](https://thepropfirmguide.com/prop-firm-statistics/) ; [TV-Hub](https://www.tv-hub.org/guide/crypto-prop-firms)

**Kraken et Breakout**
- **[Donnée dure]** Kraken a annoncé l'acquisition de Breakout, société de prop trading crypto fondée sur un parcours d'évaluation, **début septembre 2025** (effet au 1er septembre selon une source, annonce du 4 septembre selon une autre). **Conditions financières non divulguées.** Breakout avait levé 4,5 M$ en seed en juillet 2024. Offre : jusqu'à 200 000 $ de capital notionnel, jusqu'à 90 % des profits pour le trader (80 % par défaut selon Finance Magnates), plus de 50 paires, levier jusqu'à 5x sur les contrats BTC et ETH, intégration à Kraken Pro. Kraken a ensuite lancé son propre programme « Kraken Prop » (date non visible). — [Finance Magnates](https://www.financemagnates.com/cryptocurrency/krakens-breakout-bet-could-normalize-prop-trading-across-the-crypto-industry/) ; [Finance Magnates (Kraken Prop)](https://www.financemagnates.com/cryptocurrency/kraken-enters-funded-trading-with-new-prop-program-after-breakout-acquisition/) ; [crypto.news](https://crypto.news/kraken-acquires-breakout-advanced-trading-2025/) ; [FinancialIT](https://financialit.net/news/investment/kraken-completes-major-acquisition-breakout-offer-prop-trading-clients-globally) ; [FX News Group](https://fxnewsgroup.com/forex-news/cryptocurrency/kraken-buys-crypto-prop-trading-firm-breakout/) ; [CoinCentral](https://coincentral.com/crypto-exchange-kraken-purchases-prop-trading-firm-breakout/) ; [NFTGators](https://www.nftgators.com/kraken-acquires-crypto-native-prop-trading-firm-breakout-to-expand-digital-asset-strategy/)
- Un article de QuantVPS situe le rachat en 2024 ; les autres sources le datent de 2025, donc cette date est jugée erronée. — [QuantVPS](https://www.quantvps.com/blog/breakout-crypto-prop-firm-rules)

**Statut des pistes de la 1re passe (Q4)**
- Date du rachat de Breakout : **corrigé** (début septembre 2025 ; l'hypothèse « 2024 » est erronée). Prix : **non divulgué** (confirmé).
- Étude YieldFund (48,48 % ; 97,04 % / 43,61 %) : **confirmée** pour 48,48 % et environ 97 % ; le 43,61 % n'a pas été revu ; date de publication : fin 2025 selon KuCoin.
- FPFX 14 % / 7 % / 4 % : **confirmé** (datation incertaine).
- 115,1 M$ au T1 2026 : **confirmé**, avec +108,9 % sur un an.
- Breakout « plus de 60 M$ versés » et part de paiement de HyroTrader / Breakout : **non vérifiés**.
- « 60 % de copieurs gagnants à trois mois » : **toujours sans source** (non retrouvé).
- Un chiffre de blog « maîtres à 5-15 % par mois, copieurs à 2-8 % après frais » a été vu dans un résumé sans source identifiable : non retenu.

### Inferences
- Pour le copy-trading, la seule donnée reste celle d'un vendeur : un copieur a à peu près une chance sur deux d'être gagnant sur 90 jours, alors que près de 97 % des traders copiés le sont. Cet écart est cohérent avec le décalage d'exécution et les frais, mais ces causes sont des hypothèses non testées (1re passe). La différence entre plateformes (66,5 % contre 43,65 %), si elle était confirmée, montrerait que la moyenne cache de fortes disparités, mais son sens est ambigu.
- Pour les prop firms, la définition change tout : 51,8 % chez Topstep (par trader, plusieurs tentatives) contre 14 % (FPFX, par compte) et 7 % de payés. Une « réussite » par trader sur plusieurs tentatives masque le coût cumulé des frais de challenge.
- Les 115,1 M$ de paiements crypto du T1 2026 (+108,9 % sur un an, stagnants depuis décembre) montrent un flux réel mais sans dénominateur : sans le montant des frais encaissés par les firmes, on ne peut pas déduire un rendement pour le candidat moyen. Le biais de survie vient de ce que seuls les gagnants et les montants versés sont publiés.
- Le rachat de Breakout par Kraken (septembre 2025) montre que les prop firms sont devenues un produit d'acquisition de clients pour les bourses ; le prix non divulgué empêche d'en tirer une valorisation.

### Gaps
- Aucune étude indépendante ni donnée de plateforme (Bitget, Binance, OKX, eToro) sur le rendement agrégé des copieurs, ni sur les faux classements de lead traders.
- Aucun taux de réussite ou de paiement audité pour HyroTrader, Breakout, FTMO (offre crypto) ou toute prop firm crypto en 2025-2026.
- Prix et conditions du rachat de Breakout ; date de lancement de Kraken Prop.
- Rapport frais de challenge encaissés / paiements versés : jamais publié.

---

## Q5. Fonds crypto en 2025 et 2026 à ce jour ; profits des market makers

### Takeaway
Les fonds crypto ont perdu de l'argent en 2025 (CFR : fonds moyen −7,2 %, médian −5,2 %, 37 % de fonds positifs ; indice −1,64 %) et en 2026 à ce jour (−6,12 % ou −9,2 % selon la capture de la page CFR), alors que le composite HFRI des hedge funds classiques est d'environ +6 à +7,6 % (rapports Crystal Funds de juin et juillet 2026). Aucun indice HFR ou PivotalPath crypto 2025-2026 n'a été trouvé, ni aucun profit de market maker publié.

### Cited Findings
- **[Donnée dure]** CFR, revue annuelle 2025 : le fonds crypto moyen a rendu −7,2 % en 2025 (médiane −5,2 %) ; seuls 37 % des fonds déclarants sont positifs ; le BTC a perdu 6,3 % sur l'année, donc le fonds moyen a fait légèrement moins bien. — [CFR, revue annuelle 2025](https://cryptofundresearch.com/crypto-hedge-fund-performance/)
- **[Donnée dure]** Indice CFR (309 fonds) : 2025 à −1,64 % et 2026 à ce jour à −6,12 % sur une page (1re passe). Une autre page CFR donne −9,2 % pour 2026, « contre 0 % pour le Bitcoin », sans date visible : captures de dates différentes, mois de référence non résolu. Attribution de chaque chiffre à une page précise incertaine. — [CFR Crypto Fund Index](https://cryptofundresearch.com/cfr-crypto-fund-index/) ; [CFR, infographie](https://cryptofundresearch.com/infographic/)
- **[Agrégateur]** Hedge funds classiques, composite HFRI Fund Weighted (résumé tiers de données HFR par Crystal Funds) : rapport de juin 2026, +7,57 % depuis le début de l'année et +16,40 % sur 12 mois ; rapport de juillet 2026, −1,10 % sur le mois, ce qui ramène le cumul annuel à +6,25 %. Périodes de référence exactes non confirmées. — [Crystal Funds, juin 2026](https://www.crystalfunds.com/insights/2026-june-hf-industry-report/) ; [Crystal Funds, juillet 2026](https://www.crystalfunds.com/insights/2026-july-hf-industry-report/)
- **[Vendeur/Marketing][Historique]** Indices de fonds crypto sur 2023-2024 : Galaxy VisionTrack +68,1 % (2023) et +52,9 % (2024), avec des données 2025 seulement jusqu'à novembre 2025 ; un autre article du même lot de résultats donne +40 % pour 2024 pour le même indice de 130 fonds (source non identifiée) ; CFR +46,25 % pour 2024 (1re passe) ; HFR Cryptocurrency Index +694,6 % cumulé sur cinq ans à février 2025. Source : blog d'un acteur du secteur, donc intéressée. — [3iQ](https://blog.3iq.io/news-insights/crypto-hedge-funds-are-outperforming-traditional-hedge-funds)
- **[Sondage]** PwC / Elwood / AIMA, 7e rapport annuel sur les hedge funds crypto (2025) : 55 % des hedge funds de l'enquête investissent dans la crypto en 2025, contre 47 % en 2024 ; enquête AIMA du premier semestre 2025 auprès de 122 investisseurs institutionnels et hedge funds. Pas de chiffre de rendement vu dans l'extrait. — [Rapport (PDF hébergé par Cayman Finance)](https://caymanfinance.ky/wp-content/uploads/2025/11/7th-Annual-Global-Crypto-Hedge-Fund-Report.pdf) ; [Wealth Professional](https://www.wealthprofessional.ca/investments/equity-markets/hedge-funds-boost-crypto-allocations-as-regulatory-clarity-fuels-institutional-confidence/390776)
- **[Agrégateur, non sourcé]** SQ Magazine : rendement moyen de +36 % en 2025 pour les hedge funds crypto, sans source primaire ; cela s'ajoute aux autres chiffres non sourcés de la même page cités en 1re passe (+13 %, +48 %), tous incompatibles avec CFR. — [SQ Magazine](https://sqmagazine.co.uk/crypto-hedge-funds-statistics/)
- **Market makers :** aucune recherche supplémentaire sur Wintermute, GSR, Jump ou DWF dans cette passe (budget). Les éléments de la 1re passe (Wintermute « rentable » sans chiffre, volume quotidien de 10 Md$ en 2026 contre 15 Md$ en 2025, B2C2 et Wintermute dans le dépôt SEC de Robinhood) restent tels quels.

**Statut des pistes de la 1re passe (Q5)**
- CFR 2026 à ce jour −6,12 % (mois de référence inconnu) : **non résolu** ; une autre page donne −9,2 %.
- CFR 2025 (indice −1,64 % ; quants +0,4 % ; long-only −15,3 %) : **non revérifié** ; nouveau : fonds moyen −7,2 %, médiane −5,2 %, 37 % de positifs, ce qui diffère de l'indice (différence de composition ou de pondération, non expliquée).
- Chiffres market-neutral à deux chiffres (14,4 %, 13 %, 48 %) : **toujours sans source** ; SQ Magazine ajoute encore +36 %.
- Indices HFR Cryptocurrency et PivotalPath 2025-2026 : **non trouvés** (seul le composite HFRI général, via un tiers).
- Rapport PwC / AIMA : **identifié** (7e édition), rendement non trouvé.
- Wintermute (profits, rachat d'Autonomous), GSR (Owler) : **non vérifiés**.

### Inferences
- Même hors levier retail, les fonds crypto professionnels n'ont pas gagné : 37 % seulement de fonds positifs en 2025 et un fonds moyen à −7,2 %, quasi au niveau du BTC (−6,3 %). Le contraste est net avec le composite HFRI général (+6 à +7,6 % en 2026) : écart de l'ordre de 12 à 17 points, en tenant compte du fait que les périodes ne sont pas alignées ([calcul personnel]).
- Trois mesures donnent trois valeurs pour 2024 (+40 %, +46,25 %, +52,9 %) et plusieurs pour 2025 (−1,64 %, −7,2 %, +36 % non sourcé) : la composition de l'indice et la déclaration volontaire pèsent lourd. **Biais de survie :** les fonds qui ferment cessent de déclarer, donc ces moyennes surestiment vraisemblablement les rendements réels (hypothèse classique, non mesurée ici). Le fait que même ces moyennes soient négatives en 2025 est d'autant plus parlant.
- La seule catégorie de gagnants structurels documentée dans les deux passes reste celle qui perçoit des frais et des écarts (plateformes, market makers), mais aucun profit de market maker n'est publié dans les sources trouvées.

### Gaps
- Indices HFR Cryptocurrency et PivotalPath pour 2025 et 2026 ; rendements du rapport PwC / AIMA / Elwood ; Galaxy VisionTrack 2025-2026 : non trouvés.
- Profits publiés de Wintermute, GSR, Jump, DWF : non recherchés dans cette passe.
- Mois de référence du −6,12 % et du −9,2 % de CFR : à confirmer sur la page vivante.

---

## Q6. Agents de trading IA : Alpha Arena, autres compétitions, tokens d'agents

### Takeaway
Alpha Arena, saison 1 (18/10-03/11/2025, 17 jours, 10 000 $ par modèle) : seuls Qwen3 Max (+22,3 %) et DeepSeek V3.1 (+4,89 %) ont gagné ; GPT-5 (−62,7 %), Gemini 2.5 Pro (−56,7 %), Grok 4 (−45,3 %) et Claude Sonnet 4.5 (−30,8 %) ont perdu, soit une moyenne équipondérée d'environ −28 % ([calcul personnel]). Aucun résultat public de saison 2 au 06/08/2026. Le classement TradeRank (vendeur, capital simulé) montre au 12/10/2026 qu'aucun des 22 modèles ne bat le BTC en saison 10 et que seulement 46,2 % des « modèle-saisons » sont rentables. Les tokens d'agents IA restent 70 à 90 % sous leurs plus hauts (guides de qualité moyenne).

### Cited Findings

**Alpha Arena, saison 1 [Historique]**
- Du 18/10 au 03/11/2025 (17 jours), six modèles ont tradé des perpétuels crypto avec 10 000 $ chacun, de l'argent réel, sans intervention humaine, selon un message sur X publié vers le 04/11/2025 (date déduite de l'identifiant du message, [calcul personnel]). — [iWeaver, résultats saison 1](https://www.iweaver.ai/blog/alpha-arena-ai-trading-season-1-results/) ; [X (Harshith)](https://x.com/HarshithLucky3/status/1985623428918100145)
- **Résultats rapportés :** Qwen3 Max +22,3 % (solde d'environ 12 231 $ selon une source, 12 287 $ selon une autre) ; DeepSeek V3.1 +4,89 %, seul autre gagnant ; Claude Sonnet 4.5 −30,8 % ; Grok 4 −45,3 % ; Gemini 2.5 Pro −56,7 % ; GPT-5 −62,7 %. — [GNCrypto News](https://www.gncrypto.news/news/qwen-wins-alpha-arena-season-1-with-22-percent-returns/) ; [ForkLog](https://forklog.com/en/four-out-of-six-ai-models-suffer-losses-in-trading-tournament/) ; [SCMP](https://www.scmp.com/tech/tech-trends/article/3331425/alibabas-ai-model-outperforms-us-rivals-crypto-trading-showdown) ; [iWeaver](https://www.iweaver.ai/blog/alpha-arena-ai-trading-season-1-results/)
- **Désaccords entre sources :** un autre relevé donne Claude −42,01 % et GPT-5 −58,74 % (instantané différent) ; un billet Medium classe DeepSeek premier (12 287 $) devant Qwen (10 476 $), ce qui contredit la majorité des sources (instantané antérieur ? hypothèse non vérifiée). Le classement officiel de nof1.ai n'a pas pu être consulté. — [Medium](https://medium.com/@joe_62117/what-happens-when-you-let-ai-trade-your-investment-portfolio-895d5f51b6ee)
- Selon Protos, ChatGPT, Gemini, Grok et Claude Sonnet ont fini sous les 10 000 $ de départ ; Nof1 a noté que le PnL était dominé par les coûts de trading lors des premières exécutions, les agents faisant trop de transactions. — [Protos](https://protos.com/llm-crypto-trading-contest-finds-llms-cant-trade-crypto/)
- Moyenne équipondérée des six modèles : environ −28 % avec les chiffres ci-dessus, environ −29 % avec le second jeu de chiffres ([calcul personnel]).

**Saison 1.5 et saison 2**
- Saison 1.5 (actions américaines) : Grok 4.2, modèle non annoncé, vainqueur. TradeRank la dit terminée le 03/12/2025, ForkLog décrit des échanges encore en cours le 08/12 (incohérence mineure). — [ForkLog](https://forklog.com/en/ai-model-grok-4-2-triumphs-in-trading-tournament/) ; [TradeRank](https://www.traderank.ai/blog/alpha-arena-alternatives-2026)
- Saison 2 : au 06/08/2026, aucun participant, classement ni résultat public ; la page d'accueil de nof1.ai affichait encore la saison 1.5. Nof1 avait annoncé pour la saison 2 « plus de fonctionnalités, un meilleur prompt et harnais, plus de rigueur statistique ». Des marchés de prédiction sur le vainqueur de la saison 2 existent sans résultat visible. **Aucun élément postérieur au 06/08/2026 n'a été trouvé.** — [TradeRank](https://www.traderank.ai/blog/alpha-arena-alternatives-2026) ; [Alpha Arena](https://nof1.info/) ; [Manifold](https://manifold.markets/AxelAhlqvist/which-model-wins-the-ai-trading-con) ; [Polymarket](https://polymarket.com/event/nof1ai-ai-trading-competition-winner)

**Autres compétitions et études sur les agents LLM**
- **[Vendeur/Marketing, capital simulé]** TradeRank.ai : 22 modèles, 10 000 $ simulés chacun, sur des marchés réels de crypto et d'actions américaines. Au 12/10/2026, saison 10 : meneur Hy4 Preview (Tencent) à +0,91 % ; 0 modèle sur 22 ne bat le BTC (+1,08 %) et 17 sur 22 battent le S&P 500 (+0,00 %). Classement de septembre 2026 : seulement 46,2 % des « modèle-saisons » finissent rentables. Saison 6 : 4 sièges sur 11 positifs. TradeRank signale lui-même des biais (prompt modifié, trois sièges ont changé de modèle, des transactions d'actions américaines classées dans l'archive crypto, toutes les positions liquidées à la clôture). Durée des saisons non précisée. — [TradeRank](https://www.traderank.ai/) ; [classement de septembre 2026](https://www.traderank.ai/llm-trading-benchmark) ; [saison 6](https://www.traderank.ai/blog/best-ai-models-for-crypto-trading-2026) ; [bilan](https://www.traderank.ai/llm-for-trading)
- **[Étude]** arXiv 2510.11695 (octobre 2025), « When Agents Trade: Live Multi-Market Trading Benchmark for LLM Agents » : d'après le résumé, les agents LLM peuvent trader de façon rentable en temps réel, souvent mieux que l'achat-conservation, mais aucun modèle ne domine sur tous les actifs. Préprint ; durée, coûts et part de la crypto non vus. — [arXiv](https://arxiv.org/pdf/2510.11695)
- **[Étude]** arXiv 2609.05663 (septembre 2026), « What LLM Trading Agents Actually Do in Production: A Six-Month, Population-Scale Record from Two Fleets » : 3 505 vaults financés par des utilisateurs sur Base et un système Hyperliquid, centrés sur la couche opérationnelle (prompts, curseurs, chemin d'ordre). **Les chiffres de PnL n'ont pas été vus** : c'est la piste la plus pertinente pour des rendements réels d'agents. — [arXiv](https://arxiv.org/pdf/2609.05663)
- **[Étude]** arXiv 2609.04917 (septembre 2026), « Artificial Intelligence in Equity and Crypto Markets: Progress, Profitability Evidence, and the Limits of Automated Investing » : titre seulement, contenu non vu. — [arXiv](https://arxiv.org/pdf/2609.04917)
- Recall, StockBench et autres compétitions de 2026 : non trouvés dans les résultats.

**Tokens d'agents IA en 2026 [qualité faible : guides et listes de sites]**
- **VIRTUAL :** environ 0,63 $ et 414 M$ de capitalisation mi-juillet 2026 (contre environ 5 Md$ au pic de début 2025 selon un article de mi-2026, attribution incertaine) ; d'autres pages affichent 0,87 $ pour 877,6 M$ et 0,92 $ pour 595 M$, non datées. Rapprochement avec la 1re passe (658,4 M de tokens en circulation) : 0,63 $ × 658,4 M ≈ 415 M$, cohérent ; le 877,6 M$ correspond à 1 Md × 0,878 $, donc à une valorisation entièrement diluée et non à une capitalisation ([calcul personnel]). — [Ryder](https://ryder.id/blogs/post/ai-crypto-tokens-in-2026-what-fet-tao-and-render-do) ; [Cryptonews](https://cryptonews.com/cryptocurrency/top-ai-agent-crypto/) ; [UEEx](https://blog.ueex.com/ai-tokens-in-crypto/) (attribution précise par chiffre incertaine)
- **ai16z / elizaOS :** migration du token AI16Z vers ELIZAOS au ratio 1:6 en novembre 2025 ; plus haut d'AI16Z à 2,48 $ en janvier 2025. Les estimations de baisse depuis le sommet se contredisent (99 % selon un guide ; 55 à 85 % pour l'ensemble des tokens d'agents selon un autre) : **non retenues**, d'autant que le ratio de migration impose de comparer à un plus haut ajusté. — [OpenAIToolsHub](https://www.openaitoolshub.org/en/blog/ai-agent-crypto-tokens-guide) ; [Crawlux](https://www.crawlux.com/compare/virtuals-vs-ai16z/)
- **aixbt :** capitalisation d'environ 80 à 150 M$ début avril 2026, environ 110 M$ dans un autre relevé non daté. — [Cryptonews](https://cryptonews.com/cryptocurrency/top-ai-agent-crypto/) ; [ChangeNOW](https://changenow.io/blog/best-ai-crypto-projects)
- **Secteur :** la plupart des tokens d'agents s'échangent 70 à 90 % sous leurs plus hauts début 2026 (un guide). — [CryptoWinRate](https://www.cryptowinrate.com/best-ai-agent-crypto)

**Statut des pistes de la 1re passe (Q6)**
- Détails de la saison 1 (10 000 $ par modèle ; Qwen autour de +20 % ; GPT-5 et Gemini autour de −60 %) : **confirmés** (Qwen +22,3 %, GPT-5 −62,7 %, Gemini −56,7 %), avec des écarts selon les sources.
- Saison 2 sans résultat au 06/08/2026 : **reconfirmé** ; rien de postérieur trouvé.
- Saison 1.5 gagnée par Grok 4.2 : **reconfirmé** ; le chiffre de +34,59 % n'a pas été revu.
- VIRTUAL à −84 % de son plus haut en octobre 2026 et frais de 0,62 M$ sur 30 jours : **non revérifiés** ; le prix d'environ 0,63 $ de mi-juillet est cohérent avec la 1re passe (0,739 $ le 03/05/2026).
- ai16z / elizaOS / aixbt : **comblé en partie**, sur des sources faibles.
- Autres compétitions (Recall) : **non trouvées**. « Fonds autonomes » gérés par des agents IA : **non trouvés**.

### Inferences
- La variance est extrême : de +22,3 % à −62,7 % en 17 jours, mêmes marchés, mêmes 10 000 $, une seule exécution par modèle. Le classement n'a pas valeur de hiérarchie stable : le vainqueur a changé à la saison 1.5 (Grok 4.2) et, selon TradeRank, change d'une saison à l'autre.
- La moyenne de −28 % sur 17 jours (avec levier, prompts fixés par l'organisateur) ne prouve pas qu'une IA ne peut pas gagner, mais elle ne soutient pas l'idée qu'un agent LLM livré clé en main génère un rendement positif pour un particulier. Les coûts de trading signalés par Nof1 vont dans le même sens.
- Les preuves sont contradictoires : TradeRank (moins de la moitié des « modèle-saisons » rentables, aucun modèle ne bat le BTC en saison 10) va dans le sens d'Alpha Arena, mais c'est un classement de vendeur, en capital simulé et avec des biais admis ; le préprint arXiv 2510.11695 affirme l'inverse (rentabilité fréquente, souvent au-dessus de l'achat-conservation) sans désigner de gagnant stable. L'étude de production d'arXiv 2609.05663 (3 505 vaults) serait la pièce manquante.
- L'absence de saison 2 publique au 06/08/2026 est un fait ; elle n'est pas, en soi, un indice de performance.
- Pour les tokens d'agents, les données sont de qualité trop faible pour un classement par token ; la direction (70-90 % sous les plus hauts) se retrouve dans plusieurs guides et dans la 1re passe (VIRTUAL à −84 %). Les gagnants ont donc été les émetteurs et les premiers détenteurs de la bulle de 2024-2025, pas les acheteurs de 2026.

### Gaps
- Classement final officiel de nof1.ai pour la saison 1 ; état de la saison 2 après le 06/08/2026.
- Chiffres de PnL de arXiv 2609.05663 et contenu de arXiv 2609.04917 : titres seulement.
- Recall, StockBench et autres compétitions d'agents ; « fonds autonomes » gérés par IA.
- Prix et capitalisations vérifiés d'elizaOS et d'aixbt en 2026 auprès d'un agrégateur fiable (CoinGecko, CoinMarketCap).

---

## Q7. Bots grid / DCA et trading algorithmique DIY (Pionex, 3Commas, Freqtrade, Hummingbot)

### Takeaway
Aucune étude indépendante n'a été trouvée sur les résultats réels des utilisateurs de bots grid ou DCA, ni sur les praticiens de Freqtrade ou de Hummingbot. La seule donnée chiffrée est un rapport de vendeur (Bitsgap, S1 2026) : taux de gain de 35,14 % (GRID) à 57,85 % (COMBO), 54,5 % de 26 473 bots DCA spot clôturés en gain, gain médian de +1,39 % sur un cycle d'environ 7 jours. Ce sont des statistiques de plateforme sur des bots clôturés, qui ne se traduisent pas en rendement annuel net d'un utilisateur.

### Cited Findings
- **[Vendeur/Marketing]** Rapport de Bitsgap sur les bots au S1 2026 : taux de gain de 35,14 % pour le GRID, 40,95 % pour le DCA spot, 50,92 % pour le DCA futures et 57,85 % pour le COMBO ; le rendement moyen du COMBO (15,77 %) est près de 9 fois sa médiane (1,76 %), la moyenne étant tirée par quelques valeurs extrêmes, et le rapport recommande de lire les médianes. — [Bitsgap, rapport 2026](https://bitsgap.com/blog/what-actually-worked-in-2026)
- **[Vendeur/Marketing]** Sur 26 473 bots DCA spot analysés au S1 2026, 54,5 % ont clôturé en gain ; le bot gagnant typique a rapporté une médiane de +1,39 % sur un cycle d'environ 7 jours. — [Bitsgap, bots DCA](https://bitsgap.com/blog/what-is-a-dca-bot-the-averaging-ladder-explained)
- **[Vendeur/Marketing]** Affirmations sans méthode vérifiable : le grid « 2,1 fois meilleur que le DCA » en marché sans tendance (ADX inférieur à 25) et « 1,8 fois moins bon » en marché tendanciel (ADX supérieur à 30), sur des backtests dont le jeu de données n'est pas cité ([Freya Finance](https://www.freyafinance.com/academy/strategy-guides/grid-bot-profitability-real-market-analysis)) ; grid de 15 à 25 % en marché latéral « bien configuré » ([Paybis](https://paybis.com/blog/ai-rule-based-bot-comparison/)) ; études de cas individuelles, dont un grid à 180 % APR avec un levier de 10x alors que le BTC était stable ([GoodCrypto](https://goodcrypto.app/case-study-180-apr-using-grid-bot-while-bitcoin-stayed-flat/) ; [3Commas](https://3commas.io/blog/ai-trading-bot-performance-analysis)).
- **Absences :** aucune étude indépendante du PnL réel des utilisateurs de Pionex, 3Commas, Freqtrade ou Hummingbot ; aucune donnée sur le surajustement des backtests de bots crypto ; aucun retour chiffré de praticiens (Reddit r/algotrading, GitHub). Le moteur suggère de chercher les travaux de Bailey et López de Prado sur le Sharpe dégonflé (non recherchés).

**Statut des pistes de la 1re passe (Q7)**
- « Aucune preuve indépendante des rendements nets des bots grid / DCA » : **reconfirmé** (seules des données de vendeur).
- Retours chiffrés de praticiens DIY (Freqtrade, Hummingbot) : **toujours aucun**.
- Fuite de clés API 3Commas de 2022, programme « Hummingbot Miner », barèmes de rebates maker : **non vérifiés**.

### Inferences
- Un « taux de gain » n'est pas un rendement : 45,5 % des bots DCA spot clôturés ne l'ont pas été en gain, et un gain médian de +1,39 % sur sept jours ne s'annualise pas (frais, cycles perdants, bots encore ouverts). Si les bots ouverts en perte ne sont pas comptés dans « clôturés en gain » (hypothèse : le résumé ne le précise pas), le chiffre est biaisé à la hausse.
- **Biais de survie et conflit d'intérêts :** Bitsgap vend l'outil et choisit la métrique publiée ; les places de marché de bots et les études de cas mettent en avant les meilleurs résultats ; la médiane de +1,76 % contre une moyenne de 15,77 % montre que les chiffres flatteurs sont portés par quelques bots.
- Les affirmations sur les performances du grid par régime (Freya Finance, Paybis) sont plausibles mécaniquement mais non testées publiquement ; elles restent cohérentes avec la 1re passe (le grid gagne dans un marché oscillant, le DCA suit le marché moins les frais).

### Gaps
- Études ou données indépendantes sur les résultats nets des utilisateurs de bots CEX (Pionex, 3Commas, bots natifs des bourses).
- Retours chiffrés de praticiens Freqtrade / Hummingbot ; données sur le surajustement des backtests.
- Incidents de sécurité 2025-2026 des plateformes de bots (non recherchés).

---

## Synthèse : chiffres datés de cette passe et récapitulatif du statut des pistes de la 1re passe

### Takeaway
Cette passe confirme sans l'inverser la conclusion de la 1re passe : les preuves publiques de rentabilité du trading actif, du copy-trading, des prop firms, des fonds crypto et des agents IA sont minces, souvent émises par des vendeurs, et défavorables dès qu'elles sont indépendantes ou mesurent des particuliers. Elle apporte trois ajouts utiles : les pourcentages de comptes perdants des brokers (51 à 81 %), le funding du 06/10/2026 (environ 11 %) et la trajectoire de la base CME (de 15 % à 3-5 %), et des chiffres précis pour Alpha Arena (moyenne d'environ −28 %). Les trous restants les plus importants sont le total du T3 2026 des liquidations, la base CME de septembre-octobre et une vraie mesure de 2026 de la rentabilité des particuliers.

### Cited Findings

| Sujet | Chiffre daté | Fiabilité | Source |
|---|---|---|---|
| Comptes de CFD perdants (broker) | eToro 51 % ; Plus500 76-81 % ; 74-89 % chez les grands brokers (2024-2026, résumé secondaire) | Moyenne (mentions réglementaires relayées par des comparateurs, tous CFD) | [eToro](https://www.etoro.com/customer-service/general-risk-disclosure/) ; [FXEmpire](https://www.fxempire.com/brokers/compare/etoro-vs-plus500) ; [fortraders](https://fortraders.com/blog/day-trading-profitable) |
| Wallets Hyperliquid, 30 jours (données de nov. 2024) | 16,5 % rentables, 73,8 % perdants, 9,7 % à l'équilibre | Moyenne-faible (échantillon d'un blog) | [Medium](https://medium.com/@envyprotocol/i-analyzed-10-000-hyperliquid-traders-the-results-are-brutal-a29adcca8c2a) |
| Wallets Hyperliquid cumulés | 230 sur 82 586 (≈ 0,28 %) au-dessus de 1 M$ | Faible (méthode non détaillée) | [Hyperdash](https://hyperdash.com/learn/best-tools-trading-hyperliquid) |
| Liquidations du 06/10/2026 | 555,6 M$ en 24 h, dont 487,2 M$ de longs (≈ 88 %) | Bonne (CoinGlass via The Block) | [The Block](https://www.theblock.co/news/markets/2026-10-06-bitcoin-slides-crypto-long-liquidations-surge-417882) |
| Liquidations fin août 2026 | plus de 9,7 Md$ en deux semaines, dont 6,55 Md$ de shorts | Faible (agrégateur, date non visible) | [BigGo](https://finance.biggo.com/news/938e56a0-a3ab-4100-931f-d3c14b1cbe8c) |
| Funding BTC | ≈ +10,9 % annualisé sur Hyperliquid, ≈ +11,5 % en moyenne sur 5 plateformes (6,4 % à 15,4 %) au 06/10/2026 | Moyenne (agrégateur de taux) | [defirate](https://defirate.com/perp/) |
| Base CME BTC | ≈ 15 % (fin 2024) ; ≈ 5 % (fin 2025, avril 2026) ; ≈ 3 % ou 5,7-7,9 % brut (août 2026) | Bonne à moyenne (presse spécialisée) | [CoinDesk 22/12/2025](https://www.coindesk.com/markets/2025/12/22/cme-loses-top-spot-to-binance-in-bitcoin-futures-open-interest-as-institutional-demand-wanes) ; [CoinDesk 10/08/2026](https://www.coindesk.com/markets/2026/08/10/a-rare-cme-shift-hedge-funds-abandon-structural-shorts-to-bet-on-a-bitcoin-rally) ; [CryptoSlate](https://cryptoslate.com/bitcoin-futures-carry-treasury-yield-etf-flows/) |
| sUSDe | 9,4 % (25/04/2026) ; ≈ 4,5 % (juin) ; 4,14 % (28/07/2026) | Moyenne (agrégateurs DeFi) | [eco.com](https://eco.com/support/en/articles/14798653-susde-explained-ethena-s-yield-bearing-stablecoin) ; [Aavescan](https://aavescan.com/rates/ethena-susde) |
| Copy-trading | 48,48 % de copieurs rentables, ≈ 97 % de traders copiés positifs (90 jours, fin 2025) | Faible (étude d'un vendeur) | [KuCoin](https://www.kucoin.com/blog/is-crypto-copytrading-profitable-in-2026) |
| Prop firms | 14 % de réussite, 7 % de payés (sept. 2024) ; 115,1 M$ de paiements crypto au T1 2026 (+108,9 % sur un an) | Moyenne | [Prop Firm Backtester](https://www.propfirmbacktester.com/prop-firm-statistics) ; [FM Datalab](https://datalab.financemagnates.com/market-insights/tracked-prop-firm-crypto-payouts-doubled-to-115m-in-q1-2026) |
| Kraken-Breakout | Début septembre 2025, prix non divulgué | Bonne (plusieurs sources concordantes) | [Finance Magnates](https://www.financemagnates.com/cryptocurrency/krakens-breakout-bet-could-normalize-prop-trading-across-the-crypto-industry/) |
| Fonds crypto 2025 | Moyenne −7,2 %, médiane −5,2 %, 37 % positifs ; indice −1,64 % | Moyenne (déclaration volontaire) | [CFR](https://cryptofundresearch.com/crypto-hedge-fund-performance/) |
| Fonds crypto 2026 à ce jour | −6,12 % ou −9,2 % (CFR, mois non résolu) ; hedge funds classiques +6,25 à +7,57 % | Moyenne ; tiers pour HFRI | [CFR](https://cryptofundresearch.com/cfr-crypto-fund-index/) ; [Crystal Funds](https://www.crystalfunds.com/insights/2026-july-hf-industry-report/) |
| Alpha Arena S1 (17 jours, 10 000 $) | Qwen3 Max +22,3 % ; DeepSeek +4,89 % ; Claude −30,8 % ; Grok 4 −45,3 % ; Gemini −56,7 % ; GPT-5 −62,7 % ; moyenne ≈ −28 % | Moyenne (concordance des sources, désaccords de détail) | [GNCrypto](https://www.gncrypto.news/news/qwen-wins-alpha-arena-season-1-with-22-percent-returns/) ; [iWeaver](https://www.iweaver.ai/blog/alpha-arena-ai-trading-season-1-results/) |
| TradeRank (capital simulé) | 46,2 % de « modèle-saisons » rentables ; 0 modèle sur 22 bat le BTC en saison 10 (12/10/2026) | Faible (vendeur, biais admis) | [TradeRank](https://www.traderank.ai/llm-trading-benchmark) |
| Bots Bitsgap S1 2026 | Taux de gain 35,14 % (GRID) à 57,85 % (COMBO) ; 54,5 % de bots DCA clôturés en gain, médiane +1,39 % sur ≈ 7 jours | Faible (vendeur) | [Bitsgap](https://bitsgap.com/blog/what-actually-worked-in-2026) |
| VIRTUAL | ≈ 0,63 $ (≈ 414 M$) mi-juillet 2026 | Faible (guides) | [Ryder](https://ryder.id/blogs/post/ai-crypto-tokens-in-2026-what-fet-tao-and-render-do) |

### Inferences
- **Qui gagne, d'après les deux passes :** les plateformes et teneurs de marché qui prélèvent des frais et des écarts (1re passe : 429 M$ de revenus pour Hyperliquid de janvier à mi-septembre 2026), les vendeurs d'outils et d'évaluations (frais de challenge des prop firms, abonnements de bots, copy-trading rémunéré) et une très petite queue de très gros comptes. Les particuliers perdent majoritairement (51 à 89 % selon la mesure), les fonds crypto professionnels sont négatifs en 2025 et 2026 à ce jour, et les agents IA ne montrent pas d'avantage durable.
- **Biais de survie à rappeler partout :** classements de wallets (seuils élevés), lead traders et ROI de bots (seuls les meilleurs sont visibles), indices de fonds (déclaration volontaire), compétitions d'IA (une seule exécution, résultats publiés par l'organisateur), marketing des prop firms (seuls les paiements sont publiés).
- **Portage delta-neutre :** à 3-5 % net sur la base CME et 4-5 % pour sUSDe, il rapporte à peine plus que les bons du Trésor ; le funding de 6 à 15 % brut début octobre est volatil et brut de tous coûts.

### Gaps
- Mesure directe de 2025-2026 de la rentabilité des particuliers en crypto (aucune étude trouvée).
- Total du T3 2026 des liquidations ; base CME de septembre-octobre 2026 ; funding Binance d'octobre 2026 ; sUSDe de fin septembre 2026 revérifié.
- PnL réels d'agents IA en production (arXiv 2609.05663) ; classement officiel de nof1.ai ; profits de market makers ; rendements nets d'utilisateurs de bots CEX et de praticiens DIY.

**Récapitulatif du statut des pistes de la 1re passe (fichiers 03 et 04)**

| Piste de la 1re passe | Statut | Remarque |
|---|---|---|
| Échantillon Hyperliquid 16,5 % / 73,8 % (envyprotocol) | Confirmé | Publication en janvier 2026 ; données de novembre 2024 |
| 82 586 wallets / 230 à plus de 1 M$ (« Buildix ») | Corrigé | Attribution probable à Hyperdash |
| Seuils du classement Hyperliquid | Confirmé | 100 000 USDC et 10 M USDC |
| Étude Dropstab (247 000 wallets) ; CoinDuck contre classement officiel | Non vérifié | Non retrouvés |
| Hyperliquid Policy Center / MiCA (fintelegram) | Non vérifié | Non recherché |
| Kogan et al. (2023) | Identifié, non lu | Probablement NBER w31317 (données eToro) |
| AMF 2014 (89 %) | Confirmé, nuancé | Forex et CFD non séparés, options binaires incluses pour une partie |
| Simulation 125x (98,32 %) | Confirmé | Simulation |
| 1,8 Md$ le 02/06/2026 | Contradiction non résolue | Record S1 de CoinGlass : 31/01 (2,588 Md$) |
| 1,19 Md$ les 8-9/10/2026 (CoinCentral) | Non vérifié | The Block : 555,6 M$ le 06/10 |
| CME « plus bas depuis février 2024 » | Contradiction en faveur du titre (« 14 mois », soit février 2025) | Non résolu sans l'article |
| Base CME 3 % (CoinDesk) contre 5,69-7,89 % (CryptoSlate) | Confirmés comme deux mesures | Écart de méthode probable |
| Funding 0,0067 % par 8 h au 30/09 | Non revérifié | Relevés ultérieurs : 0,01 % (08/10), 10,9 % annualisé sur Hyperliquid (06/10) |
| Funding Binance ≈ 4,4 % APY | Confirmé comme relevé d'environ début juillet | Page d'environ 98 jours |
| sUSDe 9,4 % en avril ; 7,1 % en juin | 9,4 % confirmé (eco.com) ; 7,1 % non confirmé | CoinMarketCap : ≈ 4,5 % en juin |
| sUSDe 4,14 % le 28/07 (Aave) | Confirmé | Dépôts −9 % |
| sUSDe 4,76 % fin septembre ; offre d'USDe 4,95 Md$ ; réserve de 61 M$ | Non vérifié | Non retrouvés |
| YieldFund 48,48 % / 97 % | Confirmé | Date : fin 2025 selon KuCoin |
| FPFX 14 % / 7 % / 4 % | Confirmé | Datation incertaine (sept. 2024) |
| 115,1 M$ de paiements crypto au T1 2026 | Confirmé | +108,9 % sur un an |
| Date de rachat de Breakout | Corrigé | Début septembre 2025 ; prix non divulgué ; « 2024 » est faux |
| « Plus de 60 M$ versés » par Breakout ; 60 % de copieurs gagnants | Non vérifié | Toujours sans source |
| CFR −6,12 % en 2026 | Non résolu | Autre page : −9,2 % |
| CFR 2025 par stratégie (quants +0,4 %) | Non revérifié | Nouveau : moyenne −7,2 %, médiane −5,2 %, 37 % positifs |
| Market-neutral à deux chiffres (SQ Magazine, TV-Hub) | Toujours sans source | SQ Magazine ajoute +36 % |
| Wintermute, GSR, Owler | Non vérifié | Non recherché |
| Alpha Arena S1 (10 000 $ ; Qwen ≈ +20 % ; GPT-5 et Gemini ≈ −60 %) | Confirmé | Chiffres précis ci-dessus |
| Alpha Arena S2 sans résultat au 06/08/2026 | Reconfirmé | Rien de postérieur |
| VIRTUAL −84 % ; frais 0,62 M$ sur 30 jours | Non revérifié | Prix de mi-juillet cohérent |
| ai16z / elizaOS / aixbt | Comblé en partie | Sources faibles (guides) |
| Bots grid / DCA : aucune preuve indépendante | Reconfirmé | Seul un rapport de vendeur (Bitsgap) |
| DIY (Freqtrade, Hummingbot) : aucun retour chiffré | Toujours aucun | |
| 3Commas (2022), Banana Gun, Hummingbot Miner, CEX-DEX | Non vérifié | Non recherchés |

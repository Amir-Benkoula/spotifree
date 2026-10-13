# Revenus de l'infrastructure crypto en 2026 : minage Bitcoin, autres PoW, validateurs/nœuds, DePIN (état au 13 octobre 2026)

> **Avertissement de collecte (à lire avant d'utiliser ces notes).** Le 13/10/2026, l'outil WebFetch a échoué sur tous les domaines testés : erreur DNS `ENOTFOUND`, y compris sec.gov et wikipedia.org. L'accès HTTP direct est par ailleurs refusé par le proxy de sortie (403). **Tous les chiffres ci-dessous proviennent donc d'extraits de résultats WebSearch** (mode « extended », 15 requêtes abouties) et non de la lecture intégrale des pages. Ils sont fidèles aux extraits mais n'ont pas pu être recoupés avec le document source complet. Le **budget partagé de recherches web** de ce tour (200 requêtes pour l'ensemble des agents) a ensuite été épuisé.
> **Conséquence :**
> - Les questions 1 (économie du minage Bitcoin, cas français) et 2 (mineurs cotés et pivot IA/HPC) sont documentées.
> - Les questions 3 (autres PoW), 4 (validateurs), 5 (DePIN) et 6 (arnaques cloud mining / AMF) **n'ont PAS pu être documentées avec des sources 2026**. Elles ne contiennent que des pistes marquées « NON VÉRIFIÉ », à ne pas présenter comme des faits.
>
> Pour les compléter : relancer une passe de recherche (message de suivi, ou relever `CLAUDE_CODE_MAX_WEB_SEARCHES_PER_SESSION`).
>
> Les calculs (marqués **CALCUL**) n'utilisent que des entrées sourcées ci-dessous ; les hypothèses non sourcées sont signalées.

## 1. Économie du minage Bitcoin en 2026 : hashrate, difficulté, hashprice, part des frais, coût de production, rentabilité par génération d'ASIC, cas d'un foyer français (tarif bleu EDF)

### Takeaway
2026 est une année de compression des marges :
- le hashprice a touché un plus bas historique en juin 2026 (moyenne mensuelle de 27,7 $/PH/jour, CoinShares), puis il est remonté vers ~40 $/PH/jour début octobre (Hashrate Index) ;
- les frais de transaction ne pèsent qu'environ 1 % des revenus ;
- le coût cash moyen des mineurs cotés était d'environ 75 500 $/BTC au T2 2026, et le secteur coté est passé sous son seuil de rentabilité cash en agrégé.

Seuls les opérateurs industriels payant ≤ 0,04–0,05 $/kWh avec des machines récentes (< 15 J/TH) dégagent une marge cash. Pour un particulier français au tarif bleu (0,2001 €/kWh TTC depuis le 1/08/2026), **même la machine la plus efficace (S23 Hydro, 9,5 J/TH) coûte plus cher en électricité qu'elle ne rapporte (CALCUL)**, avant même l'achat du matériel.

### Cited Findings

**Hashprice (revenu par unité de calcul, $/PH/s/jour)**
- **Juin 2026 :** moyenne mensuelle de **27,7 $/PH/s/jour, plus bas historique**. Le hashrate était ~50 % sous sa tendance. CoinShares attribue la situation à la flambée des prix de l'électricité au Texas en début d'année et au basculement des mineurs vers le calcul haute performance pour l'IA — [CoinShares, Bitcoin Mining Report Q2 2026 (publié au T3 2026, date exacte non vérifiée)](https://coinshares.com/corp/insights/research-data/bitcoin-mining-report-q2-2026/). Repris par [KuCoin News (« hash price hits 5-year low, 20% of old miners in loss »)](https://www.kucoin.com/news/flash/coinshares-bitcoin-mining-report-hash-price-hits-5-year-low-20-of-old-miners-in-loss).
- **Fin juin à début octobre 2026 :** hashprice tombé à ~27,70 $/PH/jour fin juin (« one of the lowest daily readings in five years »), revenu à **~40 $/PH/jour la première semaine d'octobre 2026** (≈ +50 %), selon les données Hashrate Index (Luxor) — [hoge.gg, « Hashprice in 2026: The Ceiling Is the Network, Not the Price » (début oct. 2026)](https://hoge.gg/hashprice-2026-difficulty-ceiling-miner-recovery/).
- **Points intermédiaires :**
  - 51,76 $/PH/jour mi-avril 2026 (contexte, ~6 mois) — [Hashrate Index Roundup, 13/04/2026](https://hashrateindex.com/blog/hashrate-index-roundup-april-13-2026/) ;
  - 36 $/PH/jour fin mai 2026 — [Hashrate Index Roundup, 25/05/2026](https://hashrateindex.com/blog/hashrate-index-roundup-may-25-2026/) ;
  - ~33,34 $ mi-juillet 2026, avec un plancher mi-juin vers 27–28 $ — [Axis Intelligence, Bitcoin Mining Statistics 2026](https://axis-intelligence.com/bitcoin-mining-statistics/).
- **7 septembre 2026 :** 39,63 $/PH/jour (+22 % sur un mois), BTC ~79 150 $, hashrate ~932–934 EH/s — [Bitcoin.com News, « Difficulty Rises, Hashprice Rips 22% as Bitcoin Hashrate Stalls »](https://news.bitcoin.com/mining/difficulty-rises-hashprice-rips-22-as-bitcoin-hashrate-stalls/). L'attribution est déduite de la concordance titre/extrait.
- **Fin Q3 2026 :** hashprice « coincé près des plus bas historiques, dans le bas de la fourchette des 30 $ » pendant le trimestre, ce qui pousse les vieilles machines hors ligne — [Hashrate Index, Global Hashrate Heatmap Update: Q3 2026](https://hashrateindex.com/blog/global-hashrate-heatmap-update-q3-2026/).
- **Prix du BTC :** rebond d'environ 58 000 $ en juillet 2026 à plus de 83 000 $ début octobre 2026 — [hoge.gg (début oct. 2026)](https://hoge.gg/hashprice-2026-difficulty-ceiling-miner-recovery/). Le cours au 13/10/2026 n'a pas pu être vérifié (voir Gaps).
- **Projections :** Hashrate Index a publié son « Q3 2026 Projection Report » le 3/08/2026 (scénarios de hashrate, difficulté et hashprice issus du modèle offre/demande de Luxor) — [Hashrate Index](https://hashrateindex.com/blog/author/hashrate_index/). Contenu non lu.

**Hashrate et difficulté**
- **Q3 2026 :** hashrate moyen **~940 EH/s, −6,3 % sur un trimestre**. C'est le **deuxième recul trimestriel consécutif**, environ −12 % sous le pic de ~1 066 EH/s de décembre 2025. Hashrate Index l'attribue surtout à l'économie : hashprice bas et machines anciennes débranchées — [Hashrate Index, Heatmap Q3 2026](https://hashrateindex.com/blog/global-hashrate-heatmap-update-q3-2026/) ; repris par [hoge.gg, « Bitcoin's Hashrate Shrinks Again as Q3 Redraws the Map »](https://hoge.gg/bitcoin-hashrate-q3-2026-shrinking-network-map/).
- **Ajustement du 19/09/2026 :** difficulté portée à **132,76 T (+4,16 %)**, plus forte hausse depuis juin — [hoge.gg (Q3 2026)](https://hoge.gg/bitcoin-hashrate-q3-2026-shrinking-network-map/).
- **Mesures ponctuelles d'octobre :**
  - ~971 EH/s et difficulté de 132,72 T au 12/10/2026 (bloc ~971 146) — [CoinWarz, hashrate](https://www.coinwarz.com/bitcoin-hashrate) ; [CoinWarz, difficulté](https://www.coinwarz.com/bitcoin-difficulty). Prudence : la série quotidienne de CoinWarz oscille de façon peu plausible entre 0,9 et 1,18 ZH/s début octobre (estimation à partir du temps de bloc).
  - 987,8 EH/s et difficulté de 132,7 T au 09/10/2026 — [Cryptohall24](https://www.cryptohall24.com/en/mining/bitcoin-netzwerk-hashrate).
- **Trajectoire selon CoinShares :** pic ~1 160 EH/s début octobre 2025, ~850 EH/s début février 2026, puis remontée vers ~1 020 EH/s. CoinShares projetait auparavant ~1,8 ZH/s fin 2026 — [The Block, 26/03/2026 (contexte)](https://www.theblock.co/news/business/2026-03-26-bitcoin-miners-face-breakeven-pressure-as-ai-pivot-accelerates-coinshares-says-395259) ; [CoinMarketCap Academy](https://coinmarketcap.com/academy/article/bitcoin-miners-face-breakeven-pressure-as-ai-pivot-accelerates).
  - **Conflit de mesures :** le pic est de 1 160 EH/s (oct. 2025) chez CoinShares contre 1 066 EH/s (déc. 2025) chez Hashrate Index, probablement à cause de lissages différents.
  - **Autre conflit :** [24/7 Wall St (13/08/2026)](https://247wallst.com/investing/cryptocurrency/2026/08/13/what-happens-to-bitcoin-when-the-block-rewards-run-out/) évoque −33 % de puissance de calcul depuis octobre 2025, nettement plus que les −12 % de Hashrate Index.
- **Février 2026 (historique) :** difficulté +15 %, plus forte hausse depuis 2021 malgré la baisse du prix — [CoinDesk, 20/02/2026 (titre)](https://www.coindesk.com/markets/2026/02/20/bitcoin-difficulty-jumps-15-largest-increase-since-2021-despite-price-slump).

**Part des frais dans la récompense de bloc**
- La subvention reste de **3,125 BTC par bloc** depuis le halving d'avril 2024 — [LBank, « Bitcoin Block Reward 2026: 3.125 BTC »](https://www.lbank.com/explore/bitcoin-mining-2025-supply-security-market-trend).
- Les frais de transaction sont tombés à **0,69 % des revenus des mineurs, plus bas depuis 10 ans** : environ 1 000 $ de frais par bloc contre ~200 000 $ de récompense — [24/7 Wall St, 13/08/2026](https://247wallst.com/investing/cryptocurrency/2026/08/13/what-happens-to-bitcoin-when-the-block-rewards-run-out/). Source unique, non recoupée.
- **Contraste historique :** pendant le lancement de Runes (avril 2024), une journée a généré ~80 M$ de frais contre ~26 M$ de subvention — [ViaBTC](https://www.viabtc.com/en/blog/Mining-bitcoin-mining-rewards-explained-block-subsidy-vs-transaction-fees-648). L'attribution à ViaBTC est incertaine : le chiffre provient d'un extrait de recherche multi-sources. C'est un contexte historique, non essentiel.

**Coût de production par BTC (mineurs cotés)**
- **T2 2026 :** coût cash moyen pondéré (hors impôts) de **~75 500 $/BTC** pour les mineurs cotés. La fourchette va de 871 $/BTC (ABTC) à 134 446 $/BTC (WULF) ; le chiffre de WULF est faussé par une production réduite à 179 BTC. **Le secteur coté est passé sous le seuil de rentabilité cash en agrégé** — [CoinShares Q2 2026](https://coinshares.com/corp/insights/research-data/bitcoin-mining-report-q2-2026/) ; [version alternative de l'URL](https://coinshares.com/insights/research-data/bitcoin-mining-report-q2-2026/).
- **T4 2025 (historique) :** coût cash moyen pondéré de ~79 995 $/BTC — [CoinShares Q1 2026](https://coinshares.com/insights/research-data/bitcoin-mining-report-q1-2026/) ; [ETFdb/CoinShares, « Bitcoin Miners Face Tightest Profit Squeeze in 2 Years »](https://etfdb.com/coinshares-crypto-etf-hub/coinshares-channel/bitcoin-miners-face-tightest-profit-squeeze-2-years/). Une source secondaire donne 79 995–90 000 $ pour le T1 2026, ce qui est incohérent : à écarter.
- **Écart cash / tout compris (exemple CleanSpark) :** coût tout compris (amortissements et charges non cash) de 135 691 $/BTC contre 70 452 $/BTC en cash. Le trimestre n'est pas précisé dans l'extrait — [CoinShares (extraits de couverture)](https://coinshares.com/insights/research-data/bitcoin-mining-report-q2-2026/). En avril 2025 (historique), CoinShares estimait déjà le coût tout compris à ~137 000 $/BTC — [Benzinga, 04/2025](https://www.benzinga.com/markets/cryptocurrency/25/04/45017261/bitcoin-mining-costs-jump-to-137000-per-coin-when-accounting-for-non-cash-expenses-coinshares).
- **MARA, T2 2026 :** coût d'énergie achetée de 38 690 $ par BTC (contre 33 735 $ un an plus tôt), coût par PH/jour de 27,7 $, électricité sur sites propres à 0,04 $/kWh — [Investing.com, slides MARA Q2 2026](https://www.investing.com/news/company-news/mara-q2-2026-slides-digital-infrastructure-pivot-amid-mining-losses-93CH-4844908) ; [MARA Q2 2026 Shareholder Letter](https://ml.globenewswire.com/Resource/Download/20012703-ca39-4465-acd3-cbd840a78e46).

**Rentabilité par génération d'ASIC**
- **Seuils CoinShares :** les machines de milieu de gamme ont besoin d'une électricité **< 0,05 $/kWh** pour rester cash-flow positives, alors que les modèles récents (< 15 J/TH) gardent des marges substantielles — [The Block, 26/03/2026](https://www.theblock.co/news/business/2026-03-26-bitcoin-miners-face-breakeven-pressure-as-ai-pivot-accelerates-coinshares-says-395259). Le prix d'électricité d'équilibre du S19 XP est passé de ~0,12 $/kWh (déc. 2024) à ~0,077 $/kWh (déc. 2025, historique) — [CoinShares, via la même couverture](https://coinmarketcap.com/academy/article/bitcoin-miners-face-breakeven-pressure-as-ai-pivot-accelerates).
- **Part du parc non rentable :** « jusqu'à 20 % des mineurs non rentables » ; « 20 % des anciennes machines en perte » — [Cointelegraph via TradingView](https://www.tradingview.com/news/cointelegraph:366577b2c094b:0-coinshares-says-up-to-20-of-bitcoin-miners-are-unprofitable/) ; [KuCoin News](https://www.kucoin.com/news/flash/coinshares-bitcoin-mining-report-hash-price-hits-5-year-low-20-of-old-miners-in-loss). Date 2026 exacte non précisée.
- **Antminer S23 Hydro :** ~**580 TH/s** (certaines fiches indiquent 563 ou 578 TH/s), **9,5 J/TH**, premier modèle phare Bitmain sous 10 J/TH — [OneMiners, revue S23 Hydro](https://oneminers.com/blogs/news/antminer-s23-hydro-review-580-th-s-9-5-j-th-power-use-mining-profitability-2026) ; [SimpleMining](https://www.simplemining.io/insights/post/antminer-s23-hydro-review).
  - Prix affichés très divergents : ~5 500 $ ([MillionMiner, comparatif](https://millionminer.com/news/antminer-s23-hydro-vs-s21-xp-comparison)), ~12 299 $ ([OneMiners, « upgrade math »](https://oneminers.com/blogs/news/antminer-s23-vs-s21-xp-upgrade-math-2026)), ~14 890 $ ([MillionMiner](https://millionminer.com/news/antminer-s21-xp-hydro-review)).
  - Ces sources sont des blogs de revendeurs (conflit d'intérêts) et les dates varient.
- **Antminer S21 XP Hydro :** **473 TH/s, 12 J/TH**, prix indiqué 9 500–11 500 $ par une source — [MillionMiner](https://millionminer.com/news/antminer-s21-xp-hydro-review) ; [SimpleMining](https://www.simplemining.io/insights/post/antminer-s23-hydro-review).
- **Antminer S21 XP (refroidi par air) :** **270 TH/s, 13,5 J/TH** — [MillionMiner, comparatif](https://millionminer.com/news/antminer-s23-hydro-vs-s21-xp-comparison).

**Électricité en France : tarif bleu EDF (TRVE), grille au 1er août 2026**
- **Option Base, 3 et 6 kVA :** **0,2001 €/kWh TTC**, contre 0,1940 € auparavant (+3,1 %) — [Selectra](https://selectra.info/energie/fournisseurs/edf/tarifs-reglementes) ; [Kelwatt, « Tarif Bleu EDF réglementé officiel du 1er août 2026 »](https://www.kelwatt.fr/actu/tarif-edf-reglemente-1er-aout-2026) ; [Fournisseurs-Électricité.com](https://www.fournisseurs-electricite.com/fournisseurs/edf/tarifs/bleu-reglemente).
  - Au-delà de 6 kVA (contrats existants) : 0,1985 €/kWh TTC.
  - Selon Selectra, l'option Base de 9 à 36 kVA n'est plus ouverte aux nouvelles souscriptions. La même page contient une incohérence (elle affirme que la Base 6 kVA n'est pas proposée tout en l'incluant dans sa grille).
- **Abonnement Base 6 kVA :** **190,81 €/an (15,90 €/mois)**, grille en vigueur au 2/10/2026 — [Comparons l'énergie](https://www.comparonslenergie.com/prix/tarif-bleu/). Une autre source indique 190,32 €/an.
- **Option Heures Creuses, 6 kVA :** heures pleines **0,2142 €/kWh**, heures creuses **0,1589 €/kWh**, abonnement 15,86 €/mois — [Comparons l'énergie](https://www.comparonslenergie.com/prix/tarif-bleu/).
- **Ampleur de la hausse d'août 2026 :** +2,5 % TTC en moyenne sur la facture selon [Comparons l'énergie](https://www.comparonslenergie.com/prix/tarif-bleu/), ~+3 % sur le kWh selon [Kelwatt](https://www.kelwatt.fr/actu/tarif-edf-reglemente-1er-aout-2026) et [Sunethic](https://www.sunethic.fr/tarif-abonnement-electricite-le-comparatif-en-2026-sunethic/).

### Inferences

**CALCUL 1 : prix d'électricité d'équilibre (cash, hors achat de la machine, hors frais de pool)**

Formule : prix d'équilibre ($/kWh) = hashprice ($/PH/jour) ÷ (J/TH × 24). Spécifications et hashprices issus des sources ci-dessus.

| Machine | Puissance (W) | kWh/jour | Revenu brut/jour à 40 $/PH (début oct. 2026) | Équilibre à 40 $/PH | Équilibre à 27,7 $/PH (juin 2026) | Équilibre à 51,76 $/PH (avril 2026) |
|---|---|---|---|---|---|---|
| S23 Hydro (580 TH/s ; 9,5 J/TH) | 5 510 | 132,2 | 23,20 $ | 0,175 $/kWh | 0,122 $/kWh | 0,227 $/kWh |
| S21 XP Hydro (473 TH/s ; 12 J/TH) | 5 676 | 136,2 | 18,92 $ | 0,139 $/kWh | 0,096 $/kWh | 0,180 $/kWh |
| S21 XP air (270 TH/s ; 13,5 J/TH) | 3 645 | 87,5 | 10,80 $ | 0,124 $/kWh | 0,086 $/kWh | 0,160 $/kWh |

**CALCUL 2 : particulier français au tarif bleu Base (0,2001 €/kWh TTC, 6 kVA)**

| Machine | Coût électrique/jour | Coût électrique/an | Hashprice nécessaire pour couvrir la seule électricité | Taux EUR/USD maximal pour l'équilibre à 40 $/PH |
|---|---|---|---|---|
| S23 Hydro | 26,46 € (contre 23,20 $ de revenu) | 9 658 € | 45,6 €/PH/jour | 0,877 |
| S21 XP Hydro | 27,26 € (contre 18,92 $ de revenu) | 9 949 € | 57,6 €/PH/jour | 0,694 |
| S21 XP air | 17,50 € (contre 10,80 $ de revenu) | 6 389 € | 64,8 €/PH/jour | 0,617 |

- **Lecture :** au hashprice de début octobre 2026, même la meilleure machine perd de l'argent sur la seule électricité **dès que 1 € vaut plus de 0,877 $**. Le taux EUR/USD d'octobre 2026 n'a pas pu être vérifié (voir Gaps), mais la conclusion vaut pour tout taux supérieur à 0,877.
  - Au hashprice record d'avril 2026 (51,76 $), le S23 Hydro n'aurait été à l'équilibre électrique que pour un EUR/USD ≤ 1,135.
  - Au plancher de juin (27,7 $), il aurait fallu un EUR/USD ≤ 0,607.
- **Ce qui s'ajoute aux pertes :** achat de la machine (5 500 à 14 890 $ selon les annonces), frais de pool, installation de refroidissement liquide (modèles « Hydro »), abonnement.
- **Option heures creuses :** un mix de 8 h en HC (0,1589 €) et 16 h en HP (0,2142 €) donne ~25,89 €/jour pour le S23 Hydro, contre 26,46 € en Base. Gain négligeable. La durée de 8 h de HC par jour est une hypothèse non sourcée ici.
- **Contrainte de puissance :** un S23 Hydro (5,5 kW) ou un S21 XP Hydro (5,7 kW) sature presque à lui seul un abonnement de 6 kVA. Passer à 9 kVA ou plus imposerait l'option HC ou une offre de marché si la Base 9–36 kVA est bien fermée aux nouveaux clients (Selectra).
- **Conclusion pour un particulier français :** au tarif réglementé, le minage Bitcoin à domicile n'est pas rentable en octobre 2026, même en ignorant l'amortissement du matériel. Seule une électricité quasi gratuite pourrait changer l'équation (surplus solaire non valorisé, chaleur réutilisée qui remplace un chauffage). Cette piste n'a pas pu être documentée.

**CALCUL 3 : opérateur industriel (marge cash par machine et par jour, hashprice constant)**

| Prix de l'électricité | S23 Hydro (40 $ / 27,7 $) | S21 XP Hydro (40 $ / 27,7 $) | S21 XP air (40 $ / 27,7 $) |
|---|---|---|---|
| 0,04 $/kWh (coût des sites propres de MARA au T2 2026) | 17,91 $ / 10,78 $ | 13,47 $ / 7,65 $ | 7,30 $ / 3,98 $ |
| 0,05 $/kWh (seuil cité par CoinShares) | 16,59 $ / 9,45 $ | 12,11 $ / 6,29 $ | 6,43 $ / 3,10 $ |
| 0,07 $/kWh | 13,94 $ / 6,81 $ | 9,38 $ / 3,57 $ | 4,68 $ / 1,36 $ |

- **Part de l'électricité dans le revenu :** 23 % (S23 Hydro, 0,04 $, 40 $/PH) à 82 % (S21 XP air, 0,07 $, 27,7 $/PH).
- **Retour sur investissement simple (S23 Hydro, 0,04 $/kWh, hashprice constant à 40 $) :** 0,84 an à 5 500 $, **1,88 an à 12 299 $**, 2,28 ans à 14 890 $. Pour le S21 XP Hydro à 9 500–11 500 $ : 1,9 à 2,3 ans.
  - Ces chiffres excluent : frais de pool, infrastructure (refroidissement, transformateurs, bâtiment), maintenance, arrêts, hausse de la difficulté et impôts.
- **Effet du prochain halving :**
  - Il reste 1 050 000 − 971 146 = 78 854 blocs au 12/10/2026 (hauteur CoinWarz), soit **~548 jours, donc un halving vers mi-avril 2028** à 10 minutes par bloc. La subvention passera alors à 1,5625 BTC.
  - Si le revenu par TH est divisé par deux à cette date (prix du BTC et hashrate inchangés), le retour sur investissement d'un S23 Hydro à 12 299 $ passe de 1,88 an à ~2,6 ans.
- **Pour qui c'est rentable :**
  - Rentable en cash : uniquement les industriels avec une électricité ≤ ~0,05 $/kWh et des machines de dernière génération. C'est cohérent avec le seuil de CoinShares.
  - Non rentable : le tarif résidentiel français, ainsi que les machines anciennes (S19 XP déjà à l'équilibre vers 0,077 $/kWh fin 2025, avant le creux de juin 2026).
- **Mineurs cotés :** leur coût cash moyen (~75 500 $/BTC au T2 2026) était supérieur au BTC de juillet (~58 000 $). Il est un peu inférieur à celui de début octobre (> 83 000 $), mais très loin du coût tout compris : environ ×2 sur l'exemple CleanSpark (135 691 $ contre 70 452 $). La rentabilité actionnariale dépend donc de la hausse du BTC ou de la diversification, pas du minage seul.
- **Revenus tirés de la subvention :** les frais ne représentant que ~0,7–1 % du revenu, le revenu des mineurs dépend quasi entièrement de la subvention, donc du prix du BTC et du hashrate concurrent. Il n'existe pas de « coussin » de frais avant le halving de 2028.
- **Hashrate en recul :** les deux reculs trimestriels consécutifs (Hashrate Index) suggèrent que le réseau ne grossit plus mécaniquement. Une partie de la puissance électrique part vers l'IA (voir §2), ce qui soutient le hashprice des mineurs restants. La projection CoinShares de 1,8 ZH/s fin 2026 ne se réalise manifestement pas (~0,94–0,99 ZH/s en octobre).

### Gaps
- **Prix du BTC au 13/10/2026 et taux EUR/USD d'octobre 2026 :** non vérifiés (budget de recherche épuisé). Les calculs en euros sont présentés sous forme de seuil EUR/USD pour rester valides.
- **Hashprice exact au 13/10/2026 :** non vérifié. Le dernier point sourcé est « ~40 $ la première semaine d'octobre ».
- **Part des frais :** source unique (24/7 Wall St, août 2026). Aucune moyenne multi-semaines (mempool.space, Glassnode) n'a pu être consultée.
- **Tableau CoinShares Q2 2026 par entreprise** (coûts cash et tout compris de chaque mineur, parc par génération, seuils S21/S23) : non lu en entier. Le trimestre de l'exemple CleanSpark (135 691 $ / 70 452 $) n'est pas précisé.
- **Spécifications et prix sourcés manquants :** S21 « standard », S19 XP et autres générations. Les prix du S23 Hydro sont incohérents entre revendeurs. Les taux de frais de pool (FPPS/PPLNS) ne sont pas quantifiés.
- **Contexte français non documenté :**
  - minage à petite échelle (« lottery mining » type Bitaxe, chauffage par minage, surplus photovoltaïque) ;
  - régime fiscal des revenus de minage (BNC) ;
  - position de la CRE ou du gestionnaire de réseau sur les usages de minage domestique.

## 2. Mineurs cotés : résultats 2025–2026, stratégie et pivot vers les data centers IA/HPC

### Takeaway
Au T2 2026, les grands mineurs cotés ont publié de lourdes pertes comptables, en grande partie non cash (juste valeur des BTC, bons de souscription, dépréciations). Leurs revenus de minage ont reculé et le secteur est passé sous le seuil cash en agrégé.

La valeur stratégique s'est déplacée vers leurs sites et leur électricité, loués à des clients IA/HPC sur 10 à 20 ans : Microsoft (IREN), AWS (Cipher), Fluidstack adossé à Google (TeraWulf, Cipher), Anthropic (TeraWulf), CoreWeave et AMD (Core Scientific). Keel (ex-Bitfarms) a totalement arrêté le minage, et Bitdeer démonte des machines pour faire de la place à l'IA.

CoinShares souligne que l'IA rapporte davantage par MW que le minage, mais la conversion reste lente : plus de 100 Md$ de carnet de commandes annoncé ne produisent encore qu'environ 1,1 Md$ de revenus annualisés.

### Cited Findings

**Vue sectorielle**
- **Constats du rapport T2 2026 de CoinShares :**
  - plus de **100 Md$ de carnet de commandes IA/HPC annoncé** ne soutiennent qu'environ **1,1 Md$ de revenus IA/HPC annualisés** ;
  - l'IA est actuellement plus rentable par MW que le minage ;
  - les mineurs disposant de capacités IA sous contrat se négocient avec une prime ;
  - le secteur coté est passé sous le seuil cash en agrégé.

  Sources : [CoinShares Q2 2026](https://coinshares.com/corp/insights/research-data/bitcoin-mining-report-q2-2026/) ; [KuCoin News, « Bitcoin mining fails to turn a profit as AI revenue grows for crypto miners in Q2 »](https://www.kucoin.com/news/flash/bitcoin-mining-fails-to-turn-profit-as-ai-revenue-grows-for-crypto-miners-in-q2) ; [Futu News, « Miners Exit at a Loss, Reshaping the Hashrate Landscape »](https://news.futunn.com/en/post/79357421/coinshares-q2-mining-quarterly-report-miners-exit-at-a-loss).
- **Titres de presse (non lus en entier) :**
  - « Public miners shed bitcoin hashrate as AI revenue accelerates » — [The Energy Mag, 13/08/2026](https://www.theenergymag.com/news/2026-08-13/public-miner-shed-bitcoin-hashrate-ai-revenue-accelerate) ;
  - « Miners Beat Bitcoin by 70% in 2026 as TeraWulf Locks $12.8B in AI Contracts » — [Bitcoin.com News](https://news.bitcoin.com/miners-beat-bitcoin-by-70-in-2026-as-terawulf-locks-12-8b-in-ai-contracts/). Le chiffre de +70 % relève du titre ; méthode non vérifiée.

**MARA Holdings (T2 2026, publié le 6/08/2026)**
- **Production et coûts :**
  - hashrate énergisé de **70,3 EH/s** (+22 % sur un an contre 57,4 EH/s, mais en baisse par rapport aux 72,2 EH/s du T1 2026, en raison du retrait de machines anciennes) ;
  - coût par PH/jour de **27,7 $** (contre 28,7 $) ;
  - électricité sur sites propres à 0,04 $/kWh ;
  - **2 422 BTC** produits (+3 %).
- **Résultats :**
  - revenus de **174,9 M$ (−27 %)**, en raison principalement d'un prix moyen du BTC en baisse de 28 % ;
  - **perte nette de 611,3 M$** (−1,6 $ par action) ;
  - EBITDA ajusté de **−360,9 M$**.

  Sources : [Investing.com, slides MARA Q2 2026 (« digital infrastructure pivot amid mining losses »)](https://www.investing.com/news/company-news/mara-q2-2026-slides-digital-infrastructure-pivot-amid-mining-losses-93CH-4844908) ; [MARA, Q2 2026 Shareholder Letter](https://ml.globenewswire.com/Resource/Download/20012703-ca39-4465-acd3-cbd840a78e46) ; [The Energy Mag](https://www.theenergymag.com/news/market-news/mara-holdings-reports-611-million-net-loss-for-q2-2026) ; [BigGo, appel du 6/08/2026](https://finance.biggo.com/quote/MARA/earnings-call/US_MARA_2026-08-06).
- La perte inclut **~343 M$ de pertes latentes de juste valeur sur les BTC détenus** — [KuCoin News](https://www.kucoin.com/news/flash/bitcoin-mining-fails-to-turn-profit-as-ai-revenue-grows-for-crypto-miners-in-q2) / [The Energy Mag](https://www.theenergymag.com/news/market-news/mara-holdings-reports-611-million-net-loss-for-q2-2026). L'attribution exacte entre ces deux sources est incertaine.

**Riot Platforms (T2 2026)**
- **Minage :** revenus de **113,7 M$** (contre 140,9 M$), **1 587 BTC** minés.
- **Data centers :** revenus de **23,2 M$**.

Source : [Riot Platforms, communiqué T2 2026](https://www.riotplatforms.com/riot-platforms-reports-second-quarter-2026-financial-results-and-strategic-highlights/) (extrait ; page non lue en entier).

**CleanSpark (T3 de l'exercice 2026, trimestre clos fin juin)**
- **Résultats :** revenus de **138 M$ (−30,5 % sur un an)**, **perte nette de 239,8 M$**, EBITDA ajusté négatif.
- **Bail de Sandersville :** il ne générait pas encore de revenus.

Sources : [CleanSpark, 8-K (SEC)](https://www.sec.gov/Archives/edgar/data/0000827876/000119312526216866/clsk-ex99_1.htm) ; [Yahoo Finance](https://finance.yahoo.com/markets/crypto/articles/cleanspark-sinks-6-even-bitcoin-161436724.html).
- **Montant du bail data center :** les sources divergent (bail de 20 ans de 6,6 Md$ contre contrat de 9,1 Md$) — [The Currency Analytics](https://thecurrencyanalytics.com/bitcoin/bitcoin-miners-ditch-pure-mining-as-hpc-contracts-reshape-6-6b-revenue-streams-288662). Non tranché.

**TeraWulf (T2 2026)**
- **Revenus :** **44,8 M$**, dont **31,9 M$ de loyers HPC (~71 %)**.
- **Capacité livrée :** la livraison de CB3 porte la capacité IT critique facturée à **102 MW**. Elle déclenche **600 M$ de garantie de crédit de Google** sur les obligations locatives de Fluidstack ; la garantie totale de Google est d'environ 3,2 Md$ après l'extension CB-5.
- **Avenant Fluidstack :** TeraWulf apporte ~150 M$ pour l'aménagement et attend plus de 300 M$ de loyers supplémentaires sur la durée initiale de 10 ans.
- **Nouveaux accords :** bail de **20 ans avec Anthropic pour 401 MW** (site nommé « Justify » dans l'extrait ; nom à vérifier). Un titre Yahoo évoque un « bail Anthropic de 19 Md$ ». TeraWulf cède aussi sa participation dans la coentreprise d'Abernathy pour ~530 M$.
- **Résultats :** **perte nette GAAP de 939,9 M$**, dont 755,7 M$ de perte non cash sur la juste valeur des bons de souscription Google. EBITDA ajusté de −18,3 M$.

Sources : [TeraWulf, communiqué T2 2026 (SEC)](https://www.sec.gov/Archives/edgar/data/1083301/000108330126000162/a_wulfearningsreleaseq22026.htm) ; [TeraWulf IR](https://investors.terawulf.com/news-events/press-releases/detail/144/terawulf-reports-second-quarter-2026-results) ; [Yahoo Finance, points clés de l'appel](https://finance.yahoo.com/markets/stocks/articles/terawulf-inc-wulf-q2-2026-190057902.html) ; [Benzinga, transcription](https://www.benzinga.com/news/26/10/62238227/transcript-terawulf-q2-2026-earnings-conference-call). La date de publication exacte n'est pas confirmée.
- **Carnet de commandes :** ~12,8 Md$ de revenus HPC sous contrat ; le HPC est désormais majoritaire dans les revenus — [Bitcoin.com News](https://news.bitcoin.com/miners-beat-bitcoin-by-70-in-2026-as-terawulf-locks-12-8b-in-ai-contracts/). Ce montant est probablement antérieur au bail Anthropic.
- **Minage résiduel :** au T2 2026, CoinShares mesure un coût cash de 134 446 $/BTC pour seulement 179 BTC produits — [CoinShares Q2 2026](https://coinshares.com/corp/insights/research-data/bitcoin-mining-report-q2-2026/).

**IREN (exercice clos au 30/06/2026, publié le 27/08/2026)**
- **Revenus :** **707,0 M$** (contre 501,0 M$), dont **578,2 M$ issus du minage** et **128,8 M$ du cloud IA** (×~8).
- **Résultat :** **perte nette de 702,6 M$**, dont 638,8 M$ de dépréciations et coûts de transition non cash.
- **Revenus récurrents (ARR) :** **4 Md$ d'ARR sous contrat** liés à la capacité 2026, dont **1 Md$ déjà opérationnel** après l'acceptation par Microsoft du déploiement « Horizon 1 ». La capacité 2026 est quasiment vendue ; trois nouveaux déploiements de 50 MW sont visés pour le trimestre de décembre.
- **Nouveau client et financement :** signature avec un « frontier AI lab » non nommé et ~2,8 Md$ de dette GPU couvrant 90 % des investissements associés.

Sources : [GlobeNewswire, « IREN Reports FY26 Results », 27/08/2026](https://www.globenewswire.com/news-release/2026/08/27/3352401/0/en/iren-reports-fy26-results.html) ; [The Energy Mag](https://theenergymag.com/news/market-news/iren-reports-707-million-fy-26-revenue-and-ai-cloud-expansion) ; [Alpha Spread](https://www.alphaspread.com/market-news/earnings/iren-reports-4-billion-in-contracted-ai-cloud-revenue-for-2026-capacity).
- **Contrat Microsoft (historique, annoncé avec les résultats du T1 de l'exercice 2026, fin 2025) :**
  - **9,7 Md$** sur une durée moyenne de 5 ans, avec 20 % de prépaiement et ~1,9 Md$ d'ARR attendu ;
  - 3,6 Md$ de financement GPU « investment grade » à 6,0 % ;
  - objectif antérieur de 3,4 Md$ d'ARR cloud IA fin 2026 et 140 000 GPU.

  Sources : [IREN Q1 FY26](https://irisenergy.gcs-web.com/news-releases/news-release-details/iren-reports-q1-fy26-results) ; [MLQ](https://mlq.ai/news/iren-reports-record-q1-fy26-revenue-announces-97-billion-multi-year-ai-cloud-contract-with-microsoft/). Les deux financements (3,6 Md$ et 2,8 Md$) semblent distincts, sans confirmation.
- **Réserve de l'entreprise elle-même :** les ARR sont des projections fondées sur ses propres hypothèses, sans garantie de réalisation — [GlobeNewswire](https://www.globenewswire.com/news-release/2026/08/27/3352401/0/en/iren-reports-fy26-results.html).

**Cipher Mining (accords de 2025 ; contexte historique)**
- **Bail AWS :** **15 ans, 300 MW, ~5,5 Md$**, signé le 29/10/2025 (site Black Pearl). Livraison en deux phases à partir de juillet 2026, fin prévue au T4 2026, loyers à partir d'août 2026 — [DCD](https://www.datacenterdynamics.com/en/news/aws-signs-300mw-hosting-deal-to-lease-capacity-from-cipher-mining/) ; [SEC 8-K, 3/11/2025](https://www.sec.gov/Archives/edgar/data/1819989/000181998925000110/nov3_earningspressreleasex.htm) ; [Forklog](https://forklog.com/en/cipher-mining-secures-5-5-billion-ai-hosting-deal-with-aws/).
- **Bail Fluidstack :** **168 MW** à Barber Lake (Texas), 10 ans, ~3 Md$, Google reprenant le bail en cas de défaillance de Fluidstack — [The Block](https://www.theblock.co/post/379722/cipher-mining-full-site-fluidstack-lease-raise-333-million-texas-expansion).
- **Colchis :** coentreprise pour un site de 1 GW, avec mise sous tension visée en 2028 — [EnkiAI](https://enkiai.com/ai-infrastructure/cipher-mining-hpc-data-center/).

**Core Scientific (T2 2026)**
- **Revenus :** **164,2 M$** au total, dont **136,7 M$ de colocation** (contre 10,6 M$ un an plus tôt).
- **Capacité facturée :** **437 MW** mi-juillet, soit ~635 M$ de revenus de colocation annualisés. Une nouvelle hausse est attendue au T3.
- **Programme CoreWeave :** 4 campus sur 5 quasiment achevés ; la phase 2 de Dalton est prévue début 2027.
- **Concentration :** **83 % des revenus proviennent d'un seul client** de colocation.
- **Contrat AMD :** **530 MW sur 5 sites**, plus de 14 Md$ de revenus de base sous contrat.
- **Résultat :** **perte nette de 1,16 Md$**, dont 1,05 Md$ non cash (juste valeur des bons de souscription et des CVR).

Sources : [Core Scientific, communiqué T2 2026](https://investors.corescientific.com/news-events/press-releases/detail/139/core-scientific-announces-second-quarter-2026-results) ; [10-Q au 30/06/2026 (SEC)](https://www.sec.gov/Archives/edgar/data/0001839341/000183934126000014/core-20260630.htm) ; [Crypto Briefing](https://cryptobriefing.com/core-scientific-revenue-doubles-q2-ai-colocation/) ; [Investing.com, transcription](https://www.investing.com/news/transcripts/earnings-call-transcript-core-scientific-posts-strong-q2-2026-ramp-shares-fall-93CH-4817081).

**Bitdeer (T2 2026)**
- **Résultats :** revenus de **228,8 M$** (contre 155,6 M$), **perte brute de 8,5 M$**, **perte nette de 92,3 M$** (contre 62,9 M$), EBITDA ajusté de 31,1 M$.
- **Minage :** ~73 EH/s en auto-minage, **2 694 BTC** minés.
- **Bascule vers l'IA :**
  - **bail IA/HPC de 16 ans d'environ 4,7 Md$ à Tydal (Norvège)**, où le démontage des machines de minage a commencé ;
  - Wenatchee et Knoxville sont en conversion vers l'IA.

Sources : [TipRanks](https://www.tipranks.com/news/company-announcements/bitdeer-posts-q2-2026-loss-as-it-accelerates-shift-to-ai-and-colocation-infrastructure) ; [Bitdeer, 6-K (SEC)](https://www.sec.gov/Archives/edgar/data/0001899123/000121390026100537/ea030523501ex99-1.htm) (rattachement exact du 6-K au T2 non vérifié).

**Keel (ex-Bitfarms)**
- **Arrêt officiel du minage de Bitcoin :** Moses Lake a cessé en avril 2026 ; Panther Creek, Scrubgrass et Sharon fin juin 2026.
- **Marge brute de −285 % au T2**, due à l'amortissement accéléré des machines retirées.

Source : [CoinShares Q2 2026](https://coinshares.com/corp/insights/research-data/bitcoin-mining-report-q2-2026/).

### Inferences
- **Signal envoyé par le pivot vers l'IA :** les mineurs qui disposent d'électricité et de sites l'allouent à l'IA dès qu'un locataire solvable se présente. C'est un signal fort que les marges du minage sont durablement inférieures à celles de l'hébergement IA, ce qu'affirme explicitement CoinShares.
  - Cas extrêmes : arrêt total chez Keel ; démontage chez Bitdeer ; minage devenu marginal chez TeraWulf (179 BTC au T2, 71 % des revenus issus du HPC).
- **Effet sur le réseau :** ce transfert d'électricité contribue au recul du hashrate en 2026 (deux trimestres de baisse selon Hashrate Index). Il soutient mécaniquement le hashprice des mineurs restants : MARA, qui reste le plus exposé au minage pur, et les mineurs privés à bas coût.
- **MARA au plancher de juin :** son coût de 27,7 $/PH/jour au T2 2026 égale le hashprice moyen de juin 2026 (27,7 $/PH/jour). Même le plus grand mineur coté était donc proche de l'équilibre sur cet indicateur au creux de juin. La définition exacte de l'indicateur de MARA n'a pas été vérifiée.
- **Ce qu'achète désormais un investisseur dans ces actions :**
  - surtout l'exécution de projets de data centers : des contrats en dollars sur 10 à 20 ans, souvent adossés à Google ou à des hyperscalers ;
  - avec des risques de construction, de concentration des clients (83 % chez Core Scientific) et de solidité des locataires (Fluidstack garanti par Google) ;
  - et un délai entre carnet de commandes et revenus (100 Md$ contre 1,1 Md$ selon CoinShares).

  Les pertes GAAP sont gonflées par des éléments non cash : juste valeur des BTC, bons de souscription, dépréciations.

### Gaps
- **Hut 8 :** résultats du T2 2026 et pivot IA/HPC non trouvés. Piste NON VÉRIFIÉE : projet de bail sur le campus de River Bend (Louisiane) annoncé fin 2025, montants à vérifier. Le coût de 871 $/BTC d'ABTC chez CoinShares serait lié à un accord d'hébergement avec Hut 8, sa maison mère à 80 % selon l'extrait (attribution non confirmée).
- **Cipher :** résultats du T2 2026 et état réel des livraisons à AWS (loyers prévus dès août 2026) non vérifiés.
- **Riot :** un extrait évoque ~9,8 Md$ de revenus IA sous contrat sur un campus à deux locataires, sans source identifiable. **Non vérifié**, à ne pas citer. Le détail des baux (locataires, MW) n'a pas été trouvé.
- **CleanSpark :** montant et locataire du bail de Sandersville en conflit (6,6 Md$ contre 9,1 Md$).
- **Core Scientific / CoreWeave :** issue du projet de rachat par CoreWeave non vérifiée en 2026. Piste NON VÉRIFIÉE : vote négatif des actionnaires de Core Scientific fin octobre 2025.
- **MARA :** stratégie IA (« digital infrastructure ») non détaillée. Piste NON VÉRIFIÉE, intéressante pour un lecteur français : acquisition annoncée en 2025 d'une participation majoritaire dans **Exaion, filiale d'EDF** ; statut 2026 à vérifier.
- **TeraWulf :** bail Anthropic (montant de 19 Md$, nom et localisation du site) et date exacte de publication du T2 à vérifier.
- Les résultats du T3 2026 (attendus fin octobre et novembre 2026) ne sont pas encore publiés au 13/10/2026.

## 3. Autres PoW : Kaspa, fusion de minage Litecoin/Dogecoin, Monero (dont l'épisode Qubic de 2025), viabilité du minage GPU en 2026

### Takeaway
**Non documenté : aucune source 2026 n'a pu être collectée** (budget de recherche épuisé avant cette section). Seule conclusion transposable : au tarif résidentiel français (~0,20 €/kWh), tout appareil PoW doit rapporter plus de ~0,20 € par kWh consommé pour couvrir son électricité. Les ASIC Bitcoin les plus efficaces n'y parviennent pas en octobre 2026 (CALCUL, §1).

### Cited Findings
- Aucune donnée 2026 vérifiée sur Kaspa, Litecoin/Dogecoin, Monero ou le minage GPU.
- Seule donnée applicable : le prix de l'électricité résidentielle française est de 0,2001 €/kWh TTC en option Base (3–6 kVA) depuis le 1/08/2026 — [Selectra](https://selectra.info/energie/fournisseurs/edf/tarifs-reglementes) ; [Kelwatt](https://www.kelwatt.fr/actu/tarif-edf-reglemente-1er-aout-2026).

### Inferences
- **Test de rentabilité à domicile :** revenu journalier du matériel (en €) > 0,2001 € × kWh consommés par jour. Le test est indépendant de l'algorithme et s'applique aussi bien aux cartes graphiques qu'aux ASIC Scrypt ou kHeavyHash. Faute de données 2026 sur les revenus par MH/s ou GH/s de ces réseaux, il n'a pas pu être appliqué.

### Gaps
Pistes NON VÉRIFIÉES issues de connaissances antérieures, **à confirmer avant toute utilisation** :
- **Monero / Qubic :** en août 2025, le projet Qubic (« useful proof-of-work ») a revendiqué la majorité du hashrate de Monero, et une réorganisation de quelques blocs a été rapportée. Vérifier les faits, les réactions des plateformes d'échange et la situation 2026 (part de Qubic, éventuelles contre-mesures de Monero).
- **Kaspa :** réseau dominé par les ASIC kHeavyHash (IceRiver, Bitmain) ; le minage GPU de KAS est réputé non viable depuis 2023–2024. Vérifier le revenu par TH/s et la rentabilité en 2026.
- **Litecoin / Dogecoin :** fusion de minage via AuxPoW avec des ASIC Scrypt (gamme Antminer L, Elphapex). Vérifier les revenus combinés LTC+DOGE et les seuils d'équilibre en 2026.
- **Minage GPU :** effondrement des revenus depuis le passage d'Ethereum à la preuve d'enjeu (septembre 2022). Vérifier la situation 2026 (WhatToMine, Hashrate.no) et la concurrence des locations de GPU pour l'IA.
- **Sources suggérées :** Hashrate Index, WhatToMine, Hashrate.no, CoinWarz, miningpoolstats.stream, annonces de Qubic et de la communauté Monero (getmonero.org), TheMinerMag.

## 4. Économie des validateurs et des nœuds : Ethereum en solo, validateurs Solana, autres réseaux, nœuds en tant que service

### Takeaway
**Non documenté : aucune source 2026 n'a pu être collectée** (budget de recherche épuisé). Aucun chiffre de rendement, de coût ou de seuil d'équilibre ne peut être fourni de façon vérifiée pour octobre 2026.

### Cited Findings
- Aucune donnée 2026 vérifiée.

### Inferences
- Aucune inférence étayée possible sans données.

### Gaps
Pistes NON VÉRIFIÉES issues de connaissances antérieures, **à confirmer** :
- **Ethereum :**
  - 32 ETH minimum pour un validateur en solo ;
  - la mise à jour Pectra (mai 2025, EIP-7251) a relevé le solde effectif maximal à 2 048 ETH (consolidation) ;
  - rendement de l'ordre de ~3 % par an en 2025 ;
  - modules de staking « sans permission » à caution réduite (Lido CSM, Rocket Pool).

  À vérifier : APR d'octobre 2026, nombre de validateurs, file d'entrée et de sortie, coûts matériels et risques de pénalité (slashing). Sources : beaconcha.in, Rated Network, ultrasound.money.
- **Solana :**
  - coût des transactions de vote historiquement de l'ordre de ~1 SOL par jour et par validateur ;
  - réforme de consensus Alpenglow (SIMD-0326, approuvée par vote en 2025) censée supprimer les votes on-chain et introduire un ticket d'admission pour les validateurs ;
  - SIMD-0123 (redistribution des frais de bloc aux délégateurs) ;
  - SIMD-0228 (inflation fondée sur le marché, rejetée en mars 2025) ;
  - proposition d'accélérer la désinflation (numéro de SIMD incertain).

  À vérifier : date d'activation d'Alpenglow sur le réseau principal, coût annuel d'un validateur, stake nécessaire pour atteindre l'équilibre, part des pourboires Jito et MEV, programme de délégation de la Solana Foundation. Sources : Solana Compass, validators.app, Helius blog, docs Anza.
- **Nœuds en tant que service et autres réseaux :** Figment, Kiln, Chorus One ; rendements par réseau (Staking Rewards). Tout reste à documenter.
- **Fiscalité française des récompenses de staking :** probablement couverte par un autre axe de recherche. À vérifier.

## 5. DePIN : gains réels des participants (Helium, Hivemapper, Render, io.net, Grass, Geodnet, Natix…) face au coût du matériel et à la baisse des jetons

### Takeaway
**Non documenté : aucune source 2026 n'a pu être collectée** (budget de recherche épuisé). Aucun chiffre de revenus DePIN 2026, de gains par appareil ou de période de retour sur investissement ne peut être fourni de façon vérifiée.

### Cited Findings
- Aucune donnée 2026 vérifiée.

### Inferences
- Aucune inférence étayée possible sans données.

### Gaps
Pistes NON VÉRIFIÉES, **à confirmer** :
- **Données sectorielles :** rapport « State of DePIN » de Messari (édition publiée en 2026 ?), DePINscan, DePIN Ninja : revenus on-chain par projet et ratio revenus/émissions.
- **Helium :**
  - réduction de moitié des émissions de HNT à l'été 2025 (à vérifier) ;
  - conversion des jetons MOBILE et IOT vers HNT ;
  - abonnés Helium Mobile et destruction de crédits de données ;
  - gains réels par hotspot en 2026.
- **Hivemapper :** changement de nom en Bee Maps et nouvel appareil « Bee » (à vérifier) ; gains en HONEY par conducteur.
- **Render :** équilibre destruction/émission du jeton RENDER et revenus du réseau.
- **io.net :** revenus des fournisseurs de GPU et taux d'utilisation.
- **Grass :** valeur des distributions de jetons (airdrops) par participant.
- **Geodnet :** revenus des stations RTK et gains par station.
- **Natix :** gains par conducteur.
- **Risque générique à quantifier :** gains libellés en jetons, alors que les prix des jetons DePIN ont pu baisser fortement. À vérifier avec les cours de 2026.

## 6. Arnaques au « cloud mining » et aux applications de minage (2025–2026) : alertes des régulateurs, listes noires de l'AMF

### Takeaway
**Non documenté avec des sources 2026** (budget de recherche épuisé). Les données de hashprice du §1 fournissent toutefois un test objectif pour repérer les offres de rendement impossibles.

### Cited Findings
- Aucune alerte de régulateur (AMF, FCA, SEC, CFTC) datée de 2025–2026 n'a pu être collectée.
- Donnée de référence utilisable : hashprice d'environ **40 $/PH/jour début octobre 2026** et **27,7 $/PH/jour en moyenne en juin 2026** — [hoge.gg (début oct. 2026)](https://hoge.gg/hashprice-2026-difficulty-ceiling-miner-recovery/) ; [CoinShares Q2 2026](https://coinshares.com/corp/insights/research-data/bitcoin-mining-report-q2-2026/).

### Inferences
- **Plafond de revenu d'un contrat légitime (CALCUL) :** au hashprice de début octobre 2026 (~40 $/PH/jour, soit ~0,04 $ par TH/s et par jour), un contrat portant sur 100 TH/s ne peut pas rapporter plus d'environ **4 $/jour bruts**, avant électricité et frais de l'opérateur.
  - Toute offre de « cloud mining » promettant un rendement fixe quotidien supérieur au hashprice net d'électricité est mathématiquement suspecte.
  - Il en va de même pour une offre promettant un rendement garanti en euros indépendant du prix du BTC et de la difficulté.
- **Arguments contre les offres présentées comme « dormantes » :** les mineurs cotés eux-mêmes étaient sous le seuil cash en agrégé au T2 2026 (CoinShares). Une plateforme qui promettrait des rendements élevés et stables contredit les données économiques du secteur.

### Gaps
Pistes NON VÉRIFIÉES, **à confirmer** :
- **AMF :** listes noires des sites non autorisés proposant des investissements en crypto-actifs ; repérer les mentions de « cloud mining », « minage » ou « contrats de minage » ajoutées en 2025–2026, et les mises en garde conjointes AMF/ACPR.
- **Autres régulateurs :** alertes de la FCA, de la SEC, de la CFTC et des régulateurs belge (FSMA) et suisse (FINMA) sur les plateformes de cloud mining et les applications mobiles de « minage », y compris les usurpations de marques de fabricants d'ASIC.
- **Ne pas nommer de plateformes comme frauduleuses** sans source officielle (risque juridique).

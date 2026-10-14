## 15. Méthodologie, sources et limites

### 15.1 Deux passes de recherche, une rédaction par section, un assemblage éditorial

La recherche a été menée les 13 et 14 octobre 2026, en deux passes. La première a couvert **douze axes thématiques**, chacun consigné dans un fichier de notes : état du marché et macroéconomie ; carte des revenus de l'industrie ; trading actif ; bots, MEV et automatisation ; memecoins et launchpads ; ventes de tokens, ICO et airdrops ; bourse (IPO, actions, DAT, ETF/ETP) ; rendement passif (staking, DeFi, stablecoins) ; minage, validateurs et DePIN ; marchés prédictifs ; communautés, narratifs et risques ; fiscalité et réglementation en France et dans l'UE. La seconde passe a comblé les lacunes de la première en **huit axes de compléments** : revenus, bots et MEV ; trading, bots et agents IA ; airdrops et launchpools ; IPO, DAT et ETF ; rendements, validateurs et DePIN ; marchés prédictifs et memecoins ; communautés, podcasts et macroéconomie ; fiscalité et réglementation. Les **vingt fichiers de notes**, rédigés en français ou en anglais selon l'axe, totalisent environ 150 000 mots. Six rédacteurs ont ensuite écrit les sections 2 à 13 à partir de ces notes, chacun pour deux sections, avec une fiche de points clés par paire. L'assemblage éditorial a ajouté l'en-tête, la synthèse (section 1), la conclusion (section 14) et la présente section, sans nouvelle recherche et sans introduire de chiffre absent des sections ou des fiches de points clés.

**Harmonisation éditoriale.** À l'assemblage, les montants en dollars ont été uniformisés en « USD » : les sections 2 à 8 et 11 à 13 employaient le symbole « $ », que certains lecteurs Markdown interprètent comme un délimiteur de formule mathématique, alors que les sections 9 et 10 écrivaient déjà « USD ». Les sous-sections « Fiche synthèse » des sections 6 et 7 ont été numérotées. Des renvois ont été ajoutés pour expliquer des écarts entre sections : revenus d'Axiom et de GMGN (revenu net selon CoinGecko en section 3, frais bruts selon DefiLlama en section 6) ; cours de référence du bitcoin au 13/10/2026 (83 408 USD selon Fortune) repris en section 10 ; mesures du mNAV de Strategy (sections 2 et 8) ; contexte MiCA et fiscal ajouté en section 2 à partir de la section 13 ; décomptes d'enlèvements (sections 12 et 13) ; statut des contrats perpétuels (sections 4 et 13) ; revenus de Polymarket (sections 3 et 11) ; couverture fiscale du trading et des bots (sections 4, 5 et 13). L'adresse d'un article (Mpost) affirme qu'Hyperliquid aurait gagné plus que les deux projets suivants réunis : ses propres chiffres la contredisent (322,21 + 132,09 = 454,30 M USD, au-dessus de 429,04 M USD), et cette affirmation n'est reprise nulle part.

### 15.2 Des extraits de moteurs de recherche, pas des pages lues

L'outil de lecture de pages (WebFetch) a échoué sur tous les domaines pendant la recherche (erreur de résolution DNS), et le proxy de sortie bloquait l'accès direct à certains sites et interfaces, dont l'API de DefiLlama et SEC EDGAR. **Chaque chiffre provient donc des extraits que le moteur de recherche renvoie pour une page** ; le rapport cite l'URL et, quand elle est visible, la date de la page résumée. Il en découle trois limites. La formulation exacte, le contexte et parfois la date d'un chiffre peuvent différer de la page d'origine. Les sources primaires citées (DefiLlama, Dune, Légifrance, BOFiP, registre de l'ESMA, liste blanche de l'AMF, dépôts auprès de la SEC) n'ont pas été lues en entier ; les rares sources consultées directement sont signalées comme telles, notamment trois dépôts GitHub publics en section 12 (base d'attaques physiques de Jameson Lopp, index DeFiHackLabs, rapport d'étape de SlowMist). Enfin, le budget de recherche était limité (22 requêtes par axe en seconde passe), ce qui explique une partie des lacunes listées en 15.5. **Les chiffres clés doivent être vérifiés auprès des sources primaires avant toute décision.**

### 15.3 Communautés : ce que le rapport n'a pas pu écouter

X/Twitter, Reddit, Discord, Telegram, YouTube et les transcriptions de podcasts n'ont pas pu être consultés directement, pas plus que les tableaux de bord d'attention (Kaito, LunarCrush, Santiment) ou Google Trends. Le contenu communautaire vient d'articles qui rapportent des propos, d'extraits de moteurs de recherche et de listes d'épisodes (titres et dates) ; aucune citation d'animateur ou de forum n'est utilisée sans article qui la rapporte, et aucun propos n'est présenté comme représentatif d'une communauté (section 12). Les témoignages de gains cités (sections 4, 11 et 12) sont des portraits de presse aux revenus auto-déclarés, biaisés vers les gagnants.

### 15.4 Étiquettes de fiabilité utilisées dans les sections

| Étiquette | Sens |
|---|---|
| « non vérifié » | Piste trouvée mais non confirmée par une seconde source ou par la seconde passe |
| « estimation » | Chiffre calculé ou modélisé par un tiers (par exemple 1kx ou Sacra), non publié par l'acteur concerné |
| « auto-déclaré » | Chiffre publié par l'acteur lui-même, non audité |
| « calcul », « calcul de l'auteur » | Arithmétique de rédaction sur des chiffres sourcés (pourcentages, annualisations, ratios) |
| « s.d. » | Date de la page non visible dans l'extrait |
| « inférence », « analyse », « lecture », « interprétation » | Raisonnement du rédacteur, pas un fait sourcé |
| « vendeur », « éditeur », « conflit d'intérêts possible » | Source ayant un intérêt commercial : vendeur d'outil, fournisseur de données, plateforme, émetteur de produits |
| « promotionnel » | Taux ou gain issu d'une communication commerciale |
| « historique » | Donnée ancienne (antérieure à 2026 ou, en section 5, à la mi-avril 2026), citée comme repère |
| « attribution incertaine » ou « probable » | Lien entre le chiffre et la source citée non confirmé |
| « source unique » | Chiffre non recoupé par une autre source |

### 15.5 Ce que le rapport ne couvre pas

Plusieurs domaines restent hors champ ou non documentés faute de sources : les arnaques de masse (pig-butchering, address poisoning, wallet drainers), les arnaques assistées par IA et les fuites de données, que les sections 5 et 12 signalent sans les chiffrer ; les faillites d'exchanges de 2025-2026 et le total des rug pulls ; les rendements des fournisseurs de liquidité, des particuliers acheteurs ou vendeurs d'options et des programmes de Kalshi ; les marchés de NFT, le GameFi et le play-to-earn ; les autres cryptos minées (Kaspa, Monero, minage GPU) ; les bug bounties, les emplois et salaires du secteur et les revenus de création de contenu ; les comptes de Binance ; les rapports du T3 2026 (rapport trimestriel de CoinGecko, attestation de Tether, résultats des mineurs) ; les données d'attention et de recherche pour la France. Côté français, ne sont pas vérifiés la formule de calcul des plus-values de l'art. 150 VH bis, les contributions sur les hauts revenus, les cotisations sociales des BNC, le statut MiCA des produits « earn », du staking et du lending, les textes officiels sur le levier, l'éligibilité au PEA des actions crypto et la fiscalité des dividendes américains, le régime des actions tokenisées, le traitement fiscal des perpétuels, des gains de marchés prédictifs et du DePIN, ni les listes noires de l'AMF (sections 8.6, 10.8 et 13.13).

### 15.6 Annexe : contradictions non résolues

Le tableau recense les écarts entre sources que les sections signalent sans pouvoir les trancher, et ceux relevés à l'assemblage. La dernière colonne indique le choix fait dans le texte quand il existe.

| Sujet | Versions en présence | Sections | Lecture retenue ou état |
|---|---|---|---|
| Enlèvements et séquestrations en France | Parquet national anticriminalité organisée : plus de 70 sur les huit premiers mois de 2026, 67 en 2025 ; source citée par Cryptoast : 103 du 01/01 au 07/09/2026, 56 en 2025 ; ministère de l'Intérieur : 77 depuis janvier 2026 (extorsions et tentatives comprises), 45 en 2025 | 12.5, 13.12 | Périmètres différents ; fourchette |
| Règle du Trésor américain pour le GENIUS Act | « Interim final rule » du 30/09/2026 ou simple proposition du 17/08/2026 | 2.7 | À vérifier au Federal Register |
| Vote du CLARITY Act | 49 voix pour (seuil de 60), 49-50 selon certaines sources ; caractère définitif contesté (motion de réexamen) | 2.7 | Échec au 15/09/2026, avenir ouvert |
| Indicateurs on-chain | Prix réalisé : 61 120 USD (Amberdata) ou ≈52 300-52 500 USD (bit.com, mi-2026) ; pic du MVRV : 2,524 ou 2,9 ; plus bas du cycle : 57 800 à 60 861 USD selon la source et la convention | 2.1, 2.4 | Non réconciliés ; 59 024 USD (24/06/2026) retenu comme repère |
| Offre de stablecoins | Trackers divergents de 15 à 20 Md USD selon la méthode, le périmètre et la date | 2.2 | Citer tracker et date |
| Plus bas du BTC le 08/10/2026 | ≈80 400 USD ou 81 750 USD | 2.1, 2.3 | Non tranché |
| Flux nets 2026 des ETF bitcoin | +478,6, +886,8, +934 ou +985 M USD à l'automne selon le fournisseur et la date | 2.5, 8.4 | Solde légèrement positif, montant non réconcilié |
| Indice Fear & Greed au 13/10/2026 | De 39 à 61 selon le fournisseur et l'horodatage | 2.8 | Citer fournisseur et heure, sans moyenne |
| Cours du BTC « en juillet » | ≈58 000 USD (hoge.gg) contre un plus bas de cycle de 59 024 USD le 24/06/2026 | 2.1, 10.1 | Repère de la section 2 retenu |
| Revenus de Polymarket | ≈1 Md USD annualisé (Sacra, juin 2026) contre ≈115 M USD du 01/01 au 15/09/2026 (CoinGecko) | 3.4, 3.9, 11.2 | Écart d'environ six fois, non résolu |
| Revenus 2026 d'Hyperliquid | 429 M USD au 15/09 (CoinGecko) contre ≈602 M USD sur T1-T3 (sources mêlées, calcul) | 3.4 | Fourchette ; CoinGecko pour le classement |
| Rachats de HYPE en 2026 | ≈370 M USD (Allium) contre ≈600 M USD (calcul sur DefiLlama) | 3.8 | Définitions non réconciliées |
| « Hyperliquid devant les deux suivants réunis » | Adresse de l'article Mpost ; contredite par 322,21 + 132,09 = 454,30 M USD, au-dessus de 429,04 M USD | 3.4 | Affirmation écartée |
| Tether, T2 2026 | 1,5 Md USD de résultat et 4,11 Md USD de réserves excédentaires, contre 1,3 et 5,2 Md USD (articles du 03/09/2026) | 3.2 | Seconde version écartée, incompatible avec le bilan rapporté ; attestation non lue |
| Revenus d'Axiom et de GMGN | 132 et 126 M USD (revenu net, CoinGecko, 01/01-15/09) contre 211 et 171 M USD (frais bruts, DefiLlama, T1-T3) | 3.4, 3.5, 6.7 | Différence de définition et de fenêtre, expliquée dans le texte |
| Part de marché d'Axiom | 44,6 % du volume Solana (04/06/2026) contre 60 à 72 % ailleurs ; mesures de volume, pas de revenu | 3.5 | Non tranché |
| Pertes des sandwiches sur Solana | 29,7 M USD bruts en 11 mois (Bitquery) contre ≈345 M USD de profit en 36 mois (préprint) ; « 370 à 500 M USD » sans source primaire | 5.3, 6.3 | Périmètres différents : fourchette |
| Rachats de PUMP | ≈200 M USD en 2026 (WalletInvestor), ≈213 M USD (Bex), 371 M USD cumulés (DefiLlama), 482,47 M USD (page officielle) | 3.5, 6.10 | Définitions et dates différentes |
| Traders de pump.fun en mars 2026 | 50,6 % en perte contre 70 % de portefeuilles « rentables » | 5.1 | Non tranché ; avril 2026 détaillé en 6.3 |
| Plus grosse journée de liquidations de 2026 | ≈1,8 Md USD le 02/06 contre 2,588 Md USD le 31/01 (CoinGlass) | 4.2 | CoinGlass retenu |
| Base CME en août 2026 | ≈3 % à trois mois contre 5,69 à 7,89 % brut | 4.4, 5.7 | Méthodes ou contrats différents |
| Indice CFR des fonds crypto, 2026 à ce jour | −6,12 % contre −9,2 % | 4.8 | Mois de référence non résolu |
| Rendement de sUSDe en juin 2026 | ≈4,5 % contre 7,1 % | 4.4, 9.4 | Non tranché |
| Offre d'USDe | ≈3,9 Md USD au 31/07/2026 ; « sous 5 Md USD » fin août ; ≈4,95 Md USD fin septembre (non vérifié) | 3.7, 4.4, 9.4 | Séries non réconciliées |
| Rendement du vault HLP | « 15 à 30 % » présentés comme une promesse non vérifiée (4.3) ou comme un rendement trimestriel passé (9.1) ; ≈22 % net sur 12 mois à fin T2 2026 ; ≈3 à 7 % annualisés en 2026 | 4.3, 9.1, 9.5 | Relevés de 2026 retenus comme actuels |
| Levée publique de PUMP | 500 M USD contre 600 M USD | 7.2 | Non tranché |
| Part des jetons « rugués » | 98,6 % des jetons pump.fun (Solidus) contre ≈3,6 % des jetons de 2024 (Chainalysis) | 6.3 | Périmètres différents, non comparables |
| Levées des ventes publiques | T2 2026 : 58 M USD sur 37 ventes ou 40 M USD sur 47 ; S1 2026 : ≈448 M USD ou « plus de 1,4 Md USD » | 7.1, 7.9 | Non tranché |
| Airdrop de Linea | 9,36 Md de jetons pour 749 662 portefeuilles, ou 6,48 Md plus 720 M de HODLer Airdrop | 7.5 | Non tranché |
| Plus haut de LIT | 7,86 ou 5,48 USD ; une source le situe à ≈2 fois son prix du jour de l'airdrop, incompatible avec 3,6-4,0 USD | 7.5 | Non tranché |
| Ventes XPL, FF, AZTEC et MEGA | Dates et montant de la vente XPL ; prix de vente de Falcon (0,035 ou 0,045 USD) ; prix de compensation d'Aztec ; plus haut de MEGA antérieur au TGE | 7.2 | Fourchettes de variation données dans le tableau 7.2 |
| Cours de HYPE | 55,27 à 82,05 USD selon des relevés non datés, contre 91,65 USD le 27/09/2026 (page non identifiée) | 3.8, 7.5 | Non réconcilié ; calculs à refaire avec un cours daté |
| PFU sur les cessions de 2025 | 31,4 % (clause « imposition des revenus de l'année 2025 ») ou 30 % (hausse limitée aux faits générateurs de 2026) | 13.1 | 31,4 % jugé mieux étayé, confiance moyenne |
| Hausse de CSG et PEA | PEA touché selon une source, maintenu à 9,2 % selon une autre | 13.1 | Non tranché |
| NFT et loi n° 2026-534 | Intégrés à l'art. 150 VH bis ou régis par un nouvel art. 150 VH ter (régime du bien sous-jacent) | 13.2 | Non tranché |
| Amendes et régularisation | 750 € par NFT ou par compte non déclaré, 1 500 € au-delà de 50 000 € ou par portefeuille selon les sources ; régularisation à 0,20 % d'intérêts par mois sans majoration, ou réduction de 50 % des intérêts | 13.2, 13.6 | À vérifier dans le texte |
| Trading habituel | BNC selon la plupart des sources, BIC selon une source citant le BOFiP | 13.3 | Non tranché ; aucun seuil officiel |
| Fondement de l'imposition du staking et des airdrops | Doctrine BOFiP ou simple page d'impots.gouv.fr ; loi de finances 2024 ayant ou non imposé le staking ; airdrops imposés à la réception ou à la cession | 13.4 | Zone grise |
| Nombre de prestataires agréés MiCA | ≈35 (ESMA selon un média), 33 plateformes, 365 entreprises au registre (autre périmètre) | 13.9 | Périmètres différents |
| Régulateur de Bitpanda | BaFin (Allemagne) ou FMA (Autriche) | 13.9 | Non tranché |
| Binance et Bybit dans l'UE après le 01/07/2026 | Demande grecque retirée, échouée ou jamais complète ; arrêt limité à la France ou étendu à l'UE ; statut de Bybit disputé, Bybit EU GmbH listée au registre selon un tracker | 9.6, 13.9 | Arrêt du trading pour les Français établi ; le reste n'est pas clair |
| Impôt sur la fortune improductive | Dates d'adoption et exercice concerné issus d'une source unique | 13.7 | Abandon établi, chronologie à vérifier |
| Reprise du PLF 2027 en séance | 12 ou 13/10/2026 | 13.8 | Non tranché |
| mNAV de Strategy | 0,76× (tracker) ; 0,81 à 0,84× en base simple ; 1,07 à 1,09× en valeur d'entreprise ou selon la méthode d'un site | 2.5, 8.3 | Mesures non comparables entre elles |
| Levée de l'IPO d'eToro | ≈620 M USD au total contre ≈310 M USD (probablement la part de la société) | 8.1 | 620 M USD dans le tableau |
| Levée de BitGo | 212,8 ou 198,5 M USD | 8.1 | Non tranché |
| Clôtures du premier jour | Circle à 83,23 ou 82,84 USD ; Figure non confirmée | 8.1 | Non tranché |
| Kraken et Ledger | Date et existence d'un S-1 public de Kraken ; Ledger en pause ou « en attente » | 8.2 | Non tranché |
| Riot depuis le 01/01/2026 | +46 % ou ≈ +90 % (relevés non datés) | 8.5 | Non tranché |
| Tours de Kalshi | Series F à 22 Md USD datée de mars ou de mai 2026 ; levée à ≈40 Md USD en finalisation, clôture non confirmée au 13/10 | 11.2 | Non tranché |
| Tour de Polymarket à ≈21 Md USD | Une seule source secondaire, qui cite Bloomberg | 11.2 | À confirmer |
| Rentabilité des wallets Polymarket | 0,51 % ou ≈2 % au-dessus de 1 000 USD ; 72 % « rentables » (une source, méthode inconnue) contre 84,1 % dans le rouge ; 70 % et ≈69 % de perdants dans deux autres études | 11.3 | Large majorité de perdants dans toutes les études sérieuses |
| Rebates aux teneurs de marché sur Polymarket | 15 à 25 % des frais taker selon la catégorie, 100 % selon une source, « jusqu'à 50 % » selon un guide ; coefficient sportif de 0,03 ou 0,05 | 11.2 | Grille V2 retenue, formule non vérifiée |
| Début du géoblocage de Polymarket en France | Novembre 2024 ou 2025 selon les sources | 11.8, 13.11 | Non tranché |
| Arrêt du 6e circuit sur Kalshi | Défavorable à Kalshi selon CNBC et CoinDesk, favorable selon un titre de Prediction News | 11.8 | Non résolu |
| Bons du Trésor tokenisés | ≈16,2 Md USD en juillet contre ≈14,9 Md USD à la mi-octobre ; ≈11,5 Md USD sur une page non datée de CoinGecko | 9.4, 12.1 | Sorties ou différence de périmètre, non tranché |
| Slashing d'EigenLayer et encours de Symbiotic | Mise en service le 17/04/2025 ou le 17/04/2026 ; encours de ≈0,9 ou ≈4,8 Md USD | 9.3 | Non tranchés |
| Taux de Compound v3 (USDC) | ≈4,5 % ou 5,3 à 6,45 % | 9.1 | Non tranché |
| Dette douteuse d'Aave après Kelp DAO | 124 à 230 M USD selon les scénarios ; issue réalisée non vérifiée | 9.7 | Scénarios, pas des pertes constatées |
| Sommet et recul du hashrate | Pic de ≈1 160 EH/s ou de 1 066 EH/s ; recul de −12 % ou de −33 % depuis octobre 2025 | 10.1 | Non tranché |
| Alpenglow (Solana) | Activation le 21/10/2026 (page officielle) ou le 28/09 (titre d'un média) ; ticket de 0,8 SOL par époque, ≈0,8 SOL par jour ou 1,6 SOL par époque | 10.6 | Page officielle retenue ; unités non réconciliées |
| Totaux des piratages | CertiK : 2,68 Md USD au 30/09 et 1,26 Md USD au T3, septembre à 768,4 ou 768,5 M USD selon la reprise ; PeckShield : ≈1,14 Md USD au T3 ; S1 : ≈942 M USD (CryptoRank) ou ≈1,3 Md USD (Forbes) | 9.7, 12.5 | Trackers non comparables entre eux |
| Repères sans risque | Bon du Trésor à 3 mois 4,15 %, taux de dépôt de la BCE 2,50 %, Livret A 1,7 % : relevés en première passe, non revérifiés | 9.1 | À vérifier avant usage |
| Cours de l'ETH de référence | 2 503,64 USD le 13/10 (Fortune) contre 2 507 USD (date non précisée) dans le calcul du validateur | 2.1, 10.6 | Écart négligeable ; calcul conservé |
| Statut des perpétuels pour un particulier de l'UE | Déclaration de l'ESMA du 24/02/2026 rapportée par la presse et une circulaire de la MFSA ; aucun texte de l'AMF ou de l'ESMA lu directement | 4.10, 13.11 | Renvoi croisé ; assimilation aux CFD jugée « probable » |
| Autres écarts mineurs | Bail de CleanSpark (6,6 ou 9,1 Md USD) ; période des revenus de Grass (2025 ou S1 2026) ; taux de frais de créateur de pump.fun (0,05 % ou 0,30 %) ; nombre de pièces dans l'affaire pump.fun (≈5 000 ou 15 000) ; frais des ETP européens selon les sites | 6.10, 8.6, 10.4, 10.7 | Non tranchés |

*Ce rapport n'est ni un conseil en investissement ni un conseil fiscal ou juridique. Pour toute décision, se reporter aux sources primaires et, pour un cas concret, à un avocat fiscaliste ou à un expert-comptable.*

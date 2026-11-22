// ============================================================
// Polycopié — Cours 0 : Introduction Module DevSecOps
// Université de Rennes · IRISA / DiverSE
// Olivier Barais
// ============================================================

#set document(
  title: "Cours 0 — Introduction Module DevSecOps",
  author: "Olivier Barais",
  date: datetime(year: 2026, month: 9, day: 1),
)

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8pt, fill: luma(130))
      #grid(columns: (1fr, 1fr),
        [DevSecOps — Cours 0 · Université de Rennes],
        align(right)[Olivier Barais]
      )
      #line(length: 100%, stroke: 0.5pt + luma(200))
    ]
  },
  footer: context [
    #set text(size: 8pt, fill: luma(130))
    #line(length: 100%, stroke: 0.5pt + luma(200))
    #v(2pt)
    #grid(columns: (1fr, 1fr),
      [IRISA / DiverSE · 2026],
      align(right)[Page #counter(page).display("1")]
    )
  ]
)

#set text(font: "New Computer Modern", size: 10.5pt, lang: "fr")
#set par(justify: true, leading: 0.65em, spacing: 1.2em)
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(1.5em)
  block(
    fill: rgb("#1e40af"),
    radius: 4pt,
    inset: (x: 10pt, y: 6pt),
    width: 100%,
    text(fill: white, size: 14pt, weight: "bold")[#it.body]
  )
  v(0.5em)
}

#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 12pt, weight: "bold", fill: rgb("#1d4ed8"))[#it.body]
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.5em)
  text(size: 11pt, weight: "bold", fill: rgb("#374151"))[#it.body]
  v(0.2em)
}

// Boîte d'alerte
#let alert(color: red, icon: "⚠", body) = block(
  fill: color.lighten(90%),
  stroke: 0.8pt + color,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
)[
  #text(weight: "bold")[#icon  ] #body
]

// Boîte d'exemple
#let example(title, body) = block(
  fill: rgb("#f0f9ff"),
  stroke: (left: 3pt + rgb("#0ea5e9")),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#0369a1"))[Exemple — #title] \
  #v(4pt)
  #body
]

// Boîte de définition
#let definition(term, body) = block(
  fill: rgb("#f5f3ff"),
  stroke: (left: 3pt + rgb("#7c3aed")),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#6d28d9"))[Définition — #term] \
  #v(4pt)
  #body
]

// Boîte de retenir
#let keypoint(body) = block(
  fill: rgb("#fff7ed"),
  stroke: (left: 3pt + rgb("#ea580c")),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#c2410c"))[À retenir] \
  #v(4pt)
  #body
]

// ============================================================
// PAGE DE TITRE
// ============================================================

#align(center)[
  #v(2cm)
  #block(
    fill: rgb("#1e3a8a"),
    radius: 8pt,
    inset: 20pt,
    width: 90%,
  )[
    #text(fill: white, size: 11pt)[DevSecOps — Université de Rennes · IRISA / DiverSE]
    #v(8pt)
    #text(fill: white, size: 20pt, weight: "bold")[Cours 0]
    #v(4pt)
    #text(fill: rgb("#93c5fd"), size: 15pt)[Introduction au module DevSecOps]
  ]

  #v(1.5cm)

  #text(size: 11pt, weight: "bold")[Olivier Barais]
  #linebreak()
  #text(size: 10pt, fill: luma(80))[Professeur des Universités · Université de Rennes]
  #linebreak()
  #text(size: 10pt, fill: luma(80))[IRISA UMR 6074 · Équipe DiverSE · INRIA]
  #linebreak()
  #text(size: 10pt, fill: luma(80))[D'après les travaux de B. Combemale]

  #v(1cm)
  #text(size: 9pt, fill: luma(100))[Année universitaire 2026–2027]

  #v(2cm)
]

#outline(
  title: "Table des matières",
  indent: 1em,
  depth: 2,
)

#pagebreak()

// ============================================================
// OBJECTIF DU COURS
// ============================================================

= Objectif de ce cours

Ce premier cours introductif pose le cadre de l'ensemble du module. Il a pour but de faire comprendre les notions centrales qui seront détaillées tout au long de l'UE :

#definition("Notions du module")[
  *DevOps*, *DevSecOps*, *Software Supply Chain* (chaîne d'approvisionnement logicielle), *SBOM* (Software Bill of Materials) et *Software Supply Chain Attack* (attaque de la chaîne d'approvisionnement logicielle).
]

À la fin de ce module, vous aurez une meilleure compréhension des *techniques logicielles* mises en œuvre pour développer des systèmes modernes, ainsi que des *risques associés* à cette chaîne de production.

// ============================================================
// POURQUOI EST-CE IMPORTANT ?
// ============================================================

= Pourquoi est-ce important ? Le regard d'un futur RSSI

En tant que futur Responsable de la Sécurité des Systèmes d'Information (RSSI), vous serez confronté à trois réalités structurantes qui font de la chaîne d'approvisionnement logicielle un enjeu central.

== Un SI composé de logiciels en perpétuelle évolution

Vous aurez en charge la sécurisation d'un *Système d'Information* composé d'applicatifs propriétaires et open source qui évoluent en permanence. Des dizaines, voire des centaines de dépendances sont mises à jour chaque semaine ; chaque mise à jour est une surface d'attaque potentielle.

== Les développeurs disposent de droits importants… et c'est une cible

Les développeurs, les environnements de tests et les comptes de services associés tendent à disposer de *droits importants* au sein d'un système d'information (accès aux dépôts, aux registres, aux environnements de staging). Cette concentration de droits en fait une *cible d'attaque tentante*.

== Les développeurs open source sont par défaut optimistes

Les développeurs, en particulier dans l'écosystème open source, sont par défaut *optimistes* : ils font confiance aux paquets qu'ils intègrent. Cette confiance implicite est une seconde *cible d'attaque tentante*.

#keypoint[
  Ces trois constats — évolution permanente, droits étendus, confiance par défaut — convergent vers une même conclusion : la chaîne d'approvisionnement logicielle est devenue le vecteur d'attaque de prédilection des acteurs sophistiqués.
]

// ============================================================
// SUPPLY CHAIN OPEN SOURCE & SÉCURITÉ
// ============================================================

= Supply Chain Open Source & Sécurité

L'écosystème open source est omniprésent dans les centres de données, les appareils grand public et les applications. Sécuriser ses chaînes d'approvisionnement nécessite une combinaison d'outils automatisés, de bonnes pratiques, d'éducation et de collaboration.

> *"Open source software is pervasive in data centers, consumer devices, and applications. Securing open source supply chains requires a combination of automated tooling, best practices, education, and collaboration."*
> — *OpenSSF*

Quelques incidents récents illustrent la réalité de cette menace :

- *Mars 2022* — `node-ipc` et `peacenotwar` (CVE-2022-23812)
- *Déc. 2021* — Log4Shell (CVE-2021-44228)
- *Nov. 2018* — Attaque du paquet npm `event-stream`

== Une autre façon de comprendre le problème

Toute l'infrastructure numérique moderne repose sur *des projets open source maintenus par quelques bénévoles*. Un seul paquet compromis peut affecter *des milliers* d'applications et de systèmes.

#alert(color: rgb("#dc2626"), icon: "⚠")[
  *Le maillon faible est souvent invisible.* Un composant apparemment anodin, maintenu en marge, peut conditionner la sécurité de l'ensemble de la chaîne.
]

#keypoint[
  La question n'est plus *si* votre supply chain sera attaquée, mais *quand* — et si vous disposez des outils pour le savoir.
]

// ============================================================
// INCIDENTS MARQUANTS
// ============================================================

= Quelques incidents marquants

Cette section présente, de façon synthétique, plusieurs incidents réels qui montrent la supply chain « en action ». Ils constituent le fil conducteur de l'ensemble de l'UE.

== Nov. 2018 — Attaque npm : `event-stream`

`event-stream` est un paquet npm utilitaire téléchargé à plus d'*1,5 million de fois par semaine*, utilisé par plus de *1 600 paquets* dépendants.

- Un utilisateur malveillant (`right9control`) a *demandé la propriété* du paquet au mainteneur original et a réussi.
- Il a ajouté `flatmap-stream` comme *dépendance malveillante*.
- Le code malveillant n'était présent que dans le *paquet npm publié*, pas dans le dépôt Git.
- Le malware ne s'activait que dans le contexte d'un *build de release* du wallet Bitcoin `copay`.
- Il a été découvert *uniquement par hasard*.

#example("Dépendance transitive non détectée")[
  Un projet A dépend de `event-stream`, qui lui-même dépend de `flatmap-stream` (introduit par l'attaquant). Le projet A n'a jamais entendu parler de `flatmap-stream` et pourtant l'exécute à chaque build.
]

== Mars 2022 — `node-ipc` & peacenotwar (CVE-2022-23812)

Les versions 10.1.1 et 10.1.2 du module npm populaire *`node-ipc`* contenaient du code *effaçant le contenu du système de fichiers* des machines dont l'adresse IP était géolocalisée en Biélorussie ou en Russie.

- Le code malveillant a été ajouté dans Git, mais *l'historique a été réécrit* pour en dissimuler la trace.
- *Pas d'attaquant externe* : l'auteur est un mainteneur open source politisé et mécontent.
- Distribué à travers *Vue CLI*, qui dépend de `node-ipc`.

#alert(color: rgb("#dc2626"), icon: "⚠")[
  *Implication pour les RSSI :* toute dépendance, même ancienne et de confiance, peut devenir malveillante à l'occasion d'une mise à jour. L'audit des dépendances doit être continu.
]

== 2020 — SolarWinds : l'attaque qui a tout changé

L'attaque SolarWinds (révélée en décembre 2020) a compromis la plateforme de monitoring IT SolarWinds Orion, utilisée par des milliers d'organisations gouvernementales et privées :

- Code injecté dans le *processus de build* de l'entreprise.
- Binaire légitimement signé, contenant une *backdoor dormante* (~14 jours).
- *Trafic réseau légitime* pour les communications de commande et contrôle.
- *18 000 clients* potentiellement compromis, dont l'armée US, le Pentagone, le département d'État et la NSA.
- Impact également sur le *cours de l'action* de l'entreprise.

#keypoint[
  SolarWinds a démontré que l'*infrastructure de livraison logicielle* — la pipeline CI/CD — est une cible aussi précieuse que les systèmes eux-mêmes.
]

== 2023 — AI Package Hallucination

Avec la généralisation des grands modèles de langage (LLM) pour l'assistance au développement, une nouvelle surface d'attaque a été identifiée en 2023 :

- Les LLM *« hallucinent »* parfois des noms de paquets qui *n'existent pas*.
- Un attaquant *publie réellement* un paquet malveillant sous ce nom sur le registre.
- La prochaine fois qu'un développeur suit la même recommandation du LLM, il installe le malware.

#alert(color: rgb("#7c3aed"), icon: "🤖")[
  *Nouvelle surface d'attaque :* les outils d'IA génèrent du code qui référence des dépendances non vérifiées.
]

== Mars 2024 — XZ Utils : backdoor dans liblzma (CVE-2024-3094)

Découverte *par hasard* : des connexions SSH anormalement lentes alertent un contributeur de PostgreSQL (Andres Freund) sur une machine Debian instable.

- Backdoor *ultra-sophistiquée* cachée dans *liblzma* (xz 5.6.0/5.6.1), ciblant `sshd` via `systemd`.
- Attaque en *5 étages* avec obfuscation : stub de script, tests modifiés, binaires d'extraction `good` / `bad`.
- Infiltration via un faux mainteneur *« Jia Tan »* gagnant la confiance pendant *~3 ans* (sock puppet).
- Valeur d'analyse ajoutée *dans les artefacts* (`.tar.xz`) *et non* dans le dépôt Git.
- *Impact :* porte dérobée RCE dans les accès distants.

#keypoint[
  *Leçon :* compromission d'un mainteneur légitime + build non traçable = risque maximal. Un seul bailleur de fonds maintenait `xz` bénévolement.
]

== Ce n'est pas une liste exhaustive…

Les attaques de supply chain se déclinent selon plusieurs catégories, qui seront approfondies dans les cours suivants :

- *Dépendances* : `left-pad`, `colors.js`, `faker.js`, `ua-parser-js`…
- *Clés & secrets* : tokens CI/CD, credentials publiés dans des dépôts publics…
- *Pipeline CI/CD* : XZ Utils (2024), SolarWinds, Codecov…
- *Agentique* : agents & IA générative — hallucinations de packages, dépendances synthétiques, attaques par prompt injection, agents autonomes malicieux, exfiltration via tooling…

// ============================================================
// STRUCTURE DU MODULE
// ============================================================

= Structure de ce module

L'UE DevSecOps s'organise en trois grandes parties, réparties sur dix cours, complétées par des travaux pratiques, un projet et un contrôle de connaissances.

== Plan de l'UE

*🚀 DevOps — Cours 1 à 5*

- 1 · Introduction DevOps
- 2 · Git & GitFlow
- 3 · Gestion de dépendances
- 4 · CI/CD
- 5 · Conteneurs & images

*🔐 DevSecOps — Cours 6 à 9*

- 6 · Incidents & contre-mesures
- 7 · Attaques Supply Chain Open Source
- 8 · Builds reproductibles
- 9 · GNU Guix & environnements

*🤖 Nouveaux risques — Ère agentique*

- 10 · Agentique & risques émergents

#keypoint[
  Le tout est complété par : 4 TPs pratiques · 1 Projet de groupe · 1 Contrôle de connaissances sur table.
]

== Compétences à l'issue de ce module

- *C1 — Comprendre* une *chaîne de production logicielle moderne* (gestion de versions, dépendances, intégration continue…) et pouvoir interagir avec les architectes chargés de sa maintenance.
- *C2 — Expliquer* les *risques et enjeux* associés à la sécurisation de la chaîne de production logicielle.
- *C3 — Mener* une *analyse des risques d'attaques* sur une supply chain logicielle.
- *C4 — Mettre en place* des *contre-mesures intégrées à la CI/CD* (analyse statique, analyse de dépendances, génération de SBOM).
- *C5 — S'approprier*, en jouant le rôle d'un attaquant, les *techniques d'attaque* utilisées pour compromettre une chaîne de production logicielle.

// ============================================================
// ÉVALUATION
// ============================================================

= Évaluation

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  block(fill: rgb("#eff6ff"), stroke: 1pt + rgb("#2563eb"), radius: 4pt, inset: 10pt)[
    *🧪 Travaux Pratiques* \
    #v(4pt)
    4 TPs pratiques tout au long du semestre. Évaluation sur la qualité des rendus et la démarche.
  ],
  block(fill: rgb("#f5f3ff"), stroke: 1pt + rgb("#7c3aed"), radius: 4pt, inset: 10pt)[
    *📝 Contrôle de Connaissances* \
    #v(4pt)
    Un CC sur table, couvrant l'ensemble des 9 cours.
  ],
  block(fill: rgb("#ecfdf5"), stroke: 1pt + rgb("#059669"), radius: 4pt, inset: 10pt)[
    *🔍 Projet Audit* \
    #v(4pt)
    Vous jouerez le rôle d'*auditeur* sur un projet *open source*, en évaluant les *risques majeurs* et les *contre-mesures* à appliquer.
  ]
)

#v(0.5em)

#keypoint[
  L'objectif n'est pas de mémoriser des commandes, mais de *comprendre les enjeux* et de *raisonner* sur les risques et les pratiques.
]

// ============================================================
// BIBLIOGRAPHIE
// ============================================================

#pagebreak()

= Références et pour aller plus loin

== Ressources en ligne

- *OpenSSF — Securing the Open Source Ecosystem* : #link("https://openssf.org")
- *Snyk — peacenotwar / node-ipc* : #link("https://snyk.io/blog/peacenotwar-malicious-npm-node-ipc-package-vulnerability/")
- *The Register — incident event-stream* : #link("https://www.theregister.com/2018/11/26/npm_reco_bitcoin_stealer/")
- *CISA — SolarWinds Advisory AA21-008A* : #link("https://www.cisa.gov/uscert/ncas/alerts/aa21-008a")
- *CVE-2024-3094 — XZ Utils Backdoor* : la documentation officielle CVE et les analyses techniques (Andres Freund, PostgreSQL) fournissent le détail de l'attaque.
- *Vulcan / VOYAGER18 — AI Package Hallucination* : étude sur les recommandations de paquets par les LLM.

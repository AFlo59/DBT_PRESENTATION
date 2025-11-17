## Présentation du projet dbt

Ce dépôt contient un projet **dbt** structuré pour présenter un pipeline analytique complet basé sur une architecture en couches (`bronze`, `silver`, `gold`). L’objectif est de fournir un exemple pédagogique que vous pouvez exécuter localement pour comprendre comment dbt organise les transformations de données, la documentation et les tests.

## Structure fonctionnelle

- `models/sources` : définition des sources brutes (fichiers seeds, bases, etc.).
- `models/bronze` : ingestion et harmonisation minimale des données.
- `models/silver` : enrichissements, joints, métriques intermédiaires.
- `models/gold` : marts analytiques prêts pour la BI (ex. ventes quotidiennes, performance produit).
- `macros` : helpers réutilisables pour la standardisation, la génération de noms de schéma et les règles métier.
- `analyses`, `tests`, `snapshots` : espaces prêts pour approfondir la gouvernance et la qualité.

## Démarrage rapide

1. Créez un environnement Python : `python -m venv .venv && .\.venv\Scripts\activate`.
2. Installez les dépendances : `pip install -r requirements.txt`.
3. Configurez vos connexions dans `profiles.yml` (un exemple est fourni dans `dbt_presentation/profiles.exemples.yml`).
4. Placez-vous dans `dbt_presentation/` puis lancez :
   - `dbt deps` pour récupérer les packages éventuels.
   - `dbt seed` si vous utilisez les données CSV fournies.
   - `dbt run` pour exécuter les modèles.
   - `dbt test` pour vérifier la qualité.

## Pistes d’utilisation

- Illustrer une démo ou une formation dbt grâce à un jeu de données simple.
- Tester des macros personnalisées (ex. `standardize_column.sql`) dans un projet isolé.
- Servir de base pour expérimenter la modélisation par couches ou la documentation automatique (`dbt docs generate`).

## Ressources utiles

- Documentation officielle : <https://docs.getdbt.com>
- Discourse communautaire : <https://discourse.getdbt.com>
- Slack dbt Community : <https://community.getdbt.com>

_Astuce_ : utilisez `dbt docs serve` après un `dbt docs generate` pour naviguer dans la lignée et les descriptions des modèles directement dans votre navigateur.


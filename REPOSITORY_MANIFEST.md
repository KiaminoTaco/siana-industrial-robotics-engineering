# Repository Package Manifest

## Included

- Consolidated academic README and contribution documentation.
- Clean SIANA APP source and deployment material.
- Project specification (`software/siana-app/docs/cahier_de_charges.pdf`).
- System architecture figure.
- Defect-detection source, notebook, dataset configuration and evaluation artifacts.
- Frontend source and dependency manifests.
- Backend/auth/infrastructure source.
- Dedicated repository structure for electrical, mechanical and embedded work.

## Excluded intentionally

- `node_modules/` and generated `dist/` directories.
- Local `.env` and `.env.production` configuration files.
- Large trained model binaries (`*.pt`, etc.) because they are unsuitable for a normal GitHub repository; use Git LFS or artifact storage.
- Mechanical/electrical CAD and design files that the project owner explicitly requested to add manually later.

## Note

The repository is a source-oriented academic archive. Generated dependencies and secrets are deliberately not packaged.

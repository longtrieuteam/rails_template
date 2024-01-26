# APPNAME

## Dumming DB and Running in local

After changing `.env`, run:

```bash
rails runner 'MagicModels.dump'
annotate --delete && annotate --models
rubocop --parallel -A
```

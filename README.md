# dev-rh-rag-loader

Load new webpages into our PGVector store for RAG.

Create a Secret with your postgres database credentials (this needs to exist already).

```bash
oc apply -f - <<'EOF'
kind: Secret
apiVersion: v1
metadata:
  name: load-new
stringData:
  connection_string: "postgresql+psycopg://postgres:password@postgres:5432/vectordb"
  db_password: "password=password"
type: Opaque
EOF
```

CronJob loader runs nightly.

```bash
oc apply -f load-new.yaml
```

See: https://github.com/eformat/messing-with-models

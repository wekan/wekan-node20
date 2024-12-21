## FerretDB PostgreSQL

1. Start:

```
docker compose up -d
```

2. Create OpLog manually: (I don't know why at docker-compose.yml it does not do that)

```
mongosh

use local

db.createCollection('oplog.rs', { capped: true, size: 536870912 })

exit
```

3. Start WeKan

# Database Replication

## Harlequin command's

```shell
harlequin -a postgres "postgres://root:thordb2024@$THOR_DBHOST:5432/sinarm"
harlequin -a postgres "postgres://root:mjolnirdb2024@$MJOLNIR_DBHOST:5432/sinarm"
harlequin -a postgres "postgres://root:stormbreakerdb2024@$STORMBREAKER_DBHOST:5432/sinarm"
```

```sql
SELECT * , TO_TIMESTAMP(CAST(__kafka_timestamp AS BIGINT)/1000) AS kafka_timestamp
```

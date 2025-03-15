// Replication:
// master - slave
// RF = 3 (sync + async)
//
// Sharding:
// hash based by uuid

s3://host/
├── posts/
│    ├── {uuid1}.{ext}
│    ├── ...

# Private Oracle RDS example

This example creates an Oracle SE2 CDB instance in caller-supplied private data subnets. It demonstrates the generic Oracle inputs, option-group configuration, and an externally managed IAM role for S3 integration.

Set `snapshot_identifier` to restore the instance from an existing snapshot. The database name, master credentials, character sets, and storage encryption settings are then inherited from that snapshot.

Use a currently available engine version in the target AWS region. Oracle engine versions are deliberately supplied by the caller rather than selected inside the module.

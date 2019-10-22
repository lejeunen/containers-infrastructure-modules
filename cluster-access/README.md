# Cluster access

## In AWS

Creates 2 roles , _role-developer_ and _role-admin_, which can be assumed in the specified account

Creates policies for assuming these roles. These policies can be attached to a group (preferred) or a user.

## In kubernetes

Grants full access to the specified namespace to the specified user.

User should match what's defined in aws-auth config map for the _role-developer_ role.

```
- rolearn: arn:aws:iam::8XXXXXXXXX0:role/role-developer
  username: developer
```

## Authentication

Developers who want to interact with the cluster must authenticate with the role.

In AWS credentials file :

```
[dev-role]
role_arn = arn:aws:iam::8XXXXXXX0:role/role-developer
source_profile = actual user configuration name`
```







As I no longer in the k8s@home space, the community has taken this project over.

It has moved to:

https://github.com/DrummyFloyd/crunchy-userinit-controller

------

<div align="center">

# crunchy-userinit-controller

_A simple k8s controller to assist in creating users for the [crunchydata postgres operator][crunchy]._

[![License](https://img.shields.io/github/license/ramblurr/crunchy-userinit-controller?style=for-the-badge&v1)](https://spdx.org/licenses/AGPL-3.0-or-later.html)

</div>


## What?

This is a k8s controller that exists to run `ALTER DATABASE "{database_name}" OWNER TO "{user_name}"`.

This controller should be deployed alongside a [crunchydata postgres-operator][crunchy] `PostgresCluster` instance.

It will watch for `pguser` secrets created by the PostgresCluster (due to you adding [users with databases]( https://access.crunchydata.com/documentation/postgres-operator/latest/tutorials/basic-setup/user-management) to the cluster instance).

When a pguser secret is detected it will open up the secret, pull out the username and dbname, then using superuser creds, it will connect to the database and execute the above `ALTER` statement.

## Why?

🤦

## How?

```
helm repo add crunchy-userinit-controller https://ramblurr.github.io/crunchy-userinit-controller
helm repo update
helm install -n YOUR_DB_NS crunchy-userinit-controller/crunchy-userinit-controller
```

You must label annotate your `PostgresCluster` so the userinit-controller can find it:

``` yaml
---
apiVersion: postgres-operator.crunchydata.com/v1beta1
kind: PostgresCluster
metadata:
  name: "app-db"
  namespace: database
spec:
  metadata:
    labels:
      # This label is required for the userinit-controller to activate
      crunchy-userinit.ramblurr.github.com/enabled: "true"
      # This label is required to tell the userinit-controller which user is the the superuser
      crunchy-userinit.ramblurr.github.com/superuser: "dbroot"
  postgresVersion: 16

  ... snip ...

  users:
  
    # This is the useruser that will be used by the userinit-controller to execute the SQL
    - name: "dbroot"
      databases:
        - "postgres"
      options: "SUPERUSER"
      password:
        type: AlphaNumeric

    # This is a user that will be affected by the userinit-controller
    - name: "nextcloud"
      databases:
        - "nextcloud"
      password:
        type: AlphaNumeric

  ... snip ...
```

## Contributing

When using this repo locally or contributing to this repo, you will need to build the dependencies used for each helm chart.
You can run the following commands to do so:

### The Controller

If you use nix, then just activate the dev shell and you'll be good to go.

On other distros, you'll have to install the requirements yourself.

To run it locally

1. Ensure `KUBECONFIG` is defined
2. `export DEV_MODE=y`
3. Run it:

    ``` sh
    kopf run --dev --namespace YOUR_DB_NS src/userinit.py
    ```


### The Chart

The chart is pretty simple and is in `charts/`

[crunchy]: https://access.crunchydata.com/documentation/postgres-operator/latest/

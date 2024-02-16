
<div align="center">

# crunchy-userinit-controller

_A simple k8s controller to assist in creating users for the [crunchydata postgres operator][crunchy]._

[![License](https://img.shields.io/github/license/ramblurr/crunchy-userinit-controller?style=for-the-badge)](https://opensource.org/licenses/AGPL-3.0)
</div>


## What?

## Why?

## Usage

```
helm repo add crunchy-userinit-controller https://ramblurr.github.io/crunchy-userinit-controller
helm repo update
helm install -n YOUR_DB_NS crunchy-userinit-controller/crunchy-userinit-controller
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

# BeerMeTwice App

[beermetwice.nibir.xyz](http://beermetwice.nibir.xyz/), an app to track daily drinks! 🍻

Source code is on github repository [cheers-counter](https://github.com/nbir/cheers-counter).

iOS app [BeerMeTwice](https://apps.apple.com/us/app/beermetwice/id6743499695) on App Store.

## Instructions

Follow instruction on [cheers-counter/README.md](https://github.com/nbir/cheers-counter/blob/main/README.md) to build Docker image locally and push to registry.

Install the `cheers-counter` static website by applying manifest:

```
kubectl apply -f manifests
```

This will create the following resources:

```
namespace/beermetwice
deployment.apps/cheers-counter
service/cheers-counter
ingress.networking.k8s.io/beermetwice-nibir-xyz
```

To pull the latest docker image, perform a rollout restart (`imagePullPolicy: Always` is set). 

```
kubectl rollout restart deployment cheers-counter
```

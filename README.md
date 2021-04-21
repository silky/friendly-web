# Friendly-Web

[friendly](https://github.com/edsko/friendly) by
[Edsko](https://github.com/edsko), in the browser compiled by
[Miso](https://github.com/dmjio/miso).

The license for `./src/Friendly.hs` is in `License-FRIENDLY` (copied right out
of that repo).

All credit goes to [edkso](https://github.com/edsko) and
[dmjio](https://github.com/dmjio) for making this possible!

### Building locally with Nix

Using the cachix cache prepared for miso:

```
# optional use of cache
nix-env -iA cachix -f https://cachix.org/api/v1/install
# optional use of cache
cachix use miso-haskell
```

Then

```
nix-build
```

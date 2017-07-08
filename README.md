# Matrix Gentoo overlay

This Gentoo overlay contains clients and servers for the Matrix protocol

## Installation

Install this overlay like any other.

* Install [`layman`](https://wiki.gentoo.org/wiki/Layman), Gentoo's official overlay manager.

```
# emerge --ask app-portage/layman
```

* Add the `matrix` overlay

```
# layman -a matrix
```

* Synchronize overlays

```
# layman -S
```

## Contributing

Don't hesitate to create a PR for any other Matrix clients, servers and other services!

You can report any ebuild issues or feature requests in the [issue tracker](https://github.com/puretryout/matrix-overlay/issues).

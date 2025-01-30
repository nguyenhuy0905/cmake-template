# template

> Yet another CMake template of mine.

## Why

I took a look at `cmake-init` and modified to my own use:

- Linking with sanitizers (ASan, UBSan, and such).

## How to use

Modify [this script](./tools/sed.sh), and run it at the project root.

```bash
sh ./tools/sed.sh
```

Modify the `project` section in [the main CMake file](./CMakeLists.txt) to that
of your project.

<!--
    The stuff above this comment should be deleted if you decide to use this
    template.
-->

## Building

See the [BUILDING](BUILDING.md) document.

## Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) document.

## Licensing

Choose your own!

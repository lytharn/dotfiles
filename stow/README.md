## [`stow`](https://www.gnu.org/software/stow/)

    ├── .stow-global-ignore     Ignore files to install from a package
    └── .stowrc                 Set $HOME as default install location

### Install notes

1. Update .stowrc if using older version of stow than 2.3.0, because older versions cannot handle environment variables

**Important:** it should be the first package you install as it is responsible for ignoring files in packages.

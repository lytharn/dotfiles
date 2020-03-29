# Dotfiles
Dotfiles that are organized using GNU Stow and a set of rules.

## Features

- Group dotfiles into packages
- Install only desired packages
- Reuse dotfiles across different setups
- No scripts
- Each package has its own documentation

## Requriments

- GNU Stow (2.3.0 or newer recommended)
- Perl (requirement of GNU Stow)

## Install

1. Install GNU Stow via package handler or build from [source](http://ftp.gnu.org/gnu/stow/)
1. Clone this repository
1. Setup stow: `stow -t ~ stow`
1. Install desired package in:
  * `$HOME`: `stow <package>`
  * `/`: `stow -t / <Package>`

When needed, special install instructions are present in package `README.md` file.

See [stow ducumentation](https://www.gnu.org/software/stow/manual/html_node/Installing-Packages.html)
for more info on how stow installs a package.

## Rules

For this to work, stow and a set of rules are required.

### Structure

The rules are probably best shown using an example that contains all the rules.

    ├── package_in_home                 A lower letter directory containing dotfiles to install in
    │   │                               `$HOME` (the default).
    │   └── README.md
    ├── Package_in_root                 A first upper letter directory containing dotfiles to
    │   │                               install in `/` and not in `$HOME`.
    │   │                               Use stow -t / <package_directory> to install package.
    │   └── README.md
    ├── directory@                      A directory with packages for different environments
    │   │
    │   ├── _common                     Directory to reuse common files across different environments.
    │   │   └── config                  Directory that is linked to from the packages.
    │   ├── @mac                        Directory containing specific files for "mac" environment.
    │   │   └── macrc                   Symlink to ../_common/config
    │   ├── @linux                      Directory containing specific files for "linux" environment.
    │   │   └── linuxrc                 Symlink to ../_common/config
    │   └── README.md
    ├── README.md                       This file
    └── stow                            A directory containing dotfiles for stow.
                                        Need to be installed first so that stow behaves correctly.

### Naming scheme

- Lowercase for packages to install in `$HOME` (the default).
  - Install with `stow <package>`
- Titlecase for packages to install `/`.
  - Install with `stow -t / <package>`
- Leading `@` for packages and subpackages that depend on a specific environment.
- Ending `@` for directories containing packages for different environments.
  - Don't install, install the package for your specific environment
- Leading `_` for non packages.
  - Don't install

### Ignore files

GNU Stow has the ability to ignore files to install from a package.

The stow package contains a .stow-global-ignore file that will ignore files in all packages.
A package can ignore specific files by containing a .stow-local-ignore file.

See [stow documentation](https://www.gnu.org/software/stow/manual/html_node/Types-And-Syntax-Of-Ignore-Lists.html)
for meaning and syntax of the ignore files.

## Uninstall package

Uninstall desired package in:
  * `$HOME`: `stow -D <package_directory>`
  * `/`: `stow -t / -D <Package_directory>`

See [stow ducumentation](https://www.gnu.org/software/stow/manual/html_node/Deleting-Packages.html)
for more info on how stow uninstalls a package.

## Reinstall package

Reinstall desired package in:
  * `$HOME`: `stow -R <package_directory>`
  * `/`: `stow -t / -R <Package_directory>`

This is uninstalls and installs a package.
This is useful for pruning obsolete symlinks from the install location after updating a package.

## Thanks to
I have used pretty much the same rules/structure as [F-dotfiles](https://github.com/Kraymer/F-dotfiles).

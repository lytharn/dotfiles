## [`nvim`](https://neovim.io/)

~
└── .config
    └── nvim
        └── init.vim

### Install notes

1.  Download plug-in manager
    `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1.  Install plugins
    `nvim +PlugInstall`

#### Extra notes for VS Code

Make sure to have the Neo Vim plugin installed

Install plugins in VS Code, by typing `:PluginInstall`

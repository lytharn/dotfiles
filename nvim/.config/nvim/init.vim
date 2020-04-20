if exists('g:vscode')
	" Plugins will be downloaded under the specified directory.
	call plug#begin(stdpath('data') . '/vs_plugged')

	" Declare the list of plugins.

	" Text manipulation
	Plug 'tpope/vim-surround'

	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()
else
	" Plugins will be downloaded under the specified directory.
	call plug#begin(stdpath('data') . '/plugged')

	" Declare the list of plugins.

	" UI
	Plug 'nanotech/jellybeans.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'edkolev/tmuxline.vim'

	" Backup
	Plug 'tpope/vim-obsession'

	" Git
	Plug 'tpope/vim-fugitive'

	" Text manipulation
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'

	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()

	" Jellybeans
	" Use terminals default background color
	let g:jellybeans_overrides = {
				\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
				\}
	if has('termguicolors') && &termguicolors
		let g:jellybeans_overrides['background']['guibg'] = 'none'
	endif
	colorscheme jellybeans

	" vim-airline
	let g:airline_theme = 'wombat'
endif

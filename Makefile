all: inkpot darkglass
	./setup-cli.sh

neovim/colors:
	mkdir -p neovim/colors
darkglass: neovim/colors
	curl https://raw.githubusercontent.com/smancill/darkglass/master/colors/darkglass.vim > neovim/colors/darkglass.vim
inkpot: neovim/colors
	curl https://raw.githubusercontent.com/ciaranm/inkpot/master/colors/inkpot.vim > neovim/colors/inkpot.vim

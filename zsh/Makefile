
# --- Makefile Variables ---

# Makefile directory
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Dotfiles
.OHMYZSH := $(HOME)/.oh-my-zsh
.ZSHRC := $(HOME)/.zshrc

# zsh paths and plugins
.ZSH := $(HOME)/.zsh
ZSH_CUSTOM_PATH := $(.ZSH)/custom
ZSH_THEME_PATH := $(ZSH_CUSTOM_PATH)/themes
ZSH_PLUGIN_PATH := $(ZSH_CUSTOM_PATH)/plugins
ZSH_PLUGINS := $(addprefix $(ZSH_CUSTOM_PATH)/, $(wildcard plugins/*))


# --- ZSH Target ---
zsh: oh-my-zsh $(.ZSHRC) zsh-themes zsh-plugins

# Download and install Oh My Zsh (zsh plugin manager)
oh-my-zsh: $(.OHMYZSH)/oh-my-zsh.sh
$(.OHMYZSH)/oh-my-zsh.sh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	rm -f $(HOME)/.zshrc

# Create symlink for $HOME/.zshrc
$(.ZSHRC): zshrc
	ln -s $(ROOT_DIR)/zshrc $@

# Create symlinks for zsh themes
zsh-themes: $(ZSH_THEME_PATH)
$(ZSH_THEME_PATH): themes
	ln -fs $(ROOT_DIR)/$< $@

# Create symlinks for zsh plugins
zsh-plugins: $(ZSH_PLUGIN_PATH) $(ZSH_PLUGINS)
$(ZSH_PLUGIN_PATH):
	@mkdir -p $@
$(ZSH_CUSTOM_PATH)/%: %
	ln -fs $(ROOT_DIR)/$< $@


# --- Clean ---
realclean: clean
	rm -rf $(.OHMYZSH)

clean: mostlyclean

mostlyclean:
	rm -f $(.ZSHRC) $(.ZSH)


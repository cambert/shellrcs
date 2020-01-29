#
# Automatic management of a collection of small libraries for Emacs.
# 
# Written by Tim Clapp, 
# based upon a template from http://www-verimag.imag.fr/~moy/emacs/

EMACS  = emacs  -batch -no-site-file -no-init-file -q
XEMACS = xemacs -batch -no-site-file -no-init-file -q
LISP_SRC = lisp_src
VHDLMODE = $(LISP_SRC)/vhdl-mode-3.33.22

# Directories to look in for shared files
LISPDIRS = $(LISP_SRC)

EMACSOBJ=elisp
XEMACSOBJ=xelisp

# Extra files for emacs only
EMACS_LISP_SRC_EXTRA= \
  $(VHDLMODE)/vhdl-mode.el

# Extra files for xemacs only
XEMACS_LISP_SRC_EXTRA= \
  $(VHDLMODE)/vhdl-mode.el \
  $(VHDLMODE)/itimer.el

# This was in the Makefile from http://www-verimag.imag.fr/~moy/emacs/
# I'm not convinced it's much use to us -- Tim
# Set the variable AUTOLOADFILE below
# to a filename which will contain all the autoloads. This file must
# then be "required" by your configuration file (.emacs for a single
# user.) by the following line :
# (require 'site-autoloads "~/.autoloads") 
# where, off course, ~/.autoloads is to be replaced by the value of
# AUTOLOADFILE.
AUTOLOADFILE = $(HOME)/.autoloads

#####################################################################

LISPFILES = ${notdir ${wildcard $(LISPDIRS)/*.el}}

# Look in src directories to find sources
vpath %.el $(LISPDIRS)

.PHONY: all clean emacs xemacs

all : emacs xemacs

clean : 
	rm -rf $(EMACSOBJ) $(XEMACSOBJ)

emacs  : $(EMACSOBJ)  $(LISPFILES:%.el=$(EMACSOBJ)/%.elc)
xemacs : $(XEMACSOBJ) $(LISPFILES:%.el=$(XEMACSOBJ)/%.elc)

$(EMACSOBJ):
	mkdir $(EMACSOBJ)

$(XEMACSOBJ):
	mkdir $(XEMACSOBJ)

# Build rules for byte compiling: we need to copy .el file in before
# compiling, then remove it afterwards
$(EMACSOBJ)/%.elc : %.el
	@echo "Byte compiling the source file "$<
	p4 edit $@
	@cp -f $< $(@D)
	$(EMACS) -f batch-byte-compile $(@D)/$(^F)
	@rm $(@D)/$(^F)

$(XEMACSOBJ)/%.elc : %.el
	@echo "Byte compiling the source file "$<
	p4 edit $@
	@cp -f $< $(@D)
	$(XEMACS) -f batch-byte-compile $(@D)/$(^F)
	@rm $(@D)/$(^F)

# Verilog mode needs to load itself in emacs to be able to byte compile
$(EMACSOBJ)/verilog-mode.elc : verilog-mode.el
	@echo "Byte compiling the source file "$<
	@cp $< $(@D)
	$(EMACS) -l $(@D)/$(^F) -f batch-byte-compile $(@D)/$(^F)
	@rm $(@D)/$(^F)

autoloads : $(AUTOLOADFILE).elc

# This was in the Makefile from http://www-verimag.imag.fr/~moy/emacs/
# I'm not convinced it's much use to us -- Tim
$(AUTOLOADFILE).el: $(LISPFILES)
	@$(RM) $@;
	@echo "(provide 'nellie-autoloads)" > $@;
	@echo "" >> $@;
	$(EMACS) -batch -q -l autoload \
		--eval '(setq generated-autoload-file "$@")' \
		--eval "(if (featurep 'xemacs) (delete-file generated-autoload-file))" \
		--eval '(setq make-backup-files nil)' \
		-f batch-update-autoloads $(LISPDIRS)

$(AUTOLOADFILE).elc: $(AUTOLOADFILE).el
	@echo "Byte compiling the autoload file "$<
	@$(EMACS) -batch -q -f batch-byte-compile $^
	@echo "*******************************************************************"
	@echo "Autoloads up to date. Put the following lines in your configuration"
	@echo "file (~/.emacs for a single user) :"
	@echo
	@echo ${patsubst %, "(add-to-list 'load-path \""%"\")   ", $(LISPDIRS)}
	@echo "(require 'nellie-autoloads \""$(AUTOLOADFILE)"\")"
	@echo


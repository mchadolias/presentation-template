# Minimal Makefile for Physics Presentation

# --------------------------------------------------
# Repository paths
# --------------------------------------------------
ROOT_DIR := $(abspath .)

# --------------------------------------------------
# Configuration (defaults: main presentation)
# --------------------------------------------------
MAIN        ?= main
BUILD_DIR   ?= build
STYLES_DIR  = styles
PREAMBLE_DIR = preamble

MAIN_TEX := $(ROOT_DIR)/$(MAIN).tex

# --------------------------------------------------
# Style management
# --------------------------------------------------
STYLES = classic modern
CURRENT_STYLE ?= classic
STYLE_FILE = $(ROOT_DIR)/$(STYLES_DIR)/$(CURRENT_STYLE).sty

# --------------------------------------------------
# LaTeX configuration
# --------------------------------------------------
LATEX = pdflatex
LATEX_OPTS = -shell-escape -interaction=nonstopmode -output-directory=$(BUILD_DIR)

TEXINPUTS := $(ROOT_DIR)/$(PREAMBLE_DIR)//:$(TEXINPUTS):
export TEXINPUTS

RM = rm -rf

.PHONY: all example clean clean-all classic modern help

# --------------------------------------------------
# Default target (main presentation)
# --------------------------------------------------
all: $(BUILD_DIR)/$(notdir $(MAIN)).pdf

# --------------------------------------------------
# Example target
# --------------------------------------------------
example:
	@$(MAKE) MAIN=examples/minimal/main \
	         BUILD_DIR=build/example \
	         all

# --------------------------------------------------
# PDF generation
# --------------------------------------------------
$(BUILD_DIR)/$(notdir $(MAIN)).pdf: $(MAIN_TEX) $(STYLE_FILE) | $(BUILD_DIR)
	@echo "Compiling $(MAIN).tex with $(CURRENT_STYLE) style..."
	cd $(BUILD_DIR) && ln -sf $(STYLE_FILE) $(notdir $(MAIN))_style.sty
	$(LATEX) $(LATEX_OPTS) $(MAIN_TEX)
	$(LATEX) $(LATEX_OPTS) $(MAIN_TEX)
	@echo "Build complete: $(BUILD_DIR)/$(notdir $(MAIN)).pdf"

# --------------------------------------------------
# Build directory
# --------------------------------------------------
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# --------------------------------------------------
# Style switching targets
# --------------------------------------------------
classic modern:
	$(eval CURRENT_STYLE = $@)
	@$(MAKE) clean
	@$(MAKE) all
	@echo "Switched to $@ style"

# --------------------------------------------------
# Cleaning
# --------------------------------------------------
clean:
	$(RM) $(BUILD_DIR)

clean-all:
	$(RM) build

# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	@echo "Minimal Physics Presentation Template"
	@echo ""
	@echo "Targets:"
	@echo "  all        Build the main presentation (default)"
	@echo "  example    Build the minimal example presentation"
	@echo "  clean      Remove current build directory"
	@echo "  clean-all  Remove all build outputs"
	@echo "  classic    Switch to classic style and rebuild"
	@echo "  modern     Switch to modern style and rebuild"
	@echo "  help       Show this help message"
	@echo ""
	@echo "Current style: $(CURRENT_STYLE)"

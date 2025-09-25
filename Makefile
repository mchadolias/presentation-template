# Minimal Makefile for Physics Presentation

# Configuration
MAIN = main
BUILD_DIR = build
STYLES_DIR = styles
PREAMBLE_DIR = preamble
CONTENT_DIR = content

# Style management
STYLES = classic modern
CURRENT_STYLE = modern
STYLE_FILE = $(STYLES_DIR)/$(CURRENT_STYLE).sty

# LaTeX configuration
LATEX = pdflatex
LATEX_OPTS = -shell-escape -interaction=nonstopmode -output-directory=$(BUILD_DIR)
TEXINPUTS := $(PREAMBLE_DIR)//:$(TEXINPUTS):
export TEXINPUTS

RM = rm -rf

.PHONY: all clean clean-all classic modern help

# Default target
all: $(BUILD_DIR)/$(MAIN).pdf

# Main PDF generation
$(BUILD_DIR)/$(MAIN).pdf: $(MAIN).tex $(CONTENT_DIR)/intro.tex $(STYLE_FILE) | $(BUILD_DIR)
	@echo "Compiling $(MAIN).tex with $(CURRENT_STYLE) style..."
	cd $(BUILD_DIR) && ln -sf ../$(STYLE_FILE) $(MAIN)_style.sty
	$(LATEX) $(LATEX_OPTS) ../$(MAIN).tex
	$(LATEX) $(LATEX_OPTS) ../$(MAIN).tex
	@echo "Build complete: $(BUILD_DIR)/$(MAIN).pdf"

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Style switching targets
classic modern:
	$(eval CURRENT_STYLE = $@)
	@make clean
	@make $(BUILD_DIR)/$(MAIN).pdf
	@echo "Switched to $@ style"

# Cleaning targets
clean:
	$(RM) $(BUILD_DIR)

# Help
help:
	@echo "Minimal Physics Presentation Template"
	@echo ""
	@echo "Targets:"
	@echo "  all       Build the presentation (default)"
	@echo "  clean     Remove all generated files"
	@echo "  classic   Switch to classic style and rebuild"
	@echo "  modern    Switch to modern style and rebuild"
	@echo "  help      Show this help message"
	@echo ""
	@echo "Current style: $(CURRENT_STYLE)"
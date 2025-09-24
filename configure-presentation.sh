#!/bin/bash

CONFIG_FILE="config/presentation.conf"
INFO_FILE="presentation-info.tex"

# Default values
TITLE="Physics Presentation"
AUTHOR="Researcher"
INSTITUTE="Institution"
DATE="\\today"
EVENT="Seminar"
LOCATION=""
EMAIL=""
STYLE="modern"

# Load configuration if exists
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi

apply_config() {
    cat > "$INFO_FILE" << EOF
% Auto-generated presentation metadata
% Edit config/presentation.conf and rerun ./configure-presentation.sh

\\title{$TITLE}
\\author{$AUTHOR}
\\institute{$INSTITUTE}
\\date{$DATE}
\\newcommand{\\presentationevent}{$EVENT}
\\newcommand{\\presentationlocation}{$LOCATION}
\\newcommand{\\email}{$EMAIL}
EOF
}

interactive_config() {
    echo "Configure Presentation Details:"
    read -p "Title [$TITLE]: " input_title
    read -p "Author [$AUTHOR]: " input_author
    read -p "Institute [$INSTITUTE]: " input_institute
    read -p "Event [$EVENT]: " input_event
    read -p "Email [$EMAIL]: " input_email
    read -p "Style (classic/modern) [$STYLE]: " input_style

    TITLE="${input_title:-$TITLE}"
    AUTHOR="${input_author:-$AUTHOR}"
    INSTITUTE="${input_institute:-$INSTITUTE}"
    EVENT="${input_event:-$EVENT}"
    EMAIL="${input_email:-$EMAIL}"
    STYLE="${input_style:-$STYLE}"

    # Update config file
    cat > "$CONFIG_FILE" << EOF
# Presentation Configuration
TITLE="$TITLE"
AUTHOR="$AUTHOR"
INSTITUTE="$INSTITUTE"
EVENT="$EVENT"
EMAIL="$EMAIL"
STYLE="$STYLE"
DATE="\\today"
EOF
}

case "${1:-}" in
    "interactive")
        interactive_config
        apply_config
        ;;
    "edit")
        ${EDITOR:-nano} "$CONFIG_FILE"
        apply_config
        ;;
    *)
        apply_config
        ;;
esac

# Also update Makefile style if changed
sed -i.bak "s/^CURRENT_STYLE = .*/CURRENT_STYLE = $STYLE/" Makefile
rm -f Makefile.bak

echo "Presentation configuration updated!"
echo "Run 'make' to rebuild with new settings."
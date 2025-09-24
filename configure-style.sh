#!/bin/bash
# configure.sh - Minimal style configuration script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STYLES=("classic" "modern")
CURRENT_STYLE="modern"

show_usage() {
    echo "Usage: $0 [style]"
    echo "Available styles: ${STYLES[*]}"
    echo "Current style: $CURRENT_STYLE"
}

list_styles() {
    echo "Available styles:"
    for style in "${STYLES[@]}"; do
        if [ "$style" = "$CURRENT_STYLE" ]; then
            echo "  * $style (current)"
        else
            echo "    $style"
        fi
    done
}

set_style() {
    local style=$1
    
    if [[ ! " ${STYLES[@]} " =~ " ${style} " ]]; then
        echo "Error: Unknown style '$style'"
        show_usage
        return 1
    fi
    
    # Update Makefile variable
    sed -i.bak "s/^CURRENT_STYLE = .*/CURRENT_STYLE = $style/" "$SCRIPT_DIR/Makefile"
    rm -f "$SCRIPT_DIR/Makefile.bak"
    
    echo "Style set to: $style"
    echo "Run 'make' to rebuild with the new style"
}

# Main script
if [ $# -eq 0 ]; then
    list_styles
    exit 0
fi

case $1 in
    -h|--help)
        show_usage
        ;;
    list)
        list_styles
        ;;
    *)
        set_style "$1"
        ;;
esac
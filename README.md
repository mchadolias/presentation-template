# LaTeX Beamer Presentation Template 🎓⚛️

![LaTeX](https://img.shields.io/badge/LaTeX-Professional-blue.svg)  ![Beamer](https://img.shields.io/badge/Beamer-Presentations-green.svg)

A modern, modular LaTeX Beamer template designed specifically for physics presentations with a prefrence in particle physics. Features two distinct styles (classic academic and modern clean) with easy configuration and automation.

## 📁 Project Structure

```md
presentation-template/
├── config/
│   └── presentation.conf      # Human-editable config
│
├── content/                   # Slide content modules
│   ├── 01-introduction.tex    # Example
│   ├── 02-motivation.tex
│   ├── 03-methodology.tex
│   └── 04-results.tex
│
├── preamble/                  # Packages list
│   ├── 00-preamble.tex        # Wrapper of all packages for main.tex
│   ├── 01-packages.tex        # Load order matters
│   ├── 02-physics.tex
│   ├── 03-math.tex
│   └── 04-custom.tex
│
├── styles/                    # Beamer style definitions
│   ├── classic.sty
│   ├── modern.sty
│   └── custom.sty             # For future expansion
│
├── build/                     # Auto-generated
│
├── main.tex
├── presentation-info.tex      # Auto-generated from config
├── Makefile
├── README.md
├── main.tex
├── configure-presentation.sh  # Bash script for presentation detail configuration
├── configure-style.sh         # Bash script for style selection
└── .gitignore      
```

## 🚀 Quick Start

### Prerequisites

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- `beamer` and essential LaTeX packages (`texlive-full` recommended)
- `make` utility

Example for Ubuntu/Debian based OS:

```bash
sudo apt install texlive-luatex texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-science
```

### Installation

```bash
git clone git@github.com:mchadolias/presentation-template.git
cd presentation-template
```

### Usage

```bash
### Configure presentation details
./configure-presentation.sh interactive

### Choose style
./configure-style.sh <option> (classic, modern)

### Compilation
make
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

I am open to outside contributions! Please feel free to:

- Report bugs and issues
- Suggest new features or styles
- Submit pull requests for improvements

## 📞 Contact

- **Issues:** [Github Project](https://github.com/mchadolias/presentation-template/issues)
- **Emails:** [mchadolias@gmail.com](mailto:mchadolias@gmail.com)

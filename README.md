# dotfiles

A repository for managing my shell and editor configuration files. Instead of manually copying custom aliases and settings each time I provision a new VM or machine, I simply clone this repo and run the installer script.

## Supported Files

- **Included (sourced) files** (`*.custom`, `*.local`)
  - Right now:  
    - `.bashrc.custom`
    - `.zshrc.custom`  
  - In the future you can drop in:  
    - `.vimrc.custom`  
    - `.tmux.conf.local`  
    - `.gitconfig.local`  
    - `.profile.custom`  
    - `.bash_profile.custom`  
    - …and more

- **Replaced files** (no suffix)  
  Any file in `dotfiles.d/` without a `.custom` or `.local` suffix will be copied directly to your home directory, overwriting an existing one if present.

## Quick Start

```bash
git clone https://github.com/andyahn/dotfiles.git
cd ~/dotfiles
./apply.sh
```

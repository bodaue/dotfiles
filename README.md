# dotfiles

My personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

- **Shell** — `.zshrc`, `.profile`
- **Git** — `.gitconfig`, global ignore
- **Micro** — theme, keybindings
- **k9s** — config, aliases, dark skin
- **SSH** — host configs

## Usage

```bash
git clone git@github.com:bodaue/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo apt install stow
stow -t ~ .
```

To remove symlinks:

```bash
stow -t ~ -D .
```

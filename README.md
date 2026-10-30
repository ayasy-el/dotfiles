# Dotfiles

Konfigurasi pribadi untuk Arch/KDE (KineticWE), dikelola dengan [GNU Stow](https://www.gnu.org/software/stow/).

## Struktur

| Paket       | Isi                                                                                                            |
| ----------- | -------------------------------------------------------------------------------------------------------------- |
| `shell`     | `.zshrc`, `.bashrc`, `.bash_profile`, `.profile`                                                               |
| `starship`  | `.config/starship.toml`                                                                                        |
| `nvim`      | `.config/nvim` (LazyVim + AstroCore)                                                                           |
| `zed`       | `.config/zed` (settings + theme)                                                                               |
| `vscode`    | `.config/Code/User/{settings,keybindings}.json`                                                                |
| `ghostty`   | `.config/ghostty` (config, themes, shaders) — terminal default                                                 |
| `kitty`     | `.config/kitty`                                                                                                |
| `foot`      | `.config/foot/foot.ini`                                                                                        |
| `cava`      | `.config/cava`                                                                                                 |
| `kde`       | `kdeglobals`, `kwinrc`, `kwinrulesrc`, `kglobalshortcutsrc`, `plasmarc`, `plasmashellrc`, `plasma-*-appletsrc` |
| `kineticwe` | `.config/kineticwe/*.kwe` + `*outputconfig.json`                                                               |

## Pakai

```sh
cd ~/dotfiles

./install.sh              # stow semua paket
./install.sh nvim zed     # stow paket tertentu
stow -D -t ~ nvim         # lepas symlink satu paket
stow -R -t ~ nvim         # restow setelah menambah/menghapus file
```

Butuh `stow` (`sudo pacman -S stow`).

Clone di mesin baru:

```sh
git clone --recurse-submodules <url> ~/dotfiles
```

`ghostty/.config/ghostty/shaders` adalah submodule
[ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders),
jadi butuh `--recurse-submodules` (atau `git submodule update --init`).

## Menambah konfigurasi baru

```sh
mkdir -p ~/dotfiles/<paket>/<path-relatif-home>
mv ~/.config/<app> ~/dotfiles/<paket>/.config/
cd ~/dotfiles && stow -t ~ <paket>
```

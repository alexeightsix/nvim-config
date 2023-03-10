docker run -it archlinux/archlinux:latest bash -c "pacman -Syu --noconfirm && \
  pacman -S git fzf nodejs php npm neovim ripgrep fd --noconfirm && \
  git clone https://github.com/alexeightsix/nvim-config.git ~/.config/nvim-config && \
  mv ~/.config/nvim-config ~/.config/nvim && \
  nvim"

<h1 align="center">schanze<sub><sup><sub><samp>❄️</samp></sub></sup></sub>nix</h1>

<div align="center">

[![home-manager](https://img.shields.io/badge/home--manager-26.05-red.svg?style=flat-square&color=99e6ff&logo=nixos&logoColor=white)](https://github.com/nix-community/home-manager)
[![last commit](https://img.shields.io/github/last-commit/glmlm/schanze.nix?style=flat-square&color=ffe699)](https://github.com/glmlm/schanze.nix/pulse)
[![issues](https://img.shields.io/github/issues/glmlm/schanze.nix?style=flat-square&color=ff9999)](https://github.com/glmlm/schanze.nix/issues)

</div>

schanze.nix is a minimal [Home Manager](https://nix-community.github.io/home-manager/) / [NixOS](https://nixos.org/) setup designed to highlight common pitfalls and slightly tricky parts.

## Installation & Setup

### Install Nix

Install Nix by following the [official installer guide](https://github.com/NixOS/nix-installer#install-nix).

```sh
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install
```

### Fork and Clone the Repository

<details>

<summary>Proxy settings (Optional)</summary>

If you are behind a proxy, set it for the Nix daemon.

```sh
export https_proxy=http://user:passwd@proxy-server:port
sudo systemctl set-environment https_proxy="${https_proxy}"
sudo systemctl restart nix-daemon
```

</details>

[Fork this repository](https://github.com/glmlm/schanze.nix/fork) and clone it to your preferred location (e.g., `~/.config/home-manager`).

```sh
nix shell nixpkgs#git
git clone https://github.com/your-username/schanze.nix ~/.config/home-manager
```

### Initial Bootstrap

> [!IMPORTANT]
> Update `user.nix` to match your environment before activating the configuration. Activation will fail if the values are incorrect.

Depending on your operating system, follow the instructions below to activate the configuration.

<details open>

<summary>🐧 Linux (non-NixOS)</summary>

```sh
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager -b bak
sudo $(command -v non-nixos-gpu-setup)
```

</details>

<details>

<summary>❄️ NixOS</summary>

```sh
nixos-generate-config --dir ~/.config/home-manager
git -C ~/.config/home-manager add hardware-configuration.nix
sudo nixos-rebuild switch --flake ~/.config/home-manager
```

</details>

<details>

<summary>🍎 macOS</summary>

```sh
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager -b bak
```

</details>

## Apply Changes

Nix requires an explicit switch to apply your configurations.

> [!NOTE]
> All files must be tracked by git before running.

```sh
nh home switch
```

Use the `-u` flag to fetch the latest flake inputs when upgrading applications to their latest versions.

```sh
nh home switch -u
```

If you are on NixOS, use `nh os switch` instead.

## Cleanup

Nix accumulates old generations as you switch configurations. To keep the disk clean, garbage collection is automated.  
You can check the next scheduled run by `systemctl --user status nh-clean.timer`.

If you need to clear space immediately, first use `home-manager generations` to review your history.  
Then, you can prune old entries while keeping the most recent ones.

```sh
nh clean all -k 5
```

Alternatively, you can delete all previous generations if you are certain you won't need to roll back.

> [!WARNING]
> This action is irreversible. You will not be able to roll back to earlier configurations.

```sh
nh clean all
```

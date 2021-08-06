{ config, pkgs, ... }:
let
fzf-tab-completion = {
	name = "zsh-tab-completion";
	file = "zsh/fzf-zsh-completion.sh";
	src = pkgs.fetchFromGitHub {
		owner = "lincheney";
		repo = "fzf-tab-completion";
		rev = "53eb325f573265a6105c9bd0aa56cd865c4e14b7";
		sha256 = "sha256-hvlz8/mdg9spKy2RLhqPukqdawd9+MEvW31smCsuUhA=";
	};
};
zsh-nix-shell = {
	name = "zsh-nix-shell";
	file = "nix-shell.plugin.zsh";
	src = pkgs.fetchFromGitHub {
		owner = "chisui";
		repo = "zsh-nix-shell";
		rev = "v0.2.0";
		sha256 = "1gfyrgn23zpwv1vj37gf28hf5z0ka0w5qm6286a7qixwv7ijnrx9";
	};
};
in
{



	imports = [../../pkgs/base16.nix];
	home.packages = with pkgs; [discord wget firefox dmenu steam xmobar opentabletdriver];
	nixpkgs.config.allowUnfree = true;
	home.stateVersion = "21.05";
	home.username = "dia45";
	home.homeDirectory = "/home/dia45";

	programs.fzf.enable = true;

#	programs.neovim = {
#		enable = true;
#		plugins = with pkgs.vimPlugins; [ vim-airline ];
#		settings = { ignorecase = true; };
#		extraConfig = ''
#                       set mouse=a
#			'';
#	};

	programs.git = {
		enable = true;

		userName = "Dia45";
		userEmail = "arthurmullerboes@gmail.com";
		package = pkgs.gitFull;

		extraConfig = {
			core.editor = "vim";
		};

		delta = {
			enable = true;
			options = {
				features = "side-by-side line-numbers decorations";
				syntax-theme = "gruvbox-dark";
				plus-style = ''syntax "#003800"'';
				minus-style = ''syntax "#3f0001"'';
				decorations = {
					commit-decoration-style = "bold yellow box ul";
					file-style = "bold yellow ul";
					file-decoration-style = "none";
					hunk-header-decoration-style = "cyan box ul";
				};
				delta = {
					navigate = true;
				};
			};
		};
	};	

	programs.keychain = {
		enable = true;
		keys = [ "id_ed25519" ];
	};

	programs.zsh = {
		enable = true;
		enableSyntaxHighlighting = true;
		autocd = true;
		shellAliases.rb = "sudo nixos-rebuild switch --flake '.#nixos'";

		prezto = {
			enable = true;

			pmodules = [
				"environment"
					"terminal"
					"editor"
					"history"
					"directory"
					"spectrum"
					"utility"
					"completion"
					"syntax-highlighting"
					"prompt"
					"tmux"
					"git"
			];

			editor = {
				dotExpansion = true;
				keymap = "vi";
			};
			tmux = {
				autoStartRemote = true;
				defaultSessionName = "default";
			};
			syntaxHighlighting = {
				highlighters = [ "main" "brackets" "pattern" "line" "cursor" "root" ];
			};

			extraConfig = ''
				zstyle ':prezto:module:git:alias' skip 'yes'
				zstyle ':prezto:module:utility' safe-ops 'no'
				'';
		};

		plugins = [
			zsh-nix-shell
				fzf-tab-completion
		];

		initExtra = ''
			unsetopt BEEP
			'';
	};	


	programs.chromium = {
		enable = true;
		extensions = [
			"pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy badger
				"cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock origin
				"eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
				{
					id = "cmhmcmgkegfffbbfobhjpdbimgmoohap"; # slate azul cinza
						version = "2";
				}
		];
	};


	programs.kitty = {
		enable = true;

		font.package = pkgs.source-code-pro;
		font.name = "Source Code Pro";
		font.size = 11;

		settings = {
			window_padding_width = 6;
			enable_audio_bell = false;
		};
	};
}


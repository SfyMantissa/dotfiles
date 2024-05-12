#               __       ____ __
#   __ _  ___ _/ /_____ / _(_) /__
#  /  ' \/ _ `/  '_/ -_) _/ / / -_)
# /_/_/_/\_,_/_/\_\__/_//_/_/\__/
#

all:
	stow --dotfiles --ignore=png --verbose --target=$$HOME --restow */

remove:
	stow --dotfiles --ignore=png --verbose --target=$$HOME --delete */


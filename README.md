My vim config
=============

Install
-------
    rm -rf ~/.vim ~/.vimrc ~/.config/nvim;
    git clone https://github.com/imbolc/.vim
    ln -s ~/.vim/.vimrc ~/
    ln -s ~/.vim ~/.config/nvim

    cd ~/.vim
    python3 -m venv py3env
    ./py3env/bin/pip install wheel
    ./py3env/bin/pip install -r requirements.txt

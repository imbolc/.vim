My vim config
=============

Install
-------

Remove old vim config:

    rm -R ~/.vim ~/.vimrc

Clone git repositore:

    git clone https://github.com/imbolc/.vim

Create simlink:
    
    ln -s ~/.vim/.vimrc ~

Setup Vundle:

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

Install bundles (from vim):

    :BundleInstall

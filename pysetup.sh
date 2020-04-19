#!/usr/bin/bash

# Required variables:
# $1: project name e.g. `foo`
# $2: python version, 3-part e.g. `3.8.0`.

# This script sets up a new virtualenvwrapper project
# and copies in some boilerplate that I find useful.

# This is a very basic script that doesn't check for any fuckups.

HERE=$(pwd)
source /usr/bin/virtualenvwrapper.sh
mkproject -p $HOME/.pyenv/versions/$2/bin/python $1
cd $PROJECT_HOME
poetry new --src $1
cd $PROJECT_HOME/$1
git init .
rm -Rf tests/*
rm -Rf src/$1/*
cp $HERE/MIT_License_Template ./LICENSE
cp $HERE/mypy.ini .
cp $HERE/pylintrc .
cp $HERE/.bandit .
cp $HERE/.flake8 .
cp $HERE/.gitignore .
cp -r $HERE/.vscode/ .
poetry add --dev isort black pylint flake8 bandit mypy
echo -e "\n[tool.black]\nline-length=79" >> $PROJECT_HOME/$1/pyproject.toml
# year=$(date +'%Y')
# my_name=$(git config user.name)
sed -i "s/\[year]/$(date +'%Y')/" $PROJECT_HOME/$1/LICENSE
sed -i "s/\[fullname]/$(git config user.name)/" $PROJECT_HOME/$1/LICENSE
echo -e "\nSetup Complete.\n\nActivate virtual environment by running:"
echo -e "    \$ workon $1\n"

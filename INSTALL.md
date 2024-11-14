# Installation

## OS and Hardware Specifications
This was ran on Ubuntu Server 24.0.1 hosted using a Virtual Machine. MacOS (version higher than Sierra) might also work, but has not been tested. Avoid using Windows, one of the dependencies (jaxlib) will fail to install.

Most modern computers should work. The main requirement, that I experienced, is that your CPU must be able to run A7X instructions.

For more details, look at Tensorflow's specifications.

## Install Guide

Install python version 3.8.20 (any 3.8.x versions may also work).

Clone this repository:
```bash
git clone https://github.com/butterman0423/SGN_patching.git
```

Enter the repository:
```bash
cd /path/tp/repository
```

Create a .venv virtual environment and connect to it:
```bash
source .venv/bin/activate
```

Run the following pip commands to install required dependencies:
```bash
pip install --upgrade pip setuptools
pip install jaxlib==0.1.76 -f https://storage.googleapis.com/jax-releases/jax_releases.html
pip install ./uncertainty-baselines[jax,models,datasets]
pip install --no-deps dm-haiku==0.0.6
```

You are now able to run the tests. See the original SGN repository (https://github.com/ErikEnglesson/SGN) for directions on how to run each test.
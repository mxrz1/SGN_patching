#! /usr/bin/bash

source .venv/bin/activate

pip install --upgrade pip setuptools
pip install jaxlib==0.1.76 -f https://storage.googleapis.com/jax-releases/jax_releases.html
pip install ./uncertainty-baselines[datasets,models]

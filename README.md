# iammordaty/essentia-docker

Custom Essentia build to support [high-level model classification](https://github.com/MTG/essentia/blob/master/doc/sphinxdoc/streaming_extractor_music.rst#high-level-classifier-models) and [Chromaprint](https://acoustid.org/chromaprint) calculations in [essentia_streaming_extractor_music](https://github.com/MTG/essentia/blob/master/doc/sphinxdoc/streaming_extractor_music.rst).

This image is aviable on Docker Hub: https://hub.docker.com/r/iammordaty/essentia.

## Overview

Image overview:

- Based on Ubuntu 18.04,
- Gaia (ver. [2.4.6](https://github.com/MTG/gaia/releases/tag/v2.4.6)) configured with `--with-python-bindings`,
- Essentia (rev. [4237da97237397caf837dc79020f34af8dfc35b2](https://github.com/MTG/essentia/commit/4237da97237397caf837dc79020f34af8dfc35b2)) configured with `--mode=release --with-gaia --with-example=streaming_extractor_music`
- SVM models (trained with essentia ver. [2.1_beta5](https://github.com/MTG/essentia/releases/tag/v2.1_beta5)) downloaded from https://essentia.upf.edu/svm_models ([direct link](https://essentia.upf.edu/svm_models/essentia-extractor-svm_models-v2.1_beta5.tar.gz))

## Additional links

Essentia:
* https://essentia.upf.edu
* https://essentia.upf.edu/svm_models
* https://essentia.upf.edu/gaia/index.html
* https://github.com/MTG/essentia
* https://github.com/MTG/essentia-docker

Chromaprint:
* https://acoustid.org/chromaprint

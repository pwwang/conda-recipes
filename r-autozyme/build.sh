#!/bin/bash

# 'Autobrew' is being used by more and more packages these days
# to grab static libraries from Homebrew bottles. These bottles
# are fetched via Homebrew's --force-bottle option which grabs
# a bottle for the build machine which may not be macOS 10.9.
# Also, we want to use conda packages (and shared libraries) for
# these 'system' dependencies. See:
# https://github.com/jeroen/autobrew/issues/3
export DISABLE_AUTOBREW=1

# R refuses to build packages that mark themselves as Priority: Recommended
mv autozyme_r/DESCRIPTION autozyme_r/DESCRIPTION.old
grep -va '^Priority: ' autozyme_r/DESCRIPTION.old > autozyme_r/DESCRIPTION
# shellcheck disable=SC2086
${R} CMD INSTALL --build autozyme_r ${R_ARGS}

# Add more build steps here, if they are necessary.

# See
# https://docs.conda.io/projects/conda-build
# for a list of environment variables that are set during the build process.

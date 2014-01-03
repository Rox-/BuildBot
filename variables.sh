#!/usr/bin/env bash

# Device name to build
if [ -z "$DEVICE" ]
then
  echo Device not specified
  exit 1
fi

# Branch to sync and build
if [ -z "$REPO_BRANCH" ]
then
  echo REPO_BRANCH not specified
  exit 1
fi

# Rom name
if [ $REPO_BRANCH = "jellybean" ] || [ $REPO_BRANCH =~ "cm-" ]
then
  ROM_NAME="cm_"
elif [ $REPO_BRANCH = "omni-4.3" ] || [ $REPO_BRANCH = "omni-4.4" ]
then
  ROM_NAME="omni_"
else
  echo ROM not supported.
  exit 1
fi

# Debug level
if [ $DBG = "true" ]
then
  DEBUG=eng
else
  DEBUG=userdebug
fi

# Lunch
export LUNCH="$ROM_NAME$DEVICE-$DEBUG"

# Upload folder
if [ $DEVICE = "codina" ]
then
  export FOLDER=26295
elif [ $DEVICE = "codinap" ]
then
  export FOLDER=29956
elif [ $DEVICE = "janice" ]
then
  export FOLDER=26296
else
  echo Device upload not supported
  export UPLOAD=false
fi

# DevHost Nickname and password
if [ -z "$DH_PASSWORD" ] || [ -z "$DH_USER" ]
then
  echo DevHost Password or user not specified.
  echo Upload will be skipped
  export UPLOAD=false
fi

# Clean directory before building
if [ -z "$CLEAN" ]
then
  echo CLEAN not specified
  exit 1
fi

#DEFAULT VALUES
# Kernel only
if [ -z "$KERNEL_ONLY" ]
then
  export KERNEL_ONLY="false"
fi

# Single package
if [ -z "$SINGLE_PACKAGE" ]
then
  export SINGLE_PACKAGE="false"
fi

# Cherrypicking
if [ -z "$CHERRYPICK_COMMITS" ]
then
  export CHERRYPICK_COMMITS="true"
fi

# Sync
if [ -z "$SYNC" ]
then
  export SYNC="true"
fi

# Sync protocol
if [ -z "$SYNC_PROTO" ]
then
  SYNC_PROTO=https
fi

# Upload description
if [ -z "$DESC" ]
then
  DESC=None
fi

# Public upload
if [ -z "$PUBLIC" ]
then
  export PUBLIC="false"
fi

if [ $PUBLIC = "true" ]
then
  export DH_PUB=1
else
  export DH_PUB=0
fi

#!/bin/bash -e

if getent passwd $NBGRADER_USER_ID > /dev/null ; then
  echo "$NBGRADER_USER ($NBGRADER_USER_ID) exists"
else
  useradd -u $NBGRADER_USER_ID -s /bin/bash $NBGRADER_USER
fi
export HOME=/home/$NBGRADER_USER
export USER=$NBGRADER_USER
sudo -E -u $NBGRADER_USER /srv/formgrade.sh $@
#!/bin/bash

(cd gpdb && git remote update && git reset --hard origin/5X_STABLE)
(cd gporca && git remote update && git reset --hard tags/v2.54.2)

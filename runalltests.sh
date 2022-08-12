#!/bin/sh

set -x

flutter test
cd example || exit
flutter test
cd ..
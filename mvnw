#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# Apache Maven Wrapper startup batch script, version 3.3.2
# ----------------------------------------------------------------------------

# If specified, validates that the maven version is correct.
MAVEN_WRAPPER_PROPERTIES_PROPERTIES=".mvn/wrapper/maven-wrapper.properties"

# Define variables
WRAPPER_LAUNCHER="org.apache.maven.wrapper.MavenWrapperMain"

set -e

# OS specific support.
cygwin=false;
darwin=false;
mingw=false
case "$(uname)" in
  CYGWIN*) cygwin=true ;;
  MINGW*) mingw=true;;
  Darwin*) darwin=true;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=$(cygpath --unix "$JAVA_HOME")
  [ -n "$M2_HOME" ] && M2_HOME=$(cygpath --unix "$M2_HOME")
fi

# Attempt to find Java
if [ -z "$JAVA_HOME" ]; then
  if $darwin; then
    if [ -x '/usr/libexec/java_home' ]; then
      export JAVA_HOME=$(/usr/libexec/java_home)
    fi
  fi
fi
if [ -z "$JAVA_HOME" ]; then
  javaExecutable="$(which javaw)"
  if [ -z "$javaExecutable" ]; then
    javaExecutable="$(which java)"
  fi
  if [ -n "$javaExecutable" ] && ! [ "$(expr "$javaExecutable" : '.*\(javaw\)$')" = "javaw" ]; then
    readLink=$( which readlink)
    if [ "$readLink" != "" ]; then
      if $mingw; then
        javaExecutable=$(readlink -n "$javaExecutable")
      else
        javaExecutable=$(readlink -f "$javaExecutable")
      fi
      javaHome="$(dirname "$javaExecutable")"
      javaHome=$(expr "$javaHome" : '\(.*\)/bin')
      JAVA_HOME="$javaHome"
      export JAVA_HOME
    fi
  fi
fi

# Check JAVA_HOME
if [ -z "$JAVA_HOME" ] && ! java -version >/dev/null 2>&1; then
  echo "Error: JAVA_HOME is not set and no 'java' command could be found in your PATH."
  exit 1
fi

JAVA_CMD="java"
if [ -n "$JAVA_HOME" ]; then
  JAVA_CMD="$JAVA_HOME/bin/java"
fi

# Determine the location of the script
PRG="$0"
while [ -L "$PRG" ]; do
  ls=$(ls -ld "$PRG")
  link=$(expr "$ls" : '.*-> \(.*\)$')
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=$(dirname "$PRG")/"$link"
  fi
done
PRGDIR=$(dirname "$PRG")

# Absolute path
MAVEN_PROJECTBASEDIR="${MAVEN_BASEDIR:-$( cd "$PRGDIR" && pwd )}"
export MAVEN_PROJECTBASEDIR

# Read properties file
WRAPPER_PROPERTIES="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.properties"
DISTRIBUTION_URL=$(grep "distributionUrl" "$WRAPPER_PROPERTIES" | head -n 1 | cut -d= -f2-)
WRAPPER_JAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"

# Download maven-wrapper.jar if missing
if [ ! -f "$WRAPPER_JAR" ]; then
  WRAPPER_JAR_URL=$(grep "wrapperUrl" "$WRAPPER_PROPERTIES" | head -n 1 | cut -d= -f2-)
  echo "Downloading $WRAPPER_JAR_URL"
  if command -v curl > /dev/null; then
    curl -sLo "$WRAPPER_JAR" "$WRAPPER_JAR_URL" || {
      echo "Failed to download $WRAPPER_JAR_URL"
      exit 1
    }
  elif command -v wget > /dev/null; then
    wget -qO "$WRAPPER_JAR" "$WRAPPER_JAR_URL" || {
      echo "Failed to download $WRAPPER_JAR_URL"
      exit 1
    }
  else
    echo "No download utility (curl or wget) found."
    exit 1
  fi
fi

exec "$JAVA_CMD" \
  -classpath "$WRAPPER_JAR" \
  "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" \
  $MAVEN_OPTS \
  $MAVEN_DEBUG_OPTS \
  $WRAPPER_LAUNCHER $MAVEN_CONFIG "$@"

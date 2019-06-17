# An Android docker image for react native

## Goals

* It contains minimum Android SDK environment to be able to perform regular gradle job
* It contains NodeJS environment to build react native bundle
* Directly being used as Android CI build environment

## Notes

Gradle, NDK, and emulator are not included. Use the gradle wrapper to run any task with exact gradle version.

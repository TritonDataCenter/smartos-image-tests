# Overview

These are helper scripts for provisioning test instances (and custom images)
in a given test environment. These tests assume you have the triton CLI tool
intalled and have a profile created for your test environment.

# Setup

## Triton

Install the triton cli tool:

    sudo npm install -g triton

One installed, create a profile for your test environment

    triton profile create

Once you have a profile created you will need to create a `triton.cfg` file in 
this directory. The `triton.cfg` will ensure all the scripts use your desired
profile, packages and networks.

## triton.cfg

To use these scripts, make a copy of `triton_example.cfg` and rename it to
`triton.cfg`. In your `triton.cfg` set the appropriate triton cli profile
networks, and packages. You may also need to set `TRITON_TLS_INSECURE=1`

The SmartOS image tests assume that any test instance was created via these 
scipts. For example, the tests assume the usage of `user-data` and 
`userscript.sh` found in this directory.


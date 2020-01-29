#!/usr/bin/env bash


keytool -genkeypair -alias demo -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore demo.p12 -validity 36500

mv demo.p12 src/main/resources/keystore/demo.p12

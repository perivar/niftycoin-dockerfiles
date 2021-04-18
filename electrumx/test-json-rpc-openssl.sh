#!/bin/bash

(echo '{ "id": 0, "method": "server.features" }'; sleep 1) | openssl s_client -connect localhost:50002

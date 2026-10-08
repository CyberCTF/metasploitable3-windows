#!/bin/sh
# Metasploitable 3's Windows services answer: Jenkins, Elasticsearch 1.1.1 and the WordPress
# site on WAMP.
set -eu
curl -sS --max-time 20 http://win2k8:8484/ | grep -qi "jenkins"
curl -sS --max-time 20 http://win2k8:9200/ | grep -q '"number" : "1.1.1"'
curl -sS --max-time 20 -o /dev/null -w "%{http_code}" http://win2k8:8585/wordpress/ | grep -qE "^(200|301|302)$"
echo "Jenkins, Elasticsearch and WordPress answer"

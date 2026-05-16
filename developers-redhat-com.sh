#!/bin/bash

JQ_VERSION=1.6
LOCAL=$(pwd)

curl -sLo $LOCAL/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
chmod +x $LOCAL/jq

numFound=$(curl -s 'https://access.redhat.com/hydra/rest/search/platform/developers?redhat_client=developers-search&q=*&start=0&rows=1' | $LOCAL/jq '.response.numFound')

fileName=/tmp/developers.redhat.com-$(date +"%Y-%m-%d-%H-%M-%S")

if [[ $numFound > 0 ]]; then
    curl -s $'https://access.redhat.com/hydra/rest/search/platform/developers?redhat_client=developers-search&q=*&start=0&rows='$numFound'' | tee $fileName
fi

cat $fileName | $LOCAL/jq '.response.docs[] | .uri' | tr -d '"' > $fileName.uri

echo ">>> $fileName.uri"

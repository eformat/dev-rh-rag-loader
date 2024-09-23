#!/bin/bash

JQ_VERSION=1.6
LOCAL=$(pwd)

curl -sLo $LOCAL/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
chmod +x $LOCAL/jq

numFound=$(curl -s $'https://access.redhat.com/hydra/rest/search/platform/developers?&redhat_client=developers-search&q=*&start=0&rows=1&facet=true&facet.mincount=1&facet.sort=index&facet.field=\{\u0021ex=documentKindFilter\}documentKind&f.standard_product.facet.limit=-1&&facet.field=\{\u0021ex=productFilter\}standard_product&facet.field=\{\u0021ex=topicFilter\}topic'   -H 'accept: */*'   -H 'accept-language: en-US,en;q=0.9'   -H 'cache-control: no-cache'   -H 'origin: https://developers.redhat.com'   -H 'pragma: no-cache'   -H 'priority: u=1, i'   -H 'referer: https://developers.redhat.com/'   -H 'sec-ch-ua: "Chromium";v="128", "Not;A=Brand";v="24", "Google Chrome";v="128"'   -H 'sec-ch-ua-mobile: ?0'   -H 'sec-ch-ua-platform: "Linux"'   -H 'sec-fetch-dest: empty'   -H 'sec-fetch-mode: cors'   -H 'sec-fetch-site: same-site'   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36' | $LOCAL/jq '.response.numFound')

fileName=/tmp/developers.redhat.com-$(date +"%Y-%m-%d-%H-%M-%S")

if [[ $numFound > 0 ]]; then
    curl -s $'https://access.redhat.com/hydra/rest/search/platform/developers?&redhat_client=developers-search&q=*&start=0&rows='$numFound'&facet=true&facet.mincount=1&facet.sort=index&facet.field=\{\u0021ex=documentKindFilter\}documentKind&f.standard_product.facet.limit=-1&&facet.field=\{\u0021ex=productFilter\}standard_product&facet.field=\{\u0021ex=topicFilter\}topic'   -H 'accept: */*'   -H 'accept-language: en-US,en;q=0.9'   -H 'cache-control: no-cache'   -H 'origin: https://developers.redhat.com'   -H 'pragma: no-cache'   -H 'priority: u=1, i'   -H 'referer: https://developers.redhat.com/'   -H 'sec-ch-ua: "Chromium";v="128", "Not;A=Brand";v="24", "Google Chrome";v="128"'   -H 'sec-ch-ua-mobile: ?0'   -H 'sec-ch-ua-platform: "Linux"'   -H 'sec-fetch-dest: empty'   -H 'sec-fetch-mode: cors'   -H 'sec-fetch-site: same-site'   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36' | tee $fileName
fi

cat $fileName | $LOCAL/jq '.response.docs[] | .uri' | tr -d '"' > $fileName.uri

echo ">>> $fileName.uri"

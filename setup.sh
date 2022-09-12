#!/bin/bash

if [ -e .env ]
then
    if grep -q SUBGRAPH_SLUG .env
    then
        subgraph_slug=$(grep SUBGRAPH_SLUG .env | cut -d '=' -f2)
    fi
    
    if grep -q DEPLOY_KEY .env
    then
        deploy_key=$(grep DEPLOY_KEY .env | cut -d '=' -f2)
    fi
else
    if [[ -z "${SUBGRAPH_SLUG}" ]]; then
        echo "SUBGRAPH_SLUG env variable not found"
    else
        subgraph_slug="${SUBGRAPH_SLUG}"
    fi
    
    if [[ -z "${DEPLOY_KEY}" ]]; then
        echo "DEPLOY_KEY env variable not found"
    else
        deploy_key="${DEPLOY_KEY}"
    fi
    
fi

protocol="ethereum"
abi_path="ABI/Message.json"
network="mainnet"
directory="my_dir"

graph init \
--studio ${subgraph_slug} \
--protocol ${protocol} \
--abi ${abi_path} \
--network ${network} \
${directory}

graph auth --studio ${deploy_key}

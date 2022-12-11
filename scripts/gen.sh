#!/bin/sh
PROTOFILE="./helloworld.proto"

# Typescript
JS_OUT_DIR="./frontend/src/generated"
rm -rf $JS_OUT_DIR
mkdir -p $JS_OUT_DIR
protoc -I=. "${PROTOFILE}" \
    --js_out=import_style=commonjs,binary:"${JS_OUT_DIR}" \
    --ts_out "${JS_OUT_DIR}"

# Golang
GO_OUT_DIR="./internal/helloworld"
rm -rf $GO_OUT_DIR
mkdir -p $GO_OUT_DIR
protoc --go_out="${GO_OUT_DIR}" \
    --go_opt=paths=source_relative \
    --go-grpc_out="${GO_OUT_DIR}" \
    --go-grpc_opt=paths=source_relative \
    "${PROTOFILE}"

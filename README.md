# Traefik + gRPC-Web + Protobuf-ts + React (doesn't work)

> :warning: this doesn't work currently.

I'm learning how to use grpc-web with traefik now that it's out in Traefik 3.0-Beta

Asked for help here: [community.traefik.io/t/getting-started-with-the-grpcweb-middleware/16778](https://community.traefik.io/t/getting-started-with-the-grpcweb-middleware/16778)

# Setup

Built on:
  - Golang 1.19
  - Node 19

Bring up traefik and the gRPC server

```sh
docker compose up --build
```

# Generating (optional)

Install the protoc plugins

- Download [protoc-gen-js](https://github.com/protocolbuffers/protobuf-javascript/releases/tag/v3.21.2)
- Install `protoc-gen-go` (commands below)
- Install `protoc-gen-go-grpc` (commands below)
- Install `protoc-gen-ts` (commands below)

```sh
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
npm install -g @protobuf-ts/plugin # make sure protoc-gen-ts is available in PATH
```

Run the generator script

```sh
sh scripts/gen.sh
```

# Try the GRPC server with the Go client

Add the hostname below to `/etc/hosts`

```
127.0.0.1 mooncar.docker.localhost
```

Run the go client, and hopefully the gRPC request should go through traefik

```sh
go run internal/client.go --addr=mooncar.docker.localhost:80 --name=john

# 2099/01/01 10:11:12 Greeting: Hello john
```

# This is where things don't work for me

Run the frontend

```sh
cd frontend
npm install
npm run dev
```

click the button `click me`

and the reverse proxy says

```
mooncar-reverse-proxy-1  | 2022-12-11T20:20:00Z DBG github.com/traefik/traefik/v2/pkg/server/service/proxy.go:119 >
500 Internal Server Error error="stream error: stream ID 3; PROTOCOL_ERROR; received from peer"
```

```
Access to fetch at 'http://mooncar.docker.localhost/helloworld.Greeter/SayHello' from origin 'http://localhost:5173' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource. If an opaque response serves your needs, set the request's mode to 'no-cors' to fetch the resource with CORS disabled.
grpc-web-transport.js:123          POST http://mooncar.docker.localhost/helloworld.Greeter/SayHello net::ERR_FAILED
helloworld.ts:18 RpcError: Failed to fetch
    at grpc-web-transport.js:183:25
```

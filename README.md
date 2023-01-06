# Traefik + gRPC-Web + Protobuf-ts + React (doesn't work)

I'm learning how to use grpc-web with traefik now that it's out in Traefik 3.0.0-Beta.2

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
127.0.0.1 mooncar.nomad.localhost
```

Run the go client, and hopefully the gRPC request should go through traefik

```sh
go run internal/client.go --addr=mooncar.nomad.localhost:80 --name=john

# 2099/01/01 10:11:12 Greeting: Hello john
```

# Frontend

Run the frontend

```sh
cd frontend
npm install
npm run dev
```

click the button `click me` and see the response in the inspector

import { GrpcWebFetchTransport } from '@protobuf-ts/grpcweb-transport';
import { HelloRequest } from './generated/helloworld'
import { GreeterClient } from "./generated/helloworld.client"

const transport = new GrpcWebFetchTransport({
    baseUrl: "http://mooncar.docker.localhost:80",
    timeout: 100,
});

const client = new GreeterClient(transport)

export function Hello() {
    const request: HelloRequest = {"name": "john"}
    let {response} = client.sayHello(request)
    response.then(res => {
        console.log(res.message)
    }).catch(err => {
        console.log(err)
    })
}

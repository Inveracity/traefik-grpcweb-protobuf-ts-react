import { GrpcWebFetchTransport } from '@protobuf-ts/grpcweb-transport';
import { HelloRequest } from './generated/helloworld'
import { GreeterClient } from "./generated/helloworld.client"

let transport = new GrpcWebFetchTransport({
    baseUrl: "http://mooncar.nomad.localhost:80",
});

const client = new GreeterClient(transport)

export function Hello() {
    const request: HelloRequest = {name: "john"}
    let {response} = client.sayHello(request)
    response.then(res => {
        console.log(res.message)
    }).catch(err => {
        console.log(err)
    })
}

from lightbug_http import HTTPRequest, HTTPResponse, SysServer, NotFound
from lightbug_api.routing import Router

@value
struct App:
    var router: Router

    fn __init__(inout self):
        self.router = Router()
    
    fn func(self, req: HTTPRequest) raises -> HTTPResponse:
            for route_ptr in self.router.routes:
                var route = route_ptr[]
                if route.path == req.uri.path and route.method == req.method:
                    return route.handler(req)
            return NotFound(req.uri.path)
    
    fn get(inout self, path: String, handler: fn(HTTPRequest) -> HTTPResponse):
        self.router.add_route(path, "GET", handler)
    
    fn start_server(inout self, address: StringLiteral = "0.0.0.0:8080") raises:
        var server = SysServer()
        server.listen_and_serve(address, self)

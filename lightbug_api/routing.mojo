from lightbug_http import HTTPRequest, HTTPResponse, NotFound

@value
struct APIRoute:
    var path: String
    var method: String
    var handler: fn(HTTPRequest) -> HTTPResponse

@value
struct Router:
    var routes: List[APIRoute]

    fn __init__(inout self):
        self.routes = List[APIRoute]()

    fn add_route(inout self, path: String, method: String, handler: fn(HTTPRequest) -> HTTPResponse):
        self.routes.append(APIRoute(path, method, handler))
    


@value
struct CaseInsensitiveStringDict(Stringable):
    """
    Takes dict[string, string] to instantiate an object with a case-insensitive keys and only values as case sensitive.
    Useful in request/response headers.
    """

    var _store: Dict[String, List[String]]

    fn __init__(
        inout self, 
        owned data:Dict[String, String]
        ):

        self._store = Dict[String, List[String]]()
        for k in data^.items():
            self._store[k[].key.lower()] = List(k[].key, k[].value)
    
    fn __getitem__(self: Self, key:String) raises -> String:
        try:
            var paired_item: List[String] = self._store[key.lower()]
            return paired_item[1]
        except Exception:
            raise Error("Could not get the value for the specified key")

    fn __str__(self: Self) -> String:
        var representation: String = '< CaseInsensitiveStringDict >\n('
        for i in self._store.items():
            representation += '\n\t' + i[].key + ':' + i[].value[0] + ',' + i[].value[1]
        return representation + '\n)'
    



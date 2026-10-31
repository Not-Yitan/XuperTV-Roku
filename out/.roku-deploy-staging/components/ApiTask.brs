sub init()
    m.top.functionName = "doRequest"
end sub

sub doRequest()
    url = CreateObject("roUrlTransfer")
    base = m.top.baseUrl
    full = base + "/" + m.top.method
    sep = "?"
    q = m.top.query
    if q <> invalid
        for each key in q
            full = full + sep + url.Escape(key) + "=" + url.Escape(q[key].toStr())
            sep = "&"
        end for
    end if
    url.SetUrl(full)
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    url.InitClientCertificates()
    url.EnableEncodings(true)
    body = url.GetToString()
    res = invalid
    if body <> "" then res = ParseJson(body)
    if res = invalid
        res = { returnValue: false, errorText: "Sin respuesta del servidor" }
    end if
    res.tag = m.top.tag
    m.top.result = res
end sub

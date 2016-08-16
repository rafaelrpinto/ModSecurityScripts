--Script that retreives browser data and stores in the session to be validated in further requests.

function main()

    local remoteIp = m.getvar("REMOTE_ADDR");
    local userAgent = m.getvar("REQUEST_HEADERS.User-Agent", { "sha1", "hexEncode" });
    local csrfToken = m.getvar("UNIQUE_ID", { "sha1", "hexEncode" });

    --Sets the retrieved values inthe session
    m.setvar("session.valid", "1");
    m.setvar("session.ip", remoteIp);
    m.setvar("session.uahash", userAgent);
    m.setvar("session.csrf_token", csrfToken);

    return nil;
end
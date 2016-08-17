-- This scripts searches for the search keyword on the search result HTML and 
-- adds random invalid tags between its characters to attempt to mitigate side channel attacks. 
-- Technically this will increase the HTML size, but since it's the same token the compression
-- should reduce it.

function main()
    local keyword = m.getvar("ARGS.keyword");
    local responseBody = m.getvar("RESPONSE_BODY");
    local unique = m.getvar("UNIQUE_ID");

    --The immediate unique HTML element that holds the reflected content
    local reflectedBlock = "<h5>No advertisements found for <strong>\"" .. keyword .. "\"<\/strong><\/h5>";

    if string.match(responseBody, reflectedBlock) then
        --Reflected content found. Let's mask it...
        local escapedKeyword = "";
        for i in string.gmatch(keyword, ".") do
            escapedKeyword = escapedKeyword .. i .. "<" .. unique .. "/>";
        end
       
        local escapedReflectedBlock = string.gsub(reflectedBlock, keyword, escapedKeyword);
    
        --Add the original and escabed HTML blocks to TX variables to be used in the next @rsub chain rule
        m.setvar("TX.reflectedBlock", reflectedBlock);
        m.setvar("TX.escapedReflectedBlock", escapedReflectedBlock);

        return escapedReflectedBlock;
    end

    return nil;
end
*** Keywords ***
Loop Out Index Value From Dictionary List    [arguments]     ${list}   ${key}   ${expectedvalue}
    ${listlength}=      Get Length  ${list}
    #loop out the value
    For     ${i}    IN RANGE    ${listlength}
        Exit For Loop if    '${list[${i}]["{key}"]}'=='${expectedvalue}'
    END
    #fail keyword if value is not found
    Run Keyword If  '${list[${i}]["{key}"]}'!='${expectedvalue}'    Fail   List did not contain a value with given key atrribute
    [return]    ${i}

Loop Out Index Value From List    [arguments]     ${list}   ${expectedvalue}
    ${listlength}=      Get Length  ${list}
    #loop out the value
    For     ${i}    IN RANGE    ${listlength}
        Exit For Loop if    '${list[${i}]}'=='${expectedvalue}'
    END
    #fail keyword if value is not found
    Run Keyword If  '${list[${i}]}'!='${expectedvalue}'    Fail   List did not contain the searched value
    [return]    ${i}

Send Get Request      [arguments]  ${session}  ${path}  ${headers}  ${expresultstatus}=200
    ${resp}=        Get On Session    ${session}  ${path}  headers=${headers}
    Run Keyword And Ignore Error    Log     ${resp.json()}
    Run Keyword And Ignore Error    Log     ${resp.headers}
    Should Be Equal As Strings   ${resp.status_code}     ${expresultstatus}
    [return]    ${resp}

Send Post Request      [arguments]  ${session}  ${path}  ${body}  ${headers}  ${expresultstatus}=200
    ${resp}=        Post On Session    ${session}  ${path}  ${body}  headers=${headers}
    Run Keyword And Ignore Error    Log     ${resp.json()}
    Run Keyword And Ignore Error    Log     ${resp.headers}
    Should Be Equal As Strings      ${resp.status_code}     ${expresultstatus}
    [RETURN]    ${resp}

Send Post Request Without Rest Path      [arguments]  ${session}  ${body}  ${headers}  ${expresultstatus}=200
    ${resp}=        Post On Session   ${session}    /    json=${body}  headers=${headers}
    Run Keyword And Ignore Error    Log     ${resp.json()}
    Run Keyword And Ignore Error    Log     ${resp.headers}
    Should Be Equal As Strings      ${resp.status_code}     ${expresultstatus}
    [RETURN]    ${resp}

Send Post Request With File      [arguments]  ${session}  ${path}   ${json}  ${file}  ${headers}  ${expresultstatus}=200
    log  ${file}
    ${resp}=        Post On Session    ${session}  ${path}  data=${json}   files=${file}  headers=${headers}
    Run Keyword And Ignore Error    Log     ${resp.json()}
    Run Keyword And Ignore Error    Log     ${resp.headers}
    Should Be Equal As Strings      ${resp.status_code}     ${expresultstatus}

Send Put Request      [arguments]  ${session}  ${path}  ${body}  ${headers}  ${expresultstatus}=200
    ${resp}=        Put On Session    ${session}  ${path}  ${body}  headers=${headers}
    Run Keyword And Ignore Error    Log     ${resp.json()}
    Run Keyword And Ignore Error    Log     ${resp.headers}
    Should Be Equal As Strings      ${resp.status_code}     ${expresultstatus}

Send Delete Request      [arguments]  ${session}  ${path}  ${headers}  ${expresultstatus}=200
    ${resp}=        Put On Session    ${session}  ${path}  headers=${headers}
    Run Keyword And Ignore Error    Log     ${resp.json()}
    Run Keyword And Ignore Error    Log     ${resp.headers}
    Should Be Equal As Strings      ${resp.status_code}     ${expresultstatus}


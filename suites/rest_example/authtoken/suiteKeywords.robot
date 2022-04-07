*** Settings ***

*** Keywords ***
Get Booking Ids     [arguments]
    ${headers}=     Create Dictionary   accept=application/json
    ${response}=    Send Get Request  bookingApi  /${BOOKINGRESTPATH}/  ${headers}    200
    [RETURN]    ${response}

Find Books By Id     [arguments]     ${id}   ${respcode}=200
    ${headers}=     Create Dictionary   accept=application/json
    ${response}=     Send Get Request    bookingApi  /${BOOKINGRESTPATH}/${id}     ${headers}    ${respcode}
    [RETURN]    ${response}

Create Book    [arguments]     ${body}   ${respcode}=200
    ${headers}=     Create Dictionary   accept=application/json     content-type=application/json
    ${response}=     Send Post Request     bookingApi   /${BOOKINGRESTPATH}/   ${body}    ${headers}    ${respcode}
    [RETURN]    ${response}

Update Book    [arguments]  ${id}   ${body}   ${respcode}=200
    ${headers}=     Create Dictionary   accept=application/json     content-type=application/json   Cookie=token=${authtoken}
    ${response}=     Send Put Request     bookingApi    /${BOOKINGRESTPATH}/${id}      ${body}    ${headers}    ${respcode}
    [RETURN]    ${response}

Delete Book    [arguments]  ${id}   ${respcode}=200
    ${headers}=     Create Dictionary    content-type=application/json   Cookie=token=${authtoken}
    ${response}=     Send Delete Request     bookingApi    /${BOOKINGRESTPATH}/${id}    ${headers}    ${respcode}

Set Authentication Token    [arguments]     ${username}=admin     ${password}=password123
    ${headers}=     Create Dictionary   content-type=application/json
    ${authbody}=    Create Dictionary   username=${username}    password=${password}
    #${authbody}=    Evaluate     {"username":"${username}","password":"${password}"}
    log     ${authbody}
    ${response}=     Send Post Request Without Rest Path    authApi     ${authbody}  ${headers}     200
    ${authtoken}=   Set Variable    ${response.json()["token"]}
    Set Global Variable    ${authtoken}

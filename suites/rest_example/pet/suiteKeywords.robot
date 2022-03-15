*** Settings ***

*** Keywords ***
Upload Image     [arguments]     ${petid}    ${additionalMetadata}   ${file}
    ${headers}=     Create Dictionary   accept=application/json  content-type=multipart/form-data;boundary=----WebKitFormBoundaryMSlPdlg7Py0fVgOK
    ${fileasbinary}=    Get Binary File     ${file}
    ${json}=    Create Dictionary   additionalMetadata=${additionalMetadata}
    ${data}=    Create Dictionary   file    ${fileasbinary}
    ${formdata}=    Create Dictionary   files=${data}    data=${json}

    Send Post Request With File  petapi  /${petid}/uploadImage  ${json}  ${data}  ${headers}    200

Find Pets By Status     [arguments]     ${status}
    ${headers}=     Create Dictionary   accept=application/json
    ${response}=     Send Get Request    petapi  /findByStatus?status=${status}     ${headers}    200
    [RETURN]    ${response}

Find Pets By Id     [arguments]     ${id}   ${respcode}=200
    ${headers}=     Create Dictionary   accept=application/json
    ${response}=     Send Get Request    petapi  /${id}     ${headers}    ${respcode}
    [RETURN]    ${response}

Create Pet     [arguments]     ${body}   ${respcode}=200
    ${headers}=     Create Dictionary   accept=application/json     content-type=application/json
    ${response}=     Send Post Request Without Rest Path    petapi      ${body}    ${headers}    ${respcode}
    [RETURN]    ${response}
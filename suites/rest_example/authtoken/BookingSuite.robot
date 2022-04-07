*** Settings ***
Documentation    Test suite for booking api
Resource    suiteKeywords.robot
Resource    ../../../resources/global_variables.robot
Resource    ../../../resources/keywords/globalkeywords.robot
Resource    suiteResources/bookjson.robot
Suite Setup     Initialize Sessions
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem
*** Test Cases ***
Find Booking Ids
    [documentation]  gets all booking ids
    [tags]      rest_test
    ${books}=   Get Booking Ids
    #set first booking id for next text
    ${firstreturnedbookingid}=      Set Variable    ${books.json()[0]["bookingid"]}
    Set Global Variable         ${firstreturnedbookingid}

Find Book By ID
    [documentation]  gets a book by id from the last test
    [tags]      rest_test
    ${book}=    Find Books By Id        ${firstreturnedbookingid}
    log     ${book.json()}

Create Book
    [documentation]  creates a book using json found from suiteResources
    [tags]      rest_test
    ${createdbook}=     Create Book     ${createbook}
    ${createdbookid}=   Set Variable    ${createdbook.json()["bookingid"]}
    Set Global Variable      ${createdbookid}
    # Fetch the book and check it was found correctly
    ${createdbookreturned}=      Find Books By Id        ${createdbookid}
    ${nameaftercreation}=   Set Variable    ${createdbookreturned.json()["firstname"]}
    Set Global Variable     ${nameaftercreation}
    # tässä kohtaa tajusin että kyseessä ei olekkaan kirjat vaan varaukset... :D

Update Book
    [documentation]  updates book from create book testcase
    [tags]      test
    ${updatejson}=  evaluate    json.loads('''${createbook}''')    json
    Set To Dictionary   ${updatejson}       firstname=Robot Edited
    ${updatejson}=  evaluate    json.dumps(${updatejson})    json
    Update Book     ${createdbookid}    ${updatejson}   200
    ${updatebookreturned}=      Find Books By Id        ${createdbookid}
    ${nameafterupdate}=   Set Variable  ${updatebookreturned.json()["firstname"]}
    Set Global Variable     ${nameafterupdate}
    Should Not Be Equal     ${nameaftercreation}    ${nameafterupdate}

Delete Book
    [documentation]  deletes book which was created
    [tags]      test
    # runs keyword and check that the execution status was true
    ${status}=  Run Keyword And Return Status       Find Books By Id        ${createdbookid}    200
    Should Be Equal As Strings  	${status}        True
    Delete Book     ${createdbookid}   201
    # runs keyword and check that the execution status was false
    ${status}=  Run Keyword And Return Status       Find Books By Id        ${createdbookid}    200
    Should Be Equal As Strings  	${status}        False
*** Keywords ***
Initialize Sessions
   Create Session  bookingApi  ${APIBASEURLAUTH}
   Create Session  authApi  ${APIBASEURLAUTH}/${authrestpath}
   Set Authentication Token

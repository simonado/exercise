*** Settings ***
Documentation    Test suite for pet api
Resource    suiteKeywords.robot
Resource    suiteResources/petjsons.robot
Resource    ../../../resources/global_variables.robot
Resource    ../../../resources/keywords/globalkeywords.robot
Suite Setup     Initialize Pet Session
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem
*** Test Cases ***
Find Pet By Available Status
    [documentation]  finds pets by available status with rest api
    [tags]      test
    ${pets}=     find pets by status     available
    ${petcount}=    get length  ${pets.json()}

    ${pets}=     find pets by status     invalidstate
    ${petcount}=    get length  ${pets.json()}

Find Pet By Id
    ${pet}=     find pets by id   96998071

Find Pet By Id Which Is Not Found
    ${pet}=     find pets by id   911   404

Create Pet
    log     ${createjson}
    ${petasdict}=   evaluate    json.loads('''${createjson}''')     json
    log     ${petasdict}
    Set To Dictionary   ${petasdict}    name=testdoggieforrestmuokattu
    ${petasjson}=   evaluate    json.dumps(${petasdict})     json
    log     ${petasjson}
    ${response}=    Create Pet   ${petasjson}    201


*** Keywords ***
Initialize Pet Session
   Create Session  petapi  ${apibaseurl}/${petrestpath}

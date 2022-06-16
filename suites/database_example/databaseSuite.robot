*** Settings ***
Documentation    Test suite for database
Resource    suiteResources/variables.robot
Library    OperatingSystem
Library    DatabaseLibrary

suite setup     Connect To Database     psycopg2	${database} 	${user} 	${password}     ${host}     ${port}
suite teardown     Disconnect From Database

*** Test Cases ***
Connect To Database And Retrieve Data
    [Documentation]     testing database connection
    [Tags]  database_test

    ${firstevenets}=    Retrieve 100 First Events
    Loop Results    ${firstevenets}
    Check List Count    ${firstevenets}     100

Connect To Database And Retrieve 200 Data
    [Documentation]     testing database connection 2
    [Tags]  database_test

    ${firstevenets}=    Retrieve 200 First Events
    Loop Results    ${firstevenets}
    Check List Count    ${firstevenets}     200

*** Keywords ***
Retrieve 100 First Events
    ${result}=  query   Select * from events Limit 100
    [return]    ${result}

Retrieve 200 First Events
    ${result}=  query   Select * from events Limit 200
    [return]    ${result}

Loop Results    [Arguments]     ${list}
    ${listlength}=  Get Length  ${list}
    FOR     ${i}    IN RANGE  ${listlength}
        Log     ${list[${i}]}
    END

Check List Count    [Arguments]    ${list}     ${count}
    ${listlength}=  Get Length  ${list}
    Should Be Equal As Strings   ${listlength}   ${count}

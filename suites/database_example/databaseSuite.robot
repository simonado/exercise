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
    [Tags]  Test

    ${firstevenets}=    Retrieve 100 First Events
    Loop Results    ${firstevenets}

*** Keywords ***
Retrieve 100 First Events
    ${result}=  query   Select * from events Limit 100
    [return]    ${result}

Loop Results    [Arguments]     ${list}
    ${listlength}=  Get Length  ${list}
    FOR     ${i}    IN RANGE  ${listlength}
        Log     ${list[${i}]}
    END

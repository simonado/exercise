*** Settings ***
Documentation    Test suite for variables
Resource    suiteResources/variables.robot

*** Test Cases ***
Test Suite 2 Test Case
    [Documentation]     testing variable visibility
    [Tags]  Test
    Log Variables

    Comment     Lokitetaan globaali muuttuja (pitäisi onnistua)
    Log     ${GLOBALVARIABLE}

    Comment     Lokitetaan ensimmäisen suiten suite muuttuja (pitäisi epäonnistua)
    ${isvariablevisible}=    Run Keyword And Return Status   Log     ${suitevariable}
    Should Not Be True      ${isvariablevisible}

    Comment     Lokitetaan ensimmäisen testitapauksen testi muuttuja (pitäisi epäonnistua)
    ${isvariablevisible}=    Run Keyword And Return Status   Log     ${testcase_variable}
    Should Not Be True      ${isvariablevisible}

*** Keywords ***

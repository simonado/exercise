*** Settings ***
Documentation    Test suite for variables
Resource    suiteResources/variables.robot

*** Test Cases ***
Test Suite 1 Test Case 1
    [Documentation]     testing variable visibility
    [Tags]  Test
    Log Variables
    #test variable
    Set Test Variable   ${testcase_variable}   Test Variable For First Test Case
    #global variable
    Set Global Variable   ${GLOBALVARIABLE}   GLOBAL VARIABLE
    #Set Global Variable     ${GLOBALVARIABLE}
    Log Variables
    ${GLOBALVARIABLE}=  Set Variable    ${GLOBALVARIABLE} MODIFIED
    Log Variables
    #suite variable
    Set Suite Variable    ${suitevariable}   This Variable Should Be Visible For ${TEST_NAME} and Test Suite 1 Test Case 2

Test Suite 1 Test Case 2
    [Documentation]     testing variable visibility
    [Tags]  Test
    Log Variables

*** Keywords ***

*** Settings ***
Documentation    Test suite for variables
Resource    suiteResources/variables.robot

*** Test Cases ***
Test Suite 2 Test Case
    [Documentation]     testing variable visibility
    [Tags]  Test
    Log Variables

*** Keywords ***

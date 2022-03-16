*** Settings ***
Documentation    Test suite for exercise
Resource    suiteResources/variables.robot

*** Test Cases ***
Increment Test Variable And Set It Global
    [Documentation]     reads variable from resource file, increments it by one and sets it global
    [tags]  test

*** Keywords ***

*** Settings ***
Library  SeleniumLibrary
Library  Strting


*** Variables ***



*** Test Cases ***
Test1
    log to console   ${number}

*** Keywords ***
${number}    Generate Random String    10    0123456789
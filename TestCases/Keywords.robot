*** Settings ***
Library  String
Library   DatabaseLibrary
Library   OperatingSystem
Variables   ../TestCases/Locators.py

*** Variables ***
${url}    https://integration-apps.azuga.com
${browser}    chrome
${switch}    5131
${DBname}    azuga
${Dbuser}    azugaro
${Dbpass}    azugaro
${DBhost}    stagingdb.azuga.com
${DBport}    3306


*** Keywords ***
LoginApplication
    open browser    ${url}    ${browser}
    maximize browser window
    input text    ${username}    abhinayak@azuga.com
    input text    ${password}    123456
    click element  ${loginbutton}
    sleep    7
    click element    ${switchcust}
    input text    ${switchentry}     ${switch}
    click element  ${switchbutton}


Devicecreation
    click element    ${admintab}
    sleep  4
    click element    ${devicetab}
    sleep  3
    click element    ${adddevice}
    ${number}    Generate Random String    10    0123456789
    set suite variable    ${number}
    input text    ${Dserialnumber}    ${number}
    sleep  3
    click element   ${Dchosen}
    input text   ${Dtype}    Datalogger
    press keys    ${Dtype}    ENTER
    ${IMEI}    Generate Random String    15    0123456789
    set suite variable  ${IMEI}
    input text    ${DIMEI}    ${IMEI}
    ${wire}    Generate Random String    14    0123456789
    set suite variable  ${wire}
    input text    ${Dsimid}    ${wire}
    click element    ${Dcarrier}
    input text  ${Dcarrierchoosen}    AT&T
    press keys    ${Dcarrierchoosen}    ENTER
    click element  ${Dproduct}
    input text  ${Dproductchosen}    DL750-30Z3
    press keys    ${Dproductchosen}   ENTER
    #capture page screenshot   device.png
    #capture element screenshot  class:logo    logo.png
    click element  ${savedevice}
    sleep    6



SafetycamCreation
    click element    ${admintab}
    sleep   2
    click element    ${devicetab}
    sleep   2
    click element    ${Safetycamtab}
    sleep    3
    click element    ${AddSafetycam}
    sleep    3
    click element    ${SVendor}
    input text    ${SVchoosen}    Azuga SafetyCam
    press keys    ${SVchoosen}    ENTER
    click element    ${Sproduct}
    input text    ${Sproductchosen}    AZ-D007
    press keys    ${Sproductchosen}    ENTER
    ${Snumber}    Generate Random String    8    0123456789
    set suite variable    ${Snumber}
    input text    ${SSerialnumber}    ${Snumber}
    click element    ${Ssave}
    sleep    7

DeviceCreateDBvalidation
    Connect To Database   pymysql    ${DBname}    ${Dbuser}    ${DBpass}    ${DBhost}    ${DBport}
    check if exists in database    select * from azuga.device where serialNum=${number};
    Disconnect From Database
    #${device}    query    select * from azuga.device where serialNum=${number};
    #log to console    many    ${device}
SafetyCreateDBvalidation
    Connect To Database   pymysql    ${DBname}    ${Dbuser}    ${DBpass}    ${DBhost}    ${DBport}
    check if exists in database    select * from azuga.device where serialNum=${Snumber};
    Disconnect From Database


    #input text  xpath://*[@id="deviceTable_custom_filter"]/input    ${number}
    #press keys   xpath://*[@id="deviceTable_custom_filter"]/input   ENTER
    #${searchdevice}    get text  //*[@role="row"]/td[2]
    #should be equal    ${searchdevice}  ${number}

*** Settings ***
Library  SeleniumLibrary
Library  String
Library   DatabaseLibrary
Library   OperatingSystem

Resource  Variables.robot
Resource  Keywords.robot

Suite Setup  LoginApplication


#Suite Setup    Connect To Database   pymysql    ${DBname}    ${Dbuser}    ${DBpass}    ${DBhost}    ${DBport}
#Suite Teardown  Disconnect From Database


*** Variables ***
${DBname}    azuga
${Dbuser}    azugaro
${Dbpass}    azugaro
${DBhost}    stagingdb.azuga.com
${DBport}    3306



*** Test Cases ***
TC1
   Devicecreation
TC2
    DeviceCreateDBvalidation
TC3
    SafetycamCreation
TC4
    SafetyCreateDBvalidation
















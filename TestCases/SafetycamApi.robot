*** Settings ***
Library  RequestsLibrary
Library   String
Library   OperatingSystem
Library   Collections
Library   DatabaseLibrary

#  Selenium2Library

Resource  Keywords.robot

*** Variables ***
${baseurl}    https://apidemo.azuga.com

*** Test Cases ***
SafetycamCreation
    ${serialnumber}    Generate Random String    8    0123456789
    set suite variable     ${serialnumber}
    set test variable  &{data}    cameraProductCode=AZ-D007    cameraType=Road facing,Driver facing    customerId=5131    deviceDesc=abhi    packageId=112   serialNum=${serialnumber}    vendorId=14     vendorName=Azuga SafetyCam
    set suite variable  &{headers}    authorization=Basic NDQ5NzZiOTAtM2JjOS00ZDc3LWI4ZGQtMmE0ZDc3ZjBiNjdm    content-type=application/json    application-key=1
    create session    mysession    ${baseurl}    verify=True
    ${response}=    post request    mysession    /azuga-ws/v3/dashcam.json  data=${data}    headers=${headers}
    ${responsecode}=   convert to string    ${response.status_code}
    should be equal   ${responsecode}   200
    log to console    ${response.content}
    Connect To Database   pymysql    ${DBname}    ${Dbuser}    ${DBpass}    ${DBhost}    ${DBport}
    check if exists in database    select * from azuga.device where serialNum=${serialnumber};
    @{DBdata1}      query    select serialNum,deviceId from azuga.device where serialNum=${serialnumber};
    ${safetycamId}    get from list  @{DBdata1}   1
    set suite variable   ${safetycamId}
    should contain    ${DBdata1[0]}    ${serialnumber}
    Disconnect From Database
    log to console  verified in Db
Safetycamview
    create session    mysession    ${baseurl}    verify=True
    ${response}=    post request    mysession    /azuga-ws/v3/dashcam/list.json    headers=${headers}
    ${responsecode}=   convert to string    ${response.status_code}
    should be equal  ${responsecode}   200
    ${responsecontent}=    convert to string    ${response.content}
    should contain    ${responsecontent}    ${serialnumber}
SingleSafetycam
    create session  mysession    ${baseurl}    verify=True
    ${response}     get request  mysession    /azuga-ws/v3/dashcam/${safetycamId}.json    headers=${headers}
    ${responsecode}=   convert to string    ${response.status_code}
    should be equal  ${responsecode}   200
    ${responsedata}    convert to string    ${response.content}
    should contain  ${responsedata}    ${serialnumber}
UpdateSafetycam
    create session  mysession    ${baseurl}    verify=True
    ${newserialnumber}    Generate Random String    8    0123456789
    set suite variable   ${newserialnumber}
    set test variable  &{data}     cameraProductCode=AZ-D007    cameraType=Road facing,Driver facing    customerId=5131    dashcamId=c984cc1a5-0dde-11eb-9800-5338a277a31c    packageId=112    serialNum=${newserialnumber}    vehicleId=fe4275c7-0c99-11eb-a0c2-7d01b9e19c99    vendorId=14    vendorName=Azuga SafetyCam    staticPairing=true
    ${response1}    put request     mysession    /azuga-ws/v3/dashcam/${safetycamId}.json    headers=${headers}    data=${data}
    ${response1}=    convert to string    ${response1.status_code}
    should be equal     ${response1}    200
    log to console  updated safetycam
    #DBvalidation
    connect to database  pymysql    ${DBname}    ${Dbuser}    ${DBpass}    ${DBhost}    ${DBport}
    check if exists in database    select * from azuga.device where serialNum=${newserialnumber};
    @{DBdata}      query    select serialNum,deviceId from azuga.device where serialNum=${newserialnumber};
    log to console  DBvalidationdone
    ${safetycamIdV}   get from list  @{DBdata}    1
    set suite variable    ${safetycamIdV}
    should be equal  ${safetycamId}    ${safetycamIdV}
DeleteSafetycam
    create session    mysession    ${baseurl}    verify=True
    ${response}     delete request    mysession    /azuga-ws/v3/dashcam/${safetycamIdV}.json    headers=${headers}
    ${responsecode}    convert to string  ${response.status_code}
    should be equal  ${responsecode}    200
    log to console  deleted safetycam
    log to console  Deletedin Db
    #Dbvalidation
    connect to database  pymysql    ${DBname}    ${Dbuser}    ${DBpass}    ${DBhost}    ${DBport}
    @{DBdata}      query    select serialNum,deviceId,deleted from azuga.device where serialNum=${newserialnumber};
    ${deleted}   get from list  @{DBdata}    2
    ${deletedstring}    convert to string  ${deleted}
    should be equal  ${deletedstring}    1









*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${url}    https://testproject.io/?gclid=CjwKCAjwlID8BRAFEiwAnUoK1RN3GdtHYCdGkfoHI7O6G9J0S5oPcemCWnOGGImOvWMRKYFnwc5zFhoC7nAQAvD_BwE
${browser}    chrome



*** Test Cases ***
Practice
    open browser  ${url}    ${browser}
    maximize browser window
    click link  Docs

    select window  url:https://docs.testproject.io/
    click link    Creating an Account
    close all browsers
*** Settings ***
Documentation     Login with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${Email}=              testing01@gmail.com
${Password}=           asdasd@123
${Username}=           Raisani Aprilia

*** Test Cases ***
Login with correct credential
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do login with correct credential
    Verify login
    Do Screenshot

Logout 
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s

*** Keywords ***
Do Screenshot
    ${timestamp}=              Get Current Date    result_format=%d%m%Y_%H%M%S
    ${screenshot_path}=        Set Variable        \images
    ${screenshot_filename}=    Set Variable        screenshot_${timestamp}.png
    Set Screenshot Directory   ${screenshot_path}
    Capture Page Screenshot    ${screenshot_filename}

Do login with correct credential
    Input Text                    xpath=//input[@id='validationCustom03' and @type='email']                            ${Email}
    Input Password                xpath=//input[@id='validationCustom03' and @type='password' and @name='password']    ${Password}
    Click Element                 xpath=//button[@type='submit'] 
Verify login    
    Wait Until Page Contains      Kirana    timeout=30s
    ${verify_login}   Wait Until Page Contains  ${Username}    timeout=30s
    Run Keyword If    '${verify_login}' == 'True'
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed    
    
Redirect to profile page
    Click Element               xpath=//img[@alt='profile' and @class='img-profile']
    Click Element               xpath=//a[@href='/setting#account' and @class='custom-router-link'][text()='Account']
    Wait Until Page Contains    My Account

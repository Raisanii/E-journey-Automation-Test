*** Settings ***
Documentation     Login with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${Email}=              testing01@gmail.com
${Password}=           asdasd@123
${Incorrect-pass}=     asdasd@1234
${Incorrect-email}=    aingmaung@gmail.com

*** Test Cases ***
Login attempt with Missing Credentials
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do Login Attempt with Missing Credentials
    Do Screenshot

Login attempt without entering password
    Do login attempt without entering password
    Do Screenshot

Login attempt without entering email
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do login attempt without entering email
    Do Screenshot

Login attempt with incorrect email
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do login attempt with incorrect email
    Do Screenshot   

Login attempt with incorrect password
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do login attempt with incorrect password
    Do Screenshot  

Login with correct credential
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do login with correct credential
    Verify login
    Do Screenshot

*** Keywords ***
Do Screenshot
    ${timestamp}=              Get Current Date    result_format=%d%m%Y_%H%M%S
    ${screenshot_path}=        Set Variable        \images
    ${screenshot_filename}=    Set Variable        screenshot_${timestamp}.png
    Set Screenshot Directory   ${screenshot_path}
    Capture Page Screenshot    ${screenshot_filename}

Do Login Attempt with Missing Credentials
    ${CheckButton}   Element Should Be Disabled       xpath=//button[@type='submit']    
    Run Keyword If    '${CheckButton}' == 'True'
    ...    Log  Passed. Button is disabled.
    ...    ELSE
    ...    Log    Failed. Button is enabled
    Element Should Be Disabled       xpath=//button[@type='submit'] 

Do login attempt without entering password
    Input Text         xpath=//input[@id='validationCustom03' and @type='email']    ${Email}
    Do Login Attempt with Missing Credentials

Do login attempt without entering email
    Input Password        xpath=//input[@id='validationCustom03' and @type='password' and @name='password']    ${Password}
    Do Login Attempt with Missing Credentials

Do login attempt with incorrect email
    Input Text                    xpath=//input[@id='validationCustom03' and @type='email']                            ${Incorrect-email}
    Input Password                xpath=//input[@id='validationCustom03' and @type='password' and @name='password']    ${Password}
    Click Element                 xpath=//button[@type='submit'] 
    Wait Until Element Contains   xpath=//div[contains(@class, 'alert-danger') and contains(., 'Invalid email or password')]    Invalid email or password    

Do login attempt with incorrect password
    Input Text                    xpath=//input[@id='validationCustom03' and @type='email']                            ${Email}
    Input Password                xpath=//input[@id='validationCustom03' and @type='password' and @name='password']    ${Incorrect-pass}
    Click Element                 xpath=//button[@type='submit'] 
    Wait Until Element Contains   xpath=//div[contains(@class, 'alert-danger') and contains(., 'Invalid email or password')]    Invalid email or password    
     
Do login with correct credential
    Input Text                    xpath=//input[@id='validationCustom03' and @type='email']                            ${Email}
    Input Password                xpath=//input[@id='validationCustom03' and @type='password' and @name='password']    ${Password}
    Click Element                 xpath=//button[@type='submit'] 
Verify login    
    Wait Until Page Contains      Kirana    timeout=30s
    ${verify_login}   Wait Until Page Contains  Kirana    timeout=30s
    Run Keyword If    '${verify_login}' == 'True'
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed
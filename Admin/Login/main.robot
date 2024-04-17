*** Settings ***
Documentation     Login Admin
Library           SeleniumLibrary

*** Variables ***
${URL}=        https://staging.admin.ejourney.id/auth/login
${Correct_email}=      admin@staging.id
${Correct_pass}=       MamangSekayu@97
${Incorrect_email}=    admin@admin.com
${Incorrect_pass}=     abc@123   

*** Tasks ***    
Login with incorrect credential
    Open Browser        ${URL}    browser=chrome
    Wait Until Page Contains    Login Admin
    Do Log in with incorrect password
    Verify Login with in correct password
    Capture Page Screenshot

Login with correct credential
    Wait Until Page Contains    Login Admin
    Do Log in with correct credential
    Verify Login with correct credential
    Capture Page Screenshot

*** Keywords ***
Do Log in with incorrect password
    Input Text        email       ${Correct_email}
    Input Password    password    ${Incorrect_pass}
    Click Button      Login

Do Log in with correct credential
    Input Text        email       ${Correct_email}
    Input Password    password    ${Correct_pass}
    Click Button      Login
    

Verify Login with correct credential
    ${Verify_login}    Wait Until Element Is Visible     xpath=//p[text()='Login Success!']    timeout=30s
    Run Keyword If    '${Verify_login}' == 'True'
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed
    Sleep    2s

Verify Login with in correct password
    ${Verify_login}    Wait Until Element Is Visible     xpath=//p[text()='Login Failed!']    timeout=30s
    Run Keyword If    '${Verify_login}' == 'True'
    ...    Log    Passed
    ...    ELSE
    ...    Log    Failed
    Sleep    2s    
  
    
    
    
    

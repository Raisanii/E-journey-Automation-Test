*** Settings ***
Documentation     Sign up with google sso
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${SignUp}=             xpath=//a[text()='Sign up']
${Email}=              testing.s4n1@gmail.com
${Pass}=               Raisani.254
${username}=           testing

*** Test Cases ***
SignUp with sso
    Open Browser       ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Move to signUp page
    Click google sso
    Verify signUp
    Do Screenshot


*** Keywords ***
Do Screenshot
    ${timestamp}=              Get Current Date    result_format=%d%m%Y_%H%M%S
    ${screenshot_path}=        Set Variable        \images
    ${screenshot_filename}=    Set Variable        screenshot_${timestamp}.png
    Set Screenshot Directory   ${screenshot_path}
    Capture Page Screenshot    ${screenshot_filename}

Move to signUp page
    Click Element      ${SignUp}

Click google sso
    Click Element                    xpath=//a[contains(@class, 'btn-google') and @href='https://staging.api.ejourney.id/auth-service/auth/google/redirect']
    Wait Until Element Is Visible    xpath=//input[@type='email' and @name='identifier']
    Click Element                    xpath=//input[@type='email' and @name='identifier']
    Input Text                       xpath=//input[@type='email' and @name='identifier']    ${Email}
    Click Element                    xpath=//*[@id='identifierNext']
    Wait Until Element Is Visible    xpath=//input[@type='password' and @name='Passwd']     timeout=10s
    Input Password                   xpath=//input[@type='password' and @name='Passwd']     ${Pass}
    Click Element                    xpath=//*[@id='passwordNext']
   

Verify signUp
    Wait Until Page Contains        Welcome back! Please select method to sign in    timeout=10s  
    Click Element                   xpath=//a[contains(@class, 'btn-google') and @href='https://staging.api.ejourney.id/auth-service/auth/google/redirect']
    Wait Until Page Contains        ${username}    timeout=60s




    





    
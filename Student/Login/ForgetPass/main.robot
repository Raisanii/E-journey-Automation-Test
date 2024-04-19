*** Settings ***
Documentation     Sign up with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${Email}=              testing01@gmail.com
${Password}=           asdasd@123
${Incorrect-email}=    aingmaung@gmail.com

*** Test Cases ***
Forget pass with missing email
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do forget pass with missing email
    Do Screenshot

Forget pass with incorrect email
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do Forget pass with incorrect email
    Do Screenshot

Forget pass with correct email
    Reload Page
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do Forget pass with correct email
    Do Screenshot    
*** Keywords ***
Do Screenshot
    ${timestamp}=              Get Current Date    result_format=%d%m%Y_%H%M%S
    ${screenshot_path}=        Set Variable        \images
    ${screenshot_filename}=    Set Variable        screenshot_${timestamp}.png
    Set Screenshot Directory   ${screenshot_path}
    Capture Page Screenshot    ${screenshot_filename}

Do Forget pass with incorrect email
    Click Element                xpath=//a[@href='#'][text()='Forgot Password ?']
    Wait Until Page Contains     Reset password link will be sent to your email Please enter your email 
    Input Text                   xpath=//input[@placeholder='Type your email'][@type='email'][@class='form-control'][@required='']    ${Incorrect-email}
    Click Element                xpath=//button[text()='Reset Your Password']
    Wait Until Page Contains     Email is not registered, Please try again
    ${Verify}                    Wait Until Page Contains     Email is not registered, Please try again
    Run Keyword If               '${Verify}'=='True'    
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed

Do forget pass with missing email
    Click Element                xpath=//a[@href='#'][text()='Forgot Password ?']
    Wait Until Page Contains     Reset password link will be sent to your email Please enter your email 
    Click Element                xpath=//button[text()='Reset Your Password']
    Wait Until Element Contains  xpath=//div[@class='form-group']//input[@placeholder='Type your email' and @type='email' and @class='form-control' and @required='']/following-sibling::div[@class='invalid-feedback' and text()='Email is required']    Email is required

Do Forget pass with correct email
    Click Element                xpath=//a[@href='#'][text()='Forgot Password ?']
    Wait Until Page Contains     Reset password link will be sent to your email Please enter your email 
    Input Text                   xpath=//input[@placeholder='Type your email'][@type='email'][@class='form-control'][@required='']    ${Email}
    Click Element                xpath=//button[text()='Reset Your Password']
    Wait Until Page Contains     Reset password have been sent to your email
    ${Verify}                    Wait Until Page Contains     Reset password have been sent to your email
    Run Keyword If               '${Verify}'=='True'    
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed
    
*** Settings ***
Documentation     Sign up with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${SignUp}=             xpath=//a[text()='Sign up']
${FullName}=           Raisani aprilia
${Email}=              testing01@gmail.com
${BirthDate}=          20040425
${Password}=           asdasd@123
${ConfirmPass}=        asdasd@123 

*** Test Cases ***    
SignUp with correct credential
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Move to signUp page
    Do SignUp with correct credential
    Verify SignUp with correct credential
    Sleep    2s
    Save Screenshot


*** Keywords ***
Save Screenshot
    ${timestamp}=              Get Current Date    result_format=%d%m%Y_%H%M%S
    ${screenshot_path}=        Set Variable        \images
    ${screenshot_filename}=    Set Variable        screenshot_${timestamp}.png
    Set Screenshot Directory   ${screenshot_path}
    Capture Page Screenshot    ${screenshot_filename}
   


Do SignUp with correct credential
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${ConfirmPass}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    sleep    1s
    Click Element                    xpath=//button[@type='submit']

Accept TnC
    Click Element                 //input[@type='checkbox']
    Wait Until Page Contains      Terms and conditions
    Wait Until Element Contains   xpath=//button[contains(.,'Accept')]    Accept
    Click Element                 xpath=//button[contains(.,'Accept')]
    Wait Until Page Contains      Welcome back! Please select method to sign up


Move to signUp page
    Click Element      ${SignUp}
Verify SignUp with correct credential
    ${Verify_signup}   Wait Until Page Contains    Your account successfully created    timeout=30s
    Run Keyword If    '${Verify_signup}' == 'True'
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed
    Sleep    1s
    
    

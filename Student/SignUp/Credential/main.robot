*** Settings ***
Documentation     Sign up with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${SignUp}=             xpath=//a[text()='Sign up']
${FullName}=           Raisani aprilia
${Email}=              testing02@gmail.com
${BirthDate}=          20040425
${Password}=           asdasd@123
${ConfirmPass}=        asdasd@123 
${DuplicateEmail}=     testing01@gmail.com

*** Test Cases *** 

SignUp Attempt with Missing Credentials
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Move to signUp page
    Do SignUp Attempt with Missing Credentials
    Do Screenshot

 SignUp Attempt with Duplicate Email  
     Do SignUp Attempt with Duplicate Email
     Verify SignUp Attempt with Duplicate Email
     Do Screenshot


SignUp with correct credential
    Reload Page
    Do SignUp with correct credential
    Verify SignUp with correct credential
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

Accept TnC
    Click Element                 //input[@type='checkbox']
    Wait Until Page Contains      Terms and conditions
    Wait Until Element Is Enabled   xpath=//button[contains(.,'Accept')]    
    Click Element                 xpath=//button[contains(.,'Accept')]
    Wait Until Page Contains      Welcome back! Please select method to sign up

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
    Wait Until Element Is Enabled    xpath=//button[@type='submit']
    Click Element                    xpath=//button[@type='submit']
Verify SignUp with correct credential
    Element Should Not Contain    xpath=//div[contains(span[@class='alert-text'], 'Email already exists')]       Email already exists 
    ${Verify_signup}   Wait Until Page Contains    Your account successfully created    timeout=30s
    Run Keyword If    '${Verify_signup}' == 'True'
    ...    Log   Passed. User successfully Create account
    ...    ELSE
    ...    Log    Failed create accoount
    Wait Until Page Contains    Your account successfully created     timeout=5s

Do SignUp Attempt with Missing Credentials
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Scroll Element Into View         xpath=//button[@type='submit']
    sleep    1s
    ${CheckButton}   Element Should Be Disabled       xpath=//button[@type='submit']    
    Run Keyword If    '${CheckButton}' == 'True'
    ...    Log  Passed. Button is disabled.
    ...    ELSE
    ...    Log    Failed. Button is enabled
    Element Should Be Disabled       xpath=//button[@type='submit']    

    
 Do SignUp Attempt with Duplicate Email
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${DuplicateEmail}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${ConfirmPass}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Click Element                    xpath=//button[@type='submit']   

Verify SignUp Attempt with Duplicate Email
    ${VerifyEmail}   Wait Until Element Contains    xpath=//div[contains(span[@class='alert-text'], 'Email already exists')]    Email already exists
    Run Keyword If    '${VerifyEmail}' == 'True'
    ...    Log   Passed. users cannot use an email that is already registered
    ...    ELSE
    ...    Log    Failed. users can use an email that is already registered
    Page Should Contain Element    xpath=//div[contains(span[@class='alert-text'], 'Email already exists')]
    
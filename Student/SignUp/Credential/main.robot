*** Settings ***
Documentation     Sign up with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${SignUp}=             xpath=//a[text()='Sign up']
${FullName}=           Raisani aprilia
${Email}=              testing17@gmail.com
${BirthDate}=          20040425
${Password}=           asdasd@123
${ConfirmPass}=        asdasd@123 
${Pass-Symbols}=       asdasd123
${Pass-Letters}=       1313@123
${Pass-Numbers}=       asdasd@asdads
${Pass-Less}=          asd@1
${DuplicateEmail}=     testing01@gmail.com
${message}=            write your message...


*** Test Cases *** 

SignUp Attempt with Missing Credentials
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Move to signUp page
    Do SignUp Attempt with Missing Credentials
    Do Screenshot

SignUp Without entering Fullname
    Reload Page
    Do SignUp without entering fullname
    Do Screenshot

SignUp Without entering email
    Reload Page
    Do SignUp without entering email
    Do Screenshot

 SignUp Attempt with Duplicate Email  
     Reload Page
     Do SignUp Attempt with Duplicate Email
     Verify SignUp Attempt with Duplicate Email
     Sleep    1s
     Do Screenshot
     Reload Page

SignUp Attempt with Age Below 13 Years
    Reload page
    Do signUp with Age Below 13 Years
    Do Screenshot

SignUp Attempt without entering password
    Reload page
    Do SignUp without entering password
    Do Screenshot

SignUp Attempt without entering confirmPass
    Reload page
    Do SignUp without entering confirmPass
    Do Screenshot

SignUp Attempt with Password Missing Symbols
    Reload page
    Do SignUp with Password Missing Symbols
    Do Screenshot

SignUp Attempt with Password Missing Letters
    Reload page
    Do SignUp with Password Missing Letters
    Do Screenshot

SignUp Attempt with Password Missing Numbers
    Reload page
    Do SignUp with Password Missing Numbers
    Do Screenshot

SignUp Attempt with Password Less Than 8 Characters
    Reload page
    Do SignUp with Password Less Than 8 Characters
    Do Screenshot

SignUp Attempt with Password Confirmation Mismatch
    Reload page
    Do SignUp with Password Confirmation Mismatch
    Do Screenshot    

SignUp Attempt without Accepting Terms and Conditions
    Reload Page
    Do SignUp without Accepting Terms and Conditions
    Do Screenshot 
    
SignUp with correct credential
    Reload Page
    Do SignUp with correct credential
    Verify SignUp with correct credential

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
    Scroll Element Into View         xpath=//button[@type='submit']
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
    Sleep    3s
    Do Screenshot
Verify SignUp with correct credential
    Wait Until Page Contains      Kirana    timeout=30s
    ${Verify_signup}   Wait Until Page Contains  Kirana    timeout=30s
    Run Keyword If    '${Verify_signup}' == 'True'
    ...    Log   Passed. User successfully Create account
    ...    ELSE
    ...    Log    Failed create accoount
    
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


Do SignUp without entering email
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${ConfirmPass}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Click Element                    xpath=//button[@type='submit']
    Wait Until Element Contains      xpath=//div[@class='invalid-feedback' and text()='Email is required']    Email is required

Do SignUp without entering fullname
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${ConfirmPass}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Click Element                    xpath=//button[@type='submit']
    Wait Until Element Contains      xpath=//div[@class='invalid-feedback' and text()='Name is required']    Name is required

Do signUp with Age Below 13 Years
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
     Input Text                      //input[@id='validationCustom01']    ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${ConfirmPass}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']    
    Wait Until Element Contains      xpath=//div[@class='invalid-feedback-doesnt-match' and contains(text(), 'Birthdate invalid, Must be 13 y.o. or older')]    Birthdate invalid, Must be 13 y.o. or older

Do SignUp without entering password
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${ConfirmPass}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']    
    Wait Until Element Contains      xpath=//div[@class='invalid-feedback-doesnt-match' and contains(text(), 'Confirm password is not match')]    Confirm password is not match
    Sleep    3s

Do SignUp without entering confirmPass
    Wait Until Element Is Visible    //input[@id='validationCustom01']
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Sleep    3s    

Do SignUp with Password Missing Symbols
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Pass-Symbols}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${Pass-Symbols}
    Scroll Element Into View         xpath=//button[@type='submit']
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Do Screenshot

Do SignUp with Password Missing Letters
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Pass-Letters}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${Pass-Letters}
    Scroll Element Into View         xpath=//button[@type='submit']
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Do Screenshot    

Do SignUp with Password Missing Numbers
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Pass-Numbers}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${Pass-Numbers}
    Scroll Element Into View         xpath=//button[@type='submit']
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Do Screenshot  

Do SignUp with Password Less Than 8 Characters
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Pass-Less}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${Pass-Less}
    Scroll Element Into View         xpath=//button[@type='submit']
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Do Screenshot  

Do SignUp with Password Confirmation Mismatch
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${Pass-Numbers}
    Scroll Element Into View         xpath=//button[@type='submit']
    Accept TnC
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Do Screenshot  

Do SignUp without Accepting Terms and Conditions
    Wait Until Element Is Visible    //input[@id='validationCustom01'] 
    Input Text                       //input[@id='validationCustom01']     ${FullName}
    Input Text                       //input[@id='validationCustom03']     ${Email}
    Input Text                       //div[@id='dob']/input[@type='text']  ${BirthDate}  
    Input Password                   //input[@id='validationCustom04']     ${Password}
    Wait Until Element Is Visible    //input[@id='validationCustom04'] 
    Input Password                   //input[@id='validationCustom05']     ${Password}
    Scroll Element Into View         xpath=//button[@type='submit']
    Element Should Be Disabled       xpath=//button[@type='submit']
    Do Screenshot      
                
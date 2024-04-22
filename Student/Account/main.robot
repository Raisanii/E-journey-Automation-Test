*** Settings ***
Documentation     Login with credential
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Library           String

*** Variables ***
${URL}=                https://staging.auth.app.ejourney.id/
${Email}=              sani@gmail.com
${Password}=           asdasd@123
${Username}=           Raisani Aprilia
${FullNameEdt}=        Sansan aprilia update
${UsernameEdt}=        Sunnyy update
${EmailEdt}=           update@gmail.com
${EmailDpl}=           sani2@gmail.com
${Profession}=         Student update
${Birthdate}=          2000-02-01 
${Interest}=           techonolgy and math update
${Goals}=              I want to be a great human update
${Skills}=             Automation testing update
${FilePDF}=            D:/Primeskill/E-journey/Student/Account/files/pdf.pdf
${Image}=              D:/Primeskill/E-journey/Student/Account/files/pp.jpg 
${NewPass}=            apaaja123@

*** Test Cases ***
Login with correct credential
    Open Browser        ${URL}    browser=chrome
    Maximize Browser Window
    Wait Until Page Contains    Welcome back! Please select method to sign in    timeout=10s
    Do login with correct credential
    Verify login

Redirect to profile page 
    Redirect to profile page
    Do Screenshot

Change password with correct data
    Do change password with correct data
    Do Screenshot
    Verify change password
    Do Screenshot
    
Update profile picture  
    Redirect to profile page
    Do update profile picture
    Do Screenshot

Update profile picture with incorrect file 
    Reload Page
    Do update profile picture with incorrect file
    Do Screenshot
             
Edit profile with duplicate email 
    Reload Page
    Wait Until Page Contains    My Account
    Do edit profile with duplicate email
    Do Screenshot

Edit profile with correct data    
    Reload Page
    Wait Until Page Contains    My Account
    Do edit profile with correct data
    Do Screenshot

# Edit profile with Missing data
#     Do edit profile with missing data   
#     Do Screenshot


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
    Wait Until Page Contains      Kirana    timeout=32
    ${verify_login}   Wait Until Page Contains  Kirana   timeout=30s
    Run Keyword If    '${verify_login}' == 'True'
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed    
    
Redirect to profile page
    Wait Until Element Is Visible   xpath=(//a[@id='dropdownMenuButton']/div/div)[2]    timeout=30s
    Sleep    1s
    Click Element                   xpath=(//a[@id='dropdownMenuButton']/div/div)[2]
    Click Element                   xpath=//a[contains(.,'Account')]
    Wait Until Page Contains        My Account

Do edit profile with correct data
    Click Element    xpath=//div[@id='account']/div[2]/div[2]
    Wait Until Page Contains    Full Name
    Input Text       xpath=//div[@id='account']/div[2]/div[2]/div/input        ${FullNameEdt}
    Input Text       xpath=//div[@id='account']/div[2]/div[2]/div[2]/input     ${UsernameEdt}
    Input Text       xpath=//div[@id='account']/div[2]/div[3]/div/input        ${EmailEdt}
    Input Text       xpath=//div[@id='account']/div[2]/div[3]/div[2]/input     ${Profession}
    Input Text       xpath=//div[@id='account']/div[2]/div[4]/div/input        ${Birthdate}
    Input Text       xpath=//div[@id='account']/div[2]/div[4]/div[2]/input     ${Interest}
    Input Text       xpath=//div[@id='account']/div[2]/div[5]/input            ${Skills}
    Input Text       xpath=//div[@id='account']/div[2]/div[6]/textarea         ${Goals}    
    Scroll Element Into View     xpath=//button[2]
    Wait Until Element Is Enabled     xpath=//button[2]
    Click Element    xpath=//button[2]
    Sleep    2s
    Wait Until Page Contains    Your account successfully edited

Do edit profile with missing data4
    
    Click Element    xpath=//div[@id='account']/div[2]/div[2]
    Wait Until Page Contains    Full Name
    Input Text       xpath=//div[@id='account']/div[2]/div[2]/div/input        ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[2]/div[2]/input     ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[3]/div/input        ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[3]/div[2]/input     ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[4]/div/input        ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[4]/div[2]/input     ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[5]/input            ${EMPTY}
    Input Text       xpath=//div[@id='account']/div[2]/div[6]/textarea         ${EMPTY}  
    Sleep    2s  
    Scroll Element Into View     xpath=//button[2]
    Wait Until Element Is Enabled     xpath=//button[2]
    Click Element    xpath=//button[2]
    Sleep    2s
    Page Should Not Contain    Your account successfully edited   

Do edit profile with duplicate email
    Wait Until Page Contains    My Account
    Click Element    xpath=//div[@id='account']/div[2]/div[2]
    Wait Until Page Contains    Full Name
    Input Text       xpath=//div[@id='account']/div[2]/div[3]/div/input        ${EmailDpl}
    Scroll Element Into View     xpath=//button[2]
    Wait Until Element Is Enabled     xpath=//button[2]
    Click Element    xpath=//button[2]
    Sleep    2s
    Page Should Not Contain    Your account successfully edited   
         
Do update profile picture
    
    Click Element    xpath=//div[@id='account']/div[2]/div[2]
    Wait Until Page Contains Element    xpath=//input[@type='file' and contains(@class, 'hidden') and contains(@accept, 'png') and contains(@accept, 'jpg') and contains(@accept, 'jpeg')]
    Choose File    xpath=//input[@type='file' and contains(@class, 'hidden') and contains(@accept, 'png') and contains(@accept, 'jpg') and contains(@accept, 'jpeg')]    ${Image}
    Sleep    5s
    Scroll Element Into View     xpath=//button[2]
    Click Element    xpath=//button[2]
    Wait Until Page Contains    Your account successfully edited

Do update profile picture with incorrect file
    Sleep    3s
    Click Element    xpath=//div[@id='account']/div[2]/div[2]
    Wait Until Page Contains Element    xpath=//input[@type='file' and contains(@class, 'hidden') and contains(@accept, 'png') and contains(@accept, 'jpg') and contains(@accept, 'jpeg')]
    Choose File    xpath=//input[@type='file' and contains(@class, 'hidden') and contains(@accept, 'png') and contains(@accept, 'jpg') and contains(@accept, 'jpeg')]    ${FilePDF}
    Sleep    5s
    Scroll Element Into View     xpath=//button[2]
    Click Element    xpath=//button[2]  
    Sleep    2s
    Page Should Not Contain    Your account successfully edited
    Reload Page

Do logout
    Reload Page
    Wait Until Element Is Visible   xpath=(//a[@id='dropdownMenuButton']/div/div)[2]    timeout=30s
    Click Element                   xpath=(//a[@id='dropdownMenuButton']/div/div)[2]
    Click Element                   xpath=//li[4]/a
    Wait Until Page Contains         Welcome back! Please select method to sign in    timeout=10s

Do change password with correct data
    Scroll Element Into View    xpath=//div[3]/button
    Click Element    xpath=//div[3]/button
    sleep    1s
    Input Password    xpath=//div[@id='account']/div[4]/div/div/div[2]/form/div/input       ${Password}
    Input Password    xpath=//div[@id='account']/div[4]/div/div/div[2]/form/div[2]/input    ${NewPass}
    Input Password    xpath=//div[@id='account']/div[4]/div/div/div[2]/form/div[3]/input    ${NewPass}
    Click Element     xpath=//button[2]
    Wait Until Page Contains    Your password successfully changed


Verify change password
    Do logout
    Input Text                    xpath=//input[@id='validationCustom03' and @type='email']                            ${Email}
    Input Password                xpath=//input[@id='validationCustom03' and @type='password' and @name='password']    ${NewPass}
    Click Element                 xpath=//button[@type='submit']  
    Wait Until Page Contains      Kirana    timeout=32
    ${verify_login}   Wait Until Page Contains  Kirana   timeout=30s
    Run Keyword If    '${verify_login}' == 'True'
    ...    Log   Passed
    ...    ELSE
    ...    Log    Failed  
*** Settings ***
Documentation     Test case for verifying the form submission with invalid inputs.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Suite Setup       Open Browser To Form Page
Suite Teardown    Close Browser
Test Setup        Go To Form Page
Test Template     Submit Invalid Form Should Fail
Resource          resource.robot

*** Test Cases ***                   FIRST NAME     LAST NAME    DESTINATION     CONTACT PERSON      RELATIONSHIP    EMAIL                      PHONE
Empty Destination                    Somsong        Sandee       ${EMPTY}        Sodsai Sandee       Mother          somsong@kkumail.com        081-111-1234
Empty Email                          Somsong        Sandee       Europe          Sodsai Sandee       Mother          ${EMPTY}                   081-111-1234
Invalid Email                        Somsong        Sandee       Europe          Sodsai Sandee       Mother          somsong@                   081-111-1234
Empty Phone Number                   Somsong        Sandee       Europe          Sodsai Sandee       Mother          somsong@kkumail.com        ${EMPTY}
Invalid Phone Number                 Somsong        Sandee       Europe          Sodsai Sandee       Mother          somsong@kkumail.com        191

*** Keywords ***
Submit Invalid Form Should Fail
    [Arguments]    ${firstname}    ${lastname}    ${destination}    ${contactperson}    ${relationship}    ${email}    ${phone}
    Input Text    firstname        ${firstname}
    Input Text    lastname         ${lastname}
    Input Text    destination       ${destination}
    Input Text    contactperson    ${contactperson}
    Input Text    relationship      ${relationship}
    Input Text    email             ${email}
    Input Text    phone             ${phone}
    Submit Form
    Form Submission Should Fail    ${destination}    ${email}    ${phone}

Form Submission Should Fail
    Location Should Be    ${FORM URL}
    [Arguments]    ${destination}    ${email}    ${phone}
    Run Keyword If    '${destination}' == '${EMPTY}'    Element Text Should Be    id:errors    Please enter your destination.
    Run Keyword If    '${email}' == '${EMPTY}'          Element Text Should Be    id:errors    *Please enter an email!!
    Run Keyword If    '${email}' == 'somsong@'          Element Text Should Be    id:errors    *Please enter a valid email!!
    Run Keyword If    '${phone}' == '${EMPTY}'          Element Text Should Be    id:errors    *Please enter a phone number!!
    Run Keyword If    '${phone}' == '191'               Element Text Should Be    id:errors    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678.
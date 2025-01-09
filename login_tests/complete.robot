*** Settings ***
Documentation     Test case for verifying the form submission with valid inputs.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Open Form
    Open Browser To Form Page

Record Success
    Input First Name    Somsong
    Input Last Name    Sandee
    Input Destination    Europe
    Input Contact Person    Sodsai Sandee
    Input Relationship    Mother
    Input Email    somsong@kkumail.com
    Input Phone No    081-111-1234
    Submit Form
    Location Should Be    ${COMPLETE URL}
    Title Should Be    Completed
    Page Should Contain    Our agent will contact you shortly.
    Page Should Contain    Thank you for your patient.
    [Teardown]    Close Browser
    
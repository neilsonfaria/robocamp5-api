*** Settings ***
Library               Collections
Library               RequestsLibrary

*** Test Cases ***
Login na API
    Dado que o usuário informou suas credenciais de acesso:
    ...     papito@ninjapixel.com   pwd123
    Quando eu faço uma solicitação POST para o serviço /auth
    Entao o código de resposta deve ser igual a     200

Senha incorreta
    Dado que o usuário informou suas credenciais de acesso:
    ...     papito@ninjapixel.com   abc123
    Quando eu faço uma solicitação POST para o serviço /auth
    Entao o código de resposta deve ser igual a     401

***Keywords***
Dado que o usuário informou suas credenciais de acesso:
    [Arguments]     ${email}        ${pass}

    &{payload}=       Create Dictionary     email=${email}     password=${pass}

    Set Test Variable       ${payload}

Quando eu faço uma solicitação POST para o serviço /auth
    Create Session    pixel          http://pixel-api:3333

     &{headers}=       Create Dictionary     Content-Type=application/json

     ${resp}=          Post Request   pixel      /auth   data=${payload}     headers=${headers}

     Set Test Variable      ${resp}

Entao o código de resposta deve ser igual a
    [Arguments]     ${status_code}

    Status Should Be    ${status_code}    ${resp}

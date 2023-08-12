Guia de Utilização: GLPI com Docker
Pré-requisitos:

    Docker instalado em sua máquina.
    Docker Compose instalado em sua máquina.

Passo a Passo:
1. Obtenção do docker-compose.yml

Certifique-se de ter o docker-compose.yml que definimos anteriormente. Você pode obtê-lo clonando um repositório Git ou baixando-o diretamente.
2. Inicialize o GLPI e o banco de dados

No diretório onde o docker-compose.yml está localizado, execute o seguinte comando:

bash

docker-compose up -d

Este comando irá baixar as imagens necessárias (se ainda não tiverem sido baixadas) e inicializar os contêineres para o GLPI e o banco de dados.
3. Acesse a interface do GLPI

Após os contêineres estarem em execução, abra um navegador e acesse:

http://IP:8080

Você será levado para a página de instalação inicial do GLPI.
4. Siga o assistente de instalação

    Escolha o idioma desejado e clique em "OK".

    Leia e aceite os termos da licença.

    Escolha "Instalar" para uma nova instalação.

    Na página de configuração do banco de dados:
        Servidor SQL: db (nome do serviço do banco de dados no docker-compose.yml)
        Usuário: glpi
        Senha: Ch@ng3P@ssw0rd (ou a que você definiu no docker-compose.yml)

    Clique em "Continuar".

    Selecione o banco de dados glpi da lista e prossiga.

    Siga as etapas restantes do assistente de instalação, configurando informações adicionais conforme desejado.

5. Login no GLPI

Depois de finalizar a instalação, você será levado à tela de login. Por padrão, você pode usar glpi como nome de usuário e senha para acessar com uma conta de administrador.
6. Configuração adicional

Dentro do GLPI, você pode agora configurar usuários adicionais, ativos, regras, plugins e outras configurações conforme sua necessidade.
Conclusão

Agora você tem uma instalação funcional do GLPI rodando via Docker. Isso facilita a manutenção, backup e atualização do sistema, uma vez que tudo é containerizado.

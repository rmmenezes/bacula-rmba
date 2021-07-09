

# Manual de Execução dos Scripts 

Para que serve este script?:

É esperado que ao final da instalação de todos os scipts corretamente, obtenha um ambiente funcional do Bacula e Baculum no sistema operacional Centos 8.

O que é feito em cada script?:

Script -> 01-bacula-install.sh: Instala o bacula, baculum e todos os requisitos de instalação necessários como exemplo MySQL.

Script -> 02-bacula-configure-files.sh: Subistiui os arquivos de configuração do bacula pelo os arquivos de configuração já configurados e disponíveis neste repositório no diretório "conf"

Script -> 03-bacula-restart-all.sh: Este script realiza o "restart" de todos os serviços do bacula


ATENÇÃO: Executar todos os scripts com sudo ativo.

### Instalar o git 
yum install git -y

### Clonar o repositório
git clone https://github.com/rmmenezes/bacula-rmba.git

### Entrar no diretório
cd bacula-rmba

### Prover permissão de execução aos scripts
chmod 777 *.sh

### Execute cada um deles na sequência 
./01-bacula-install.sh

./02-bacula-configure-files.sh

./03-bacula-restart-all.sh

### Execute este conjunto de linhas
sudo /usr/libexec/bacula/grant_mysql_privileges
sudo /usr/libexec/bacula/create_mysql_database -u root
sudo /usr/libexec/bacula/make_mysql_tables -u bacula

mysql --execute="UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"
mysql --user="root" --password="password" --execute="UPDATE mysql.user SET Password=PASSWORD('bacula') WHERE User='bacula';"
mysql --user="root" --password="password" --execute="FLUSH PRIVILEGES;"

### Ateção, apos reiniciar a maquina SEMPRE executar o script "03-bacula-restart-all.sh" para que todos os serviços bacula voltem para o status ativo.

### Entrar no diretório
cd bacula-rmba
### Execute o script 03 isoladamente (use o sudo)
./03-bacula-restart-all.sh



#INICIALIZAR A CONSOLE WSLT 
[MIDDLEWARE_HOME]\[SOA_HOME]\common\bin\wlst.cmd

#CONECTAR ADMIN SERVER
connect('[USUARIO]','[SENHA]','t3://[ADMIN_SERVER]:[PORTA_CONSOLE]');

#BACKUP DO MDS (TOTAL)
exportMetadata(application='soa-infra',server='[HOSTNAME_MANAGEDSERVER]',toLocation='[CAMINHO DO ZIP C:/test/][NOME_BACKUP].zip',remote='true');

#BACKUP DO MDS (APPS)
exportMetadata(application='soa-infra',server='[HOSTNAME_MANAGEDSERVER]',toLocation='[CAMINHO DO ZIP C:/test/][NOME_BACKUP].zip',docs='/apps/**',remote='true');

#DEPLOY DO MDS 
importMetadata(application='soa-infra',server='[HOSTNAME_MANAGEDSERVER]', fromLocation='[CAMINHO DO ZIP C:/test/][NOME_PACOTE].zip',remote='true');

#SAIR DA CONSOLE
exit()

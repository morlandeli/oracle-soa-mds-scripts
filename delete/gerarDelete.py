linhas=[]
linhasOut =[]

file_assets = open('lista.txt','r')
linhas = file_assets.readlines()
file_assets.close()


file_script = open('limpeza.py','w',encoding='utf-8-sig')
file_script.writelines('connect("xxx","xxx","t3://xxxx")\n')

for x in linhas:
    if x.lower().find(".xsd") != -1 or x.lower().find(".wsdl") != -1:
        print("OK  -> %s" % x)
    else:
        file_script.writelines("deleteMetadata(application='soa-infra',server='SOA_Server01_01',docs='%s')\n" % x.replace('\n',''))
        print("NOK -> %s" % x)

file_script.close()






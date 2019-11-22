DELETE
  FROM MDS_PATHS t
 WHERE t.path_fullname NOT LIKE '/apps%'
   AND t.path_fullname NOT LIKE '/policies%'
   AND t.path_fullname NOT LIKE '/assertiontemplates%'
   AND t.path_fullname NOT LIKE '/intents%'
   and t.path_fullname not like '/assertionmetadata%'
   and t.path_fullname not like '/tokenissuertrust%'
   and t.path_fullname not like '/contributions%'
   and t.path_fullname not like '/repository%'   
   and t.path_fullname not like '/oracle%'      
   AND ( t.path_fullname NOT LIKE '/soa/%'
   AND t.path_fullname <> '/soa')
   AND t.path_fullname NOT LIKE '/deployed-composites%'
   AND t.path_fullname NOT LIKE '/policyAttachments%'
   AND t.path_fullname NOT LIKE '/mdssys%'
   AND t.path_fullname NOT LIKE '/resource%'
   AND t.path_fullname NOT LIKE '/model%'
   AND t.path_fullname NOT LIKE '/bpm%'
   AND t.path_fullname NOT LIKE '/last_update%';
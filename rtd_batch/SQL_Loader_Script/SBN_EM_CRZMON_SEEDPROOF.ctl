load data 
truncate
into table RTD_BATCH_INPUTFILE_STAGING
fields terminated by X'09'
trailing nullcols
           ( MARINER_ID CHAR(4000),
             EMAIL_ADDRESS CHAR(4000),
             FIRST_NAME CHAR(4000),
             LAST_NAME CHAR(4000),
             ATTRIBUTE_1 CHAR(4000),
             ATTRIBUTE_2 CHAR(4000),             
             PCC_NAME CHAR(4000),
			 PCC_PHONE_EXT CHAR(4000),
             PCC_EMAIL_ADDRESS CHAR(4000),
			 LOYALTY_LEVEL
           )

load data 
truncate
into table RTD_BATCH_INPUTFILE_STAGING
fields terminated by '|'
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( ATTRIBUTE_1 CHAR(4000),
             ATTRIBUTE_2 CHAR(4000),
             FIRST_NAME CHAR(4000),
             LAST_NAME CHAR(4000),
             EMAIL_ADDRESS CHAR(4000),
             MARINER_ID CHAR(4000),
             LOYALTY_LEVEL CHAR(4000),
             ATTRIBUTE_3 CHAR(4000),
             ATTRIBUTE_4 CHAR(4000),
             ATTRIBUTE_5 CHAR(4000),
             ATTRIBUTE_6 CHAR(4000),
             ATTRIBUTE_7 CHAR(4000),
             ATTRIBUTE_8 CHAR(4000),
             ATTRIBUTE_9 CHAR(4000),
             PCC_NAME CHAR(4000),
             PCC_EMAIL_ADDRESS CHAR(4000),
             PCC_PHONE_EXT CHAR(4000),
             ATTRIBUTE_11,
             ATTRIBUTE_12,
             ATTRIBUTE_13,
             ATTRIBUTE_16,
             ATTRIBUTE_17,
             ATTRIBUTE_18
           )

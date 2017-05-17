load data 
infile 'C:\Yuji\Epsilon\Holland\Email Marketing Hero image personalization\planing\Loyalty_EM_Export_PCC_SE1711SEL sample.tsv' "str '\r\n'"
append
into table RTD_BATCH_INPUTFILE_STAGING
fields terminated by X'09'
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( STRING_1 CHAR(4000),
             STRING_2 CHAR(4000),
             STRING_3 CHAR(4000),
             STRING_4 CHAR(4000),
             STRING_5 CHAR(4000),
             STRING_6 CHAR(4000),
             STRING_7 CHAR(4000),
             STRING_8 CHAR(4000),
             STRING_9 CHAR(4000),
             STRING_10 CHAR(4000),
             STRING_11 CHAR(4000),
             STRING_12 CHAR(4000),
             STRING_13 CHAR(4000),
             STRING_14 CHAR(4000),
             STRING_15 CHAR(4000),
             STRING_16 CHAR(4000),
             STRING_17 CHAR(4000),
             NUMBER_1 CHAR(4000),
             NUMBER_2 CHAR(4000),
             NUMBER_3 CHAR(4000),
             NUMBER_4 CHAR(4000),
             NUMBER_5 CHAR(4000),
             NUMBER_6 CHAR(4000)
           )

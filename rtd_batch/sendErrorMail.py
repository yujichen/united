import os
import sys



def sendMail(body):
    sendmail_location = "/usr/sbin/sendmail" # sendmail location
    p = os.popen("%s -t" % sendmail_location, "w")
    p.write("From: RTDReporting@holland.com\n")
    p.write("TO:bardiya.choupani@epsilon.com,wai.chen@epsilon.com ,kevin.ng@epsilon.com,ravikumar.nagabhyru@epsilon.com,MDowe@HollandAmericaGroup.com,Ben.Brown@epsilon.com\n")    
    #p.write("To: bardiya@gmail.com,MDowe@HollandAmericaGroup.com \n")
    #p.write("To: wai.chen@epsilon.com \n")
    #p.write("TO:bardiya.choupani@epsilon.com,kevin.ng@epsilon.com,ravikumar.nagabhyru@epsilon.com\n")
    p.write("MIME-Version: 1.0\n")
    p.write("Content-Type: multipart/alternative; \n")
    p.write("boundary=\"HOLLAND\"\n")
    p.write("Subject:DirectMail Inbound Reporting \n")
    p.write("\n")
    p.write("--HOLLAND\n")
    p.write("Content-Type: text/html\n")
    p.write("\n")
    p.write(body)
    status = p.close()
    if status != 0:
        print("Sendmail exit status", status)
		
total = len(sys.argv)
cmdargs = str(sys.argv)
print ("The total numbers of args passed to the script: %d " % total)
print ("Args list: %s " % cmdargs)
# Pharsing args one by one 
print ("Script name: %s" % str(sys.argv[0]))
print ("First argument: %s" % str(sys.argv[1]))
print ("Second argument: %s" % str(sys.argv[2]))
HTML=("Inbound file " +  str(sys.argv[1]) + " upload having this error <b>"+  str(sys.argv[2]) +"</b> Please go to inbound folder correct it and upload again.")
sendMail(HTML)


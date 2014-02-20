#!/bin/bash

#################################################
#                  EZDUDE_0.1                   #
#################################################
#   A simple script to ease the use of avrdude  #
#################################################
#   by Anderson Felippe <adfelippe@gmail.com>   #
#################################################

thanks () {
    echo "
Thanks for using the EZDUDE script! ;)
    "
    exit 1
}

fuse () {

	echo "Enter LOW fuse: 0x"; read low
	echo "Enter HIGH fuse: 0x"; read high
	echo "Enter EXTENDED fuse: 0x"; read ext
	echo "Enter LOCK bits: 0x"; read lock
	avrdude -p $device -c $programmer -P $port -v -e -Uefuse:w:0x$ext:m -Uhfuse:w:0x$high:m -Ulfuse:w:0x$low:m -Ulock:w:0x$lock:m
    thanks
}

flash () {
	echo "
	Enter path to the file to be flashed: "; read filepath
	avrdude -p $device -c $programmer -P $port -v -e -U flash:w:s$filepath
    thanks
}

usage () {
    echo "
        Usage of the script:

        ./ezdude.sh fuse    [Program the fuses]
        ./ezdude.sh flash   [Flash memory with binary/hex file]
        ./ezdude.sh help    [Show this help]
        
        Run the script and follow the instructions.
        "
        exit 1
}

if [[ ($1 != "flash") && ($1 != "fuse") ]]; then
    usage
fi

echo "***********************************************"
echo "*   EZDUDE_0.1: An easy way to use avrdude    *"
echo "***********************************************"
echo "*      Simply follow the instructions         *"
echo "***********************************************"
echo "*      Bash script by Anderson Felippe        *"
echo "***********************************************"
echo "*	<adfelippe@gmail.com>	   2013       *"
echo "***********************************************
"
echo "Press <ENTER> to continue...
"
read nothing
echo "Select the device to be programmed on the list below:"

echo "
  t10  = ATtiny10	  	t9   = ATtiny9    		t5   = ATtiny5         
  t4   = ATtiny4 	  	ucr2 = 32UC3A0512		x128a4 = ATXMEGA128A4    
  x64a4 = ATXMEGA64A4		x32a4 = ATXMEGA32A4    		x16a4 = ATXMEGA16A4     
  x256a3b = ATXMEGA256A3B	x256a3 = ATXMEGA256A3    	x192a3 = ATXMEGA192A3    
  x128a3 = ATXMEGA128A3    	x64a3 = ATXMEGA64A3     	x256a1 = ATXMEGA256A1    
  x192a1 = ATXMEGA192A1		x128a1d = ATXMEGA128A1REVD	x128a1 = ATXMEGA128A1    
  x64a1 = ATXMEGA64A1     	m6450 = ATMEGA6450      	m3250 = ATMEGA3250      
  m645 = ATMEGA645       	m325 = ATMEGA325       		m8u2 = ATmega8U2       
  m16u2 = ATmega16U2      	m32u2 = ATmega32U2      	usb82 = AT90USB82       
  usb162 = AT90USB162      	usb1287 = AT90USB1287     	usb1286 = AT90USB1286     
  usb647 = AT90USB647      	usb646 = AT90USB646      	m32u4 = ATmega32U4      
  t84  = ATtiny84        	t44  = ATtiny44        		t24  = ATtiny24        
  m128rfa1 = ATMEGA128RFA1	m2561 = ATMEGA2561      	m2560 = ATMEGA2560      
  m1281 = ATMEGA1281      	m1280 = ATMEGA1280      	m640 = ATMEGA640       
  t85  = ATtiny85        	t45  = ATtiny45        		t25  = ATtiny25        
  pwm3b = AT90PWM3B       	pwm2b = AT90PWM2B       	pwm3 = AT90PWM3        
  pwm2 = AT90PWM2        	t4313 = ATtiny4313      	t2313 = ATtiny2313      
  m328p = ATMEGA328P      	t88  = attiny88        		m168p = ATMEGA168P      
  m168 = ATMEGA168       	m88p = ATMEGA88P       		m88  = ATMEGA88        
  m48  = ATMEGA48        	t861 = ATTINY861       		t461 = ATTINY461       
  t261 = ATTINY261       	t26  = ATTINY26        		m8535 = ATMEGA8535      
  m8515 = ATMEGA8515      	m8   = ATMEGA8         		m161 = ATMEGA161       
  m32  = ATMEGA32        	m6490 = ATMEGA6490      	m649 = ATMEGA649       
  m3290p = ATMEGA3290P     	m3290 = ATMEGA3290      	m329p = ATMEGA329P      
  m329 = ATMEGA329       	m169 = ATMEGA169       		m163 = ATMEGA163       
  m162 = ATMEGA162       	m1284p = ATMEGA1284P     	m644p = ATMEGA644P      
  m644 = ATMEGA644       	m324pa = ATmega324PA     	m324p = ATMEGA324P      
  m164p = ATMEGA164P      	m16  = ATMEGA16        		c32  = AT90CAN32       
  c64  = AT90CAN64       	c128 = AT90CAN128      		m128 = ATMEGA128       
  m64  = ATMEGA64        	m103 = ATMEGA103       		8535 = AT90S8535       
  8515 = AT90S8515       	4434 = AT90S4434       		4433 = AT90S4433       	
  2343 = AT90S2343       	2333 = AT90S2333       		2313 = AT90S2313       
  4414 = AT90S4414       	1200 = AT90S1200		t15  = ATtiny15        
  t13  = ATtiny13        	t12  = ATtiny12        		t11  = ATtiny11        
"
echo "Device (e.g.: m328p): "; read device

echo "Select the programmer to be used on the list below:"
echo "
c2n232i  = serial port banging				dasa3    = serial port banging, reset=!dtr sck=rts mosi=txd miso=cts 
dasa     = serial port banging				siprog   = Lancos SI-Prog
ponyser  = design ponyprog serial			89isp    = Atmel at89isp cable            
frank-stk200 = Frank STK200				blaster  = Altera ByteBlaster             
ere-isp-avr = ERE ISP-AVR				atisp    = AT-ISP V1.1 programming cable for AVR-SDK1 from <http://micro-research.co.th/>  
dapa     = Direct AVR Parallel Access cable		xil      = Xilinx JTAG cable              
futurlec = Futurlec.com programming cable.		abcmini  = ABCmini Board, aka Dick Smith HOTCHIP 
picoweb  = Picoweb Programming Cable			sp12     = Steve Bolt's Programmer        
alf      = Nightshade ALF-PgmAVR			bascom   = Bascom SAMPLE programming cable 
dt006    = Dontronics DT006				pony-stk200 = Pony Prog STK200               
stk200   = STK200                         		bsd      = Brian Dean's Programmer
pavr     = Jason Kyle's pAVR Serial Programmer 		dragon_pdi = Atmel AVR Dragon in PDI mode   
dragon_dw = Atmel AVR Dragon in debugWire mode 		dragon_hvsp = Atmel AVR Dragon in HVSP mode  
dragon_pp = Atmel AVR Dragon in PP mode    		dragon_isp = Atmel AVR Dragon in ISP mode   
dragon_jtag = Atmel AVR Dragon in JTAG mode  		jtag2pdi = Atmel JTAG ICE mkII PDI mode   
jtag2avr32 = Atmel JTAG ICE mkII im AVR32 mode 		jtagmkII_avr32 = Atmel JTAG ICE mkII im AVR32 mode 
jtag2dw  = Atmel JTAG ICE mkII in debugWire mode	jtag2isp = Atmel JTAG ICE mkII in ISP mode 
jtag2    = Atmel JTAG ICE mkII            		jtag2fast = Atmel JTAG ICE mkII            
jtag2slow = Atmel JTAG ICE mkII            		jtagmkII = Atmel JTAG ICE mkII            
jtag1slow = Atmel JTAG ICE (mkI)           		jtag1    = Atmel JTAG ICE (mkI)           
jtagmkI  = Atmel JTAG ICE (mkI)           		butterfly_mk = Mikrokopter.de Butterfly       
mkbutterfly = Mikrokopter.de Butterfly       		avr911   = Atmel AppNote AVR911 AVROSP    
avr109   = Atmel AppNote AVR109 Boot Loader 		butterfly = Atmel Butterfly Development Board 
usbtiny  = USBtiny simple USB programmer		usbasp   = USBasp
avr910   = Atmel Low Cost Serial Programmer 		stk600hvsp = Atmel STK600 in high-voltage serial programming mode 
stk600pp = Atmel STK600 in parallel mode		stk600   = Atmel STK600                   
stk500pp = Atmel STK500 V2 in parallel mode		stk500hvsp = Atmel STK500 V2 in high-voltage serial programming mode 
stk500v2 = Atmel STK500 Version 2.x firmware		mib510   = Crossbow MIB510 programming board 
stk500v1 = Atmel STK500 Version 1.x firmware		stk500   = Atmel STK500                   
buspirate = The Bus Pirate                 		avrisp2  = Atmel AVR ISP mkII             
avrispmkII = Atmel AVR ISP mkII            		avrispv2 = Atmel AVR ISP V2               
avrisp   = Atmel AVR ISP 				jtagkey  = Amontec JTAGKey, JTAGKey-Tiny and JTAGKey2                
2232HIO  = FT2232H based generic programmer 		avrftdi  = FT2232D based generic programmer 
arduino  = Arduino                      		wiring   = Wiring
"

echo "Enter the programmer name: "; read programmer

echo "Enter the port where the programmer is connected to (e.g.: usb, /dev/ttyUSB0): "; read port

if $1 == "flash"
then
	flash
else
    fuse
fi

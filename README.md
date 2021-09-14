# RATS
Remote Access Tool Service  
Make a persistent service with a custom script by using systemd on the fly  

The goal of RATS, in this case, is leave a nc connection always listening as a permanent systemd service.  
The resultant is a root shell so this is a privilege escalation script  

# Screenshots 

Run sudo bash RAT-service.sh  
![alt text](https://github.com/0bfxGH0ST/RATS/blob/main/screenshots/screenshot1.png) 
BOOM! Root privileges  
![alt text](https://github.com/0bfxGH0ST/RATS/blob/main/screenshots/screenshot2.png)

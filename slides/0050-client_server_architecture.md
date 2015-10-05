# Client/Server Architecture

.fx: titleslide

---
## Diagram
<img src="../images/client_server_architecture.png" />

## presenter notes
TODO:
* Add link to image source
* Add text on slide regarding report collection

---
## Client Server Communications
* Utilizes port 5308 for client – server communication 
* Encrypted (TLS)
* SSH-like model (public/private keypair)
* Does not use complicated chains of trust
* Agents download policy from hub
* Hub downloads reports from remote agents 



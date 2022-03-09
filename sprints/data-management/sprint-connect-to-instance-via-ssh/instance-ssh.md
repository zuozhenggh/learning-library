# How do I connect to the instance via SSH?

1. Open terminal window

2.  SSH using your private SSH key and your Public IP Address. Remove brackets when writing out IP Address. 
```
ssh -i < Location of Private SSH key> opc@< Your Public IP Address>
```

```
Example: ssh -i .ssh/test opc@132.226.31.189
```
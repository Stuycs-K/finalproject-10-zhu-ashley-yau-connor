# Final Project Proposal

## Group Members:

Ashley Zhu and Connor Yau
       
# Intentions:

Our program will encrypt a message into an image file that may then be decrypted when viewed through a plane in Stegsolve. We aim to implement encryption across all 37 different planes in Stegsolve. 
    
# Intended usage:

The user should run our program and will then be prompted to give an inputs for the message they would like to encrypt, the name of the image file they would like to encrypt this message into, and the Stegsolve pane they would like the message to be visible in.  
  
# Technical Details:
   
Similar to the image encoder and decoder assingment we had, we will implement least significant bit steganography to encode our messages in planes of our stegsolve encoder. For the red, green, blue, and alpha planes, we plan to encrypt our message in a similar way but this time spelling our message out with the bytes. 

The full and gray planes will use a similar idea but will edit a few bits to make the message more visible. 

## Breakdown: 

Ashley
- user input
- xor and gray bits planes
- full planes

Connor
- message to array conversion
- rgb and alpha planes
- random plane
    
# Intended pacing:

5/20: Take in user input
5/21: Convert message to array
5/26: Encrypt for xor, gray bits, full planes
5/26: Encrypt for red, green, blue, alpha planes
5/28: Encrypt for random
5/29: Complete Slides
5/30: Complete Video
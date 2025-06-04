[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/am3xLbu5)
# Tyranno-solve

### Cashley Cha-Ching

Ashley Zhu and Connor Yau

### Project Description:

Our program encrypts a message into an image file through different techniques that may then be decrypted when viewed through varying planes in Stegsolve. We implemented encryption across the random, red, green, blue, xor, and gray planes.

### Instructions:
The user should begin by running `make imageMask` or `make messageMask` to create a message mask text file with a -i flag for the input image/text file name and the -o flag for the output mask text file name. 

After, the user should run `make encode` with arguments with the following flags:  
- -i flag for input user image
- -o flag for output image file name
- -m flag for output message mask text file
- -p flag for mode (red or 0, green or 1, blue or 2, xor or 4, gray or 5, random or 7)
- -n flag for bit edited for relevant planes (red, green, blue)

Finally, the user should view the output image under the specified stegsolve plane to see the message. 

## Project Video
https://drive.google.com/file/d/1sWpxIFiCJgsP9Hztx3JUljcvKWseC4Fq/view?usp=sharing

### Resources/ References:
- https://www.mdpi.com/2076-3417/12/19/10096
- https://www.researchgate.net/publication/271863505_A_Survey_of_Image_Steganography_Techniques
- https://www.dafont.com/daydream-3.charmap?back=bitmap

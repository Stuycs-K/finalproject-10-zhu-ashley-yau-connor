# Image Encoder: Decryption Through Stegsolve

## About Our Project
There are three main steps that should occur when running our program, with the user completing the last step: 
1. Create a mask text file
2. Encode our message into an image so it is visible through a certain stegsolve plane
3. View the image in stegsolve

## Running Our Project
There are three commands the user may run in our program: 
- `make imageMask`: create mask text file from an image
- `make messageMask`: create mask text file from a text file
- `make encode`: encrypt message into image from mask text file

### Flags for Creating Mask File 
If we would like to create a mask text file from a message or image, we will use the following flags: 
| Flag | Description |
| ----- | --------------- |
| -i | input image or message text file |
| -o | output image | 

### Flags for Encryption
| Flag | Description |
| ----- | --------------- |
| -i | input image |
| -o | output image |
| -t | message mask text file |
| -m | plane mode |
| -p | plane mode number |

### Flags for Encryption
| Modes | Red | Green | Blue | xor | gray | random |
| Mode Number | 0 | 1 | 2 | 4 | 5 | 7 |

## Different Planes
We implemented encryption in different types of images so that the images may clearly be visible in different stegsolve planes. These planes are: 
- red, green, blue planes
- xor plane
- random plane
- gray plane
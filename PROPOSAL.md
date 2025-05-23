# Final Project Proposal

## Group Members:

Ashley Zhu and Connor Yau

# Intentions:

Our program will encrypt a message into an image file that may then be decrypted when viewed through a plane in Stegsolve. We aim to implement encryption across all 37 different planes in Stegsolve.

# Intended usage:

The user should run our program and will then be prompted to give an inputs for the message they would like to encrypt, the name of the image file they would like to encrypt this message into, and the Stegsolve pane they would like the message to be visible in.

# Technical Details:

We plan on expanding on the image encoder and decoder lab by implementing steganography to encode our messages into various planes supported by stegsolve. For the red, green, blue, and alpha planes, we plan to be able to encrypt our message into each bit. Two modes will allow for the same functionality as the lab, with greedy and selective style encryption.

We plan to implement a third mode utilizing a more elaborate mask. This advanced mode allows messages or binary masks to visually appear when viewed through specific LSB planes using tools like stegsolve. This will allow us to encode greyscale images into various channels. The target channel(s) are modified such that the structure of the mask becomes visible when isolating individual bit planes.

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

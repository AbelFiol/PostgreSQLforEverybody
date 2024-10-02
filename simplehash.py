while True:
    txt = input("Enter a string: ")  # Prompt the user to enter a string.
    if len(txt) < 1: break  # If the input string is empty, exit the loop.

    hv = 0  # Initialize hv (hash value) to 0.
    for let in txt:  # Iterate through each character in the input string.

        hv = ((hv << 1) ^ ord(let)) & 0xffffff  # Perform left shift, XOR with ASCII value of the character, and limit to 24 bits.

        if (hv < 2000):  # If the hash value is less than 2000:
            print(let, format(ord(let), '08b'), format(hv, '16b'), format(ord(let), '03d'), hv)  
            # Print the character, its binary form, hash value in binary, ASCII value, and hash value.

    print(format(hv, '08x'), hv)  # After processing all characters, print the final hash value in hexadecimal and decimal.
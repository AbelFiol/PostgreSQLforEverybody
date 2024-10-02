x = 15  # Initialize x with the value 15.
y = ord('H')  # Get the ASCII value of character 'H'.
print('x', x, format(x, '08b'))  # Print x and its binary representation in 8 bits.
print('y', y, format(y, '08b'))  # Print y and its binary representation in 8 bits.
print('x^y ', format(x^y, '08b'))  # Perform bitwise XOR between x and y, print the result in binary.
print('x&y ', format(x&y, '08b'))  # Perform bitwise AND between x and y, print the result in binary.
print('x<<1', format(x<<1, '08b'))  # Perform left shift on x by 1, print the result in binary.
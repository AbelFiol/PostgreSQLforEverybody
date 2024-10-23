while True:
    user_input = input("Enter a string: ")  # Prompt for user input.
    if len(user_input) < 1:
        break  # Exit loop if input is empty.

    hash_value = 0  # Initialize hash value.
    position_in_cycle = 0  # Track position in cycle.
    for character in user_input:
        position_in_cycle = (position_in_cycle % 4) + 1  # Update cycle position.
        hash_value = (hash_value + (position_in_cycle * ord(character))) % 1000000  # Calculate hash.
        print(character, position_in_cycle, ord(character), hash_value)  # Output character details.

    print(hash_value, user_input)  # Print final hash value and input.
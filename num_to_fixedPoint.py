def to_fixed_point(value, fractional_bits, exponent_bits):
    # Check if the value is zero (special case)
    if value == 0:
        return '0.' + '0' * fractional_bits

    # Find the exponent (shift left or right) and scale the value accordingly
    exponent = 0
    scaled_value = value
    
    # Normalize the value to fit the fixed-point format with the specified fractional bits
    while abs(scaled_value) >= 1:
        scaled_value /= 2
        exponent += 1
    
    while abs(scaled_value) < 0.5:
        scaled_value *= 2
        exponent -= 1

    # Scale the value to fit the fixed-point representation
    fixed_value = round(scaled_value * (2 ** fractional_bits))

    # Convert the fixed value to binary (integer part)
    binary_value = bin(fixed_value)[2:]  # Remove the '0b' prefix
    
    # Ensure the binary representation fits the required number of fractional bits
    binary_value = binary_value.zfill(fractional_bits + len(binary_value) - binary_value.find('1'))
    
    # Split the binary value into integer and fractional parts
    integer_part = binary_value[:-fractional_bits] if len(binary_value) > fractional_bits else '0'
    fractional_part = binary_value[-fractional_bits:]
    
    # Prepare the exponent part
    # Use a fixed-width signed representation for the exponent
    exponent_binary = bin(exponent & ((1 << exponent_bits) - 1))[2:].zfill(exponent_bits)

    # Combine the parts into a final fixed-point binary representation
    fixed_point_binary = f"{integer_part}.{fractional_part} (Exponent: {exponent_binary})"
    
    return fixed_point_binary


# Supra Move Utils 🚀

A comprehensive utility library for Supra Move development, providing essential helper functions for debugging, data conversion, vector operations, and mathematical computations.

## 🌟 Features

### 🖨️ Enhanced Printing & Debugging
- **Flexible Print Functions**: Print keys, values, or key-value pairs with custom formatting
- **Categorized Logging**: Debug, info, success, warning, and error message types
- **Formatted Output**: Pretty-print with separators and prefixes

### 🔄 Safe Type Conversions
- **String to Numbers**: Convert strings to u8, u16, u32, u64, u128, u256 with overflow protection
- **Number to String**: Convert u64 and boolean values back to strings
- **Input Validation**: Check if strings are numeric before conversion

### 📊 Vector Utilities
- **Vector Operations**: Check empty, size, contains, find index, first, last
- **Vector Manipulation**: Reverse vectors, create ranges, repeat elements
- **Functional Helpers**: Common operations for vector processing

### � Mathematical Functions
- **Min/Max Operations**: For u64, u128, u256 types
- **Power Functions**: Calculate exponential safely
- **Utility Functions**: Absolute difference, even/odd checks, clamping
- **Range Validation**: Check if values are within specified bounds

### ✅ Validation & Testing
- **Input Validation**: Check numeric strings, empty strings, string length
- **Enhanced Assertions**: Custom error messages and equality checks
- **Testing Helpers**: Utilities for comprehensive test coverage

## 📦 Installation
Add to your Move.toml:
```toml
[dependencies]
SupraMoveUtils = { git = "https://github.com/wdcs-meetrathod/supra-move-utils.git", rev = "mainnet" }
```
## 🚀 Quick Start
```move
module your_project::example {
use supra_move::utils;
use std::string::utf8;

    public fun quick_example() {
        // Enhanced printing
        utils::print_info(b"Starting application");
        utils::print_formatted(b"Version", utf8(b"1.0.0"));
        
        // Safe conversions
        let amount = utils::to_u64(utf8(b"12345"));
        utils::print_debug(b"Amount", amount);
        
        // Vector operations
        let numbers = utils::range(1, 10);
        utils::print_debug(b"Count", utils::size(&numbers));
        
        // Math operations
        let max_val = utils::max_u64(amount, 10000);
        utils::print_success(b"Processing completed");
    }
}
```

# Utility Functions Reference

## 📚 Function Reference

### Printing Functions

| Function | Description | Example |
|----------|-------------|---------|
| `print_key(key)` | Print only key | `utils::print_key(b"Username")` |
| `print_value(value)` | Print only value | `utils::print_value(42u64)` |
| `print_formatted(key, value)` | Format: [key]: value | `utils::print_formatted(b"Balance", 1000u64)` |
| `print_debug(msg, value)` | Debug output | `utils::print_debug(b"Counter", 10u64)` |
| `print_info(msg)` | Info message | `utils::print_info(b"Starting process")` |
| `print_success(msg)` | Success message | `utils::print_success(b"Complete")` |
| `print_warning(msg)` | Warning message | `utils::print_warning(b"Low balance")` |
| `print_error(msg)` | Error message | `utils::print_error(b"Invalid input")` |

### Conversion Functions

| Function | Description | Overflow Protection |
|----------|-------------|----------------------|
| `to_u8(string)` | String to u8 | ✅ Caps at 255 |
| `to_u16(string)` | String to u16 | ✅ Caps at 65,535 |
| `to_u32(string)` | String to u32 | ✅ Caps at 4,294,967,295 |
| `to_u64(string)` | String to u64 | ✅ Caps at max u64 |
| `to_u128(string)` | String to u128 | ✅ Caps at max u128 |
| `to_u256(string)` | String to u256 | ✅ No overflow |
| `u64_to_string(num)` | u64 to string | N/A |
| `bool_to_string(bool)` | Bool to string | N/A |

### Vector Utilities

| Function | Description | Example |
|----------|-------------|---------|
| `is_empty(vec)` | Check if empty | `utils::is_empty(&my_vec)` |
| `size(vec)` | Get vector size | `utils::size(&my_vec)` |
| `contains(vec, item)` | Check if contains | `utils::contains(&vec, &42)` |
| `find_index(vec, item)` | Find item index | `utils::find_index(&vec, &42)` |
| `first(vec)` | Get first element | `utils::first(&my_vec)` |
| `last(vec)` | Get last element | `utils::last(&my_vec)` |
| `reverse(vec)` | Reverse vector | `utils::reverse(&mut my_vec)` |
| `range(start, end)` | Create range | `utils::range(1, 10)` |
| `repeat(value, count)` | Repeat element | `utils::repeat(42u64, 5)` |

### Math Functions

| Function | Description | Example |
|----------|-------------|---------|
| `max_u64(a, b)` | Maximum of two u64 | `utils::max_u64(10, 20)` |
| `min_u64(a, b)` | Minimum of two u64 | `utils::min_u64(10, 20)` |
| `abs_diff_u64(a, b)` | Absolute difference | `utils::abs_diff_u64(10, 20)` |
| `pow_u64(base, exp)` | Power calculation | `utils::pow_u64(2, 3)` |
| `is_even(n)` | Check if even | `utils::is_even(10)` |
| `is_odd(n)` | Check if odd | `utils::is_odd(11)` |
| `clamp_u64(val, min, max)` | Clamp to range | `utils::clamp_u64(15, 10, 20)` |
| `in_range_u64(val, min, max)` | Check if in range | `utils::in_range_u64(15, 10, 20)` |

### Validation Functions

| Function | Description | Example |
|----------|-------------|---------|
| `is_numeric(string)` | Check if numeric | `utils::is_numeric(utf8(b"123"))` |
| `is_string_empty(string)` | Check if empty | `utils::is_string_empty(utf8(b""))` |
| `string_length(string)` | Get string length | `utils::string_length(utf8(b"hello"))` |

### Testing Helpers

| Function | Description | Example |
|----------|-------------|---------|
| `assert_with_message(condition, msg)` | Assert with custom message | `utils::assert_with_message(x > 0, b"X must be positive")` |
| `assert_eq(left, right, msg)` | Assert equality with message | `utils::assert_eq(result, expected, b"Results should match")` |

## 🧪 Testing

The library includes comprehensive test cases demonstrating all functionality:

```bash
# Run all tests
supra move tool test

# Run specific test category
supra move tool test --filter test_print_functions

# Run with verbose output to see print statements
supra move tool test --verbose
```

## 💡 Usage Examples

### Real-world Transaction Processing

```move
public fun process_user_transaction(
    user_id_str: String,
    amount_str: String,
    user_name: String
) {
    // Validate inputs
    utils::assert_with_message(utils::is_numeric(user_id_str), b"User ID must be numeric");
    utils::assert_with_message(utils::is_numeric(amount_str), b"Amount must be numeric");
    utils::assert_with_message(!utils::is_string_empty(user_name), b"Name cannot be empty");

    // Convert and process
    let user_id = utils::to_u64(user_id_str);
    let amount = utils::to_u64(amount_str);
    
    // Log transaction
    utils::print_info(b"Processing transaction");
    utils::print_formatted(b"User ID", user_id);
    utils::print_formatted(b"Amount", amount);
    utils::print_formatted(b"User", user_name);
    
    // Validate amount range
    if (utils::in_range_u64(amount, 1, 1000000)) {
        utils::print_success(b"Transaction approved");
    } else {
        utils::print_error(b"Amount out of range");
    };
}
```

# Data Analysis Helper

```move
public fun analyze_data(values: vector<u64>) {
utils::print_separator();
utils::print_info(b"Starting data analysis");

    if (utils::is_empty(&values)) {
        utils::print_warning(b"No data to analyze");
        return
    };
    
    let count = utils::size(&values);
    let min_val = *utils::first(&values);
    let max_val = *utils::last(&values);
    
    utils::print_formatted(b"Data points", count);
    utils::print_formatted(b"Min value", min_val);
    utils::print_formatted(b"Max value", max_val);
    utils::print_formatted(b"Range", utils::abs_diff_u64(max_val, min_val));
    
    utils::print_success(b"Analysis complete");
    utils::print_separator();
}
```

# 🔧 Advanced Features

## Overflow Protection
- Automatically caps values at maximum type limits
- Prevents runtime errors from large number conversions
- Maintains data integrity in financial applications

## Memory Efficient
- Functions use references where possible
- Minimal memory allocation
- Optimized for gas efficiency

## Test Coverage
- 100% function coverage
- Edge case testing
- Integration test scenarios
- Expected failure tests



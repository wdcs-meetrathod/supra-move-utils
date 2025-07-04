#[test_only]
module supra_move::utils_tests {
    use std::string::{utf8};
    use std::vector;
    use supra_move::utils::{ASSERT_FAIL_MESSAGE, ASSERT_EQ};
    use supra_move::utils;


    // ============ PRINTING FUNCTIONS TESTS ============

    #[test]
    public fun test_print_functions() {
        // Test different print functions
        utils::print_separator();
        utils::print_info(b"Starting print function tests");

        // Print only key
        utils::print_key(b"UserName");

        // Print only value
        utils::print_value(42u64);

        // Print key-value pair
        utils::print_kv(b"Balance", 1000u64);

        // Print formatted key-value
        utils::print_formatted(b"Status", true);

        // Print with custom prefix
        utils::print_with_prefix(b"RESULT:", b"Operation completed");

        // Print debug information
        utils::print_debug(b"Counter", 10u64);

        // Print different message types
        utils::print_success(b"Transaction successful");
        utils::print_warning(b"Low balance detected");
        utils::print_error(b"Invalid input provided");

        utils::print_separator();
    }

    // ============ STRING CONVERSION TESTS ============

    #[test]
    public fun test_string_to_numbers() {
        // Test string to u64 conversion
        let str_num = utf8(b"12345");
        let num = utils::to_u64(str_num);
        assert!(num == 12345, 1);
        utils::print_debug(b"String to u64", num);

        // Test string to u128 conversion
        let large_str = utf8(b"123456789012345678901234567890");
        let large_num = utils::to_u128(large_str);
        utils::print_debug(b"String to u128", large_num);

        // Test string to u256 conversion
        let huge_str = utf8(b"12345678901234567890123456789012345678901234567890");
        let huge_num = utils::to_u256(huge_str);
        utils::print_debug(b"String to u256", huge_num);

        // Test smaller integer types
        let small_str = utf8(b"255");
        let u8_num = utils::to_u8(small_str);
        assert!(u8_num == 255, 2);
        utils::print_debug(b"String to u8", u8_num);

        let medium_str = utf8(b"65535");
        let u16_num = utils::to_u16(medium_str);
        assert!(u16_num == 65535, 3);
        utils::print_debug(b"String to u16", u16_num);

        let u32_str = utf8(b"4294967295");
        let u32_num = utils::to_u32(u32_str);
        assert!(u32_num == 4294967295, 4);
        utils::print_debug(b"String to u32", u32_num);
    }

    #[test]
    public fun test_overflow_protection() {
        // Test overflow protection for u64
        let overflow_str = utf8(b"99999999999999999999999999999999");
        let safe_num = utils::to_u64(overflow_str);
        assert!(safe_num == 18446744073709551615, 5); // Max u64 value
        utils::print_debug(b"Overflow protected u64", safe_num);

        // Test overflow protection for u8
        let overflow_u8_str = utf8(b"999");
        let safe_u8 = utils::to_u8(overflow_u8_str);
        assert!(safe_u8 == 255, 6); // Max u8 value
        utils::print_debug(b"Overflow protected u8", safe_u8);
    }

    #[test]
    public fun test_number_to_string() {
        // Test u64 to string conversion
        let num = 12345u64;
        let str_result = utils::u64_to_string(num);
        utils::print_debug(b"u64 to string", str_result);

        // Test bool to string conversion
        let bool_true = utils::bool_to_string(true);
        let bool_false = utils::bool_to_string(false);
        utils::print_debug(b"Bool true to string", bool_true);
        utils::print_debug(b"Bool false to string", bool_false);

        // Test zero conversion
        let zero_str = utils::u64_to_string(0);
        utils::print_debug(b"Zero to string", zero_str);
    }

    // ============ VECTOR UTILITY TESTS ============

    #[test]
    public fun test_vector_utilities() {
        // Create test vectors
        let empty_vec = vector::empty<u64>();
        let test_vec = vector::empty<u64>();
        vector::push_back(&mut test_vec, 10);
        vector::push_back(&mut test_vec, 20);
        vector::push_back(&mut test_vec, 30);
        vector::push_back(&mut test_vec, 40);

        // Test is_empty
        assert!(utils::is_empty(&empty_vec), 7);
        assert!(!utils::is_empty(&test_vec), 8);
        utils::print_debug(b"Empty vector check", utils::is_empty(&empty_vec));

        // Test size
        assert!(utils::size(&test_vec) == 4, 9);
        utils::print_debug(b"Vector size", utils::size(&test_vec));

        // Test contains
        assert!(utils::contains(&test_vec, &20), 10);
        assert!(!utils::contains(&test_vec, &50), 11);
        utils::print_debug(b"Contains 20", utils::contains(&test_vec, &20));
        utils::print_debug(b"Contains 50", utils::contains(&test_vec, &50));

        // Test find_index
        let index = utils::find_index(&test_vec, &30);
        assert!(index == 2, 12);
        utils::print_debug(b"Index of 30", index);

        // Test first and last
        let first_val = *utils::first(&test_vec);
        let last_val = *utils::last(&test_vec);
        assert!(first_val == 10, 13);
        assert!(last_val == 40, 14);
        utils::print_debug(b"First element", first_val);
        utils::print_debug(b"Last element", last_val);

        // Test reverse
        let reverse_vec = test_vec;
        utils::reverse(&mut reverse_vec);
        assert!(*vector::borrow(&reverse_vec,0) == 40, 15);
        assert!(*vector::borrow(&reverse_vec,3) == 10, 16);
        utils::print_debug(b"First after reverse", *vector::borrow(&reverse_vec,0));
    }

    #[test]
    public fun test_vector_creation() {
        // Test range creation
        let range_vec = utils::range(1, 5);
        assert!(utils::size(&range_vec) == 4, 17);
        assert!(*vector::borrow(&range_vec,0) == 1, 18);
        assert!(*vector::borrow(&range_vec,3) == 4, 19);
        utils::print_debug(b"Range vector size", utils::size(&range_vec));

        // Test repeat creation
        let repeat_vec = utils::repeat(42u64, 3);
        assert!(utils::size(&repeat_vec) == 3, 20);
        assert!(*vector::borrow(&repeat_vec, 0) == 42, 21);
        assert!(*vector::borrow(&repeat_vec, 2) == 42, 22);
        utils::print_debug(b"Repeat vector size", utils::size(&repeat_vec));
    }

    // ============ MATH UTILITY TESTS ============

    #[test]
    public fun test_math_functions() {
        // Test min/max functions
        assert!(utils::max_u64(10, 20) == 20, 23);
        assert!(utils::min_u64(10, 20) == 10, 24);
        utils::print_debug(b"Max of 10,20", utils::max_u64(10, 20));
        utils::print_debug(b"Min of 10,20", utils::min_u64(10, 20));

        // Test absolute difference
        assert!(utils::abs_diff_u64(10, 20) == 10, 25);
        assert!(utils::abs_diff_u64(20, 10) == 10, 26);
        utils::print_debug(b"Abs diff 10,20", utils::abs_diff_u64(10, 20));

        // Test power function
        assert!(utils::pow_u64(2, 3) == 8, 27);
        assert!(utils::pow_u64(5, 2) == 25, 28);
        utils::print_debug(b"2^3", utils::pow_u64(2, 3));
        utils::print_debug(b"5^2", utils::pow_u64(5, 2));

        // Test even/odd
        assert!(utils::is_even(10), 29);
        assert!(utils::is_odd(11), 30);
        utils::print_debug(b"10 is even", utils::is_even(10));
        utils::print_debug(b"11 is odd", utils::is_odd(11));

        // Test clamp
        assert!(utils::clamp_u64(5, 10, 20) == 10, 31); // Below range
        assert!(utils::clamp_u64(15, 10, 20) == 15, 32); // In range
        assert!(utils::clamp_u64(25, 10, 20) == 20, 33); // Above range
        utils::print_debug(b"Clamp 5 to [10,20]", utils::clamp_u64(5, 10, 20));

        // Test in_range
        assert!(utils::in_range_u64(15, 10, 20), 34);
        assert!(!utils::in_range_u64(5, 10, 20), 35);
        utils::print_debug(b"15 in [10,20]", utils::in_range_u64(15, 10, 20));
    }

    // ============ VALIDATION TESTS ============

    #[test]
    public fun test_validation_functions() {
        // Test numeric validation
        let numeric_str = utf8(b"12345");
        let non_numeric_str = utf8(b"12a45");
        let empty_str = utf8(b"");

        assert!(utils::is_numeric(numeric_str), 36);
        assert!(!utils::is_numeric(non_numeric_str), 37);
        assert!(!utils::is_numeric(empty_str), 38);
        utils::print_debug(b"'12345' is numeric", utils::is_numeric(numeric_str));
        utils::print_debug(b"'12a45' is numeric", utils::is_numeric(non_numeric_str));

        // Test string empty check
        assert!(utils::is_string_empty(empty_str), 39);
        assert!(!utils::is_string_empty(numeric_str), 40);
        utils::print_debug(b"Empty string check", utils::is_string_empty(empty_str));

        // Test string length
        assert!(utils::string_length(numeric_str) == 5, 41);
        assert!(utils::string_length(empty_str) == 0, 42);
        utils::print_debug(b"String length", utils::string_length(numeric_str));
    }

    // ============ TESTING HELPERS TESTS ============

    #[test]
    public fun test_assertion_helpers() {
        // Test assert_with_message (should pass)
        utils::assert_with_message(true, b"This should pass");

        // Test assert_eq (should pass)
        utils::assert_eq(10u64, 10u64, b"Numbers should be equal");
        utils::assert_eq(utf8(b"hello"), utf8(b"hello"), b"Strings should be equal");

        utils::print_success(b"All assertion tests passed");
    }

    #[test]
    #[expected_failure(abort_code = ASSERT_FAIL_MESSAGE)]
    public fun test_assert_with_message_failure() {
        // This test should fail
        utils::assert_with_message(false, b"This should fail");
    }

    #[test]
    #[expected_failure(abort_code = ASSERT_EQ)]
    public fun test_assert_eq_failure() {
        // This test should fail
        utils::assert_eq(10u64, 20u64, b"These numbers are not equal");
    }

    // ============ COMPREHENSIVE INTEGRATION TEST ============

    #[test]
    public fun test_comprehensive_example() {
        utils::print_separator();
        utils::print_info(b"Starting comprehensive integration test");

        // Scenario: Processing user data
        let user_id_str = utf8(b"12345");
        let user_balance_str = utf8(b"1000000");
        let user_name = utf8(b"Alice");

        // Validate and convert data
        utils::assert_with_message(utils::is_numeric(user_id_str), b"User ID must be numeric");
        utils::assert_with_message(utils::is_numeric(user_balance_str), b"Balance must be numeric");
        utils::assert_with_message(!utils::is_string_empty(user_name), b"Name cannot be empty");

        let user_id = utils::to_u64(user_id_str);
        let user_balance = utils::to_u64(user_balance_str);

        // Print user information
        utils::print_formatted(b"User ID", user_id);
        utils::print_formatted(b"User Balance", user_balance);
        utils::print_formatted(b"User Name", user_name);

        // Process transaction amounts
        let transaction_amounts = vector::empty<u64>();
        vector::push_back(&mut transaction_amounts,100);
        vector::push_back(&mut transaction_amounts,250);
        vector::push_back(&mut transaction_amounts,50);

        utils::print_debug(b"Transaction count", utils::size(&transaction_amounts));

        // Calculate total transactions
        let total_transactions = 0u64;
        let i = 0;
        while (i < utils::size(&transaction_amounts)) {
            total_transactions = total_transactions +  *vector::borrow(&transaction_amounts, i);
            i = i + 1;
        };

        utils::print_formatted(b"Total Transactions", total_transactions);

        // Check if balance is sufficient
        if (user_balance >= total_transactions) {
            let remaining_balance = user_balance - total_transactions;
            utils::print_success(b"Transaction approved");
            utils::print_formatted(b"Remaining Balance", remaining_balance);

            // Check if remaining balance is in safe range
            let min_balance = 500u64;
            let max_balance = 2000000u64;

            if (utils::in_range_u64(remaining_balance, min_balance, max_balance)) {
                utils::print_info(b"Balance is in safe range");
            } else {
                utils::print_warning(b"Balance outside safe range");
            };
        } else {
            utils::print_error(b"Insufficient balance");
        };

        // Demonstrate utility functions
        let powers_of_2 = vector::empty<u64>();
        let j = 0;
        while (j < 5) {
            vector::push_back(&mut powers_of_2, utils::pow_u64(2, j));
            j = j + 1;
        };

        utils::print_debug(b"Powers of 2 count", utils::size(&powers_of_2));
        utils::print_debug(b"Max power", utils::max_u64(*utils::first(&powers_of_2), *utils::last(&powers_of_2)));

        utils::print_separator();
        utils::print_success(b"Integration test completed successfully");
    }

    // ============ EDGE CASE TESTS ============

    #[test]
    public fun test_edge_cases() {
        utils::print_info(b"Testing edge cases");

        // Test with zero values
        let zero_str = utf8(b"0");
        assert!(utils::to_u64(zero_str) == 0, 43);
        assert!(utils::is_numeric(zero_str), 44);

        // Test with single digit
        let single_digit = utf8(b"5");
        assert!(utils::to_u8(single_digit) == 5, 45);

        // Test power with zero exponent
        assert!(utils::pow_u64(999, 0) == 1, 46);

        // Test empty vector operations
        let empty_vec = vector::empty<u64>();
        assert!(utils::is_empty(&empty_vec), 47);
        assert!(utils::size(&empty_vec) == 0, 48);

        // Test range with same start and end
        let empty_range = utils::range(5, 5);
        assert!(utils::is_empty(&empty_range), 49);

        // Test repeat with zero count
        let empty_repeat = utils::repeat(42u64, 0);
        assert!(utils::is_empty(&empty_repeat), 50);

        utils::print_success(b"All edge case tests passed");
    }
}
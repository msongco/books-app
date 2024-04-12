class Isbn < ApplicationRecord
  def self.is_isbn_13_valid?(isbn)
    # Each digit, from left to right, is alternately multiplied by 1 or 3, then those products are summed modulo 10 to give a value ranging from 0 to 9.
    # Subtracted from 10, that leaves a result from 1 to 10. A zero replaces a ten, so, in all cases, a single check digit results.
    check_digit = isbn[-1]

    i = 0
    sum = 0

    while i < isbn.length - 1
      sum += (i % 2 * 2 + 1) * isbn[i].to_i # (i % 2 * 2 + 1) - the number to be multiplied : it's either 1 or 3 (integer weight)
      i += 1
    end

    diff_checker = 10 - (sum % 10)

    if diff_checker == 10
      check_digit = "0"
    end

    diff_checker.to_s == check_digit
  end

  # A 10-digit ISBN is converted to a 13-digit ISBN by prepending "978" to the ISBN-10 and recalculating the final checksum digit using the ISBN-13 algorithm.
  # The reverse process can also be performed, but not for numbers commencing with a prefix other than 978, which have no 10-digit equivalent.
  def self.convert_isbn(isbn)

    if isbn.size == 13 && isbn.start_with?("978") # convert from isbn 13 to isbn 10
      if is_isbn_13_valid?(isbn)
        isbn = isbn[3..-1]
        isbn = isbn.chop.reverse!

        i = 0
        sum = 0

        while i < isbn.length
          sum += (i + 2) * isbn[i].to_i
          i += 1
        end

        check_digit = 11 - (sum % 11)

        if check_digit == 10
          check_digit = "X"
        elsif check_digit == 11
          check_digit = "0"
        end

        converted_isbn = isbn.reverse! + check_digit.to_s

        converted_isbn
      end
    end
  end
end

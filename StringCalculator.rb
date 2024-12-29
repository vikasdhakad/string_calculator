class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = extract_delimiter_and_numbers(numbers)
    else
      delimiter = /,|\n/
    end

    numbers_array = numbers.split(delimiter)
    negative_numbers = numbers_array.map(&:to_i).select { |num| num < 0 }

    if negative_numbers.any?
      raise "Negative numbers not allowed #{negative_numbers.join(',')}"
    end

    numbers_array.map(&:to_i).sum
  end

  private

  def extract_delimiter_and_numbers(numbers)
    delimiter_line, numbers = numbers.split("\n", 2)
    delimiter = delimiter_line[2..-1]
    delimiter = Regexp.new(Regexp.escape(delimiter))
    return delimiter, numbers
  end
end

# Test Cases
stringCalculator = StringCalculator.new

puts stringCalculator.add("")
puts stringCalculator.add("1")
puts stringCalculator.add("1,5")
puts stringCalculator.add("1\n2,3")
puts stringCalculator.add("//;\n1;2")
puts stringCalculator.add("//;\n1;2\n3,4")
puts stringCalculator.add("/;\n1;2;3;4")
puts stringCalculator.add("1000,2000,3000")

# Test Negative Numbers

begin
  puts stringCalculator.add("1,-2,3")
rescue => e
  puts e.message
end

begin
  puts stringCalculator.add("//;\n1;-2")
rescue => e
  puts e.message
end

begin
  puts stringCalculator.add("//;\n1;-2;-3")
rescue => e
  puts e.message
end


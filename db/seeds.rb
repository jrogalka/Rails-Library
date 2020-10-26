require "csv"

Book.delete_all
Author.delete_all

filename = Rails.root.join("db/books.csv")

puts "Loading movies from #{filename}"

csv_data = File.read(filename)
books = CSV.parse(csv_data, headers: true, encoding: "utf-8", quote_char: "|")

books.each do |b|
  puts b["title"]
end

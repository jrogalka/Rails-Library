require "csv"

Book.delete_all
Author.delete_all

filename = Rails.root.join("db/books.csv")

puts "Loading movies from #{filename}"

csv_data = File.read(filename)
books = CSV.parse(csv_data, headers: true, encoding: "utf-8", quote_char: "|")

# CURRENT ISSUE:
#   - Rating is being stored as an exponent ie. 0.0449e1
#   - Printing value returns to decimal format ie. 4.56
#   - Is this even a problem??

books[1..10].each do |b|
  authors = b["authors"].split("/")
  author = Author.find_or_create_by(name: authors[0])

  if author&.valid?
    # rating = BigDecimal(b["average_rating"]) //Attempt to parse value as BigDecimal
    book = author.books.create(
      title:           b["title"],
      number_of_pages: b["num_pages"],
      # rating:          rating   //Uses parsed value
      rating:          b["average_rating"]
    )
    puts book.rating
    puts "Invalid Book #{b['title']}" unless book&.valid?
  else
    puts "Invalid Author #{b['authors']} for book #{b['title']}"
  end
end

puts Book.first.rating
puts "Created #{Author.count} Authors."

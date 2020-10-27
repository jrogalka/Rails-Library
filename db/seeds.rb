require "csv"

Book.delete_all
Author.delete_all

filename = Rails.root.join("db/books.csv")

puts "Loading movies from #{filename}"

csv_data = File.read(filename)
books = CSV.parse(csv_data, headers: true, encoding: "utf-8", quote_char: "|")


books[1..50].each do |b|
  authors = b["authors"].split("/")
  author = Author.find_or_create_by(name: authors[0])

  if author&.valid?
    book = author.books.create(
      title:           b["title"],
      number_of_pages: b["num_pages"],
      rating:          b["average_rating"]
    )
    puts "Invalid Book #{b['title']}" unless book&.valid?
  else
    puts "Invalid Author #{b['authors']} for book #{b['title']}"
  end
end
puts "Created #{Author.count} Authors."

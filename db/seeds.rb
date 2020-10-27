require "csv"

Book.delete_all
Author.delete_all

filename = Rails.root.join("db/books.csv")

puts "Loading movies from #{filename}"

csv_data = File.read(filename)
books = CSV.parse(csv_data, headers: true, encoding: "utf-8", quote_char: "|")

books[1..300].each do |b|
  authors = b["authors"].split("/")
  author = Author.find_or_create_by(name: authors[0])

  if author&.valid?
    book = author.books.create(
      title:           b["title"],
      number_of_pages: b["num_pages"],
      rating:          b["average_rating"]
    )
    unless book&.valid?
      puts "Invalid Book #{b['title']}"
      next
    end

    random_number = rand(1..3)
    subjects = []
    i = 0

    while i < random_number
      subjects[i] = Faker::Book.genre # Create a random amount of subject for each book.
      i += 1
    end

    subjects.split(",") # If multiple subjects, seperate with ","

    # Loop through and create subjects
    subjects.each do |subject_name|
      subject = Subject.find_or_create_by(name: subject_name)
      BookSubject.create(book: book, subject: subject)
    end

  else
    puts "Invalid Author #{b['authors']} for book #{b['title']}"
  end
end
puts "Created #{Author.count} Authors."
puts "Created #{Book.count} Books"

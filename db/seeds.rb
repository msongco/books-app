# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

authors = [
  { first_name: "Kiera", last_name: "Cass" },
  { first_name: "Harper", last_name: "Lee" },
  { first_name: "Antoine de", last_name: "Saint-Exupery" },
  { first_name: "Richard", last_name: "Howard"}
]

puts "\n -- creating authors table -- \n"
if Author.count == 0
  authors.each do |author|
    Author.create!(author)
  end
end
puts "\n -- authors created -- \n"

publishers = [
  { name: "HarperCollins"},
  { name: "Harper Perennial Modern Classics"},
  { name: "Harcourt, Inc."},
]

puts "\n -- creating publishers table -- \n"
if Publisher.count == 0
  publishers.each do |publisher|
    Publisher.create!(publisher)
  end
end
puts "\n -- publishers created -- \n"

books = [
  {
    details: { title: "The Selection (The Selection, 1)", list_price: 1000, isbn_13: "9780062059949", publication_year: 2013, edition: "Reprint", publisher: Publisher.find_by_name("HarperCollins") },
    authors: { names: [Author.find_by_first_name_and_last_name("Kiera", "Cass")] }
  },
  {
    details: { title: "To Kill a Mockingbird", list_price: 2000, isbn_13: "9780061120084", publication_year: 2006, publisher: Publisher.find_by_name("Harper Perennial Modern Classics") },
    authors: { names: [Author.find_by_first_name_and_last_name("Harper", "Lee")] }
  },
  {
    details: { title: "The Little Prince", list_price: 500, isbn_13: "9780786275397", publication_year: 2005, edition: "Paperback", publisher: Publisher.find_by_name("Harcourt, Inc.") },
    authors: { names: [Author.find_by_first_name_and_last_name("Antoine de", "Saint-Exupery"), Author.find_by_first_name_and_last_name("Richard", "Howard")] }
  }
]

puts "\n -- creating books table -- \n"
if Book.count == 0
  books.each do |book|
    new_book = Book.new(book[:details])
    book_authors = book[:authors][:names]

    book_authors.each do |b_author|
      new_book.authors << b_author
    end
    new_book.save!
  end
end
puts "\n -- books created -- \n"

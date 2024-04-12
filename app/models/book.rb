class Book < ApplicationRecord
  mount_uploader :image, BookUploader

  has_and_belongs_to_many :authors
  belongs_to :publisher

  validates :title, :isbn_13, :list_price, :publication_year, :authors, presence: true

  def book_with_author
    authors = self.authors.map { |author| author.full_name}
    authors = authors.join(", ")

    {
      id: self.id,
      title: self.title,
      author: authors,
      isbn_13: self.isbn_13,
      publication_year: self.publication_year,
      publisher: self.publisher.name,
      edition: self.edition,
      list_price: self.list_price.to_i
    }
  end
end

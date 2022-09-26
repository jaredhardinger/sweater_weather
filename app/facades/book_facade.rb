class BookFacade
  def self.books(location)
    book_data = BookService.get_books(location)
    books = book_data[:docs]
    books.map do |book|
      Book.new(book)
    end
  end
end
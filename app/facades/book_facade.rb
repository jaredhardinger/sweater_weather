class BookFacade
  def self.books(location)
    book_data = BookService.get_books(location)
    books = book_data[:docs]
    total_books = book_data[:numFound]
    books.map do |book|
      Book.new(book, total_books)
    end
  end
end
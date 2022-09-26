class Book
  attr_reader :isbn,
              :title,
              :publisher,
              :total_books

  def initialize(data, total_books)
    @total_books = total_books
    @isbn = data[:isbn] 
    @title = data[:title]
    @publisher = data[:publisher]
  end
end
class BookSerializer
  def self.book_search(location, forecast, books)
    {
      "data": {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": location,
          "forecast": {
            "summary": forecast.conditions,
            "temperature": "#{forecast.temperature} F" 
          },
          "total_books_found": books.first.total_books,
          "books": 
            books.map do |book|
            {
              "isbn": [
                book.isbn
              ],
              "title": 
                book.title,
              "publisher": book.publisher
            }
            end 
        }
      }
    }
  end
end
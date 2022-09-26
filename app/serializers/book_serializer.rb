class BookSerializer
  def self.serialize(forecast, location, books)
    binding.pry
    {
      "data": {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": location,
          "forecast": {
            "summary": ,
            "temperature": 
          },
          "total_books_found": 172,
          "books": [
            {
              "isbn": [
                "0762507845",
                "9780762507849"
              ],
              "title": "Denver, Co",
              "publisher": [
                "Universal Map Enterprises"
              ]
            },
            {
              "isbn": [
                "9780883183663",
                "0883183668"
              ],
              "title": "Photovoltaic safety, Denver, CO, 1988",
              "publisher": [
                "American Institute of Physics"
              ]
            },
            { ... same format for books 3, 4 and 5 ... }
          ]
        }
      }
    }
end
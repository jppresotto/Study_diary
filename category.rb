require 'sqlite3'
class Category
    attr_accessor :title, :id

    @@next_index =1
  
    def initialize(title:)
      @id = @@next_index          
      @title = title
      @@next_index += 1
    end

    CATEGORIES = [
      new(title: 'Ruby'),
      new(title: 'Rails'),
      new(title: 'Front-End'),
      new(title: 'Back-End'),
      new(title: 'Databases'),
      new(title: 'Java SE'),
      new(title: 'Javascrip'),
      new(title: 'Outros')
    ]
    def to_s
      "#{id} - #{title}"
    end

    def self.all
      CATEGORIES
    end

    def self.index(number)
      CATEGORIES[number]
    end
    def self.find_by_category(category)
      db = SQLite3::Database.open "db/database.db"      
      tasks = db.execute "SELECT * FROM estudos where category='#{category}'"
      db.close  
      if (tasks !=[])  
        for i in 0...tasks.length      
          puts "#{tasks[i][0]} - Título: #{tasks[i][1]} | Categoria: #{tasks[i][2]} | Descrição: #{tasks[i][3]} | Conclusão: #{tasks[i][4]}"
        end 
      else
        puts 'Não há relações para esse termo de busca.'
      end 
    end
end
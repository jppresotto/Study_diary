require 'sqlite3'

class Atividade
  attr_accessor :title, :category,:descricao,:stats

  def initialize(title:, category:,descricao:,stats:)
    @title = title
    @category = category
    @descricao = descricao
    @stats = stats
  end

  def self.all
    db = SQLite3::Database.open "/home/jppresotto/Área de Trabalho/study_diary/database.db"
    db.results_as_hash = false
    tasks = db.execute "SELECT * FROM estudos"
    db.close

    for i in 0...tasks.length
      puts ("Título: #{tasks[i][0]} | Categoria: #{tasks[i][1]} | Descrição: #{tasks[i][2]} | Conclusão: #{tasks[i][3]}")
    end   
  end

  def save_to_db
    db = SQLite3::Database.open "/home/jppresotto/Área de Trabalho/study_diary/database.db"
    db.execute "INSERT INTO estudos VALUES('#{title}', '#{category}','#{descricao}','#{stats}')"
    db.close
    self
  end

  def self.find_reference(descricao)
    db = SQLite3::Database.open "/home/jppresotto/Área de Trabalho/study_diary/database.db"
    db.results_as_hash = false
    tasks = db.execute "SELECT * FROM estudos where title LIKE'%#{descricao}%' OR descricao LIKE'%#{descricao}%'"
    db.close   
    if (tasks !=[])
      for i in 0...tasks.length      
        puts ("Título: #{tasks[i][0]} | Categoria: #{tasks[i][1]} | Descrição: #{tasks[i][2]} | Conclusão: #{tasks[i][3]}")
      end  
    end
  end

  def self.find_by_category(category)
    db = SQLite3::Database.open "/home/jppresotto/Área de Trabalho/study_diary/database.db"
    db.results_as_hash = false
    tasks = db.execute "SELECT * FROM estudos where category='#{category}'"
    db.close    
    for i in 0...tasks.length      
      puts ("Título: #{tasks[i][0]} | Categoria: #{tasks[i][1]} | Descrição: #{tasks[i][2]} | Conclusão: #{tasks[i][3]}")
    end  
  end

  def self.delete(title,category)
    db = SQLite3::Database.open "/home/jppresotto/Área de Trabalho/study_diary/database.db"
    db.results_as_hash = false
    tasks = db.execute "SELECT title, category FROM estudos where title = '#{title}' AND category='#{category}'"    
    if (tasks!=[])
      db.execute "DELETE FROM estudos WHERE title ='#{title }' AND category ='#{category }'"
      puts("\nDeletado com sucesso!\n")
      db.close 
    else
      puts("\nTitulo ou categoria incorretos, tente novamente.\n")
      db.close    
    end    
  end
  def self.alterstatus(title,category,stats)
    db = SQLite3::Database.open "/home/jppresotto/Área de Trabalho/study_diary/database.db"
    db.results_as_hash = false
    tasks = db.execute "SELECT title, category FROM estudos where title = '#{title}' AND category='#{category}'"    
    if (tasks!=[])
      db.execute "UPDATE estudos SET stats ='#{stats}' where title = '#{title}' AND category='#{category}'"
      puts("\nAlterado com sucesso!\n")
      db.close 
    else
      puts("\nTitulo ou categoria incorretos, tente novamente.\n")
      db.close    
    end    
  end


end
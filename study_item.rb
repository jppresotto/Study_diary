require 'sqlite3'
require_relative'category'

class StudyItem
  attr_accessor :title, :category,:descricao,:stats, :id, :created_at


  def initialize(id: nil, title:, category:Category.new(), descricao:, stats: false, created_at: nil)
    @id = id
    @title = title
    @category = category
    @descricao = descricao
    @stats = stats   
    @created_at = created_at  
  end

  def self.all
    db = SQLite3::Database.open "db/database.db"    
    db.results_as_hash = true
    tasks = db.execute "SELECT * FROM estudos"
    db.close   
    for i in 0...tasks.length
      puts "#{tasks[i][0]} - Título: #{tasks[i][1]} | Categoria: #{tasks[i][2]} | Descrição: #{tasks[i][3]} | Conclusão: #{tasks[i][4]}"
    end
    wait_and_clear    
  end

  def save_to_db
    db = SQLite3::Database.open "db/database.db"
    db.execute "INSERT INTO estudos (title, category, descricao, stats) VALUES('#{title}', '#{category}','#{descricao}','#{stats}')"
    db.close    
  end

  def self.find_reference(descricao)
    db = SQLite3::Database.open "db/database.db"    
    tasks = db.execute "SELECT * FROM estudos where title LIKE'%#{descricao}%' OR descricao LIKE'%#{descricao}%'"
    db.close   
    if (tasks !=[])
      for i in 0...tasks.length      
        puts "#{tasks[i][0]} - Título: #{tasks[i][1]} | Categoria: #{tasks[i][2]} | Descrição: #{tasks[i][3]} | Conclusão: #{tasks[i][4]}"
      end
    else
      puts 'Não há relações para esse termo de busca.' 
    end
  end
  
  def self.delete(title,category)
    db = SQLite3::Database.open "db/database.db"         
    if (validate_search(title,category))
      db.execute "DELETE FROM estudos WHERE title ='#{title }' AND category ='#{category}'"
      puts "\n\nDeletado com sucesso!\n"
      db.close 
    else      
      db.close    
    end    
  end

  def self.alterstatus(title,category,stats)
    db = SQLite3::Database.open "db/database.db"       
    if (validate_search(title,category))
      db.execute "UPDATE estudos SET stats ='#{stats}' where title = '#{title}' AND category='#{category}'"
      puts"\nAlterado com sucesso!\n"
      db.close 
    else      
      db.close    
    end    
  end

  def self.validate_search(title,category)
    db_validate = SQLite3::Database.open "db/database.db"    
    tasks = db_validate .execute "SELECT title, category FROM estudos where title = '#{title}' AND category='#{category}'" 
    db_validate .close    
    if (tasks!=[])       
      return true       
    else      
      puts "\nNão há relações para esse termo de busca."             
    end    
  end

  def self.create 
    print "\nDigite o titulo: "
    titulo = gets.chomp
    print_category(Category.all)    
    categoria = Category.index(gets.to_i - 1)
    print "\nDigite a descrição: "
    descricao = gets.chomp
    status =false
    while (!status)
        print "\nDigiteo Status da atividade:\n [0] - Incompleto\n [1] - Concluido\n"
        stats = gets.to_i
        case stats
        when 0
            novo_reg = new(title: titulo,category: categoria, descricao: descricao, stats: '')
            novo_reg.save_to_db 
            status = true
            wait_and_clear
        when 1
            novo_reg = new(title: titulo,category: categoria, descricao: descricao, stats: 'Finalizado')
            novo_reg.save_to_db
            status = true
            wait_and_clear
        else
            puts "\nDigite uma opção válida!\n"
            wait_and_clear
        end
    end
  end 

  def self.concluded
    print "\nDigite o titulo: "
    titulo = gets.chomp
    print_category(Category.all)    
    categoria = Category.index(gets.to_i - 1)           
    if(validate_search(titulo,categoria))
      status =false                            
        while (!status)
            print "\nDigiteo Status da atividade:\n [0] - Incompleto\n [1] - Concluido\n"
            stats = gets.to_i               
            case stats
            when 0
                stats = ''                
                alterstatus(titulo, categoria, stats)                   
                status = true
                wait_and_clear
            when 1
                stats = 'Finalizado'                 
                alterstatus(titulo, categoria, stats)                    
                status = true
                wait_and_clear
            else
                puts "\nDigite uma opção válida!\n"
                wait_and_clear
            end                
        end
      else
        wait_and_clear                    
    end 
  end 

  def self.search 
    print "\nDigite o titulo ou referencia: "
    referencia = gets.chomp
    find_reference(referencia)
    wait_and_clear
  end

  def self.search_category
    print_category(Category.all)            
    categoria = Category.index(gets.to_i - 1)
    Category.find_by_category(categoria)
    wait_and_clear
  end
  def self.delete_item
    print "\nDigite o titulo: "
    titulo = gets.chomp
    print_category(Category.all)            
    categoria = Category.index(gets.to_i - 1)
    delete(titulo,categoria)
    wait_and_clear
  end
end
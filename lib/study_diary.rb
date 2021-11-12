require_relative 'atividade'
system 'bin/setup'

opc = 0


while (opc!= '7')
    status =false    
    puts "\n[1] Cadastrar um item para estudar\n"
    puts "[2] Ver todos os itens cadastrados\n"
    puts "[3] Buscar um item de estudo\n"
    puts "[4] Listar por categoria\n"
    puts "[5] Apagar um item\n"
    puts "[6] Marcar item como concluido\n"    
    puts "[7] Sair\n"
    puts "Escolha uma opção: "
    opc = gets.chomp

    case opc
        when '1'
            puts "\nDigite o titulo: "
            titulo = gets.chomp
            puts "\nDigite a categoria: "
            categoria = gets.chomp
            puts "\nDigite a descrição: "
            descricao = gets.chomp
            while (!status)
                puts "\nDigiteo Status da atividade:\n [0] - Incompleto\n [1] - Concluido\n"
                stats = gets.chomp
                case stats
                when '0'
                    novo_reg = Atividade.new(title: titulo,category: categoria, descricao: descricao, stats: 'X')
                    novo_reg.save_to_db 
                    status = true
                when '1'
                    novo_reg = Atividade.new(title: titulo,category: categoria, descricao: descricao, stats: 'OK')
                    novo_reg.save_to_db
                    status = true
                else
                end
            end
            
        when '2'
            Atividade.all            
        when '3'
            puts "\nDigite o titulo ou referencia: "
            referencia = gets.chomp
            Atividade.find_reference(referencia)
        when '4'
            puts "\nDigite a categoria: "
            categoria = gets.chomp
            Atividade.find_by_category(categoria)
        when '5'
            puts "\nDigite o titulo: "
            titulo = gets.chomp
            puts "\nDigite a categoria: "
            categoria = gets.chomp
            Atividade.delete(titulo,categoria)
        when '6'
            puts "\nDigite o titulo: "
            titulo = gets.chomp
            puts "\nDigite a categoria: "
            categoria = gets.chomp            
            while (!status)
                puts "\nDigiteo Status da atividade:\n [0] - Incompleto\n [1] - Concluido\n"
                stats = gets.chomp
                case stats
                when '0'
                    stats="X"
                    Atividade.alterstatus(titulo,categoria, stats)                    
                    status = true
                when '1'
                    stats="OK"
                    Atividade.alterstatus(titulo,categoria, stats)                    
                    status = true
                else
                end
            end        
       
        when '7'
            puts'Acesso Finalizado!'            
        else
            puts "\nNúmero inválido, tente novamente.\n"            
    end
end

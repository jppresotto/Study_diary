require 'io/console'
require_relative 'study_item'
system 'bin/setup'

REGISTRATION    = 1
SHOW_ITENS      = 2
SEARCH          = 3
SEARCH_CATEGORY = 4 
DELETE_ITEM     = 5
CONCLUDED       = 6 
OUT             = 7

option = 0

def print_category(collection)
    collection.each.with_index(1) do |item, index|
        puts ">>#{index} - #{item}"
    end
    print "\nEscolha a categoria de seu item: "
end

def clear
    system 'clear'
end

def wait_keypress
    puts
    puts 'Pressione qualquer tecla para continuar'
    STDIN.getch
end

def wait_and_clear
    wait_keypress
    clear
end
while (option != OUT)       
    puts <<~MENU  
    --------------------------------------------------------
    [#{REGISTRATION}] Cadastrar um item para estudar
    [#{SHOW_ITENS}] Ver todos os itens cadastrados
    [#{SEARCH}] Buscar um item de estudo
    [#{SEARCH_CATEGORY}] Listar por categoria
    [#{DELETE_ITEM}] Apagar um item
    [#{CONCLUDED}] Marcar item como concluido  
    [#{OUT}] Sair
    --------------------------------------------------------
    MENU
    print "Escolha uma opção: "
    option = gets.to_i

    case option
        when REGISTRATION
            StudyItem.create
        when SHOW_ITENS
            StudyItem.all                       
        when SEARCH
            StudyItem.search
        when SEARCH_CATEGORY
            StudyItem.search_category
        when DELETE_ITEM 
            StudyItem.delete_item
        when CONCLUDED 
            StudyItem.concluded        
        when OUT 
            clear
            puts "Acesso Finalizado!\n "                     
        else
            puts "\nOpção inválida, tente novamente.\n"
            wait_and_clear                      
    end         
end
namespace :reset_database do
  desc 'Reset all database but Users'
  task reset: :environment do
    puts 'Reset all database but Users'

    reset_database
  end

  def reset_database
    Copium.delete_all
    Arquivo.delete_all
  end

end
namespace :jmpak_peepcode do

  def inform(message)
    puts "#{'*' * (message.length + 4)}"
    puts "* #{message} *}
    puts "#{'*' * (message.length + 4)}"
  end

  def render_erb_template(filename)
    template = File.read(filename)
    result = ERB.new(template).result(binding)
  end

  def run_and_return(cmd)
    output = []
    run cmd do |ch, st, data|
      output << data
    end
    return output.to_s
  end

  desc "Show installed gems"
  task :show_gems do
    run "gem list"
  end
  
  desc "Show gems, cleanly"
  task :stream_gems do 
    stream "gem list"
  end
  
  desc "Restart web server"
  task :restart do
    sudo "/etc/init.d/apache2 restart"
  end
  after "deploy:restart", "jmpak_peepcode:restart"
  
  desc "setting up permissions for the folders"
  task :setup_permissions do
    sudo "chown -R #{user}:#{user} #{deploy_to}"
  end
  
  before "jmpak_peepcode:create_shared_config", "jmpak_peepcode:setup_permissions"

  desc "Create shared/config directory and default database.yml"
  task "create_shared_config" do
    run "mkdir -p #{shared_path}/config"

    #Copy database.yml if it doesn't exist.
    result = run_and_return "ls #{shared_path}/config"
    unless result.match(/database\.yml/)
      #contents = render_erb_template(File.dirname(__FILE__) + "/templates/database.yml")
      #put contents, "#{shared_path}/config/database.yml"
      #inform "Please edit database.yml in the shared directory."
    end
  end
  after "deploy:setup", "jmpak_peepcode:create_shared_config"

  desc "Copy config files"
  task :copy_config_files do
    run "cp #{shared_path}/config/* #{release_path}/config/"
  end
  after "deploy:update_code", "jmpak_peepcode:copy_config_files"
end

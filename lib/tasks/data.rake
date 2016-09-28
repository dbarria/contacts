require 'json/stream'
require 'ruby-progressbar'
require 'awesome_print'
def receive_data(data)
  begin
    @parser << data
  rescue JSON::Stream::ParserError => e
    close_connection
  end
end

namespace :data do
  desc "Populate table contacts from json file"
  # task :populate,[:filepath] => :environment do |t, args|
  task :populate => :environment do
    # unless args.filepath
    #   fail "Filepath must be supplied"
    # end
    @parser = JSON::Stream::Parser.new do
      start_object   { @contact = Contact.new }
      key            {|k| @key = k }
      end_object     { @contact.save}
      value          {|v| @contact[@key] = v }
    end

    file = File.open(Rails.root.join("project-data-07-30.json"),"r")
    pb = ProgressBar.create(:total => file.readlines.size,:format => '%a [%B] %p%% %t')
    file.rewind
    file.each_line do |line|
      receive_data(line)
      pb.increment
    end

    file.close

  end

end

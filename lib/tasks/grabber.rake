namespace :grabber do

  desc "Grab tournaments"
  task tournaments: :environment do
    api_key  = ENV["API_KEY"]
    unless api_key
      puts "Please specify API_KEY"
      exit 0
    end

    Firefly.init_config({"grabber" => {"api_key" => api_key}})
    Firefly::Grabber::Grabbers::Tournament.grab!
    Firefly::Grabber::Grabbers::Match.grab_live!

  end

end
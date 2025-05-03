class SeedRunnerController < ApplicationController
  def run
    if Rails.env.production?
      load Rails.root.join('db/seeds.rb')
      render plain: "Seeds executed!"
    else
      render plain: "Only allowed in production"
    end
  end
end

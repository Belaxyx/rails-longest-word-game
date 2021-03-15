require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    letter = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    i = 1
    while i <= 10
      r = rand(0..25)
      @letters << letter[r]
      i +=1
    end
    @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user = JSON.parse(open(url).read)

    input_split = params[:word].split('')
    input_split.each do |letter|
      if params[:letters].include?(letter) == false
        @score = 'You did not include a valid letter'
      elsif user['found'] == false
        @score = 'This word does not exist in our dictionary'
      else
        total_score = input_split.length**2
        @score = "Your score is #{total_score}"
      end
    end
  end
end

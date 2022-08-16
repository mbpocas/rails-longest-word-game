require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(26)
    # letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @included = included?(@word)
    @english_word = english_word?(@word)
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/autocomplete/#{@word}"
    results = URI.open(url).read
    json = JSON.parse(results)
    json ['found']
  end

  # def dictionary?
  #   url = "https://wagon-dictionary.herokuapp.com/autocomplete/#{params[:word]}"
  #   results = URI.open(url).read
  #   data = JSON.parse(results)
  #   data['found']
  # end

  def included?(word)
    # word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    word.chars.all? { |l| @letters.include?(l) }
  end

  # def check_letters?(word)
  #   word.chars.all? { |l| @letters.include?(l) }
  # end
end

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    conditon = is_word(@word)
    if conditon
      if include_letter(@word, @letters)
        @result = "Congratz! #{@word} is a valid word"
      else
        @result = "Sorry #{@word} can't be build on #{@letters}"
      end
    else
      @result = "Sorry but #{@word} does not seem to be a valid English word ..."
    end
  end

  private

  def is_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    hashword = URI.open(url).read
    wordAPI = JSON.parse(hashword)
    wordAPI['found']
  end

  def include_letter(word, letters)
    word.chars.all? { |letter| letters.include?(letter) && word.count(letter) <= letters.count(letter) }
  end
end

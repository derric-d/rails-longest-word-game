require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:guess].upcase
    @letters = params[:letters].split('')
    @include = included_in_letters(@letters, @guess)
    @user = parse_json
    @score = calc_score
  end

  private

  def included_in_letters(letters, user_guess)
    user_guess.chars.all? { |letter| letters.include? letter }
  end

  def parse_json
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user_serialized = open(url).read
    JSON.parse(user_serialized)
  end

  def calc_score
    if @include == false
      "sorry but #{@guess} is not a part of #{@letters}"
    elsif @user['error']
      "sorry but #{@guess} is not an english wagon-dictionary"
    elsif @guess.empty?
      'please enter a word'
    else
      "Congrats #{@guess} is valid! your score = #{@user['length']}"
    end
  end
end

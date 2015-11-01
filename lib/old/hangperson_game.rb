class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word    
    @guesses = ''
    @wrong_guesses =''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letr)
    # game takes one letter and returns true or false depending on whether the letter is valid or not
    # processes a guess and modifies the instance variables wrong_guesses and guesses
    #letr.downcase!
    #@word.downcase!
    puts "word is #{@word.to_s}"
    puts "letter is #{letr.to_s}"
    puts "guesses are #{@guesses}"
    puts "wrong guesses are #{@wrong_guesses}"
    #reg_exp = RegExp()
    if (letr =~ /[^a-z]/i) 
      #puts "you are not a letter!"
      raise(ArgumentError) 
      return false
    elsif (letr =='')
      puts "no character"
      raise(ArgumentError)
    elsif (letr == nil)
      puts "nothing at all"
      raise(ArgumentError)
    elsif (letr =~ /[#{@word}]/i) 
      if @guesses == ''
       # the letter is in the word
       @guesses << letr
       return true
      elsif letr =~ /[^#{@guesses}]/i
       @guesses << letr
       return true
      else
        return false
      end
      puts "hay match"
      puts "@guesses: #{@guesses}"
    else
      # the letter is not in the word
      puts "no hay match"
      @wrong_guesses << letr
    end
    return true
  end
  
  ###
  ###  What a mess: try to implement helper functions to know if 
  ### a letter is in a string of a variable, i.e
  ### is_match(ltr, string)
  ### returns true if ltr appears in string, false otherwise (inc. if string or ltr are '')
  
  def check_win_or_lose
    # returns one of the symbols :win, :lose, or :play depending on the current game state
  
  end
  
  def word_with_guesses
    # substitutes the correct guesses made so far into the word
    
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

testvar = HangpersonGame.new('carta')
testvar.guess('v')
testvar.guess('a')
testvar.guess('q')
testvar.guess('A')

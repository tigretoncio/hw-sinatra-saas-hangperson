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
    #puts "word is #{@word.to_s}"
    #puts "letter is #{letr.to_s}"
    #puts "guesses are #{@guesses}"
    #puts "wrong guesses are #{@wrong_guesses}"
    #reg_exp = RegExp()
    if is_letter?(letr)
      #is a letter
      #check if the letter is repeated, even in guesses or wrong_guesses
      if (letr =~ /[#{@word}]/i) 
        # letter in the word, check  not repeated
        if(!is_repeated?(letr,@guesses))
          @guesses << letr
          return true
        else  # letter repeated, ignore and return false
          return false
        end
      else # letter not in the word
       if (!is_repeated?(letr,@wrong_guesses))
         @wrong_guesses << letr
         return true
       else # repeated letter on the wrong guesses, ignore and return false
         return false
       end
      
      end
    else
      #not a letter, '' or nil
      raise(ArgumentError) 
      return false
    end
    return true
  end
  
  ###
  
  def check_win_or_lose
    # returns one of the symbols :win, :lose, or :play depending on the current game state
  #TESTS
  #it 'should be win when all letters guessed', :pending => true do  -->if  @word_so_far == @word return win
  #
  #it 'should be lose after 7 incorrect guesses', :pending => true do  --> @wrong_guesses.length >= 7 return lose
  #
  # it 'should continue play if neither win nor lose', :pending => true do  --> else return play
   #puts "word so far: #{@word_so_far} and word to guess: #{@word}"
   if @wrong_guesses.length >= 7
     return :lose
   elsif @guesses.chars.sort.join == remove_dup(@word).chars.sort.join  
   # this does not work because the test expects the use of the existing instance variables
   # I need to compare with regex @guesses and get a match for all the letters in word, repet and order does not matter
   # use each_char method to get the letters for word? --- @guesses regex @word?
   # perhaps take @word, remove duplicate letters, order and compared with @guesses ordered.
     return :win
   else
     return :play
   end
   
  end
  
  def remove_dup(s)
    #remove duplicate letters from a string s
    s_end = ''
    s.each_char do |ch|
      if s_end.match(ch)
        #
      else
        s_end << ch
      end
    end
    return s_end
  end
  
   def word_with_guesses
    # substitutes the correct guesses made so far into the word
    # check the instance variable @guesses, and depending on its values put the characters available
    # for each character in the @guesses add it in the correct place, if '' then put the length of characters of "-" 
    
    @word_so_far = "-" * @word.length
    @guesses.each_char do |c|
     if @word.include?(c)
      a = (0...@word.length).find_all { |i| @word[i] == c }
       a.each { |x| @word_so_far[x] = c }
     end
    end
    @word_so_far
   end
  
  def is_repeated?(c,string)
    #given a character c, determine if c is in string (true) or not (false)
    if(string=='' || string.nil? || c=~/[^#{string}]/i )
      return false
    else
      return true
    end
  end
  
  def is_letter? (c)
    # given a character c, determine if it is a letter (true) or not (not letter a-z A-Z)
    if(c =~ /[^a-z]/i || c=='' || c.nil?)
        return false
    else
        return true
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end






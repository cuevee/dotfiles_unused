Pry.config.theme = "solarized"
Pry.config.editor = "vim"

# Pry.config.prompt = Pry::NAV_PROMPT

Pry.config.hooks.add_hook(:after_session, :say_bye) { puts "Adios! Keep hacking!" }

class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end

  def self.toy_alpha(n=10)
    [*'a'..'z',*'A'..'Z',*0..9].shuffle.sample(n).join ''
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end

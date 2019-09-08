class Game
  def initialize
    @position = 0
    @turns = 0
  end

  def play
    until @position >= 100
      roll = Random.rand(1..6)

      @turns = roll == 6 ? @turns : @turns + 1
      @position = teleport(@position + roll)
    end

    @turns
  end

  def teleport(position)
    case position
    when 1
      38
    when 4
      14
    when 9
      31
    when 16
      6
    when 21
      42
    when 28
      84
    when 36
      44
    when 47
      26
    when 49
      11
    when 51
      67
    when 56
      53
    when 62
      19
    when 64
      60
    when 71
      91
    when 80
      100
    when 87
      24
    when 93
      73
    when 95
      75
    when 98
      78
    else
      position
    end
  end
end

def main
  puts "Simulating..."

  channel = Channel(Int32).new()
  results = [] of Int32

  100_000.times do
    spawn do
      r = Game.new.play
      channel.send(r)
    end
  end

  100_000.times do
    result = channel.receive
    results << result
  end

  max = results.max()
  min = results.min()
  avg = results.sum() / results.size
  std_dev = Math.sqrt((results.map { |r| (r - avg)**2 }.sum()) / results.size).to_i

  puts "Results: "
  puts "Max: #{max}"
  puts "Min: #{min}"
  puts "Avg: #{avg}"
  puts "STDDEV: #{std_dev}"
end

main

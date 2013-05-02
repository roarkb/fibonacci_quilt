#!/usr/bin/env ruby

TITLE = "\n" + " " * 55 + "Fibonacci Quilt\n\n"

def grid
  Array.new(10) { Array.new(10) }
end
 
def clear
  system("clear")
end

def zzz
  sleep 1 unless ARGV.first == "fast"
end

# find element by number in $pre_grid and return indexes
def find(num)
  $pre_grid.each_with_index do |row,row_i|
    row.each_with_index do |e,e_i|
      i = [ row_i, e_i ]
      # special case for finding second 1
      if e.to_i == num && i != $first1
        return i
      end
    end
  end
end

# calculate first 100 fibonacci numbers and store in array
$fib = [ 0, 1 ]
98.times { $fib.push($fib[-1] + $fib[-2]) }

clear
puts TITLE + "\n" * 11

# make all rows even-ish, but don't take too long
row_lengths = [ 0, 1000 ]
until row_lengths.min > 90 && row_lengths.max < 120 do
  $pre_grid = grid
  
  $fib.each do |num|
    # find random available spot on grid
    found = false
    
    until found == true do
      i1 = rand($pre_grid.length)
      i2 = rand($pre_grid.length)
    
      if $pre_grid[i1][i2] == nil
        found = true
      end
    end

    $pre_grid[i1][i2] = num
  end
  
  row_lengths = $pre_grid.map { |row| row.join.length }
end

max_length = row_lengths.max + 9

# pad each grid row evenly
$pre_grid.each_with_index do |row,row_i|
  total_pad = max_length - row_lengths[row_i]
  even_times = total_pad / 9
  pads = Array.new(9, even_times)
  remainders = (0..8).to_a.shuffle.take(total_pad - (even_times * 9))
  remainders.each { |e| pads[e] = even_times + 1 }
  
  row[0..8].each_with_index do |num,num_i|
    $pre_grid[row_i][num_i] = "#{num}" + " " * pads[num_i] 
  end
end

$display_grid = grid

$pre_grid.each_with_index do |row,row_i|
  row.each_with_index do |num,num_i|
    $display_grid[row_i][num_i] = " " * num.to_s.length
  end
end

$fib.each_with_index do |num,num_i|
  i = find(num)
  # special case for finding second 1
  $first1 = i if num_i == 1
  $display_grid[i[0]][i[1]] = $pre_grid[i[0]][i[1]] 
  zzz
  clear
  puts TITLE
  $display_grid.each { |e| puts "#{e}\n" }
  puts
end

zzz

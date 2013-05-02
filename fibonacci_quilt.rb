#!/usr/bin/env ruby

TITLE = "\n" + " " * 55 + "Fibonacci Quilt\n\n"

def grid
  [
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", "", "", ""]
  ]
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

l = [ 0, 1000 ]
until l.min > 90 && l.max < 120 do
  $pre_grid = grid
  
  $fib.each do |num|
    # find random available spot on grid
    found = false
    
    until found == true do
      i1 = rand($pre_grid.length)
      i2 = rand($pre_grid.length)
    
      if $pre_grid[i1][i2] == ""
        found = true
      end
    end

    $pre_grid[i1][i2] = num
  end
  
  l = $pre_grid.map { |row| row.join.length }
end

max_length = l.max + 9

# pad each grid row evenly
$pre_grid.each_with_index do |row,row_i|
  pad = max_length - l[row_i]
  even = pad / 9
  pad_a = [ even, even, even, even, even, even, even, even, even ]
  r_a = [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ].shuffle.take(pad - (even * 9))
  r_a.each { |e| pad_a[e] = even + 1 }
  
  row[0..8].each_with_index do |num,num_i|
    $pre_grid[row_i][num_i] = "#{num}" + " " * pad_a[num_i] 
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

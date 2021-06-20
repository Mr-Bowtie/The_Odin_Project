def stock_picker(prices)
  selected_days = []
  prices.each do |day|
    next if day == prices[-1]
    post_current_val = prices.select { |price| prices.index(price) > prices.index(day) }
    high_value = (post_current_val.sort)[-1]
    if selected_days.empty?
      selected_days << day << high_value
    elsif profit_higher?(day, high_value, selected_days)
      selected_days = []
      selected_days << day << high_value
    end
  end
  selected_days
end

def profit_higher?(val1, val2, array)
  (val2 - val1) > (array[1] - array[0])
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
p stock_picker([10, 3, 9, 2, 7, 6, 5])
p stock_picker([2, 1])
p stock_picker([3, 5, 9, 2, 3, 14, 1])
p stock_picker([42, 33, 5, 16, 8, 7, 4, 5, 1])

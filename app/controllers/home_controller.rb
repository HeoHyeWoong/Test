require ('open-uri')
require ('json')

class HomeController < ApplicationController
    def index
    end
    
    def result
        get_info = JSON.parse open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read
        
        drw_numbers = []
        get_info.each do |k, v|
            drw_numbers << v if k.include? ('drwtNo')
        end
        
        drw_numbers.sort!
        
        my_numbers = [*1..45].sample(6).sort
        
        bonus_number = get_info["bnusNo"]
        match_numbers = my_numbers & drw_numbers
        match_count = match_numbers.count
        
        if match_count == 6
            result = "1등"
        elsif match_count == 5 && my_numbers.include?(bonus_number)
            result = "2등"
        elsif match_count == 5
            result = "3등"
        elsif match_count == 4
            result = "4등"
        elsif match_count == 3
            result = "5등"
        else
            result = "꽝"
        end
        
        @my_numbers = my_numbers
        @drw_numbers = drw_numbers
        @match_numbers = match_numbers
        @result = result
    end
end

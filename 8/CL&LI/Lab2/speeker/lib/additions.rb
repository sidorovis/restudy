module Additions
#  puts "Additions Loaded"
  
  def delete_from_end_of_string( text, deleted_part )
    i = 0
    u = 0
    while ( i < deleted_part.size ) do
      if ( text[ text.size - 1 - i + u ] == deleted_part[ deleted_part.size-1 - i ] )
        text[ text.size - 1 - i + u ] = ""
        u += 1
      end
      i+=1
    end
    text
  end
  
end

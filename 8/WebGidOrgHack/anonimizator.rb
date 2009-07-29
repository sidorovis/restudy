require 'net/http'
require 'net/https'

def get_ip(str)
	st_i = str.index("spy1>")+5
	str[st_i,str.index("<script",st_i)-st_i]
end
def get_port(str)
	st_i = str.index("\"+(")
	str[st_i+1,str.index("</script>",st_i)-st_i-2]
end
def get_anonim_proxy()
	array = []
    Net::HTTP::start('spys.ru') { |http|
		ind = rand(8)
		puts "Loading #{ind} proxy base list"
		ii = 0
		i_st,page = (ind == 0)?([5226,http.get("/proxylist#{ind}/",nil).body]):([5252,http.get("/proxylist/",nil).body]);
		i_fi = page.index("</tr>",i_st);
		ind_3 = nil
		decoder = {}
		while (ii < 25)
			str = page[i_st,page.index("</tr>",i_st)-i_st+5]
			ip = get_ip str
			port = get_port str
			array.push([ip,port,port.split("+").size])
			ind_3 = array.size-1 if (ind_3.nil? && array.last[2] == 3)
			i_st = i_fi+5
			i_fi = page.index("</tr>",i_st);
			ii += 1;
		end
		port_code = array[ ind_3 ][1]
		decoder[port_code[0,port_code.index("+(",3)]] = "8"
		decoder[port_code[port_code.index("+(",3),port_code.size-port_code.index("+(",3)]] = "0"
#		decoder.each {|k,v| puts k+" => "+v}
		array.each do |i| 
			port_code = i[1]
			decoder.each do |k,v|
				while (port_code[k])
					port_code[k] = v
				end
			end
			port_code = "3128" if (port_code.split("+").size == 4)
			port_code = "8081" if (port_code.split("+").size == 2)
			port_code = "9090" if (port_code.split("+").size == 3)
			port_code = "3126" if (port_code.split("+").size == 5)
			i[1] = port_code
			i.delete_at(2)
		end
		puts "Base: "
		array.each { |i| puts array.index(i).to_s+" "+ i[0]+":"+i[1] }
	}
	array
end
if (__FILE__ == $0)
	 get_anonim_proxy
end

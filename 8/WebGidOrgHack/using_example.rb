require 'net/http'
require 'net/https'
require 'iconv'
require "de_anagrammator"
require "anonimizator"

def rand_string()
 nik = ""; 14.times{nik << ((rand(2)==1?65:97) + rand(25)).chr}
 nik
end

def register_on_webgidorg( proxies )
 ic_u_w = Iconv.new('UTF-8','WINDOWS-1251')
 ic_w_u = Iconv.new('WINDOWS-1251','UTF-8')

 proxy = proxies[ rand(25) ]
 print "We try to connect with: "
 puts proxy[0]+":"+proxy[1]
 
 begin
 
 Net::HTTP::Proxy(proxy[0],proxy[1]).start('webgid.org') { |http|
   reg_page = http.get("/reger.php", nil).body
   if reg_page.size > 4000
   d_ind = reg_page.index('<input name="d" type="hidden" value="')+'<input name="d" type="hidden" value="'.size()
   d_part = reg_page[d_ind,7]
   d = d_part[0,d_part.index('"')]
   puts "Anagramma is "+ic_u_w.iconv( d )
   answer = deanagramm UtfString.new( ic_u_w.iconv(d) )
   puts "Answer to Anagramma is "+answer
   uin_ind = reg_page.index('<input name="uin" type="hidden" value="')+'<input name="uin" type="hidden" value="'.size()
   uin = reg_page[uin_ind,33]
   nik = rand_string();
   mail = rand_string().downcase+"@gmail.com";
   mysate = rand_string().downcase+".corca.org";
   vvodanagrami = ic_w_u.iconv(answer)

   data = "d=#{d}&uin=#{uin}&famil=robot&imya=killer&otchestvo=frog&nik=#{nik}&mail=#{mail}&mysate=#{mysate}&vvodanagrami=#{vvodanagrami}"
   puts "What we sent to post form: "+data
 
   headers = {
  	'Referer' => 'http://webgid.org/reg.php',
	'Content-Type' => 'application/x-www-form-urlencoded'
   }

   ans = http.post("/reg.php", data, headers)
   after_reg_location = ans['location']
   if (after_reg_location)
      puts "Where we get after registering: "+after_reg_location
      resp = http.get("/" + after_reg_location , nil)
      puts resp.code
   else
      puts after_reg_location.code
   end
  else
    puts "This IP is banned on one hour (reg page size == "+reg_page.size.to_s+")"
  end
 }
 rescue Errno::ENETUNREACH, Errno::ECONNREFUSED, Errno::ETIMEDOUT, Timeout::Error, Errno::ECONNRESET
    puts "Proxy dead"
 rescue EOFError
    puts "HTTP library dead"
 end
 
end

if (__FILE__ == $0)
  proxies = get_anonim_proxy()
  for i in (0..1000)
   puts "Registration id:"+i.to_s
   register_on_webgidorg( proxies )
  end
end

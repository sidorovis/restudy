а) создаём лексер (лексемы идут в том же порядке что и скпсок токенов в парсере дефайнать начиная с 258!
б) 	заменяем
                  when YY_END_OF_BUFFER + INITIAL + 1
                     return 0
	на
                  when YY_END_OF_BUFFER + INITIAL + 1
                     return [-1, nil]

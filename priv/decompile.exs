System.argv()
|> hd() 
|> String.to_charlist()
|> :beam_disasm.file()
|> IO.inspect

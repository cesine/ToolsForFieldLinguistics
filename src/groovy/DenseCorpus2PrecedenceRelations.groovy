def precedencerelationslocal = [:].withDefault { k -> 0 }
precedencerelationslocal.putAll(precedencerelations)

densecorpus.each{
	morphs = it.split(/\W+/)
	def previousmorph = "@"
	
	morphs.each{ morph ->
		if( !("".equals(morph)) ){
			//println ":"+morph+":"
			println previousmorph+" > "+morph
			precedencerelationslocal[previousmorph+" > "+morph]++
			previousmorph=morph
		}
	}
	println previousmorph+" > @"
	precedencerelationslocal[previousmorph+" > @"]++
}
println precedencerelationslocal
return precedencerelationslocal
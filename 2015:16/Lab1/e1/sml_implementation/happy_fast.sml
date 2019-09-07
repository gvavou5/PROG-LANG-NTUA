fun happy file = 
	let
		(* take the input from txt file *)
		fun input file = 
			let
				fun read_int input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
				val inStream = TextIO.openIn file
				val A = read_int inStream
				val B = read_int inStream
			in (A,B)
			end
			
		(*'copy' the c-program in sml language with the libraries Array, Array2*)	
		
		val magic = Array.array(730,0)
		
		fun pow_digit nn =
				let 
					fun crop nn acc = 
						if nn = 0 then acc
						else 
							let 
								val sqrt= nn mod 10 
							in	
								crop (nn div 10) (acc+ sqrt*sqrt)
							end
				in 
					crop nn 0
				end 
		
		fun happynumber a acc=
					let 
						val ya = pow_digit a
					in
						if ya < 10 then if ya = 1  then acc+1
										else if ya = 7 then acc+1
										else acc
						else happynumber ya acc
					end 
		
		
		fun happy_loop 730 = ()
			| happy_loop n = 
				let 
					val x = happynumber n 0
					val tmp = Array.update (magic, n, x)
				in 
					happy_loop (n+1)
				end
				
		val tmp = happy_loop 1		
		val (A,B) = input file
		val s = Array2.array (10,730,0)
		val tmp = Array2.update (s, 0, 0, 1)
		
		(* ebala val s kai temp giati an ebaza mono tis entoles update kai array tote skaei to programma*
		 wstoso h enhmerwsh toy pinaka s ginetai kanonika *)
		
		fun loop1 10 = ()
			|loop1 i = 
				let
					fun loop2 (~1) = ()
						| loop2 j = 
							let
								fun loop3 10 = ()
									|loop3 k = 
										let 
											val u6 = (Array2.sub (s, i, j+k*k)) + (Array2.sub (s, i-1, j))
											val u7 = Array2.update (s, i, j+k*k, u6)
										in 
											loop3 (k+1)
										end
								val tmp = loop3 0
							in 
								loop2 (j-1)
							end
					val tmp = loop2 ((i-1)*81)
				in 
					loop1 (i+1)
				end
				
				
		val u8 = loop1 1
		val digit_array = Array.array(10,0)
		
		
		fun loop 0 n = n
			|loop j n =
				let
					val tmp = Array.update (digit_array, n, j mod 10)
				in 
					loop (j div 10) (n+1)
				end		
				
		
		
		fun result (~1) r = 0
			|result i r = 
				let 
					fun tmp1 (~1) r = 0
						|tmp1 l r = 
							let
								fun tmp2 (~1) r = 0
									|tmp2 j r = ((Array2.sub (s, i, j)) * (Array.sub (magic, (j+l*l+r)))) + (tmp2 (j-1) r)
							in 
								(tmp2 (i*81) r) + (tmp1 (l-1) r)
							end
				in 
					(tmp1 ((Array.sub (digit_array, i))-1) r) + result (i-1) (r+(Array.sub (digit_array, i) * Array.sub (digit_array, i)))
				end
		in 
		(result  ((loop (B+1) 0) - 1) 0 ) - (result ((loop A 0) - 1) 0 )
	end;
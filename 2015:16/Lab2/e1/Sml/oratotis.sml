fun oratotis file =
	
	(*the function input file found at the internet*)
	let
		fun input file = 
			let
				fun read_int infile = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) infile)
				fun read_real input = Option.valOf (TextIO.inputLine input)
				val input = TextIO.openIn file
				val N = read_int input
				fun test 0 = []
				   |test i = 
						let
							val xsw = read_int input
							val ysw = read_int input
							val xne = read_int input
							val yne = read_int input
							val (SOME height) = Real.fromString(read_real input)
						in
							((xsw,ysw),(xne,yne),height)::(test (i-1))
						end
			in
				test N
			end
			
	(*list has the input*)
	val list = input file
	
	
	(*function maxposx finds the maximum x position of the buildings*)
	(*with the parameter maxposx now we have the array that we need which name is matrix(see below)*)
	(*we could not write this function and create at once a matrix with 100.000 cells which is enough for this exercise*)
	(*maybe this could 'win' some time if N = 420.000*)
	fun maxposx [] = 0
		| maxposx (((x,y),(xne,yne),h)::tail) =
			let
				fun find [] max = max
				|find (((x,y),(xne,yne),h)::tail) max =	
					if (xne > max) then find tail xne   (*i found a new maximun xne*)
					else find tail max
			in
				find(((x,y),(xne,yne),h)::tail) 0
			end
	
	
	(*create the array with the wright bounds*)
	val matrix = Array.array (maxposx list, 0.0)
	
	
	(*function Mege_Sort taken as it is from the slides*)
	(*the only thing that i change is that i sort the given list by ysw(for that i change function merge)*)
	fun Merge_Sort nil = nil
		|Merge_Sort [e] = [e]
		|Merge_Sort L = 
			let
				fun halve nil = (nil,nil)
				|halve [a] = ([a],nil)
				|halve (a::b::tail) = 
					let 
						val (x, y) = halve tail
					in
						(a::x, b::y)
					end
				fun merge (nil,ys) = ys
				|merge (xs,nil) = xs
				|merge ( ((xsw1,ysw1),ne1,h1)::xs, ((xsw2,ysw2),ne2,h2)::ys ) = 
							if ysw1 < ysw2 then (((xsw1,ysw1),ne1,h1)::merge (xs, ((xsw2,ysw2),ne2,h2)::ys))
							else (((xsw2,ysw2),ne2,h2)::merge (((xsw1,ysw1),ne1,h1)::xs, ys))
				val (x,y) = halve L
			in
				merge (Merge_Sort x, Merge_Sort y)
			end
			
	
	(*this function takes list sorted by ysw and with two for loops find the number of buildings that we can see*)
	fun numberOfBuildings [] sum= sum
		|numberOfBuildings (((xsw,ysw),(xne,yne),height)::tail) sum=
				let 
					val flag=0
					fun find xsw xne height flag = 
						if (xsw < xne) then 
							if (Array.sub(matrix, xsw) >= height) then 
								find (xsw+1) xne height flag
							else 
								let 
									val temp = Array.update(matrix, xsw, height)
									(*the command Array.update(matrix, xsw, height) is illegal if is alone*)
									(*because of that i use a temporary variable to make it work, temp is useless for the programm*)
								in
									find (xsw+1) xne height 1
								end
						else flag
				in
					if (find xsw xne height flag=0) then numberOfBuildings tail sum
					else numberOfBuildings tail (sum+1)
				end
	in
		numberOfBuildings  (Merge_Sort list) 0 
	end
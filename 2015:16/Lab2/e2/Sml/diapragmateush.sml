fun diapragmateysi input =
	let
	
		(*this function is a simple function that helps me make compares easily, and i use it in function Bfs*)
		fun check "bgbGgGGrGyry" = 0 
			|check _ = 1
		
		(* we create 4 similar function with names turn1,..., turn4 to make the right rotation when we need to do it*)
		(* turn1-->up&left turn, turn2-->up&right turn, turn3-->down&left turn, turn4-->down&right turn*)
		(* we use variables tmp1,...,tmp6 to make String.extract right. If we dont use temp variables we lose the result*)
		(*the input is a string and because of that we make the rotations with the library function String.extract*)
		(* the way that function String.extract works is very easy if you search in web. If we havent this function it would be difficult to make the rotations*)
		fun turn1 pos l= 
			let
				val tmp1 = String.extract(pos, 0, SOME 1) 
				val tmp2 = String.extract(pos, 1, SOME 1)
				val tmp3 = String.extract(pos, 2, SOME 1)
				val tmp4 = String.extract(pos, 3, SOME 1)
				val tmp5 = String.extract(pos, 4, SOME 1)
				val tmp6 = String.extract(pos, 5, SOME 1)
				val upol = String.extract(pos, 6, NONE)
				val res = tmp3^tmp2^tmp6^tmp1^tmp5^tmp4^upol
			in
				(res, l^"1")
			end
			
		fun turn2 pos l = 
			let
				val tmp1 = String.extract(pos, 0, SOME 1) 
				val tmp2 = String.extract(pos, 1, SOME 1)
				val tmp3 = String.extract(pos, 2, SOME 1)
				val tmp4 = String.extract(pos, 3, SOME 1)
				val tmp5 = String.extract(pos, 4, SOME 1)
				val tmp6 = String.extract(pos, 5, SOME 1)
				val tmp7 = String.extract(pos, 6, SOME 1)
				val upol = String.extract(pos, 7, NONE)
				val res = tmp1^tmp4^tmp3^tmp7^tmp2^tmp6^tmp5^upol
			in
				(res, l^"2")
			end

		fun turn3 pos l =
			let
				val tmp1 = String.extract(pos, 5, SOME 1) 
				val tmp2 = String.extract(pos, 6, SOME 1)
				val tmp3 = String.extract(pos, 7, SOME 1)
				val tmp4 = String.extract(pos, 8, SOME 1)
				val tmp5 = String.extract(pos, 9, SOME 1)
				val tmp6 = String.extract(pos, 10, SOME 1)
				val tmp7 = String.extract(pos, 11, SOME 1)
				val upol = String.extract(pos, 0, SOME 5)
				val res = upol^tmp3^tmp2^tmp6^tmp1^tmp5^tmp4^tmp7
			in
				(res, l^"3")
			end

		fun turn4 pos l =
			let
				val tmp1 = String.extract(pos, 6, SOME 1) 
				val tmp2 = String.extract(pos, 7, SOME 1)
				val tmp3 = String.extract(pos, 8, SOME 1)
				val tmp4 = String.extract(pos, 9, SOME 1)
				val tmp5 = String.extract(pos, 10, SOME 1)
				val tmp6 = String.extract(pos, 11, SOME 1)
				val upol = String.extract(pos, 0, SOME 6)
				val res = upol^tmp3^tmp2^tmp6^tmp1^tmp5^tmp4
			in
				(res , l^"4")
			end

		(* function Bfs(breathe first search) taken from a ml site as it is. We make it run for this kind of problem! *)
		(* the site that we get it was this : http://www.cs.cmu.edu and we choose lectures and we found it at lecture 10 *)
		fun Bfs [] l = ""
		    |Bfs l [] = ""
			|Bfs (h1::rest1) (h2::rest2) = 
				let
					val (toupl1, toupl11) = turn1 h1 h2
					val (toupl2, toupl22) = turn2 h1 h2 
					val (toupl3, toupl33) = turn3 h1 h2
					val (toupl4, toupl44) = turn4 h1 h2
					val h1nw = toupl1::toupl2::toupl3::toupl4::[]
					val h2nw = toupl11::toupl22::toupl33::toupl44::[]
				in
					if (check toupl1 = 0) then toupl11
					else if (check toupl2 = 0) then toupl22
					else if (check toupl3 = 0) then toupl33
					else if (check toupl4 = 0)  then toupl44
					else
						Bfs (rest1@h1nw) (rest2@h2nw)
				end
	in
		if (check input = 0) then "0"
		else
			Bfs [input] [""]
	end
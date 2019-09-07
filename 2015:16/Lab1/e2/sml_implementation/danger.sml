fun danger file =
	let
		fun input file =
			let
				fun parse file =
					let
						fun next_int input =
						Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
						val stream = TextIO.openIn file
						val n = next_int stream
						val m = next_int stream
						val _ = TextIO.inputLine stream
						fun scanner 0 acc = acc
							|scanner i acc =
							let
								val k = next_int stream
								fun scanline 0 acc = acc
									|scanline i acc =
									let
										val l = next_int stream
									in
										scanline (i - 1) (l :: acc)
									end
								val line = rev(scanline k [k])
							in
								scanner (i - 1) (line :: acc)
							end
					in
						(n, m, rev(scanner m []))
					end
					val (N, M, list_a)= parse file
			in
				(N,M,list_a)
			end

		val (N,M,lst_a) = input file

		fun search k lst =
			let
				val len = length lst
				fun walk lst current counter =
					if k = current then true
					else if counter = len then false
					else walk (tl lst) (hd lst) (counter+1)
			in
				walk (tl lst) (hd lst) 1
			end


		fun listcreation size =
			let
				fun walk acc =
					if acc=size then acc::[]
					else acc::(walk (acc + 1))
			in
				walk 1
			end


		val lst_n = [listcreation N]

		fun return_p  p lst =
			let
				fun walk lst current pos =
					if p=pos then current
					else walk (tl lst) (hd lst) (pos+1)
			in
				walk (tl lst) (hd lst) 1
			end


		fun Merge_Sort nil = nil
			|Merge_Sort [c] = [c]
			|Merge_Sort lst =
				let
					fun halve nil = (nil,nil)
					|halve [a] = ([a],nil)
					|halve (a::b::rest) =
						let
							val (x, y) = halve rest
						in
							(a::x, b::y)
						end
					fun merge (nil,ys) = ys
					|merge (xs,nil) = xs
					|merge (x::xs, y::ys) =
						if ((length x)<(length y)) then x::merge(xs, y::ys)
						else y::merge(x::xs,ys)
					val (x,y) = halve lst
				in
					merge (Merge_Sort x, Merge_Sort y)
				end
		(*h sunarthsh Merge_Sort xrhsimopoih8hke etoimh apo to biblio tou ma8hmatos*)

		val lst_a = map tl (Merge_Sort lst_a)

		fun delete_k  k lst =
			let
				val len = length lst
				fun walk lst current pos =
					if pos=len then
							if k=current then []
							else current::[]
					else if k=current then walk (tl lst) (hd lst) (pos+1)
					else current::walk (tl lst) (hd lst) (pos+1)
			in
				walk (tl lst) (hd lst) 1
			end


		fun match  lst l =
			let
				fun	walk l current 1 = search current lst
					|walk l current len =
						if len <> 0 then
								if search current lst  then walk (tl l) (hd (tl l)) (len-1)
								else false
						else true
			in
				walk l (hd l) (length l)
			end


		fun common_lst  lst l =
			let
				fun	walk l current 1 = if ( search current lst ) then current::[] else []
					|walk l current len =
							if len<>0  then
								if search current lst then current::walk (tl l) (hd (tl l)) (len-1)
								else walk (tl l) (hd (tl l)) (len-1)
							else []
			in
				walk l (hd l) (length l)
			end

		fun clear lst l =
			let
				fun walk l current com leng =
					if leng<>1 then [delete_k  current lst]@(walk l (hd (tl com)) (tl com) (leng-1))
					else [delete_k  current lst]
			in
				if match  lst l then walk l (hd (common_lst  lst l)) (common_lst  lst l) (length (common_lst  lst l))
				else [lst]
			end

		fun clear_1   l lst = clear lst l
		
		fun concat_lst  lst size_lst =
			let
				fun walk size_lst =
					if size_lst = 1 then hd lst
					else (hd lst)@concat_lst  (tl lst) (size_lst - 1)
			in
				walk (length lst)
			end

		fun clear_2 l lst = map ( clear_1   l )  lst

		fun work_it  lst abs =
			let
				fun walk lst abs currentm leng =
					if leng<>1 then walk (concat_lst  (clear_2   currentm lst) (length (clear_2   currentm lst))) (tl abs) (hd (tl abs)) (leng-1)
					else concat_lst  (clear_2   currentm lst) (length (clear_2   currentm lst))
			in
				walk lst abs (hd abs) (length abs)
			end
	in
		return_p  (length (work_it  lst_n lst_a)) (Merge_Sort (work_it  lst_n lst_a))
	end

(*
 * Programm : Balance
 * Authors  : 1)Vavouliotis Giorgos 03112083
 			  2)Athanasiou Nikos 03112074 
 *)
 		 
fun execute (_,0:IntInf.int,(L1,L2),_) = (L1,L2)
| execute ([],_,_,_) = ([],[])	
| execute (arr1: IntInf.int list,w: IntInf.int,(L1, L2),arr2: IntInf.int list) =
	let 
		val diff  = ( IntInf.abs(w-List.hd(arr1)) > List.hd(arr2) )
		val diff2 = ( IntInf.abs(w+List.hd(arr1)) > List.hd(arr2) )
		val len   = length(arr1)
	in
		case diff of
			false => execute(List.tl(arr1),w-List.hd(arr1),([len]@L1,L2),List.tl(arr2))
			|_    => 
					case diff2 of
						false => execute(List.tl(arr1),w+List.hd(arr1),(L1,[len]@L2),List.tl(arr2))
						|_    => execute(List.tl(arr1), w,(L1, L2),List.tl(arr2))		
	end;

fun balance N W = 
let
	fun helpfun1 (_, arr1: IntInf.int list, 1, arr2: IntInf.int list) = (arr1, arr2)
	|   helpfun1 (W: IntInf.int, arr1: IntInf.int list, N, arr2: IntInf.int list) =
		let 
			val boolean = (W > List.hd(arr2))
			val temp    = 3*List.hd(arr1)
		in
			if boolean = true then helpfun1(W, [temp]@arr1, N-1, [temp+List.hd(arr2)]@arr2)
			else (arr1, arr2)  
		end;
	val (x1::x2,y1::y2) = helpfun1(W, [1], N, [1]@[0]);
	val len = length(([x1]@x2))
in
	execute(x2,x1-W,([],[len]@[]),List.tl(y2))
end;
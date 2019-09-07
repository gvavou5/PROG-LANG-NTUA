(*********************************************************************
 *********************************************************************
 Programm : Deksamenes
 Authors  : 1)Vavouliotis Giorgos 03112083  2)Athanasiou Nikos 03112074 
 *********************************************************************
 *********************************************************************)

fun search (L: (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, Min: IntInf.int, Max: IntInf.int, Midean: IntInf.int, acc: IntInf.int) =
let
	fun BenefitSum ([], _, accsum) = accsum 	
	|   BenefitSum (L: (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, ind, accsum) = 
			let
				fun volume ((i1: IntInf.int, i2: IntInf.int, i3: IntInf.int, i4: IntInf.int), i5: IntInf.int) = 
						let 
							val dif  = (i5 > i1)
							val dif1 = (i5 >= i1+i2)
						in 
							case dif of 
								false => 0
								|_    => 
											case dif1 of	
												false => (i5-i1)*(i3)*(i4)
												|_    => (i2)*(i3)*(i4)
						end;  
			in
				BenefitSum(tl(L), ind, accsum + volume(hd(L), ind))
			end;

	fun Find_Ret (true, _) = Midean
	|   Find_Ret (i1,i2) =
			let
				val dif = (#2(i1,i2) < acc)
			in
				case dif of 
					false => search(L, Min, Midean, (Min+Midean) div 2, acc)
				    |_    => search(L, Midean+1, Max, (Midean+Max+1) div 2, acc)
			end;
in
	Find_Ret ( (Min =  Max), BenefitSum(L, Midean, 0) ) 
end;


fun DoItAll (L : (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list , Q : IntInf.int) =
	let
		fun ben_lst_sum ([], n) = n 
		|   ben_lst_sum (list: (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, n) = 
			let
				val (_,x,y,z) = List.hd(list)
			in
				ben_lst_sum (tl(list), x * y * z + n)
			end;

		fun find_min ([], acc) = acc
		|   find_min (Ln: (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, acc) =
				let	
					val (x,_,_,_) = List.hd(Ln)
					val dif = (x >= acc)
				in
					case dif of
						true => find_min(tl(Ln), acc)
						|_   => find_min(tl(Ln), x)
				end;

		fun find_max ([], n) = n  
		|	find_max (Ln: (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, acc) =
				let	
					val (x,y,_,_) = List.hd(Ln)
					val dif = (x+y <= acc)
				in
					case dif of
						true => find_max(tl(Ln), acc)
						|_   => find_max(tl(Ln), x + y)
				end;

		fun Find_Res (indx) = 
				let	
					val min = find_min (L, Int.toLarge(1000000*1000+42000*1000))
					val max = find_max (L, 0)
					val dif = ( Q <= indx ) 
					fun format _ false  = ~1.0
					|   format x  _     = (Real.realRound(x/10.0))/100.0
				in	
				    ( search(L, min, max, (min+ max) div 2, Q), dif ) 
				end;
	in
		Find_Res ( ben_lst_sum(L, 0) )
	end;


fun runner input = 
	let 
		val temp = TextIO.openIn  input
		fun int_from_stream () = Option.valOf(TextIO.scanStream(Int.scan StringCvt.DEC) temp);
		
		val hp = int_from_stream ();
		fun unroll (inp, L : (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, 0) = L
		|   unroll (inp, L : (IntInf.int * IntInf.int * IntInf.int * IntInf.int) list, acc)  = unroll (inp, (Int.toLarge(int_from_stream())*1000, Int.toLarge(int_from_stream())*1000, Int.toLarge(int_from_stream()), Int.toLarge(int_from_stream()))::L, acc-1);
	in	
		(unroll (input, [], hp), temp)
	end;

fun deksamenes (input) =
let
	val (L,inp) = runner input
	fun int_from_stream ()  = Option.valOf(TextIO.scanStream(Int.scan StringCvt.DEC) inp);
    val (result,booleanval) = 	DoItAll(L,Int.toLarge(int_from_stream ())*1000)
	fun format_res x = Real.realRound(Real.fromLargeInt(x)/10.0)/100.0
in
    case booleanval of  
        true => format_res result
        |_   => ~1.0
end;
(*
Authors:
Athanasiou Nikolaos 03112074
Vavouliotis Georgios 03112083
*)

fun reverse([],z) = z
|reverse(x,z) = reverse(tl(x),hd(x)::z);

fun myrev x = reverse (x,[]);

fun myconc s l =
    let fun aux (h::t, res) = aux(t, s::h::res)
          | aux ([], res)   = myrev (tl res)
    in
        if   l=[] then ""
        else String.concat (aux (l, []))
    end;
    
fun mymap f xs = 
    let
     fun m ([], acc) = myrev acc
      | m ((x::xs),  acc) = m (xs, f x  :: acc)
    in
      m (xs, [])
    end;

fun athr ([], sum: IntInf.int) = sum 
| athr (list: IntInf.int list, sum: IntInf.int)=athr(tl(list), sum+hd(list));

fun lowerbound ([], max: IntInf.int, sum: IntInf.int, N: IntInf.int) =
    let
      val ind = IntInf.compare(max,#1(IntInf.divMod(sum, N)))
    in 
      if(ind = LESS orelse ind = EQUAL) then #1(IntInf.divMod(sum, N))
      else max
    end
|lowerbound (list: IntInf.int list, max: IntInf.int, sum: IntInf.int, N: IntInf.int)=
    let 
      val ind = IntInf.compare(hd(list),max)
    in 
      if(  ind = LESS orelse ind = EQUAL) then lowerbound(tl(list), max, sum, N)
      else lowerbound(tl(list), hd(list), sum, N)
    end;

fun upperbound (list: IntInf.int list, max: IntInf.int, sum: IntInf.int, 1) =
  let 
    val inf = IntInf.compare(max,sum)
  in  
    if ( inf = LESS orelse inf = EQUAL) then sum
    else max 
  end
| upperbound (list: IntInf.int list, max: IntInf.int, sum: IntInf.int, N)=
  let 
    val inf = IntInf.compare(hd(list),max)
  in 
    if(inf = LESS orelse inf = EQUAL) then upperbound(tl(list), max, sum-hd(list), N-1)
    else upperbound(tl(list), hd(list), sum-hd(list), N-1)
  end;

fun check ([], mid: IntInf.int, sum: IntInf.int, cnt) = cnt+1
| check (list: IntInf.int list, mid: IntInf.int, sum: IntInf.int, cnt) =
  let 
    val ing = IntInf.compare(sum+hd(list),mid) 
  in
    if( ing = LESS orelse ing = EQUAL) then check(tl(list), mid, sum+hd(list), cnt)
    else check(list, mid, 0, cnt+1)
  end;

fun mybinary (L: IntInf.int list, lb: IntInf.int, ub: IntInf.int, N) = 
  let
    val inr = IntInf.compare( Int.toLarge(check(L, #1(IntInf.divMod(lb+ub, 2)), 0, 0)),Int.toLarge N)
  in
    if(IntInf.compare(lb,ub) = EQUAL) then #1(IntInf.divMod(lb+ub, 2))
    else if (inr = LESS orelse inr = EQUAL) then mybinary(L, lb, #1(IntInf.divMod(lb+ub, 2)), N)
    else mybinary(L, #1(IntInf.divMod(lb+ub, 2))+1, ub, N)
  end;

fun checker ([], acc: IntInf.int list, mid: IntInf.int, sum: IntInf.int) = acc
| checker (list: IntInf.int list, acc: IntInf.int list, mid: IntInf.int, sum: IntInf.int) = 
  let 
    val inu = IntInf.compare(sum+hd(list),mid)
  in
    if( inu = LESS orelse inu = EQUAL) then checker(tl(list), hd(list)::acc , mid, sum+hd(list))
    else checker(list, ~1::acc, mid, 0)
  end;

fun myreturn ([list], str, n, c) = IntInf.toString(list)::str 
| myreturn (list: IntInf.int list, str, n, c) =
    if ((IntInf.compare(Int.toLarge n, Int.toLarge 0) = GREATER) andalso (hd(list) <> ~1) andalso (c <> ~1)) then myreturn(tl(list), IntInf.toString(hd(list))::"|"::str, n-1, hd(list))
    else if (IntInf.compare(hd(list),~1) = EQUAL) then myreturn(tl(list), "|"::str, n, hd(list))
    else myreturn(tl(list), IntInf.toString(hd(list))::str, n, hd(list));

fun basecases (M, N, L) =
 if (Int.compare(N,1) = EQUAL) then (myconc " " (mymap IntInf.toString L))
 else if (Int.compare(N,M) = EQUAL) then (myconc " | " (mymap IntInf.toString L))
 else myconc " " (myrev(myreturn(checker(myrev(L), [], mybinary(myrev(L), lowerbound(L, 0, athr(L, 0), Int.toLarge(N)), upperbound(L, 0, athr(L, 0), N), N), 0), [], N-check(myrev(L), mybinary(myrev(L), lowerbound(L, 0, athr(L, 0), Int.toLarge(N)), upperbound(L, 0, athr(L, 0), N), N), 0,0), ~1)));

fun hp (inp, list, 0) = list
| hp (inp,list,i) = 
    let 
      fun int_from_stream () = Option.valOf(TextIO.scanStream(Int.scan StringCvt.DEC) inp);
    in
      hp(inp, (Int.toLarge(int_from_stream() ))::list, i-1)
    end;
 
fun takeinput input = 
  let
    val inp = TextIO.openIn  input
    fun int_from_stream () = Option.valOf(TextIO.scanStream(Int.scan StringCvt.DEC) inp)
    val M = int_from_stream ()
    val N = int_from_stream ()
  in
    (M,N,inp)
  end;

fun fair_parts (input) = 
let
  val mn = takeinput input
  val L = myrev(hp(#3(mn), [], #1(mn)))
in
  basecases(#1(mn), #2(mn), L)
end;





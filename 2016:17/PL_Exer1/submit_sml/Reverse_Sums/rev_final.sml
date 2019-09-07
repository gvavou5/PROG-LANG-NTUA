(*
Authors:
Athanasiou Nikolaos 03112074
Vavouliotis Georgios 03112083
*)

fun reverse([],z) = z
|reverse(x,z) = reverse(tl(x),hd(x)::z);

fun myrev x = reverse (x,[]);
    
fun mymap f xs = 
    let
     fun m ([], acc) = myrev acc
      | m ((x::xs),  acc) = m (xs, f x  :: acc)
    in
      m (xs, [])
    end;
    
fun diaxwrise (x, 0) = (x-(Int.div(x,2)))::[]
| diaxwrise(x,_) = (Int.div(x,2))::[];

fun output (a::[], lst2, eks1, eks2, _) = ([a], lst2, eks1, eks2, length([a])+length(lst2))
| output  (lst1, lst2, eks1, eks2, c)  = 
  let
    fun oria (x) =
      let 
        val xa = ( x <=18 andalso x>=0 )
      in 
        if xa then 1 
        else 0
      end
    val ind  = List.hd(lst1)
    val diff = ind - List.hd(lst2)  
  in
    if diff = 0  then 
                case oria(ind) of
                  0 => (lst1, lst2, eks1, eks2, ~1)
                  |_ =>  output(List.tl(lst1), List.tl(lst2), List.@(diaxwrise(ind, 0),eks1), List.@(diaxwrise(ind, 1),eks2), 0) 
    else if diff = 1  then 
                if (Int.compare(ind,1) <> EQUAL) orelse ( Int.compare(c,1) <> EQUAL) then 
                  case oria(Int.-(ind,1)) of 
                      0  => (lst1, lst2, eks1, eks2, ~1)
                      |_ => output((List.hd(List.tl(lst1))+10)::List.tl(List.tl(lst1)), List.tl(lst2), List.@(diaxwrise(Int.-(ind,1),0),eks1), List.@(diaxwrise(Int.-(ind,1),1),eks2), 0) 
                else (lst1, lst2, eks1, eks2, ~1)                                                           
    else if diff = 10 then
                if Int.compare(oria(ind),0) <> EQUAL then 
                  case tl(lst2) of 
                        [] => output((List.hd(List.tl(lst1))-1)::List.tl(List.tl(lst1)), List.tl(lst2), List.@(diaxwrise(ind, 0),eks1), List.@(diaxwrise(ind, 1),eks2), 0)
                        |_ => output(List.tl(lst1), (List.hd(List.tl(lst2))-1)::List.tl(List.tl(lst2)), List.@(diaxwrise(ind, 0),eks1), List.@(diaxwrise(ind, 1),eks2), 0)
                else (lst1, lst2, eks1, eks2, ~1)
    else if diff = 11 then
                if Int.compare(oria(ind-1),0) <> EQUAL then 
                  case tl(lst2) of
                        [] => output((List.hd(List.tl(lst1))+9)::List.tl(List.tl(lst1)), List.tl(lst2), List.@(diaxwrise(Int.-(ind,1), 0),eks1), List.@(diaxwrise(Int.-(ind,1), 1),eks2), 0)
                        |_ => output((List.hd(List.tl(lst1))+10)::List.tl(List.tl(lst1)), (List.hd(List.tl(lst2))-1)::List.tl(List.tl(lst2)), List.@(diaxwrise(Int.-(ind,1), 0),eks1), List.@(diaxwrise(Int.-(ind,1), 1),eks2), 0) 
                else (lst1, lst2, eks1, eks2, ~1)
    else (lst1, lst2, eks1, eks2, ~1)
  end;


fun help1 (lst, lst2, eks1, eks2) =
  let 
    fun oria (x) =
      let 
        val xa = ( x <=18 andalso x>=0 )
      in 
        if xa then 1 
        else 0
      end
    val value = oria(hd(lst))
    val dv = Int.mod(hd(lst),2)
    val dv1 = Int.div(hd(lst),2)
  in
    if (value <> 0 andalso dv = 0) then  (tl(lst), lst2, [dv1]@eks1, eks2, 0)
    else (lst, lst2, eks1, eks2, ~1)
  end;


fun help2 (lst1, lst2, eks1, eks2) = 
  let 
     fun oria (x) =
      let 
        val xa = ( x <=18 andalso x>=0 )
      in 
        if xa then 1 
        else 0
      end
    val diff = hd(lst1) - hd(lst2)
  in
    case diff of
    11 => 
      if oria(hd(lst1)-1) = 0 then (lst1, lst2, eks1, eks2, ~1)
      else (tl(lst1), tl(lst2), diaxwrise(hd(lst1)-1, 0)@eks1, diaxwrise(hd(lst1)-1, 1)@eks2, 0)
    |0  => 
      if oria(hd(lst1)) = 0 then (lst1, lst2, eks1, eks2, ~1)
      else (tl(lst1), tl(lst1), diaxwrise(hd(lst1), 0)@eks1, diaxwrise(hd(lst1), 1)@eks2, 0)
    |_ =>
      (lst1, lst2, eks1, eks2, ~1) 
  end;



fun caseswitch (lst1, lst2, eks1, eks2, 1)  =  help1(lst1, lst2, eks1, eks2)
| caseswitch (lst1, lst2, eks1, eks2, ~1)    = (lst1, lst2, eks1, eks2, ~1)
| caseswitch (lst1, lst2, eks1, eks2, 2)    = help2(lst1, lst2, eks1, eks2)
| caseswitch (lst1, lst2, eks1, eks2, c)    = (lst1, lst2, eks1, eks2, c)


fun carry (lst1, lst2) = 
  let
    fun oria (x) =
      let 
        val xa = ( x <=18 andalso x>=0 )
      in 
        if xa then 1 
        else 0
      end
    val diff = hd(lst1) -hd(lst2)
  in  
    case diff of  
      ~9 => output((hd(tl(lst1))+10)::tl(tl(lst1)), tl(lst2), diaxwrise(hd(lst1)+9, 0), diaxwrise(hd(lst1)+9, 1), 0)
      |0 => 
           if oria(Int.+(hd(lst1),10)) <> 0 then
              case tl(lst2) of  
                  [] => output((hd(tl(lst1))-1)::tl(tl(lst1)), tl(lst2), diaxwrise(hd(lst1)+10, 0), diaxwrise(hd(lst1)+10, 1), 0)
                  |_ => output(tl(lst1), (hd(tl(lst2))-1)::tl(tl(lst2)), diaxwrise(hd(lst1)+10, 0), diaxwrise(hd(lst1)+10, 1), 0)
           else  (lst1, lst2, [], [], ~1)
      |1 => 
           if oria(Int.+(hd(lst1),9)) <> 0 then
              case tl(lst2) of 
                  [] => output((hd(tl(lst1))+9)::tl(tl(lst1)), tl(lst2), diaxwrise(hd(lst1)+9, 0), diaxwrise(hd(lst1)+9, 1), 0)
                  |_ => output((hd(tl(lst1))+10)::tl(tl(lst1)), (hd(tl(lst2))-1)::tl(tl(lst2)), diaxwrise(hd(lst1)+9, 0), diaxwrise(hd(lst1)+9, 1), 0) 
           else (lst1, lst2, [], [], ~1)
      |_ => (lst1, lst2, [], [], ~1)
  end; 

fun kratoumena (lst1, lst2) = 
let
  val l = Int.+(length(lst1),length(lst2))
  val mod2 = Int.mod(l,2)
in
  case l of 
     1  => (tl(lst1), lst2, [], [], ~1)
    |2  =>
          if (Int.+(hd(lst2),10)) mod 2 <> 0 then (tl(lst1), tl(lst2), [], [], ~1)
          else (tl(lst1), tl(lst2), diaxwrise(Int.+(hd(lst2),10), 0), [], 0)
    |3  => 
           let
              val temp = hd(tl(lst1)) - hd(lst2)
              val acc = hd(tl(lst1)) + 10
              val acc1 = acc - 1
           in
              case temp of
                0  => 
                     if (((hd(diaxwrise(acc, 0))+hd(diaxwrise(acc, 1))) = Int.+(hd(lst2),10)) andalso ((hd(diaxwrise(acc, 0))+hd(diaxwrise(acc, 1))) = acc1)) then (tl(tl(lst1)), tl(lst2), diaxwrise(acc, 0), diaxwrise(acc, 1), 0)
                     else (tl(tl(lst1)), tl(lst2), [], [], ~1) 
                |1 => 
                     if (((hd(diaxwrise(acc1, 0))+hd(diaxwrise(acc1, 1))) = hd(lst2)+10) andalso ((hd(diaxwrise(acc1, 0))+hd(diaxwrise(acc1, 1))) = acc1)) then (tl(tl(lst1)), tl(lst2), diaxwrise(acc1, 0), diaxwrise(acc1, 1), 0)
                     else (tl(tl(lst1)), tl(lst2), [], [], ~1)
                |_ => (tl(tl(lst1)), tl(lst2), [], [], ~1)
           end
    |_  =>
          if mod2 <> 0 then caseswitch(carry(tl(lst1), lst2))
          else caseswitch(carry(tl(lst1@hd(rev(lst2))::[]), rev(tl(rev(lst2)))))
 end; 
 
fun wrap (list, l, i, lst2) =
    let 
      val diff = Int.compare(Int.-(l,i),0)
    in  
      case diff of  
        EQUAL => (myrev(list), myrev(lst2))
        |_    => wrap(tl(list), l, i+1, hd(list)::lst2)
   end;

fun hp input =
  let
    fun readinput (c, list) =
      let
        val i = Char.ord(c)-Char.ord(#"0")
        val i1 = Int.compare(i,0)
        val i2 = Int.compare(i,9)
      in 
        case (i1,i2) of
           (EQUAL,EQUAL)   => readinput(Option.valOf(TextIO.input1 input), i::list)
          |(GREATER,EQUAL) => readinput(Option.valOf(TextIO.input1 input), i::list)
          |(GREATER,LESS)  => readinput(Option.valOf(TextIO.input1 input), i::list)
          |(EQUAL,LESS)    => readinput(Option.valOf(TextIO.input1 input), i::list)
          |_ => list
      end
  in
    readinput(Option.valOf(TextIO.input1 input), [])
  end;

fun helpread (lst1, lst2) =
    let
      val tuple1 = caseswitch(output(lst1, lst2, [], [], 1))
      val tuple2 = kratoumena(lst1, lst2)
      val cmp = Int.compare(#5 tuple1,0)
      val cmp2 = Int.compare(#5 tuple2,0)
    in
      case cmp of 
        EQUAL =>  myrev(#3 tuple1)@(#4 tuple1)
        |_ => 
          case (List.hd(lst1),cmp2) of 
            (1,EQUAL) =>  myrev(#3 tuple2)@(#4 tuple2)
            |_ => [0]
    end
    
fun revsum (input) =
let
  val inp = TextIO.openIn(input)
  val L = hp inp
in 
  String.concat(mymap Int.toString(helpread(wrap(L, length(L) div 2, 0, []))))
end;        

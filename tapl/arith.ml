type info = string

type term =
    TmTrue of info  (* True *)
  | TmFalse of info (* False *)
  | TmIf of info * term * term * term (* if <term> then <term> else <term> *)
  | TmZero of info (* 0 *)
  | TmSucc of info * term (* succ <term> *)
  | TmPred of info * term (* pred <term> *)
  | TmIsZero of info * term (* isZero <term> *)

let rec isnumericval t = match t with
    TmZero(_) -> true (* 0 is a numerical value *)
  | TmSucc(_, t1) -> isnumericval t1 (* succ of numerical value is a numerical value *)
  | _ -> false

let rec isval t = match t with
    TmTrue(_) -> true (* True is a value *)
  | TmFalse(_) -> true (* False is a value *)
  | t when isnumericval t -> true (* A numerical value is a value *)
  | _ -> false

exception NoRuleApplies

let rec eval1 t = match t with
    (* if True then t2 else t3 => t2 *)
    TmIf(_, TmTrue(_), t2, t3) ->
      t2 
    (* if False then t2 else t3 => t3 *)
  | TmIf(_, TmFalse(_), t2, t3) ->
      t3 
    (* t1 -> t1', if t1 then t2 else t3 => if t1' then t2 else t3 *)
  | TmIf(fi, t1, t2, t3) ->
      let t1' = eval1 t1 in
      TmIf(fi, t1', t2, t3)
    (* t1 -> t1', succ t1 => succ t1' *)
  | TmSucc(fi, t1) ->
      let t1' = eval1 t1 in
      TmSucc(fi, t1')
    (* pred 0 => 0 *)
  | TmPred(fi, TmZero(_)) ->
      TmZero(fi)
    (* pred succ nv, nv numericval => nv *)
  | TmPred(_, TmSucc(_, nv1)) when (isnumericval nv1) ->
      nv1
    (* t1 -> t1', pred t1 => pred t1' *)
  | TmPred(fi, t1) ->
      let t1' = eval1 t1 in
      TmPred(fi, t1')
    (* isZero 0 => True *)
  | TmIsZero(fi, TmZero(_)) ->
      TmTrue(fi)
    (* isZero succ nv => False *)
  | TmIsZero(fi, TmSucc(_, nv1)) when (isnumericval nv1) ->
      TmFalse(fi)
    (* t1 -> t1', isZero t1 => isZero t1' *)
  | TmIsZero(fi, t1) ->
      let t1' = eval1 t1 in
      TmIsZero(fi, t1')
  | _ ->
      raise NoRuleApplies

let rec eval t =
  try let t' = eval1 t
      in eval t'
  with NoRuleApplies -> t


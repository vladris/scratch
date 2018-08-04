import Data.List
import Data.Maybe

data Type =
    TyRecord [(String, Type)]
  | TyTop
  | TyArr Type Type
  deriving (Eq, Show)

data Term =
    TmVar Int Int
  | TmAbs String Type Term
  | TmApp Term Term
  | TmRecord [(String, Term)]
  | TmProj Term String

-- from simple.hs
data Binding = NameBind | VarBind Type

type Context = [(String, Binding)]

addBinding :: Context -> String -> Binding -> Context
addBinding ctx s b = (s, b):ctx

getTypeFromContext :: Context -> Int -> Type
getTypeFromContext ctx i =
    case ctx !! i of
        (_, VarBind ty) -> ty
        _ -> error "Wrong kind of binding for variable"
--

subtype :: Type -> Type -> Bool
subtype s t = (==) s t || match s t
    where
        match _ TyTop = True
        match (TyArr s1 s2) (TyArr t1 t2) = subtype t1 s1 && subtype s2 t2
        match (TyRecord ss) (TyRecord ts) =
            all (\selem -> 
                let telem = find (\telem -> (fst selem) == (fst telem)) ts in
                    if telem == Nothing then
                        False -- no corresponding type in ts
                    else
                        subtype (snd selem) (snd (fromJust telem))
            ) ss
        match _ _ = False

typeOf :: Context -> Term -> Type
typeOf ctx (TmRecord fields) = 
    let fieldTypes = fmap (\elem -> (fst elem, typeOf ctx (snd elem))) fields in
        TyRecord fieldTypes
typeOf ctx (TmProj t1 l) = match (typeOf ctx t1)
    where
        match (TyRecord fieldTypes) =
            let felem = find (\elem -> l == (fst elem)) fieldTypes in
                if felem == Nothing then
                    error ("Label " ++ l ++ " not found")
                else
                    snd (fromJust felem)
        match _ = error "Expected record type"
typeOf ctx (TmVar i _) = getTypeFromContext ctx i
typeOf ctx (TmAbs x tyT1 t2) =
    let ctx' = addBinding ctx x (VarBind tyT1) in
    let tyT2 = typeOf ctx' t2 in
        TyArr tyT1 tyT2
typeOf ctx (TmApp t1 t2) =
    let tyT1 = typeOf ctx t1 in
    let tyT2 = typeOf ctx t2 in
        match tyT1 tyT2
            where
                match (TyArr tyT11 tyT12) tyT2 = if subtype tyT2 tyT11 then 
                                                    tyT12
                                                 else
                                                    error "Parameter type mismatch"
                match _ _ = error "Arror type expected"

main :: IO ()
main = do
    putStrLn ""
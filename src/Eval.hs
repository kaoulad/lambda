module Eval (eval) where

import Parser (Lambda (App,Abs,Var))

substitute :: Char -> Lambda -> Lambda -> Lambda
substitute p (Var a) b     = if p == a then b else Var a
substitute p (Abs m l) b   = if p == m then Abs m l else Abs m (substitute p l b)
substitute p (App m l) b   = App (substitute p m b) (substitute p l b)

eval :: Lambda -> Lambda
eval (Var x)            = Var x
eval (Abs x e)          = Abs x e
eval (App (Abs p b) a)  = substitute p b a
eval (App f x)          = App f x

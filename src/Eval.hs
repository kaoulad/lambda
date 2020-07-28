module Eval (evalLambda) where

import Text.Parsec (ParseError)
import Parser (Lambda)
import Text.PrettyPrint.ANSI.Leijen (blue,text,Doc)
import Text.Show.Unicode (uprint)

colourText :: String -> Doc
colourText s = blue $ text $ s 

evalLambda :: Either ParseError Lambda -> IO ()
evalLambda expr = do
                    uprint $ colourText "Reductions: ..."
                
                
module Main where

import Text.Show.Unicode (uprint)
import Parser (parseLambda)
import Eval (evalLambda)
import System.IO (hFlush,stdout)
import Text.PrettyPrint.ANSI.Leijen (text,green,red,magenta)

inp :: IO String -> IO ()
inp s = do
            res <- s  
            let pLambda = parseLambda res
            case res of 
                []     -> (print $ red (text "ERROR: You must enter an expression.")) >> inp (prompt "λ> ")
                "quit" -> print $ magenta (text "Bye.")
                _      -> (uprint $ green (text $ "AST: " ++ show pLambda)) >> evalLambda pLambda >> inp (prompt "λ> ")
  

prompt :: String -> IO String
prompt text = do
                putStr text
                hFlush stdout
                getLine

main :: IO ()
main = inp (prompt "λ> ")
       


module Main where

import Text.Show.Unicode (uprint)
import Parser (parseLambda)
import Eval (eval)
import System.IO (hFlush,stdout)
import Text.PrettyPrint.ANSI.Leijen (text,blue,red,magenta)

inp :: IO String -> IO ()
inp s = do
            res <- s  
            case res of
                ""     -> (print $ red $ text "ERROR: You must enter an expression.") >> inp (prompt "λ> ")
                "quit" -> print $ magenta $ text "Bye" 
                _      -> case parseLambda res of
                                        (Right expr)  -> (uprint $ blue $ text ("β> " ++ (show $ eval expr))) >> inp (prompt "λ> ")
                                        (Left  error) -> (uprint $ red $ text (show error)) >> inp (prompt "λ> ")
     
prompt :: String -> IO String
prompt text = (putStr text) >> (hFlush stdout) >> getLine

main :: IO ()
main = inp (prompt "λ> ")
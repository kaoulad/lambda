module Main where

import Text.Show.Unicode (uprint)
import Parser (parseLambda)
import System.IO (hFlush,stdout)

inp :: IO String -> IO ()
inp s = do
            res <- s  
            case res of 
                []     -> (putStrLn $ "You must enter an expression.") >> inp (prompt "λ> ")
                "quit" -> putStrLn "Bye."
                _      -> (uprint $ parseLambda res) >> inp (prompt "λ> ")

prompt :: String -> IO String
prompt text = do
                putStr text
                hFlush stdout
                getLine

main :: IO ()
main = inp (prompt "λ> ")

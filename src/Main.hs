module Main where

import Text.Show.Unicode (uprint)
import Parser (parseLambda)

setStdin :: IO ()
setStdin = do
              putStrLn "\nλ-expression:"
              input <- getLine
              stdin input

stdin :: String -> IO ()
stdin "" = setStdin
stdin "quit" = print "Bye."
stdin s      = (uprint $ parseLambda s) >> setStdin

main :: IO ()
main = putStrLn "Lambda Calculus Interpreter with Parsec." >> stdin ""
        
-- (variable) x
-- (application) (variable,abstraction) (variable,abstraction) ...
-- (abstraction) λ(variable).(variable, abstraction, application)
